//
//  ComplaintsCell.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/19.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "ComplaintsCell.h"

@implementation ComplaintsCell

- (void)awakeFromNib {
    // Initialization code
//    self.descView.layer.masksToBounds = YES;
//    self.descView.layer.cornerRadius = 6.0;
//    self.descView.layer.borderWidth = 1.0;
//    self.descView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.frame.size.height - 1, SCREEN_WIDTH, 1.0f);
    bottomBorder.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor;
    [self.layer addSublayer:bottomBorder];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)settingData:(Complaints *)complaints{
    NSArray * array = [complaints.photo componentsSeparatedByString:@"&#"];
    NSString *photoId = array[0];
    NSString *urlStr  = [NSString stringWithFormat:@"%@%@",URL_QINIU,photoId];
    NSURL *url = [NSURL URLWithString:urlStr];
    [self.descImage.layer setCornerRadius:CGRectGetHeight([self.descImage bounds]) / 2];
    self.descImage.layer.masksToBounds = YES;
    self.descImage.layer.borderWidth = 3;
    self.descImage.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self.descImage setImage:[UIImage imageNamed:@"aio_image_default"]];
    [_descImage sd_setImageWithURL:url placeholderImage: [UIImage imageNamed:@"aio_image_default"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _descImage.image = _descImage.image;
    }];
    
    self.title.text = complaints.compTitle;
    self.desc.text = complaints.describe;
    self.time.text = complaints.compTime;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    ComplaintsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ComplaintsCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
@end
