

#import "AppDelegate.h"

#import <SMS_SDK/SMS_SDK.h>
#import "LoginDao.h"
#import "CrashLogs.h"
@interface AppDelegate ()<UIAlertViewDelegate>
{
    NSString *versionUrl;
}
@end

@implementation AppDelegate
{
    int isBecomActive;
}
@synthesize  tabBarController;




-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //    float sysVersion=[[UIDevice currentDevice]systemVersion].floatValue;
    //    if (sysVersion>=8.0) {
    //        UIUserNotificationType type=UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
    //        UIUserNotificationSettings *setting=[UIUserNotificationSettings settingsForTypes:type categories:nil];
    //        [[UIApplication sharedApplication]registerUserNotificationSettings:setting];
    //    }
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self appInit];
    //初始化登陆操作

    [SMS_SDK registerApp:SMSAPPKEY withSecret:SMSAPPSECRET];
    [self loginInit];
    
    [self registerNotifications];
    
    [self intCurrentReachabilityStatus];
    
    return YES;
}


-(void)initTabBarController
{
    self.tabBarController = (UITabBarController *)self.window.rootViewController;
    
    UITabBar *tabBar = self.tabBarController.tabBar;
    
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    
    tabBarItem1.title = @"首页";
    tabBarItem2.title = @"电话";
    tabBarItem3.title = @"我";
    tabBarItem4.title = @"关于小区";
    [tabBar setBackgroundColor:[UIColor whiteColor]];
    tabBar.tintColor = RGBCOLOR(241, 141, 0);
    if (IOS_VERSION>=7.0) {
        [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_home_selected"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_home"]];
        [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_phone_selected"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_phone"]];
        [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_me_selected"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_me"]];
        [tabBarItem4 setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_about_selected"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_about"]];
        //         CGRect frame = CGRectMake(0.0, 0, tabBar.frame.size.width, 48);
        //        UIView *v = [[UIView alloc] initWithFrame:frame];
        //
        //        [v setBackgroundColor:[[UIColor alloc] initWithRed:1.0
        //                                                     green:0.0
        //                                                      blue:0.0
        //                                                     alpha:0.1]];
        //
        //        [tabBar insertSubview:v atIndex:0];
        
        // Change the tab bar background
        //        UIImage* tabBarBackground = [UIImage imageNamed:@"bottom_bg.png"];
        //        [[UITabBar appearance] setBackgroundImage:tabBarBackground];
        //         [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"bottom_bg.png"]];
        //
        // Change the title color of tab bar items
        [[UITabBarItem appearance] setTitleTextAttributes: @{ NSForegroundColorAttributeName:[UIColor lightGrayColor], NSFontAttributeName:[UIFont systemFontOfSize:11], UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero]} forState:UIControlStateNormal];
        
        [[UITabBarItem appearance] setTitleTextAttributes: @{ NSForegroundColorAttributeName:RGBCOLOR(241, 141, 0), NSFontAttributeName:[UIFont systemFontOfSize:11], UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero]} forState:UIControlStateSelected];
        
        //        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"AGShareImageBG"] forBarMetrics:UIBarMetricsDefault];
        //        [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:60.0/255.0 green:116.0/255.0 blue:230.0/255.0 alpha:1.0]];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        [[UINavigationBar appearance] setTitleTextAttributes:@{ UITextAttributeTextColor:[UIColor blackColor],NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont fontWithName:@"ArialMT" size:18], UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetZero]}];
    }
}
- (void)appInit
{
    
    if ([[Config Instance] getIsRemember] == 1) {
        if ([[XMPPManager sharedInstance] isConnectXmpp]) {
            [System_Notification postNotificationName:Notif_Login object:nil];
        }
    }
    
    //初始化网络状态
    [self intCurrentReachabilityStatus];
    
}


/**
 *  初始化登陆操作
 */
