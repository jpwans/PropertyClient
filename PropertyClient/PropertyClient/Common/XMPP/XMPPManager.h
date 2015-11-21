//
//  XMPPManager.h
//  UnisouthParents
//
//  Created by neo on 14-3-26.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
//#import "XMPPFramework.h"
#import "XMPPMessage.h"
#import "XMPPReconnect.h"
#import "XMPPvCardCoreDataStorage.h"
#import "XMPPRoom.h"
#import "GCDAsyncSocket.h"
#import "XMPP.h"
#import "XMPPReconnect.h"
#import "XMPPCapabilities.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "XMPPRoster.h"

#import "TURNSocket.h"
#import "XMPPRosterCoreDataStorage.h"
#import "MessageObject.h"
#import "XMPPRoomMemoryStorage.h"
#import "XMPPRoomCoreDataStorage.h"
#import "XMPPCapabilitiesCoreDataStorage.h"


@class XMPPMessage,XMPPRoster,XMPPRosterCoreDataStorage,XMPPRoom,XMPPvCardTempModule,XMPPvCardAvatarModule,XMPPCapabilities,XMPPCapabilitiesCoreDataStorage;
@interface XMPPManager : NSObject <UIApplicationDelegate, XMPPRoomDelegate>
{
    XMPPStream *xmppStream;
	XMPPReconnect *xmppReconnect;
    XMPPRoster *xmppRoster;
	XMPPRosterCoreDataStorage *xmppRosterStorage;
    XMPPvCardCoreDataStorage *xmppvCardStorage;
	XMPPvCardTempModule *xmppvCardTempModule;
	XMPPvCardAvatarModule *xmppvCardAvatarModule;
	XMPPCapabilities *xmppCapabilities;
	XMPPCapabilitiesCoreDataStorage *xmppCapabilitiesStorage;
    XMPPRoom *xmppRoom;
    XMPPRoomCoreDataStorage *xmppRoomStorage;
    
    
   	NSString *password;
	
	BOOL allowSelfSignedCertificates;
	BOOL allowSSLHostNameMismatch;
	
	BOOL isXmppConnected;
    
    
}


@property (nonatomic, strong, readonly) XMPPStream *xmppStream;
@property (nonatomic, strong, readonly) XMPPReconnect *xmppReconnect;
@property (nonatomic, strong, readonly) XMPPRoster *xmppRoster;
@property (nonatomic, strong, readonly) XMPPRosterCoreDataStorage *xmppRosterStorage;
@property (nonatomic, strong, readonly) XMPPvCardTempModule *xmppvCardTempModule;
@property (nonatomic, strong, readonly) XMPPvCardAvatarModule *xmppvCardAvatarModule;
@property (nonatomic, strong, readonly) XMPPCapabilities *xmppCapabilities;
@property (nonatomic, strong, readonly) XMPPCapabilitiesCoreDataStorage *xmppCapabilitiesStorage;
@property (nonatomic, strong, readonly) XMPPRoom *xmppRoom;


@property (readonly, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong) NSMutableArray *xmppRoomDidJoinArray;


- (NSManagedObjectContext *)managedObjectContext_roster;
//- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;



//初始化
+(XMPPManager*)sharedInstance;

// 连接xmpp
- (BOOL)connect;

//是否连接
- (BOOL) isConnectXmpp;
- (BOOL) isConnectedXmpp;


// 断开连接
- (void)disconnect;



#pragma mark -------配置XML流-----------

- (void)setupStream;
- (void)teardownStream;


#pragma mark ----------收发信息------------
//上线
- (void)goOnline;

//下线
- (void)goOffline;

//发送消息
- (BOOL)sendMessage:(MessageObject*)messageObject;
- (BOOL)sendMessageNotSave:(MessageObject*)messageObject;


//获取用户头像
//-(UIImage *)getPersonPhoto:(NSString*)jid;
-(void)getPersonPhoto:(NSString*)jid withCompletionHandler:(void(^)( UIImage *uiImage))block;

//修改用户头像
-(void)updatePersonPhoto:(UIImage*)uiImage;

- (void)addSomeBody:(NSString *)userId;

#pragma mark -----群消息----------

- (BOOL)createChatRoom:(NSString*)roomName;

//是否加入房间
- (BOOL)isJoinedRoom:(NSString*)roomName;
//邀请加入房间
//- (void)inviteUserJoinRoom:(XMPPRoom*)addXmppRoom  byInviteUserJid:(NSString*)jid;
- (void)inviteUserJoinRoom:(NSString*)addXmppRoomName  byInviteUserJid:(NSString*)jid;


#pragma mark ---------文件传输-----------
//-(void)sendFile:(NSData*)aData toJID:(XMPPJID*)aJID;

@end