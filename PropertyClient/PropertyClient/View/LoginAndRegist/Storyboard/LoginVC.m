

#import "LoginVC.h"
#import "LoginDao.h"
#import "ForgotPwdVC.h"
@interface LoginVC ()<UITextFieldDelegate,UIAlertViewDelegate>
{
 BOOL _isRememberPassWord;
    NSString *versionUrl;
}
@property (weak, nonatomic) IBOutlet UIView *rememberView;

@end

@implementation LoginVC

@synthesize _userNameField;
@synthesize _passWordField;
@synthesize _loginButton;
@synthesize _rememberPassImageView;
@synthesize _rememberPassButton;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
//    self.view.backgroundColor =RGBACOLOR(12, 12, 12, 1);
    _logoview.backgroundColor = BACKGROUND_COLOR;
//    UIView *v  = [[UIView alloc] initWithFrame:CGRectMake(0, _userNameField.frame.origin.y+_userNameField.frame.size.height-1, SCREEN_WIDTH, 1)];
//    v.backgroundColor = [UIColor lightGrayColor];
//    [self.view addSubview:v];
//
    
    CALayer *bottomBorder = [CALayer layer];
//    CGFloat  hight = _userNameField.frame.size.height - 1;
    bottomBorder.frame = CGRectMake(0.0f, 39, SCREEN_WIDTH, 1.0f);
    bottomBorder.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor;
    [_userNameField.layer addSublayer:bottomBorder];
    _loginButton.layer.masksToBounds = YES;
    _loginButton.layer.cornerRadius = 6.0;
    _loginButton.layer.borderWidth = 1.0;
    _loginButton.layer.borderColor = [[UIColor clearColor] CGColor];

    
//    _userNameField.backgroundColor =[UIColor orangeColor];
//    _passWordField.backgroundColor = [UIColor blueColor];
    self.view.backgroundColor = RGBCOLOR(239, 239, 244);
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault]; //UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    [UIView commitAnimations];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
// self.view.backgroundColor = BACKGROUND_COLOR;
    self.view.backgroundColor = [UIColor whiteColor];
   self.rememberView.backgroundColor =[UIColor whiteColor];
    _loginButton.backgroundColor = BACKGROUND_COLOR;
    
    _userNameField.delegate =self;
    _passWordField.delegate =self;
    _passWordField.returnKeyType = UIReturnKeyDone;
    _isRememberPassWord = YES;
    
    _userNameField.returnKeyType = UIReturnKeyNext;
    _userNameField.backgroundColor =[UIColor whiteColor];
    _passWordField.backgroundColor = [UIColor whiteColor];
    
    [System_Notification addObserver:self selector:@selector(registerPhoneNumber:) name:@"FinishRegister_Notification" object:nil];
    [System_Notification addObserver:self selector:@selector(updatePasswordPhoneNumber:) name:@"FinishUpdatePassword_Notification" object:nil];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchDownToKeyboard:)];
    [self.view addGestureRecognizer:tap];
    

   }

- (void)touchDownToKeyboard:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{

//    CATransition *animation = [CATransition animation];
//    [animation setDuration:3.0];
//    [animation setFillMode:kCAFillModeForwards];
//    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
//    [animation setType:@"rippleEffect"];// rippleEffect
//    [animation setSubtype:kCATransitionFromTop];
    textField.textAlignment= NSTextAlignmentLeft;
    CATransition *animation = [CATransition animation];
    [animation setDuration:1.0];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [animation setType:@"rippleEffect"];// rippleEffect
    [animation setSubtype:kCATransitionFromTop];
    [textField.layer addAnimation:animation forKey:nil];

}

- (void)textFieldDidEndEditing:(UITextField *)textField{


    textField.textAlignment= NSTextAlignmentCenter;


    CATransition *animation = [CATransition animation];
    [animation setDuration:1.0];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [animation setType:@"rippleEffect"];// rippleEffect
    [animation setSubtype:kCATransitionFromTop];
    [textField.layer addAnimation:animation forKey:nil];

}

- (void)registerPhoneNumber:(NSNotification *)noti {
    _userNameField.text = noti.object;
}

- (void)updatePasswordPhoneNumber:(NSNotification *)noti
{
    _userNameField.text = noti.object;
    [self.view makeToast:@"密码修改成功" duration:1.5f position:@"center"];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==_userNameField) {
        [_passWordField becomeFirstResponder];
    }
    else if (textField==_passWordField)
    {
    [_passWordField resignFirstResponder];
        
        [self loginAction:nil];
    }


    return YES;
}
/**
 *记住密码切换
 */
