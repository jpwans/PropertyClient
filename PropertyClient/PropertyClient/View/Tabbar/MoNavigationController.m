//
//  MoNavigationController.m
//  MoLottery
//
//  Created by 万子文 on 15/4/23.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#import "MoNavigationController.h"

@interface MoNavigationController ()

@end

@implementation MoNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

}
+(void)initialize{ //第一次调用这个类的时候
    //设置导航栏主题
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    // navBar.tintColor = [UIColor colorWithRed:238.0/255.0 green:85.0/255.0 blue:47.0/255.0 alpha:1.0];
    [navBar setBarTintColor:BACKGROUND_COLOR];
    [navBar setTintColor:[UIColor whiteColor]];

    //    NSString *bgName = @"NavBar";
    //    if (IOS7) {
    //        bgName=@"NavBar64";
    //    }
    
//     [navBar setBackgroundImage:[UIImage imageNamed:bgName] forBarMetrics:UIBarMetricsDefault];
    NSMutableDictionary *dicts = [NSMutableDictionary dictionary];
    dicts[NSForegroundColorAttributeName] =  [UIColor whiteColor];
    dicts[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    navBar.titleTextAttributes = dicts;
    // 设置barbutton
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] =  [UIColor whiteColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    
    //设置返回按钮背景
    [item setBackButtonBackgroundImage: [UIImage imageNamed:@"icon_back_normal"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [item setBackButtonBackgroundImage: [UIImage imageNamed:@"icon_back_selected"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
//    [item setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
//
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    viewController.hidesBottomBarWhenPushed = YES;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
        backItem.title = @"";
    viewController.navigationItem.backBarButtonItem = backItem;
    [super pushViewController:viewController animated:animated];
}

@end
