//
//  MessageCell.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/28.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (void)awakeFromNib {
    // Initialization code
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(10.0f, self.frame.size.height - 1, SCREEN_WIDTH, 1.0f);
    bottomBorder.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor;
    [self.layer addSublayer:bottomBorder];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)settingData:(MessageDB *)messageDB{
    int status = [messageDB.status intValue];
    int type= [messageDB.type intValue];
    NSString *typeTitle = @"小区提醒";
    NSString * imageName = @"message_remind.png";
    switch (type) {
        case 0:
            imageName = @"message_estate.png";
            typeTitle = @"小区通知";
            break;
        case 1:
            imageName = @"message_fast.png";
                 typeTitle = @"紧急通知";
            break;
        case 2:
             imageName = @"message_repair.png";
                    typeTitle = @"报修通知";
            break;
        case 3:
             imageName = @"message_cost.png";
                   typeTitle = @"物业费通知";
            break;
        default:
             imageName = @"message_remind.png";
            typeTitle = @"小区提醒";
            break;
    }

    self.typeImage.image = [UIImage imageNamed:imageName];
    self.msgType.text =typeTitle;
    self.msgDesc.text =messageDB.content;
    self.msgTime.text = messageDB.time;
//    self.isReadImage.image =[UIImage imageNamed:status==1?@"newMail.png":@""];
    
    _isReadImage = [[UIImageView alloc] initWithFrame:CGRectMake(_typeImage.frame.origin.x +_typeImage.frame.size.width - remindSize/2,   _typeImage.frame.origin.y - remindSize/2, remindSize, remindSize)];
   _isReadImage.image =[UIImage imageNamed:status==1?@"newMail.png":@""];
    [self addSubview:_isReadImage];
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"status";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageCell" owner:nil options:nil] lastObject];
    }
    return cell;
}


@end
