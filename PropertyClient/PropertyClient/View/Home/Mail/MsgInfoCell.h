//
//  MsgInfoCell.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/29.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Msg.h"
@interface MsgInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sendTime;




-(void)settingData:(Msg *)meg;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
