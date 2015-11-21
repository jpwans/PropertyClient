//
//  MsgInfoCell.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/29.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "MsgInfoCell.h"
@interface MsgInfoCell (){
    UIImage *_receiveImage;
}
@end
@implementation MsgInfoCell

- (void)awakeFromNib {
    _receiveImage = [UIImage imageNamed:@"SenderAppCardNodeBkg"];
    _receiveImage = [self stretcheImage:_receiveImage];
    
    self.backgroundColor =ALLBACKCOLOR;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

//赋值 and 自动换行,计算出cell的高度
-(void)setDescText:(NSString*)text{
    
    // 用何種字體進行顯示
    UIFont *font = [UIFont systemFontOfSize:14];
    // 計算出顯示完內容需要的最小尺寸
    CGSize heightSize = [text sizeWithFont:font constrainedToSize:CGSizeMake(SCREEN_WIDTH-20, 1000.0f) lineBreakMode:UILineBreakModeWordWrap];
    
    
    float poor = 0;
    if ( heightSize.height>20) {
        poor = heightSize.height -20;
    }
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(20, 35, SCREEN_WIDTH-33,  heightSize.height)];
    lable.text = text;
    
    lable.font = SystemFont(14);
    lable.numberOfLines = 0;
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:2];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [text length])];
    [lable setAttributedText:attributedString1];
    [lable sizeToFit];
    
//    lable .layer.borderWidth =1;
//    lable.layer.borderColor = [UIColor blackColor].CGColor;
    UIImage *bubble =[UIImage imageNamed:@"SenderAppCardNodeBkg"];
    UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:[self stretcheImage:bubble]];
    CGRect imageFrame  =CGRectMake(5, 25, SCREEN_WIDTH-10, lable.frame.size.height+25) ;
    bubbleImageView.frame = imageFrame;
    [self addSubview:bubbleImageView];
    [self addSubview:lable];
    CGRect cellFrame = [self frame];
    cellFrame.size.height = cellFrame.size.height +poor+15;
    self.frame = cellFrame;
}
//处理图片拉伸
-(UIImage *)stretcheImage:(UIImage *)img{
    return [img stretchableImageWithLeftCapWidth:img.size.width * 0.5  topCapHeight:img.size.height *0.6];
}

-(void)settingData:(Msg *)msg{
    int type = [msg.adviceType intValue];
    NSString *typeTitle = @"【小区提醒】";
    switch (type) {
        case 0:
            typeTitle = @"【小区通知】";
            break;
        case 1:
            typeTitle = @"【紧急通知】";
            break;
        case 2:
            
            typeTitle = @"【报修通知】";
            break;
        case 3:
            
            typeTitle = @"【物业费通知】";
            break;
        default:
            
            typeTitle = @"【小区提醒】";
            break;
    }
    
    //    self.typeTitle.text = typeTitle;
    self.sendTime.text = msg.publishDate;
    //    self.msgDesc.text = msg.content;
    [self setDescText:msg.content];
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"status";
    MsgInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MsgInfoCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
@end
