//
//  RelativeUserCell.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/29.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RelativeUser.h"
@interface RelativeUserCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *sexImage;

@property (weak, nonatomic) IBOutlet UILabel *relationship;
@property (weak, nonatomic) IBOutlet UILabel *phoneNum;



-(void)settingData:(RelativeUser *)relativeUser;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