- (IBAction)switchForRemeberPassAction:(id)sender {
    NSString *_selectImage = _isRememberPassWord?@"unchecked-mark":@"checked-mark2";
    [self._rememberPassImageView setImage:[UIImage imageNamed:_selectImage]];
    _isRememberPassWord = !_isRememberPassWord;
}

- (BOOL)judgeLoginParames {
    if (0 == _userNameField.text.length) {
        [self.view makeToast:@"请输入您的账号！" duration:1.5f position:@"center"];
        return NO;
    }
    
    if (0 == _passWordField.text.length) {
        [self.view makeToast:@"请输入您的密码！" duration:1.5f position:@"center"];
        return NO;
    }
    
    return YES;
}


- (IBAction)loginAction:(id)sender {
    if (![self judgeLoginParames])
        return;
    
    [_userNameField resignFirstResponder];
    [_passWordField resignFirstResponder];
    [self doneWithLogin];
}

- (void)doneWithLogin {
    //网络检测
    CHECKNETWORK
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[LoginDao sharedManager] login:[_userNameField.text trimString] pwd:_passWordField.text withCompletionHandler:^(NSDictionary *loginDictionary, NSError *error) {
        if (!error) {
            if (0 == [[loginDictionary objectForKey:Y_Data] count]) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.view makeToast:[loginDictionary objectForKey:Y_Message] duration:1.5f position:@"center"];
                return ;
            }
            
            if  ([[[loginDictionary objectForKey:Y_Data] objectForKey:Y_TYPE] integerValue] == 2) {
                              NSLog(@"%@",loginDictionary);
                loginDictionary = [loginDictionary objectForKey:Y_Data];
           
                NSString * username = _userNameField.text;
                NSString * pwd = _passWordField.text;
                LoginInfo *log = [LoginInfo objectWithKeyValues:loginDictionary];
       
                [[Config Instance] saveLoginInfo:log andUserName:username andPwd:pwd andIsRemember:(_isRememberPassWord?Y_U_REMEMBER:Y_U_ISNOTREMEMBER) ];
                [[Config Instance] saveCookie:YES];
                
                //检查新版本
                [[PublicClass sharedManager] getNewVersionWithCompletionHandler:^(NSDictionary *dictionary, NSError *error) {
                    if (!error) {
                        NSLog(@"%@",dictionary);
                        if (dictionary [Y_Data]) {
                            dictionary = dictionary[Y_Data];
                            versionUrl =  dictionary[@"versionUrl"];
                            if ([dictionary[@"forceUpdate"] intValue] == 0) {
                                if (![Y_APP_VERSION isEqualToString:dictionary[@"version"]]) {
                                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"有最新版可以下载" delegate:self cancelButtonTitle:@"不需要" otherButtonTitles:@"尝尝鲜", nil];
                                    [alertView show];
                                }
                            }
                            else{
                                //强制更新
                                [self alertView:nil didDismissWithButtonIndex:1];
                            }
                        }
                    }
                }];
                

                dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                dispatch_group_t group = dispatch_group_create();
                dispatch_group_async(group, queue, ^{
                    [System_Notification postNotificationName:Notif_Login object:nil];
                });
                dispatch_group_async(group, queue, ^{
                    XMPPManager *manager= [XMPPManager sharedInstance];
                    if(manager.xmppStream == nil){
                        [manager setupStream];
                    }
                    [manager goOnline];
                });
                
                dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                    
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    
         
                    //进入主界面
                    
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    ShareDelegate.window.rootViewController = [storyboard instantiateInitialViewController];
                    [ShareDelegate initTabBarController];
                });
            } else {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.view makeToast:@"无效的用户名或密码!" duration:1.5f position:@"bottom"];
            }
        } else {
            NSLog(@"登录报错,error = %@", [error description]);
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
}
//检查版本弹出框
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:versionUrl]];
        UIWindow *window = ShareDelegate.window;
        [UIView animateWithDuration:1.0f animations:^{
            window.alpha = 0;
            window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
        } completion:^(BOOL finished) {
            exit(0);
        }];
    }
    
}
- (void)dealloc {
    [System_Notification removeObserver:self name:@"FinishRegister_Notification" object:nil];
    [System_Notification removeObserver:self name:@"FinishUpdatePassword_Notification" object:nil];
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\x20"])
        return NO;
    return YES;
}

- (void)loginOutForRetsetPassword
{
    if (!_isRememberPassWord)
        _passWordField.text = NULL_VALUE;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"%@",segue.identifier);
    if ([segue.identifier isEqualToString:@"forgotPwd"]) {
        ForgotPwdVC *fw = segue.destinationViewController;
        fw.prePhoneNumber = self._userNameField.text;
    }
}
@end
