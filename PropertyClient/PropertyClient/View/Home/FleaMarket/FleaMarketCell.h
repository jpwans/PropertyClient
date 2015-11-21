//
//  FleaMarketCell.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/25.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FleaMarket.h"
@interface FleaMarketCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *publishTime;
@property (weak, nonatomic) IBOutlet UILabel *nowPrice;
@property (weak, nonatomic) IBOutlet UIImageView *FleaImageView;
@property (weak, nonatomic) IBOutlet UILabel *purityType;

-(void)settingData:(FleaMarket *)fleaMarket;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
