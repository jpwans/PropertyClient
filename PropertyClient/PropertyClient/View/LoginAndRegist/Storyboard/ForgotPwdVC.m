//
//  ForgotPwdVC.m
//  WuYeO2O
//
//  Created by MoPellet on 15/5/15.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "ForgotPwdVC.h"

@interface ForgotPwdVC ()<UIAlertViewDelegate,UITextFieldDelegate>
{
    UIButton *_authCodeBtn;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextItem;

@end

@implementation ForgotPwdVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:BACKGROUND_COLOR];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.view.backgroundColor = BACKGROUND_COLOR;
    _updatePwdBtn.backgroundColor = BACKGROUND_COLOR;
    _phoneNumberField.backgroundColor = [UIColor whiteColor];
    _authCodeField.backgroundColor = [UIColor whiteColor];
    _firstNewPassField.backgroundColor=[UIColor whiteColor];
    _secondNewPassField.backgroundColor = [UIColor whiteColor];
    //    self.view.backgroundColor = BACKGROUND_COLOR;
    _updatePwdBtn.hidden=YES;//隐藏掉NEXT换到导航栏
    
    
    [self drawUnderBorderWithBtn:_phoneNumberField];
    [self drawUnderBorderWithBtn:_authCodeField];
    [self drawUnderBorderWithBtn:_firstNewPassField];
    [self drawUnderBorderWithBtn:_secondNewPassField];
}

-(void)drawUnderBorderWithBtn:(UITextField *)textField{
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, textField.frame.size.height - 1, self.view.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor;
    [textField.layer addSublayer:bottomBorder];
}
- (void)viewDidAppear:(BOOL)animated
{
    
    //    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    _phoneNumberField.text = self.prePhoneNumber;
    if (self.prePhoneNumber.length) {
        _updatePwdBtn.enabled = YES;
        [_updatePwdBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //        [_updatePwdBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_normal.png"] forState:UIControlStateNormal];
        //        [_updatePwdBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_setected.png"] forState:UIControlStateHighlighted];
    } else {
        _updatePwdBtn.enabled = YES;
        //        [_updatePwdBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_unsetected.png"] forState:UIControlStateHighlighted];
    }
    
    
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creteAuthCode];
    _updatePwdBtn.enabled = YES;
    
    //设置代理
    _firstNewPassField.delegate =self;
    _secondNewPassField.delegate=self;
    
    
}

-(void)creteAuthCode{
    //添加获取验证码
    _authCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _authCodeBtn.frame = CGRectMake(STATUS_HEIGHT, self.view.bounds.size.height-40, 100, _authCodeField.bounds.size.height-5);
    [_authCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _authCodeBtn.backgroundColor = BACKGROUND_COLOR;
    _authCodeBtn.titleLabel.font =SystemFont(13);
    [_authCodeBtn addTarget:self action:@selector(getAuthCode:) forControlEvents:UIControlEventTouchUpInside];
    _phoneNumberField.rightView = _authCodeBtn;
    _phoneNumberField.rightViewMode = UITextFieldViewModeAlways;
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==_firstNewPassField) {
        [_secondNewPassField becomeFirstResponder];
    }else if (textField==_secondNewPassField){
        [self updatePwdAction:nil];
    }
    return YES;
}
#pragma Actions
-(void)getAuthCode:(id)sender{
    //网络检测
    CHECKNETWORK
    if ([_phoneNumberField.text trimString].length==11){
        
        [SMS_SDK getVerificationCodeBySMSWithPhone:[_phoneNumberField.text trimString]
                                              zone:@"86"
                                            result:^(SMS_SDKError *error)
         {
             if (!error) {
                 [self.view makeToast:@"验证码发送成功！" duration:1.5f position:@"center"];
                    [self startTime];
             }
             else{
                 NSLog(@"%ld,%@",(long)error.errorCode,error.errorDescription);
                 [self.view makeToast:@"验证码发送失败！" duration:1.5f position:@"center"];
             }
         }];
     
    }
    else{
        [self.view makeToast:@"您输入手机格式不正确！" duration:1.5f position:@"center"];
    }
    
}


-(void)startTime{
    __block int timeout=30; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_authCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                _authCodeBtn.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                
                [_authCodeBtn setTitle:[NSString stringWithFormat:@"获取验证码(%@)",strTime] forState:UIControlStateNormal];
                _authCodeBtn.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}

- (IBAction)updatePwdAction:(id)sender {
    NSLog(@"设置密码");
    if (![_phoneNumberField.text trimString].length) {
        return;
    }
    //检测密码
    if (![_firstNewPassField.text isEqualToString:_secondNewPassField.text]) {
        [self.view makeToast:@"您两次输入的密码不一致！" duration:1.5f position:@"center"];
        _firstNewPassField.text=@"";
        _secondNewPassField.text = @"";
        return ;
    }
    //网络检测
    CHECKNETWORK
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *code = [_authCodeField.text trimString];
    NSString *phone = [_phoneNumberField.text trimString];
    NSString *pwd = _firstNewPassField.text;
    pwd = [DES3Util encrypt:pwd];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:SMSAPPKEY ,@"appkey",phone,@"phone" ,ZONE,@"zone",code,@"code",nil];
    [manager POST:@"https://api.sms.mob.com/sms/verify" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic= responseObject;
        int status = [dic[@"status"] intValue];
        if (200==status) {
            NSString *parm =[NSString stringWithFormat:@"%@&#%@&#%@",phone,pwd,LoginType];
            parm =   [DES3Util encrypt:parm];
            NSDictionary  *part = [NSDictionary dictionaryWithObjectsAndKeys:parm,@"userInfo",nil];
            [manager POST:API_BASE_URL_STRING(URL_FORGETPWD) parameters:part success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSDictionary *dictionary = responseObject;
                NSLog(@"%@",dictionary);
                if (dictionary) {
                    int code = [dictionary[@"code"] intValue];
                    if (1==code) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [[[UIAlertView alloc] initWithTitle:@"提醒信息" message:dictionary[Y_Message] delegate:self cancelButtonTitle:@"返回登陆" otherButtonTitles:nil] show];
                    }
                    //展示显示信息
                    [self.view makeToast:[NSString stringWithFormat:@"%@",dictionary[Y_Message]] duration:1.5f position:@"center"];
                    
                }
          
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"%@",[error localizedDescription]);
            }];
        }
        else{
            [self.view makeToast:@"您输入的验证码有误！" duration:1.5f position:@"center"];
            [MBProgressHUD hideHUDForView:self.view animated:YES];

        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
    
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (0==buttonIndex) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}



@end
