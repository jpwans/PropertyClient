//
//  anima.m
//  图片动画
//
//  Created by MoPellet on 15/6/15.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#import "AnimationView.h"

@implementation AnimationView

static AnimationView *animationClass = nil;

+ (AnimationView*)animationClass
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        animationClass = [[super alloc] init];
    });
    return animationClass;
}

//+(void)hideView {
//    [[[AnimationView alloc]init] hideView];
//}
//+(void)createAnimation:(BOOL )flag toText:(NSString *)text  toView:(UIView *)superView{
//
//    [[[AnimationView alloc]init]createAnimation:flag toText:text toView:superView];
//}
-(void)hideViewToView:(UIView *)superView{
//    if (  animationView !=nil) {
//        animationView.hidden = YES;
//    }
    for(UIView *myView in [superView subviews])
    {
        if ([myView isKindOfClass:[UIView class]]){
            if (myView.tag==999) {
                [myView removeFromSuperview];
                
            }
        }
    }
}
-(void)createAnimation:(BOOL )flag toText:(NSString *)text  toView:(UIView *)superView{

    [self hideViewToView:superView];

    
    NSArray *array = flag ?[NSArray arrayWithObjects:
                            [UIImage imageNamed:@"loading01"],
                            [UIImage imageNamed:@"loading02"],
                            [UIImage imageNamed:@"loading03"],
                            [UIImage imageNamed:@"loading04"],
                            [UIImage imageNamed:@"loading05"],
                            [UIImage imageNamed:@"loading06"],nil]:[NSArray arrayWithObject:[UIImage imageNamed:@"loading03"]];
    
//    if (animationView==nil) {
        animationView = [[UIView alloc] initWithFrame:CGRectMake(0, (SCREEN_HEIGHT-120)/2, SCREEN_WIDTH, 120)];
        animationView .tag=999;
        mainImageView= [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-60)/2, 0, 60, 60)];
        
        lable = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2,60,100,20)];
        lable.textAlignment= NSTextAlignmentCenter;
        if (text==nil) {
            lable.text =flag?@"加载中。。。":@"没有更多内容...";
        }
        else{
            lable.text = text;
        }
        lable.font = SystemFont(13);
        lable.font = [UIFont systemFontOfSize:(13)];
        [  animationView  addSubview:lable];
        [  animationView  addSubview:mainImageView];
        [superView addSubview:  animationView ];
//    }
//    else{
//        if (text==nil) {
//            lable.text =flag?@"加载中。。。":@"没有更多内容...";
//        }
//        else{
//            lable.text = text;
//        }
//        animationView.hidden =NO;
//    }
    mainImageView.animationImages = array;
    [mainImageView setAnimationDuration:0.8f];
    [mainImageView setAnimationRepeatCount:0];
    [mainImageView startAnimating];
}


@end
