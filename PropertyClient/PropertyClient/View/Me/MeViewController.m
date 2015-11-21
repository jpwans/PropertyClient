//
//  MeViewController.m
//  WuYeO2O
//
//  Created by MoPellet on 15/5/13.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "MeViewController.h"
#import "LoginDao.h"
#import "PropertyFeeDao.h"
#import "LoginVC.h"
#import "UpdatePasswordController.h"
#import "RelativeUserVC.h"
#import "RelationUserTableView.h"
#import "UITableView+Add.h"
#import "XMPPManager.h"
#import "FeedBackVC.h"
@interface MeViewController ()<UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
    NSString * versionUrl;
}
@property (weak, nonatomic) IBOutlet UIButton *headPhoto;
- (IBAction)changeHead:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UITableView *setTableView;
@property (weak, nonatomic) IBOutlet UILabel *communityName;

@end

@implementation MeViewController
-(void )viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self viewInit];
    [self setHeadPhoto];
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [_setTableView setTableFooterView:view];
    [_setTableView setTableHeaderView:view];
    view = nil;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.backgroundColor = BACKGROUND_COLOR;
    self.view.backgroundColor =ALLBACKCOLOR;
    self.setTableView.delegate =self;
    self.setTableView.dataSource =self;
    self.setTableView.backgroundColor =ALLBACKCOLOR;
}


-(void)viewInit{
    self.nameLab.text = [[Config Instance] getName];
    self.communityName.text =        [SYSTEM_USERDEFAULTS objectForKey:Y_roleName];
    self.address.text =[NSString stringWithFormat:@"%@/%@",
                        [SYSTEM_USERDEFAULTS objectForKey:Y_company],
                        [SYSTEM_USERDEFAULTS objectForKey:Y_COMMUNITY]] ;
    
    
}

-(void)setHeadPhoto{
    NSString *photoId = [[Config Instance] getPhoto];
    [self.headPhoto.layer setCornerRadius:CGRectGetHeight([self.headPhoto bounds]) / 2];
    self.headPhoto.layer.masksToBounds = YES;
    self.headPhoto.layer.borderWidth = 3;
    self.headPhoto.layer.borderColor = [[UIColor clearColor] CGColor];
    self.headPhoto.layer.contents = (id)[[UIImage imageNamed:@"me_head"] CGImage];
    if (0==photoId.length)return;
    NSString *urlStr  = [NSString stringWithFormat:@"%@%@",URL_QINIU,photoId];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    [self.headImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"me_head"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.headPhoto.layer.contents = (id)[self.headImageView.image CGImage];
    }];
}

- (IBAction)changeHead:(id)sender {
    // 让用户选择照片来源
    // * 用相机作为暗示按钮可以获取到更多的真实有效的照片
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"选择照片", nil];
    [sheet showFromTabBar:self.tabBarController.tabBar];
    
}

