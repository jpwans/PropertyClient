//
//  QrcodeInfoVC.h
//  PropertyClient
//
//  Created by MoPellet on 15/7/1.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VisitorCard;
@interface QrcodeInfoVC : UIViewController
@property (nonatomic, strong)  VisitorCard *visitorCard;
@property (weak, nonatomic) IBOutlet UIView *outView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *community;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *visitTime;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (weak, nonatomic) IBOutlet UIImageView *driveImageView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

- (IBAction)backHome:(UIButton *)sender;

@end
