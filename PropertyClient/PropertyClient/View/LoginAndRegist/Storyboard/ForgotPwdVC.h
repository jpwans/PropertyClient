//
//  ForgotPwdVC.h
//  WuYeO2O
//
//  Created by MoPellet on 15/5/15.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPwdVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet UITextField *authCodeField;
@property (weak, nonatomic) IBOutlet UITextField *firstNewPassField;
@property (weak, nonatomic) IBOutlet UITextField *secondNewPassField;
@property (weak, nonatomic) IBOutlet UIButton *updatePwdBtn;
@property (nonatomic, strong) NSString *prePhoneNumber;

@end
