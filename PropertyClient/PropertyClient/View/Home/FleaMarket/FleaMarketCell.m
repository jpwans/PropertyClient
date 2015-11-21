//
//  FleaMarketCell.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/25.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "FleaMarketCell.h"

@implementation FleaMarketCell

- (void)awakeFromNib {
    // Initialization code
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.frame.size.height - 1, SCREEN_WIDTH, 1.0f);
    bottomBorder.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor;
    [self.layer addSublayer:bottomBorder];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)settingData:(FleaMarket *)fleaMarket{
   int purityType = [fleaMarket.purityType intValue];
    NSString *purity = @"【全新】";
    switch (purityType) {
        case 0:
            purity = @"【全新】";
            break;
        case 1:
            purity = @"【95成新】";
            break;
        case 2:
            purity = @"【9成新】";
            break;
        case 3:
            purity = @"【8成新】";
        case 4:
            purity = @" 【7成新以下】";
            break;
        default:
            purity = @"全新";
            break;
    }
    _purityType.text = purity;
    self.goodsName.text = fleaMarket.goodsName;
    self.publishTime.text = [fleaMarket.endTime substringToIndex:16];
    self.nowPrice.text = fleaMarket.transferPrice;
//    NSArray * array = [fleaMarket.photo componentsSeparatedByString:@"&#"];
    NSString *photoId = fleaMarket.image;
    NSString *urlStr  = [NSString stringWithFormat:@"%@%@",URL_QINIU,photoId];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    [self.FleaImageView.layer setCornerRadius:CGRectGetHeight([self.FleaImageView bounds]) / 2];
    self.FleaImageView.layer.masksToBounds = YES;
    self.FleaImageView.layer.borderWidth = 2;
    self.FleaImageView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.FleaImageView.layer.contents = (id)[[UIImage imageNamed:@"aio_image_default"] CGImage];

    [self.FleaImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"aio_image_default"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];

    
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"status";
    FleaMarketCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FleaMarketCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
@end
