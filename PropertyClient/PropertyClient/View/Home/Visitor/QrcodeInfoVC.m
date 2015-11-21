//
//  QrcodeInfoVC.m
//  PropertyClient
//
//  Created by MoPellet on 15/7/1.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "QrcodeInfoVC.h"
#import "VisitorCard.h"
@implementation QrcodeInfoVC
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _name .text= _visitorCard.name;
    _community.text = _visitorCard.community;
    _phone.text = _visitorCard.phone.length?_visitorCard.phone:@"";
    _visitTime.text = _visitorCard.visitTime;
    _sexImageView.image =[UIImage imageNamed: [_visitorCard.sex intValue]==1?@"icon_male":@"icon_female"];
    _driveImageView.image = [UIImage imageNamed:[_visitorCard.isDrive intValue]==1?@"icon_car_green":@""];
    
    _outView.layer.masksToBounds = YES;
    _outView.layer.cornerRadius = 6.0;
    _outView.layer.borderWidth = 1.0;
    _outView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    _backBtn.layer.masksToBounds = YES;
    _backBtn.layer.cornerRadius = 6.0;
    _backBtn.layer.borderWidth = 1.0;
    _backBtn.layer.borderColor = [[UIColor clearColor] CGColor];
    
//    [self drawUnderBorderWithBtn:_name];
//    [self drawUnderBorderWithBtn:_community];
//    [self drawUnderBorderWithBtn:_phone];
//    [self drawUnderBorderWithBtn:_visitTime];
}


//-(void)drawUnderBorderWithBtn:(UILabel *)label{
//    CALayer *bottomBorder = [CALayer layer];
//    bottomBorder.frame = CGRectMake(0.0f, label.frame.size.height - 1, self.view.frame.size.width, 1.0f);
//    bottomBorder.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor;
//    [label.layer addSublayer:bottomBorder];
//}
- (IBAction)backHome:(UIButton *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
