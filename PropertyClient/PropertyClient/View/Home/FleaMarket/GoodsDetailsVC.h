//
//  GoodsDetailsVC.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/25.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FleaMarket.h"
#import "MMScrollPage.h"
#import "MMScrollPresenter.h"
@interface GoodsDetailsVC : UIViewController<UIActionSheetDelegate>
@property (nonatomic, strong) FleaMarket *fleaMarket;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *publishTime;
@property (weak, nonatomic) IBOutlet UILabel *oldPrice;
@property (weak, nonatomic) IBOutlet UILabel *nowPrice;
@property (weak, nonatomic) IBOutlet UIImageView *headPhoto;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UITextView *goodsDesc;
@property (weak, nonatomic) IBOutlet UILabel *purityType;
- (IBAction)callPhone:(id)sender;

- (IBAction)smsAction:(id)sender;

@property (weak, nonatomic) IBOutlet MMScrollPresenter *mmScrollPresenter;
@property (nonatomic, strong) NSMutableArray *arrays;


@end