-(void)loginInit{
    if ([[Config Instance] getIsRemember]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ShareDelegate.window.rootViewController = [storyboard instantiateInitialViewController];
        [ShareDelegate initTabBarController];
        NSString *phone = [[Config Instance] getPhoneNum];
        NSString *pwd = [[Config Instance]getPwd];
        [[LoginDao sharedManager] login:phone pwd:pwd withCompletionHandler:^(NSDictionary *loginDictionary, NSError *error) {
            if (!error) {
                if (0 == [[loginDictionary objectForKey:Y_Data] count]) {
                    return ;
                }
                if  ([[[loginDictionary objectForKey:Y_Data] objectForKey:Y_TYPE] integerValue] == 2) {
                    NSLog(@"%@",loginDictionary);
                    loginDictionary = [loginDictionary objectForKey:Y_Data];
                    NSString * username = phone;
                    LoginInfo *log = [LoginInfo objectWithKeyValues:loginDictionary];
                    
                    [[Config Instance] saveLoginInfo:log andUserName:username andPwd:pwd andIsRemember:1 ];
                    [[Config Instance] saveCookie:YES];
                    
                    //检查新版本
                    [[PublicClass sharedManager] getNewVersionWithCompletionHandler:^(NSDictionary *dictionary, NSError *error) {
                        if (!error) {
                            NSLog(@"%@",dictionary);
                            if (dictionary [Y_Data]) {
                                dictionary = dictionary[Y_Data];
                                versionUrl =  dictionary[@"versionUrl"];
                                if ([dictionary[@"forceUpdate"] intValue] == 0) {
                                    if (![Y_APP_VERSION isEqualToString:dictionary[@"version"]]) {
                                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"有最新版可以下载" delegate:self cancelButtonTitle:@"不需要" otherButtonTitles:@"尝尝鲜", nil];
                                        [alertView show];
                                    }
                                }
                                else{
                                    //强制更新
                                    [self alertView:nil didDismissWithButtonIndex:1];
                                }
                            }
                        }
                    }];
                    
                    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                    dispatch_group_t group = dispatch_group_create();
                    dispatch_group_async(group, queue, ^{
                        [System_Notification postNotificationName:Notif_Login object:nil];
                    });
                    dispatch_group_async(group, queue, ^{
                        CrashLogs *log =    [NSKeyedUnarchiver unarchiveObjectWithFile:CrasLlogPath];
                        if (log) {
                            AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
                            NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                                        log.errorContent,@"errorContent",
                                                        CrasLlogType,@"logType",
                                                        VERSIONTYPE,@"versionType",nil];
                            [manager POST:API_BASE_URL_STRING(URL_Error) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                NSDictionary *dictionary= responseObject;
                                if([dictionary[Y_Code] intValue]==Y_Code_Success){
                                    NSFileManager *defaultManager = [NSFileManager defaultManager];
                                    BOOL flag  =      [defaultManager removeItemAtPath:CrasLlogPath error:nil];
                                    if (flag) {
                                        NSLog(@"删除成功");
                                    }
                                }
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                NSLog(@"%@",[error localizedDescription]);
                            }];
                        }
                    });
                    
                    dispatch_group_async(group, queue, ^{
                        XMPPManager *manager= [XMPPManager sharedInstance];
                        if(manager.xmppStream == nil){
                            [manager setupStream];
                        }
                        [manager goOnline];
                    });
                }}
        }];
    }
    else{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        ShareDelegate.window.rootViewController = [storyboard instantiateInitialViewController];
        //        [ShareDelegate initTabBarController];
    }
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [self intCurrentReachabilityStatus];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //    self.unreadMessageNumbers = 0;
    //    if ([[Config Instance] isCookie] && isBecomActive && ![[XMPPManager sharedInstance] isConnectedXmpp] && self.reachableViaFlag != NotReachable) {
    //        HUD = [[MBProgressHUD alloc] initWithView:self.window];
    //        [self.window addSubview:HUD];
    //        HUD.delegate = self;
    //        HUD.labelText = @"Loading";
    //        [HUD show:YES];
    //        [HUD hide:YES afterDelay:8];
    //    }
    //    isBecomActive = 1;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//检查版本弹出框
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:versionUrl]];
        UIWindow *window = ShareDelegate.window;
        [UIView animateWithDuration:1.0f animations:^{
            window.alpha = 0;
            window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
        } completion:^(BOOL finished) {
            exit(0);
        }];
    }
    
}

//监听
-(void)registerNotifications{
    
    //
    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);
    //监听登陆响应
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginRequestDidFinished:) name:Notif_Login object:nil];
    //监听网络
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    //在进入到前台时， 监听xmpp所有初始化完成
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(xmppInitializeFinish:)
                                                 name:Notif_FromBecomeActive_XMPP
                                               object:nil];
    
}

void UncaughtExceptionHandler(NSException *exception) {
    NSArray *arr = [exception callStackSymbols];//得到当前调用栈信息
    NSString *reason = [exception reason];//非常重要，就是崩溃的原因
    NSString *name = [exception name];//异常类型
    CrashLogs  *log = [[CrashLogs alloc]init];
    log.errorContent =[NSString stringWithFormat:@"exception type : %@ \n crash reason : %@ \n call stack info : %@", name, reason, arr];
    log.logType = CrasLlogType;
    //归档
    BOOL flag =  [NSKeyedArchiver archiveRootObject:log toFile:CrasLlogPath];
    if (flag) {
        NSLog(@"归档成功");
    }
    
}


/**
 *XMPP初始化完成
 */
-(void) xmppInitializeFinish:(NSNotification*)aNotification
{
    if (HUD) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [HUD removeFromSuperview];
            HUD = nil;
        });
    }
}

//登陆响应
-(void)loginRequestDidFinished:(NSNotification *)aNotification{
    
    
    
}

- (void)reachabilityChanged:(NSNotification *)notification
{
    
    Reachability* curReach = [notification object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    self.reachableViaFlag = [curReach currentReachabilityStatus];
    
    UITabBarItem *tabBarItem1;
    if (self.tabBarController != nil) {
        UITabBar *tabBar = self.tabBarController.tabBar;
        tabBarItem1 = [tabBar.items objectAtIndex:0];
    }
    
    //网络不可用
    if (self.reachableViaFlag == NotReachable && self.previousReachableViaFlag != self.reachableViaFlag)
    {
        [[CheckNetwork sharedManager] notReachableAlertView];
        
    }
    //WIFI
    else if (self.reachableViaFlag == ReachableViaWiFi){
        
        
        if ([[Config Instance] getIsRemember] == 1&&[[XMPPManager sharedInstance] isConnectXmpp] == NO) {
            [[XMPPManager sharedInstance] connect];
        }
    }
    //3G等
    else if (self.reachableViaFlag == ReachableViaWWAN){
        
        if ([[Config Instance] getIsRemember] == 1 && [[XMPPManager sharedInstance] isConnectXmpp] == NO) {
            [[XMPPManager sharedInstance] connect];
        }
    }
    self.previousReachableViaFlag = self.reachableViaFlag;
}

//当前网络状态
-(void)intCurrentReachabilityStatus{
    
    self.reachability= [Reachability reachabilityForInternetConnection];
    [self.reachability startNotifier];
    //NSLog(@"currentReachabilityStatus flag: %d",[self.reachability currentReachabilityStatus]);
    self.reachableViaFlag = [self.reachability currentReachabilityStatus];
    
    self.previousReachableViaFlag = 10;
    if (self.reachableViaFlag == NotReachable) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kReachabilityChangedNotification
                                                            object:self.reachability];
    }
}

- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}


@end
