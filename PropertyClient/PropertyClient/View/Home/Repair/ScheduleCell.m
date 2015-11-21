//
//  ScheduleCell.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/6/1.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "ScheduleCell.h"

@implementation ScheduleCell

- (void)awakeFromNib {
    // Initialization code
    
//    _descView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    _descView.layer.borderWidth =1;
//  _descView.layer.masksToBounds = YES;
//  _descView.layer.cornerRadius = 6.0;
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)settingData:(Schedule *)schedule{
    self.desc.text = schedule.scheduleRemark;
//    self.time.text =[NSString stringWithFormat:@"%@",schedule.scheduleTime] ;
    
    NSDate * dt = [NSDate dateWithTimeIntervalSince1970:[schedule.scheduleTime longLongValue]/1000];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *regStr = [df stringFromDate:dt];
    self.time.text = regStr;

}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"status";
    ScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ScheduleCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
@end
