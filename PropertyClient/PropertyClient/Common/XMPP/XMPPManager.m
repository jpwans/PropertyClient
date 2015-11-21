//
//  XMPPManager.m
//  UnisouthParents
//
//  Created by neo on 14-3-26.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import "XMPPManager.h"
//#import "MessageFileParse.h"
#import "XMPPvCardTemp.h"
//#import "PartnerDao.h"
#import "SDImageCache.h"
#import "MessageParse.h"
#import "TimeUtils.h"
//#import "ChatDao.h"
#import "NSData+Base64.h"
#import "CoreDateManager.h"
#import "MailVC.h"
#import <CoreData/CoreData.h>
#import "MessageDB.h"
#import "Body.h"
#import <AudioToolbox/AudioToolbox.h>
#if DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_INFO;
#endif




#define DOCUMENT_PATH NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]
#define CACHES_PATH NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]

@implementation XMPPManager

@synthesize xmppStream;
@synthesize xmppReconnect;
@synthesize xmppRoster;
@synthesize xmppRosterStorage,xmppvCardTempModule,xmppvCardAvatarModule,xmppCapabilities,xmppCapabilitiesStorage,xmppRoom;
@synthesize xmppRoomDidJoinArray;



static XMPPManager *sharedManager;

+(XMPPManager*)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager=[[XMPPManager alloc]init];
        [DDLog addLogger:[DDTTYLogger sharedInstance]];
        [sharedManager setupStream];
    });
    
    // Setup the XMPP stream
    return sharedManager;
}

