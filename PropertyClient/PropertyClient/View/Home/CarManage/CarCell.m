//
//  CarCell.m
//  PropertyClient
//
//  Created by MoPellet on 15/7/1.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "CarCell.h"

@implementation CarCell

- (void)awakeFromNib {
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.frame.size.height-1, SCREEN_WIDTH, 1.0f);
    bottomBorder.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor;
    [self.layer addSublayer:bottomBorder];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
-(void)settingData:(CarManage *)carManage{
    _name.text = carManage.carOwner;
    _address.text =[NSString stringWithFormat:@"%@/%@/%@",carManage.buildingNo,carManage.unitNo,carManage.roomNo];
    _phone.text = carManage.phone;

}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"status";
    CarCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CarCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
@end
