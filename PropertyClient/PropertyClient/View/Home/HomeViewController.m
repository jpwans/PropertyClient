//
//  HomeViewController.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/15.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "HomeViewController.h"
#import "CoreDateManager.h"
#import "MessageDB.h"
@interface HomeViewController ()
{
    CoreDateManager *coreManager;
    UIImageView *isReadImage;
}
@property (nonatomic, strong) NSMutableArray *arrays;
@property (weak, nonatomic) IBOutlet UIButton *mailView;

@end

@implementation HomeViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //隐藏导航栏
    
    //    [UIView beginAnimations:nil context:nil];
    //    [UIView setAnimationDuration:1.0];
    //    [self.navigationController setNavigationBarHidden:YES];
    //     self.navigationController.navigationBar.alpha = 0;
    
    //    [UIView commitAnimations];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    //
    
    //     self.navigationController.navigationBar.alpha = 0;
    
    //    self.edgesForExtendedLayout =UIRectEdgeAll;
    //
    //    // 要设置成全屏布局才能看到效果，默认就是全屏的//
    //    self.navigationController.navigationBar.translucent = true;
    //
    //        UINavigationBar *bar = self.navigationController.navigationBar;
    //        [bar setBackgroundImage:[UIImage imageNamed:@"action-black-button"] forBarMetrics:UIBarMetricsCompact];
    //
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newMsgIsCome:) name:Notif_XMPP_NewMsg object:nil];
    [self newMsgIsCome:nil];
}
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];

//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:0.1];
//    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                  forBarMetrics:UIBarMetricsDefault]; //UIImageNamed:@"transparent.png"
//    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
//    self.navigationController.navigationBar.translucent = YES;
//    self.navigationController.view.backgroundColor = [UIColor clearColor];
//    
////        [UIView commitAnimations];
    [UIView animateWithDuration:0.5 animations:^{
//        self.navigationController.navigationBar.alpha = 0;
        
            [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                          forBarMetrics:UIBarMetricsDefault]; //UIImageNamed:@"transparent.png"
            self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
            self.navigationController.navigationBar.translucent = YES;
            self.navigationController.view.backgroundColor = [UIColor clearColor];
        
    }];
    
    
}
- (void)viewDidLoad {
    //    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    //        self.edgesForExtendedLayout = UIRectEdgeNone;
    //    self.view.bounds = BOTTOM_FRAME;
    [super viewDidLoad];
    coreManager = [[CoreDateManager alloc] init];
    
//    [[Config Instance ]getRoleType];
    NSLog(@"角色ID：%@",[[Config Instance ]getRoleType]);
}
-(void)newMsgIsCome:(NSNotification *)notifacation
{
    if (isReadImage) {
        [isReadImage removeFromSuperview];
    }
   
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        _arrays = [[NSMutableArray alloc] init];
        _arrays=[coreManager msgGroupByType];
        dispatch_async(dispatch_get_main_queue(),^{
            isReadImage = [[UIImageView alloc] initWithFrame:CGRectMake(_mailView.frame.origin.x +_mailView.frame.size.width - remindSize/2,   _mailView.frame.origin.y - remindSize/2, remindSize, remindSize)];
            for (int i = 0; i<_arrays.count; i++) {
                MessageDB *messageDB = self.arrays[i];   
                if ([messageDB.status intValue]==1) {
                    isReadImage.image =[UIImage imageNamed:@"newMail.png"];
                    isReadImage.hidden = NO;
                    break;
                }
                else {
                    isReadImage.image =[UIImage new];
                      isReadImage.hidden = YES;
                }
            }
            [self.view addSubview:isReadImage];
        });
    });
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Notif_XMPP_NewMsg object:nil];
}




@end