- (void)dealloc
{
    [self teardownStream];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma  mark ------发送消息-------




#pragma mark --------配置XML流---------
- (void)setupStream
{
    NSAssert(xmppStream == nil, @"Method setupStream invoked multiple times");
    
    xmppStream = [[XMPPStream alloc] init];
    
#if !TARGET_IPHONE_SIMULATOR
    {
        xmppStream.enableBackgroundingOnSocket = YES;
    }
#endif
    
    xmppReconnect = [[XMPPReconnect alloc] init];
    xmppReconnect.autoReconnect = YES;  //是否自动连接
    
    // Setup capabilities
    //
    // The XMPPCapabilities module handles all the complex hashing of the caps protocol (XEP-0115).
    // Basically, when other clients broadcast their presence on the network
    // they include information about what capabilities their client supports (audio, video, file transfer, etc).
    // But as you can imagine, this list starts to get pretty big.
    // This is where the hashing stuff comes into play.
    // Most people running the same version of the same client are going to have the same list of capabilities.
    // So the protocol defines a standardized way to hash the list of capabilities.
    // Clients then broadcast the tiny hash instead of the big list.
    // The XMPPCapabilities protocol automatically handles figuring out what these hashes mean,
    // and also persistently storing the hashes so lookups aren't needed in the future.
    //
    // Similarly to the roster, the storage of the module is abstracted.
    // You are strongly encouraged to persist caps information across sessions.
    //
    // The XMPPCapabilitiesCoreDataStorage is an ideal solution.
    // It can also be shared amongst multiple streams to further reduce hash lookups.
    
    // Activate xmpp modules
    
    xmppRosterStorage = [[XMPPRosterCoreDataStorage alloc] init];
    xmppRoster = [[XMPPRoster alloc] initWithRosterStorage:xmppRosterStorage];
    
    xmppRoster.autoFetchRoster = YES;
    xmppRoster.autoAcceptKnownPresenceSubscriptionRequests = YES;
    
    // Setup vCard support
    //
    // The vCard Avatar module works in conjuction with the standard vCard Temp module to download user avatars.
    // The XMPPRoster will automatically integrate with XMPPvCardAvatarModule to cache roster photos in the roster.
    
    xmppvCardStorage = [XMPPvCardCoreDataStorage sharedInstance];
    xmppvCardTempModule = [[XMPPvCardTempModule alloc] initWithvCardStorage:xmppvCardStorage];
    xmppvCardAvatarModule = [[XMPPvCardAvatarModule alloc] initWithvCardTempModule:xmppvCardTempModule];
    
    // Setup capabilities
    //
    // The XMPPCapabilities module handles all the complex hashing of the caps protocol (XEP-0115).
    // Basically, when other clients broadcast their presence on the network
    // they include information about what capabilities their client supports (audio, video, file transfer, etc).
    // But as you can imagine, this list starts to get pretty big.
    // This is where the hashing stuff comes into play.
    // Most people running the same version of the same client are going to have the same list of capabilities.
    // So the protocol defines a standardized way to hash the list of capabilities.
    // Clients then broadcast the tiny hash instead of the big list.
    // The XMPPCapabilities protocol automatically handles figuring out what these hashes mean,
    // and also persistently storing the hashes so lookups aren't needed in the future.
    //
    // Similarly to the roster, the storage of the module is abstracted.
    // You are strongly encouraged to persist caps information across sessions.
    //
    // The XMPPCapabilitiesCoreDataStorage is an ideal solution.
    // It can also be shared amongst multiple streams to further reduce hash lookups.
    
    xmppCapabilitiesStorage = [XMPPCapabilitiesCoreDataStorage sharedInstance];
    xmppCapabilities = [[XMPPCapabilities alloc] initWithCapabilitiesStorage:xmppCapabilitiesStorage];
    
    xmppCapabilities.autoFetchHashedCapabilities = YES;
    xmppCapabilities.autoFetchNonHashedCapabilities = NO;
    xmppRoomStorage = [XMPPRoomCoreDataStorage sharedInstance];
    
    // Activate xmpp modules
    
    [xmppReconnect         activate:xmppStream];
    [xmppRoster            activate:xmppStream];
    [xmppvCardTempModule   activate:xmppStream];
    [xmppvCardAvatarModule activate:xmppStream];
    [xmppCapabilities      activate:xmppStream];
    [xmppRoom              activate:xmppStream];
    
    // Add ourself as a delegate to anything we may be interested in
    
    [xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    [xmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
    [xmppRoom addDelegate: self delegateQueue:dispatch_get_main_queue()];
    [xmppvCardTempModule addDelegate: self delegateQueue:dispatch_get_main_queue()];
    
    // Optional:
    //
    // Replace me with the proper domain and port.
    // The example below is setup for a typical google talk account.
    //
    // If you don't supply a hostName, then it will be automatically resolved using the JID (below).
    // For example, if you supply a JID like 'user@quack.com/rsrc'
    // then the xmpp framework will follow the xmpp specification, and do a SRV lookup for quack.com.
    //
    // If you don't specify a hostPort, then the default (5222) will be used.
    
    //	[xmppStream setHostName:XMPP_HOST_ADDRESS];
    //	[xmppStream setHostPort:XMPP_Host_PORT];
    
    
    
    // You may need to alter these settings depending on the server you're connecting to
    allowSelfSignedCertificates = NO;
    allowSSLHostNameMismatch = NO;
    
    if (![self connect]) {
        [[[UIAlertView alloc]initWithTitle:@"服务器无法连接" message:@"请联系我们！" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil] show];
        return;
    };
    
    xmppRoomDidJoinArray = [[NSMutableArray alloc]init];
}

- (void)teardownStream
{
    [xmppStream removeDelegate:self];
    [xmppRoster removeDelegate:self];
    [xmppRoom removeDelegate:self];
    
    [xmppReconnect         deactivate];
    [xmppRoom deactivate];
    [xmppRoster            deactivate];
    [xmppvCardTempModule   deactivate];
    [xmppvCardAvatarModule deactivate];
    [xmppCapabilities      deactivate];
    
    [xmppStream disconnect];
    
    xmppStream = nil;
    xmppReconnect = nil;
    xmppRoom = nil;
    xmppRoster = nil;
    xmppRosterStorage = nil;
    xmppvCardStorage = nil;
    xmppvCardTempModule = nil;
    xmppvCardAvatarModule = nil;
    xmppCapabilities = nil;
    xmppCapabilitiesStorage = nil;
    
}

// It's easy to create XML elments to send and to read received XML elements.
// You have the entire NSXMLElement and NSXMLNode API's.
//
// In addition to this, the NSXMLElement+XMPP category provides some very handy methods for working with XMPP.
//
// On the iPhone, Apple chose not to include the full NSXML suite.
// No problem - we use the KissXML library as a drop in replacement.
//
// For more information on working with XML elements, see the Wiki article:
// http://code.google.com/p/xmppframework/wiki/WorkingWithElements

- (void)goOnline
{
    XMPPPresence *presence = [XMPPPresence presence]; // type="available" is implicit
    
    NSString *domain = [xmppStream.myJID domain];
    
    //Google set their presence priority to 24, so we do the same to be compatible.
    
    if([domain isEqualToString:@"gmail.com"]
       || [domain isEqualToString:@"gtalk.com"]
       || [domain isEqualToString:@"talk.google.com"])
    {
        NSXMLElement *priority = [NSXMLElement elementWithName:@"priority" stringValue:@"24"];
        [presence addChild:priority];
    }
    
    [[self xmppStream] sendElement:presence];
}

- (void)goOffline
{
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    
    [xmppStream sendElement:presence];
}

//是否连接
- (BOOL) isConnectXmpp
{
    if ([xmppStream isDisconnected]) {
        return NO;
    }
    return YES;
}

- (BOOL) isConnectedXmpp
{
    if ([xmppStream isConnected]) {
        return YES;
    }
    return NO;
}

#pragma mark Connect/disconnect

- (BOOL)connect
{
    if (![xmppStream isDisconnected]) {
        return YES;
    }
    //   Y_OWNERID
    NSString *myJID =  [[SYSTEM_USERDEFAULTS stringForKey:Y_USERNAME] stringByAppendingString:LoginType];
    myJID = [NSString stringWithFormat:@"%@%@%@",[SYSTEM_USERDEFAULTS stringForKey:Y_employeeId],myJID,XMPP_HOST_ADDROOMRESS];
//    NSLog(@"myjid:%@",myJID);
    NSString *myPassword = [SYSTEM_USERDEFAULTS stringForKey:Y_PWD];
    if (myJID == nil || myPassword == nil) {
        return NO;
    }
    
    [xmppStream setMyJID:[XMPPJID jidWithString:myJID]];
    [xmppStream setHostName:XMPP_HOST_ADDRESS];
    
    password = myPassword;
    
    NSError *error = nil;
    if (![xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error connecting"
                                                            message:@"See console for error details."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
        
        DDLogError(@"Error connecting: %@", error);
        
        return NO;
    }
    
    return YES;
}

- (void)disconnect
{
    [self goOffline];
    [xmppStream disconnect];
    [self teardownStream];
}

#pragma mark UIApplicationDelegate

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store
    // enough application state information to restore your application to its current state in case
    // it is terminated later.
    //
    // If your application supports background execution,
    // called instead of applicationWillTerminate: when the user quits.
    
    DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    
#if TARGET_IPHONE_SIMULATOR
    DDLogError(@"The iPhone simulator does not process background network traffic. "
               @"Inbound traffic is queued until the keepAliveTimeout:handler: fires.");
#endif
    
    //	if ([application respondsToSelector:@selector(setKeepAliveTimeout:handler:)])
    //	{
    //		[application setKeepAliveTimeout:600 handler:^{
    //			DDLogVerbose(@"KeepAliveHandler");
    //			// Do other keep alive stuff here.
    //		}];
    //	}
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    [[UIApplication sharedApplication] clearKeepAliveTimeout];
}



- (NSManagedObjectContext *)managedObjectContext_roster
{
    return [xmppRosterStorage mainThreadManagedObjectContext];
}
// Returns the URL to the application's Documents directory.

#pragma mark XMPPStream Delegate


//-(void)xmppStream:(XMPPStream *)sender socketWillConnect:(GCDAsyncSocket *)socket
//{
//    CFReadStreamSetProperty([socket getCFReadStream], kCFStreamNetworkServiceType, kCFStreamNetworkServiceTypeVoIP);
//    CFWriteStreamSetProperty([socket getCFWriteStream], kCFStreamNetworkServiceType, kCFStreamNetworkServiceTypeVoIP);
//}
//


- (void)xmppStream:(XMPPStream *)sender socketDidConnect:(GCDAsyncSocket *)socket
{
    DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
}

- (void)xmppStream:(XMPPStream *)sender willSecureWithSettings:(NSMutableDictionary *)settings
{
    DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    
    if (allowSelfSignedCertificates)
    {
        [settings setObject:[NSNumber numberWithBool:YES] forKey:(NSString *)kCFStreamSSLAllowsAnyRoot];
    }
    
    if (allowSSLHostNameMismatch)
    {
        [settings setObject:[NSNull null] forKey:(NSString *)kCFStreamSSLPeerName];
    }
    else
    {
        NSString *expectedCertName = [xmppStream.myJID domain];
        
        if (expectedCertName)
        {
            [settings setObject:expectedCertName forKey:(NSString *)kCFStreamSSLPeerName];
        }
    }
}

- (void)xmppStreamDidSecure:(XMPPStream *)sender
{
    DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
}

#pragma mark 连接完成（如果服务器地址不对，就不会调用此方法）
- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    
    isXmppConnected = YES;
    
    NSError *error = nil;
    
    if (![xmppStream authenticateWithPassword:password error:&error])
    {
        DDLogError(@"Error authenticating: %@", error);
    }
    
}

#pragma mark 身份验证通过
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    
    DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    
    [self goOnline];
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"available"];
    [sender sendElement:presence];
    
}