#pragma mark - ActionSheet代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 2) {
        return;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    // 1. 设置照片源，提示在模拟上不支持相机！
    if (buttonIndex == 0) {
        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    } else {
        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    // 2. 允许编辑
    [picker setAllowsEditing:YES];
    // 3. 设置代理
    dispatch_async(dispatch_get_main_queue(), ^{
        picker.delegate=self;
    });
    // 4. 显示照片选择控制器
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    viewController.navigationItem.backBarButtonItem = backItem;
    
}
#pragma mark - 照片选择代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    // 1. 设置头像
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.headPhoto.layer setCornerRadius:CGRectGetHeight([self.headPhoto bounds]) / 2];
        self.headPhoto.layer.masksToBounds = YES;
        self.headPhoto.layer.borderWidth = 3;
        self.headPhoto.layer.borderColor = [[UIColor clearColor] CGColor];
        self.headPhoto.layer.contents = (id)[[info objectForKey:UIImagePickerControllerEditedImage] CGImage];
        
    });
    
    //    self.headPhoto.imageView.image = img;
    
    //2. 保存到服务器
    
    NSData *imgData = UIImageJPEGRepresentation(info[UIImagePickerControllerEditedImage], 1.0);
    
    //    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //    dispatch_group_t group = dispatch_group_create();
    //    dispatch_group_async(group, queue, ^{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[PublicClass sharedManager] getTokenWithCompletionHandler:^(NSDictionary *dictionary, NSError *error) {
        if (!error) {
            NSLog(@"%@",dictionary);
            if (dictionary[Y_Data]) {
                QNUploadManager *upManager = [[QNUploadManager alloc] init];
                NSString *key = [NSString stringWithFormat:@"%d", (int)[NSDate timeIntervalSinceReferenceDate]];
                [upManager putData:imgData key:key token:dictionary[Y_Data]
                          complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                              AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
                              NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:key,@"photo",nil];
                              [manager POST:API_BASE_URL_STRING(URL_UPDATEPHOTO) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  NSDictionary *dictionary= responseObject;
                                  NSLog(@"%@",dictionary);
                                  [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                  if(dictionary[Y_Data]){
                                      [SYSTEM_USERDEFAULTS removeObjectForKey:Y_PHOTO];
                                      [SYSTEM_USERDEFAULTS setObject: dictionary[Y_Data][@"photo"]forKey:Y_PHOTO];
                                      [SYSTEM_USERDEFAULTS synchronize];
                                  }
                              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  NSLog(@"%@",[error localizedDescription]);
                              }];
                          } option:nil];
            }
        }
    }];
    
    //    });
    
    
    
    // 3. 关闭照片选择器
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)loginOut:(id)sender {
    [[Config Instance] removeObjectFromUserDefaults];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    ShareDelegate.window.rootViewController = [storyboard instantiateInitialViewController];
    ShareDelegate.appLoginViewController = [[LoginVC alloc  ] init];
    [ShareDelegate.appLoginViewController loginOutForRetsetPassword];
    
    [[XMPPManager sharedInstance]disconnect];
    
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* indentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    NSInteger index = indexPath.row;
    
    cell.textLabel.font = SystemFont(14);
    cell.textLabel.textColor  = RGBCOLOR(111, 113, 121);
    switch (index) {
        case 0:
            cell.textLabel.text = @"修改密码";
            break;
            
        case 1:
            cell.textLabel.text = @"检查新版本";
            break;
        case 2:
            cell.textLabel.text = @"意见反馈";
            break;
        default:
            break;
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;;
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, cell.frame.size.height - 1, SCREEN_WIDTH, 1.0f);
    bottomBorder.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor;
    [cell.layer addSublayer:bottomBorder];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row;
    switch (index) {
        case 0:
        {
            UpdatePasswordController *updatePwdVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UpdatePasswordController"];
            [self.navigationController pushViewController:updatePwdVC animated:YES];
        }
            break;
        case 1:{
            //检查新版本
            [[PublicClass sharedManager] getNewVersionWithCompletionHandler:^(NSDictionary *dictionary, NSError *error) {
                if (!error) {
                    NSLog(@"%@",dictionary);
                    NSLog(@"%@",dictionary[Y_Message]);
                    if (dictionary [Y_Data]) {
                        dictionary = dictionary[Y_Data];
                        versionUrl =        dictionary[@"versionUrl"];
                        if ([dictionary[@"forceUpdate"] intValue] == 0) {
                            if ([Y_APP_VERSION isEqualToString:dictionary[@"version"]]) {
                                [self.view makeToast:@"您已安装最新版本" duration:1.5f position:@"center"];
                            }
                            else{
                                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"有最新版可以下载" delegate:self cancelButtonTitle:@"不需要" otherButtonTitles:@"尝尝鲜", nil];
                                [alertView show];
                            }
                        }
                        else{
                            [self alertView:nil didDismissWithButtonIndex:1];
                        }
                    }
                    else{
                        [self.view makeToast:dictionary[Y_Message] duration:1.5f position:@"center"];
                    }
                }
            }];
        }
            break;
        case 2:
        {
            FeedBackVC  * fbVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FeedBackVC"];
            fbVC.title = @"意见反馈";
            [self.navigationController pushViewController:fbVC animated:YES];
        }
        default:
        {}
            break;
    }
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

@end
