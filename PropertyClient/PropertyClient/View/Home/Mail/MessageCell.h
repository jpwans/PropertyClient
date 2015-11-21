//
//  MessageCell.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/28.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageDB.h"
@interface MessageCell : UITableViewCell
//{
// UIImageView *isReadImage;
//}
@property (weak, nonatomic) IBOutlet UIImageView *typeImage;
@property (weak, nonatomic) IBOutlet UILabel *msgType;
@property (weak, nonatomic) IBOutlet UILabel *msgTime;
@property (weak, nonatomic) IBOutlet UILabel *msgDesc;
@property (nonatomic, strong) UIImageView *isReadImage;

-(void)settingData:(MessageDB *)messageDB;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
