//
//  UINavigationItem+NavButton.m
//  UnisouthParents
//
//  Created by neo on 14-6-11.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import "UINavigationItem+NavButton.h"

@implementation UINavigationItem (NavButton)



-(void)modfyNavLeftButton :(NSString *)title action :(SEL)action target:(id)atarget
{
    //设置左上角按钮
    NSArray *nibs=[[NSBundle mainBundle] loadNibNamed:@"LeftNavBtn" owner:self options:nil];
    UIButton *aLeftBtn=[nibs objectAtIndex:0];
    [aLeftBtn addTarget:atarget action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarBtn=[[UIBarButtonItem alloc] initWithCustomView:aLeftBtn];
    self.leftBarButtonItem = leftBarBtn;
    leftBarBtn = nil ;
    
}

@end
