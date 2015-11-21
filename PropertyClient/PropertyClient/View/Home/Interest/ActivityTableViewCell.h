//
//  ActivityTableViewCell.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/21.
//  Copyright (c) 2015年 neo. All rights reserved.
//
#import "Activity.h"
#import <UIKit/UIKit.h>

@interface ActivityTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *contentImage;
@property (weak, nonatomic) IBOutlet UILabel *publishtime;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *place;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (weak, nonatomic) IBOutlet UILabel *countdown;
@property (weak, nonatomic) IBOutlet UILabel *startAndEndTime;
@property (weak, nonatomic) IBOutlet UILabel *comAndName;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;


-(void)settingData:(Activity *)activity;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
