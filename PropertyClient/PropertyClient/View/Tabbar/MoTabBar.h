

#import <UIKit/UIKit.h>
@class MoTabBar;

@protocol MoTabBarDelegate <NSObject>

@optional
- (void)tabBar:(MoTabBar *)tabBar didSelectButtonFrom:(int )from to:(int )to;

@end

@interface MoTabBar : UIView
@property (nonatomic, weak) id<MoTabBarDelegate> delegate;

/**
 *  用来添加一个内部的按钮
 *
 *  @param name    按钮图片
 *  @param selName 按钮选中时的图片
 */
- (void)addTabButtonWithName:(NSString *)name selName:(NSString *)selName;
@end
