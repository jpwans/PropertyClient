//
//  ComplaintsCell.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/19.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Complaints.h"
@interface ComplaintsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *descImage;
@property (weak, nonatomic) IBOutlet UIView *descView;


-(void)settingData:(Complaints *)complaints;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
