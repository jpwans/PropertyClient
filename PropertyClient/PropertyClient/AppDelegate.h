

#import <UIKit/UIKit.h>
//#import "DBCenter.h"
#import "Common/Network/Reachability.h"
#import "Common/MBProgressHUD/MBProgressHUD.h"

@class LoginViewController;
@class LoginVC;
//@class DBCenter;

@interface AppDelegate : UIResponder <UIApplicationDelegate,MBProgressHUDDelegate>
{
    UITabBarController *tabBarController;
    MBProgressHUD *HUD;
    
//@public
//    DBCenter *databaseService;
}

- (void)initTabBarController;

@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic)  LoginVC *appLoginViewController;
//@property (readonly, nonatomic) DBCenter *databaseService;


@property (strong, nonatomic) Reachability *xmppHostReach;
@property (strong, nonatomic) Reachability *reachability;
@property (assign, nonatomic) NetworkStatus reachableViaFlag;//	NotReachable = 0,ReachableViaWiFi,ReachableViaWWAN
@property (assign, nonatomic) NetworkStatus previousReachableViaFlag;

@property (nonatomic) NSInteger	unreadMessageNumbers;	//未读的消息条数

@end

