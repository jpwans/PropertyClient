//
//  RepairCell.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/6/1.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepairInfo.h"
@interface RepairCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *repairCreateTime;

@property (weak, nonatomic) IBOutlet UILabel *repairTitle;
@property (weak, nonatomic) IBOutlet UILabel *dealState;
@property (weak, nonatomic) IBOutlet UILabel *repairDesc;
@property (weak, nonatomic) IBOutlet UILabel *repairTime;
@property (weak, nonatomic) IBOutlet UIButton *isComplete;

@property (weak, nonatomic) IBOutlet UIView *picView;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIView *externalView;


-(void)settingData:(RepairInfo *)repairInfo;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