//验证失败
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error
{
//    NSLog(@"%@",error);
    DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    
}

- (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq
{
    //DDLogVerbose(@"%@: %@ - %@", THIS_FILE, THIS_METHOD, [iq elementID]);
    return NO;
}

#pragma mark 接收消息

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    
    DDLogVerbose(@"接收消息:-----%@: %@", THIS_FILE, THIS_METHOD);
    DDLogVerbose(@"%@: %@", @"didReceiveMessage", message);
    
    
    NSString * body =   [[message body] stringByReplacingPercentEscapesUsingEncoding:NSUTF16BigEndianStringEncoding];
    NSString *from= [message fromStr];
    from =    [from substringToIndex: [from rangeOfString:@"@"].location];
    NSDictionary *dict =[self dictionaryWithJsonString:body];
    Body *bodyEntity = [Body objectWithKeyValues:dict];
    bodyEntity.from =from;
    NSArray * msgArray = [bodyEntity.content componentsSeparatedByString:@"_#_"];
    NSArray * addArray = [[msgArray firstObject] componentsSeparatedByString:@"_"];
    if ([bodyEntity.type intValue]!=2) {
        bodyEntity.content = [NSString stringWithFormat:@"【%@】:%@",[addArray lastObject],[msgArray lastObject]];
    }
    else if([bodyEntity.type intValue]==2){
        bodyEntity.content = [NSString stringWithFormat:@"【房间号-%@】:%@",[addArray lastObject],[msgArray lastObject]];
    }
    //添加一条数据
   CoreDateManager *coreManager = [[CoreDateManager alloc] init];
    NSMutableArray *array =[[NSMutableArray alloc] init];
    [array addObject:bodyEntity];
    [coreManager insertCoreData:array];
    
    

    
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive)
    {
           [[NSNotificationCenter defaultCenter] postNotificationName:Notif_XMPP_NewMsg object:self];
    }


    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    static SystemSoundID soundIDTest = 0;
    
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"prompt" ofType:@"wav"];
    
    if (path) {
        
        AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundIDTest );
        
    }
    
    
    AudioServicesPlaySystemSound( soundIDTest );
    
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    //设置5秒之后
    NSDate *pushDate = [NSDate dateWithTimeIntervalSinceNow:1];
    if (notification != nil) {
        // 设置推送时间（1秒后）
        notification.fireDate = pushDate;
        // 设置时区（此为默认时区）
        notification.timeZone = [NSTimeZone defaultTimeZone];
        // 设置重复间隔（默认0，不重复推送）
        notification.repeatInterval = 0;
        // 推送声音（系统默认）
        notification.soundName = UILocalNotificationDefaultSoundName;
        // 推送内容
        notification.alertBody = bodyEntity.content;
        //显示在icon上的数字
//        notification.applicationIconBadgeNumber = 1;
        //设置userinfo 方便在之后需要撤销的时候使用
        NSDictionary *info = [NSDictionary dictionaryWithObject:@"name"forKey:@"key"];
        notification.userInfo = info;
        //添加推送到UIApplication
        UIApplication *app = [UIApplication sharedApplication];
        [app scheduleLocalNotification:notification];
    }
    
    
    
 }


#pragma mark  接收好友状态
- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{
    DDLogVerbose(@"%@: %@ - %@", THIS_FILE, THIS_METHOD, [presence fromStr]);
}

- (void)xmppStream:(XMPPStream *)sender didReceiveError:(id)error
{
    DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
}

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    
    if (!isXmppConnected)
    {
        DDLogError(@"Unable to connect to server. Check xmppStream.hostName");
    }
}



#pragma mark XMPPRosterDelegate

- (void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence
{
    XMPPJID *jid=[XMPPJID jidWithString:[presence stringValue]];
    [xmppRoster acceptPresenceSubscriptionRequestFrom:jid andAddToRoster:YES];
}

- (void)addSomeBody:(NSString *)userId
{
    [xmppRoster subscribePresenceToUser:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@@hcios.com",userId]]];
}

#pragma  mark ------- 群聊天  -------





@end
