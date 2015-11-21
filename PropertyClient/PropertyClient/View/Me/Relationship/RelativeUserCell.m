//
//  RelativeUserCell.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/29.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "RelativeUserCell.h"

@implementation RelativeUserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)settingData:(RelativeUser *)relativeUser{
    [self.headImage.layer setCornerRadius:CGRectGetHeight([self.headImage bounds]) / 2];
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.borderWidth = 3;
    self.headImage.layer.borderColor = [[UIColor redColor] CGColor];

    [self.headImage setImage:[UIImage imageNamed:@"me_head"]];
    if (relativeUser.photo.length) {
        NSString *urlStr  = [NSString stringWithFormat:@"%@%@",URL_QINIU,relativeUser.photo];
        NSURL *url = [NSURL URLWithString:urlStr];
        [_headImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"me_head"]];
    }
    self.name.text = relativeUser.name;
    NSString *sexImageName = [relativeUser.sex intValue]==1?@"icon_male":@"icon_female";
    _sexImage.image = [UIImage imageNamed:sexImageName];
    self.phoneNum.text = relativeUser.phone;
       self.relationship.text = relativeUser.label;
    
    
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"status";
    RelativeUserCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RelativeUserCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
@end
