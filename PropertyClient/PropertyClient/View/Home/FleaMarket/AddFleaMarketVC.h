//
//  AddFleaMarketVC.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/25.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceholderTextView.h"
#import "GoodsCategory.h"
#import "PurityType.h"
@interface AddFleaMarketVC : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;




@property (weak, nonatomic) IBOutlet UITextField *goodsName;
@property (weak, nonatomic) IBOutlet UITextField *startTime;
@property (weak, nonatomic) IBOutlet UITextField *endTime;
@property (weak, nonatomic) IBOutlet UIPlaceholderTextView *goodsDesc;
@property (weak, nonatomic) IBOutlet UITextField *transferPrice;
@property (weak, nonatomic) IBOutlet UITextField *oldPrice;

- (IBAction)submit:(UIBarButtonItem *)sender;


@property (retain, nonatomic) IBOutlet UIScrollView *picScroller;
@property (retain, nonatomic) IBOutlet UIButton *plusButton;
//- (IBAction)clearPics:(id)sender;
- (IBAction)addPic:(id)sender;

@property (nonatomic, strong) GoodsCategory *goodsCategory;
@property (weak, nonatomic) IBOutlet UIButton *category;

@property (nonatomic, strong) PurityType *purityType;
@property (weak, nonatomic) IBOutlet UIButton *purity;

@end
