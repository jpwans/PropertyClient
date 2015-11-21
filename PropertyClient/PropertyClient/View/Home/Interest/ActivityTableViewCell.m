//
//  ActivityTableViewCell.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/21.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "ActivityTableViewCell.h"
@implementation ActivityTableViewCell

- (void)awakeFromNib {
    // Initialization code
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.frame.size.height - 2, SCREEN_WIDTH, 1.0f);
    bottomBorder.backgroundColor =  RGBCOLOR(230, 230, 230).CGColor;
    [self.layer addSublayer:bottomBorder];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


-(void)settingData:(Activity *)activity{

    self.countdown.text = [activity.starttime substringToIndex:16];


//    self.layer.masksToBounds = YES;
//    self.layer.cornerRadius = 1.0;
//    self.layer.borderWidth = 1.0;
//    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];

   self.title.text = activity.title;
    self.place.text = [NSString stringWithFormat:@"地点：%@",activity.place];
    self.publishtime.text = [activity.publishtime substringToIndex:10];
    self.comAndName.text = [activity.communityName stringByAppendingString:activity.name];
    [self.contentImage.layer setCornerRadius:CGRectGetHeight([self.contentImage bounds]) / 2];
    self.contentImage.layer.masksToBounds = YES;
    self.contentImage.layer.borderWidth = 0;
    self.contentImage.layer.borderColor = [[UIColor redColor] CGColor];
    self.contentImage.layer.contents = (id)[[UIImage imageNamed:@"me_head"] CGImage];
    _startTime.text = [activity.starttime substringToIndex:16];
    _endTime.text = [activity.endtime substringToIndex:16];
//    _countdown . text
    
    self.place.text = activity.place;
    if (activity.photo.length>0) {

    NSArray * array = [activity.photo componentsSeparatedByString:@"&#"];
    NSString *photoId = array[0];
    NSString *urlStr  = [NSString stringWithFormat:@"%@%@",URL_QINIU,photoId];
    NSURL *url = [NSURL URLWithString:urlStr];
  
    [self.contentImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"1-03"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         self.contentImage.layer.contents = (id)[self.contentImage.image CGImage];
    }];
     
    }
    self.commentCount.text  =[NSString stringWithFormat:@"%@",activity.commentCount];
   
    _countdown .text = [activity.publishtime substringToIndex:16];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//    NSDate *date=[formatter dateFromString: [activity.publishtime substringToIndex:16]];
//  NSString *temp
//     = [[Config Instance] getFormatterDate:date];
//    _countdown.text = temp;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ActivityTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}



@end
