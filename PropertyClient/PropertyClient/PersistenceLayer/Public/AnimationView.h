//
//  anima.h
//  图片动画
//
//  Created by MoPellet on 15/6/15.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationView : UIView
{
    UIView *animationView;
    UILabel *lable;
    UIImageView *mainImageView;
//     AnimationView *animationClass;
}
+ (AnimationView*)animationClass;

//+(void)hideView ;
//+(void)createAnimation:(BOOL )flag toText:(NSString *)text  toView:(UIView *)superView;
-(void)hideViewToView:(UIView *)superView;
-(void)createAnimation:(BOOL )flag toText:(NSString *)text  toView:(UIView *)superView;


@end
