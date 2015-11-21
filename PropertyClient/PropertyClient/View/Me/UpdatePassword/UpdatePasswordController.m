//
//  UpdatePasswordController.m
//  WuYeO2O
//
//  Created by MoPellet on 15/5/14.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "UpdatePasswordController.h"
@interface UpdatePasswordController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstNewPwd;
@property (weak, nonatomic) IBOutlet UITextField *secondPwd;
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;

@property (weak, nonatomic) IBOutlet UITextField *oldPwd;
@end

@implementation UpdatePasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSaveBtn];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.bounds = BOTTOM_FRAME;
    self.phoneNum.text = [[Config Instance] getPhoneNum];
    _secondPwd.delegate =self;
    _oldPwd.delegate =self;
    _firstNewPwd.delegate=self;
}


-(void)createSaveBtn{
    UIBarButtonItem *   rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(savePwd)];
    
    self.navigationItem.rightBarButtonItem = rightButton;

}


/**
 *  保存密码
 */
-(void)savePwd{

   NSString * text= [[Config Instance] getPwd] ;
     if (![[[Config Instance] getPwd] isEqualToString:self.oldPwd.text] ) {
     
        [self.view makeToast:@"您输入的旧密码不正确！" duration:1.0f position:@"top"];
        return;
    }
    else if (![self.firstNewPwd.text isEqualToString:self.secondPwd.text]){
           [self.view makeToast:@"您两次输入的密码不一致！" duration:1.0f position:@"center"];
        return;
    }
    else if (self.oldPwd.text.length ==0||self.firstNewPwd.text.length==0||self.secondPwd.text.length==0) {
        [self.view makeToast:@"请完善您的输入信息！" duration:1.0f position:@"center"];
        return;
    }
    
    CHECKNETWORK

    NSString *phone = [[Config Instance] getPhoneNum];
    NSString *pwd = [DES3Util encrypt:self.firstNewPwd.text];
    
    AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];

    NSString *parm =[NSString stringWithFormat:@"%@&#%@&#%@",phone,pwd,LoginType];
    parm =   [DES3Util encrypt:parm];
    NSString *oldPwd = [[Config Instance] getPwd];
    oldPwd = [DES3Util encrypt:oldPwd];
//    NSString *oldPwd = @"123";

//        NSDictionary  *part = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phone",pwd,@"password",LoginType,@"type",nil];
        NSDictionary  *part = [NSDictionary dictionaryWithObjectsAndKeys:parm,@"userInfo",oldPwd,@"oldPassword",nil];
    NSLog(@"%@",part);
//    NSLog(@"pwd:%@",[DES3Util decrypt:pwd]);
    [manager POST:API_BASE_URL_STRING(URL_UPDATEPWD)  parameters:part success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary = responseObject;
        NSLog(@"%@",dictionary);
        //展示显示信息
        if (dictionary) {
            NSLog(@"%@",dictionary[Y_Message]);
            int code = [dictionary[@"code"] intValue];
            if (1==code) {
              NSLog(@"修改成功");
              [[Config Instance] removeObjectFromUserDefaults];
//             LoginViewController *login = [[LoginViewController alloc] init];
//                [self presentViewController:login animated:YES completion:^{
//                        [self.view makeToast:[NSString stringWithFormat:@"%@",@"密码修改成功修改成功,请重新登陆"] duration:1.5f position:@"center"];
//                }];
             
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
                ShareDelegate.window.rootViewController = [storyboard instantiateInitialViewController];

            }
            else{
                //修改失败
                [MBProgressHUD showSuccess:[NSString stringWithFormat:@"%@",dictionary[@"message"]]];
            }
        
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",[error localizedDescription]);
    }];
    

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _oldPwd) {
        [_firstNewPwd becomeFirstResponder];
    }
    else if (textField==_firstNewPwd){
        [_secondPwd becomeFirstResponder];
    }
    else if (textField==_secondPwd) {
        [self savePwd];
    }
    
    
    return YES;
}

@end
