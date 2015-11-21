//
//  UITableView+Add.m
//  UnisouthParents
//
//  Created by neo on 14-6-11.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import "UITableView+Add.h"

@implementation UITableView (Add)

- (void)setExtraCellLineHidden {
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:view];
    [self setTableHeaderView:view];
    view = nil;
}

- (void)_setTableBackgroundView {
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:DEFAULT_FRAME];
    backImageView.image = [UIImage imageNamed:@"all_bg"];
    self.backgroundView = backImageView;
    backImageView = nil;
}

@end
