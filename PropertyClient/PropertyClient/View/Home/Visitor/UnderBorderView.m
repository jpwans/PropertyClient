//
//  UnderBorderView.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/6/3.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "UnderBorderView.h"

@implementation UnderBorderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)drawRect:(CGRect)rect{

    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.frame.size.height - 1, SCREEN_WIDTH, 1.0f);
    bottomBorder.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor;
    [self.layer addSublayer:bottomBorder];
    
    
    [self setNeedsDisplay];
}

@end
