//
//  CommentsTableViewCell.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/22.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "CommentsTableViewCell.h"

@implementation CommentsTableViewCell

- (void)awakeFromNib {
    // Initialization code
//    self.backgroundColor = RGBCOLOR(230, 230, 230);
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//赋值 and 自动换行,计算出cell的高度
//-(void)setReplyText:(NSString*)text{
//    //获得当前cell高度
//    CGRect frame = [self frame];
//    //文本赋值
//    self.replyLable.text = text;
//    //设置label的最大行数
//    self.replyLable.numberOfLines = 0;
//    CGSize size = CGSizeMake(self.replyLable.frame.size.width, 1000);
//    CGSize labelSize = [self.replyLable.text sizeWithFont:self.replyLable.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
//    self.replyLable.frame = CGRectMake(self.replyLable.frame.origin.x, self.replyLable.frame.origin.y, labelSize.width, labelSize.height);
//    
//    //计算出自适应的高度
//    frame.size.height = labelSize.height+10;
//    self.frame = frame;
//}

-(void)setReplyText:(NSString*)text{
    //获得当前cell高度
    CGRect frame = [_replyLable frame];
    //文本赋值
    _replyLable.text = text;

    // 列寬
    CGFloat contentWidth = _replyLable.frame.size.width;
    // 用何種字體進行顯示
    UIFont *font = [UIFont systemFontOfSize:14];
    // 該行要顯示的內容
    //    NSString *content = [_arr objectAtIndex:row];
    // 計算出顯示完內容需要的最小尺寸
    CGSize heightSize = [text sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, 1000.0f) lineBreakMode:UILineBreakModeWordWrap];
    
    // 這裏返回需要的高度
    frame.size.height = heightSize.height;
    frame.size.width = SCREEN_WIDTH-72;
    
    float poor = 0;
    if ( heightSize.height>20) {
        poor = heightSize.height -20;
    }
    //    CGRect msgFrame = [_msgView frame];
    //    msgFrame  .size.height = msgFrame.size.height +poor;

    dispatch_async(dispatch_get_main_queue(), ^{
        _replyLable.frame = frame;
    });

    
    
    CGRect cellFrame = [self frame];
    cellFrame.size.height = cellFrame.size.height +poor;
    self.frame = cellFrame;
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.frame.size.height - 1, SCREEN_WIDTH, 1.0f);
    bottomBorder.backgroundColor =  [UIColor colorWithRed:227.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor;
    [self.layer addSublayer:bottomBorder];
}



-(void)settingData:(Comments *)comments{
    int sex = [comments.userSex intValue];
    NSString *nickName =[comments.userName substringToIndex:1];
    self.name.text =sex==1?[ nickName stringByAppendingString:@"先生："]:[ nickName stringByAppendingString:@"女士："];
    
         self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.time.text = [comments.commTime substringToIndex:10];
    [self setReplyText:comments.content];
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"status";
    CommentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CommentsTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
@end


