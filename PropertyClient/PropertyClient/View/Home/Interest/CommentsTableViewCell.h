//
//  CommentsTableViewCell.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/22.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comments.h"
@interface CommentsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *replyLable;

-(void)setReplyText:(NSString*)text;
-(void)settingData:(Comments *)comments;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
