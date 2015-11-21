

#import "MoTabBarController.h"
#import "MoTabBar.h"
#import "MoTabBarButton.h"

@interface MoTabBarController () <MoTabBarDelegate>
{
//    BOOL b;
}
@end

@implementation MoTabBarController

- (void)viewDidLoad
{

    [super viewDidLoad];

    // 1.添加自己的tabbar
    MoTabBar *moTabBar = [[MoTabBar alloc] init];
    moTabBar.delegate = self;
    moTabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:moTabBar];
//    self.tabBar.frame.size.width
    NSLog(@"width:%f",self.tabBar.frame.size.width/self.viewControllers.count);
    NSLog(@"height:%f",self.tabBar.frame.size.height);
    // 2.添加对应个数的按钮
    for (int i = 0; i < self.viewControllers.count; i++) {
        NSString *name = [NSString stringWithFormat:@"TabBarIcon%d", i + 1];
        NSString *selName = [NSString stringWithFormat:@"TabBarIcon%dSel", i + 1];
        [moTabBar addTabButtonWithName:name selName:selName];
    }

 
}

/**
 normal : 普通状态
 highlighted : 高亮(用户长按的时候达到这个状态)
 disable : enabled = NO
 selected :  selected = YES
 */

#pragma mark - MJTabBar的代理方法
-(void)tabBar:(MoTabBar *)tabBar didSelectButtonFrom:(int)from to:(int)to;
{
//    NSLog(@"%d,%d",from,to);
//    if (0==from&&0==to&&b) {
//         NSLog(@"%d,%d",from,to);
//        b=false;
//    }
    // 选中最新的控制器
    self.selectedIndex = to;
}
@end