//
//  CarCell.h
//  PropertyClient
//
//  Created by MoPellet on 15/7/1.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarManage.h"
@interface CarCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *phone;


-(void)settingData:(CarManage *)carManage;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
