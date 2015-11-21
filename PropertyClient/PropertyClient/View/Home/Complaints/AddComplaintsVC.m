//
//  AddComplaintsVC.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/20.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "AddComplaintsVC.h"
#import <QuartzCore/QuartzCore.h>
#define  PIC_WIDTH 80
#define  PIC_HEIGHT 80
#define  INSETS 10
#import "ComplaintsTableVC.h"

@interface AddComplaintsVC ()<UIActionSheetDelegate,UIPickerViewDelegate,UINavigationControllerDelegate>
{
        CGPoint _plusButtonPoint;
}
@end

@implementation AddComplaintsVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    _comDescribe
    
    _comDescribe.layer.borderColor =  [UIColor colorWithRed:227.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor;
    _comDescribe.layer.borderWidth = 2;
    _comDescribe.layer.cornerRadius = 6;
    _comDescribe.layer.masksToBounds = YES;
    
    _picScroller.layer.borderColor =  [UIColor colorWithRed:227.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor;
    _picScroller.layer.borderWidth = 2;
    _picScroller.layer.cornerRadius = 6;
    _picScroller.layer.masksToBounds = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
            _plusButtonPoint = [_plusButton center ];
    self.comDescribe.placeholder = @"详细描述下...";
    addedPicArray =[[NSMutableArray alloc]init];
    [self refreshScrollView];
}

- (void)refreshScrollView
{
    CGFloat width=100*(addedPicArray.count)<300?320:100+addedPicArray.count*90;
    
    CGSize contentSize=CGSizeMake(width, 100);
//    [_picScroller setContentSize:contentSize];
//    [_picScroller setContentOffset:CGPointMake(width<320?0:width-320, 0) animated:YES];
//    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    viewController.navigationItem.backBarButtonItem = backItem;
    
}

- (IBAction)clearPics:(id)sender {
    for (UIImageView *img in addedPicArray)
    {
        [img removeFromSuperview];
    }
    [addedPicArray removeAllObjects];
    
    CABasicAnimation *positionAnim=[CABasicAnimation animationWithKeyPath:@"position"];
    [positionAnim setFromValue:[NSValue valueWithCGPoint:CGPointMake(_plusButton.center.x, _plusButton.center.y)]];
    [positionAnim setToValue:[NSValue valueWithCGPoint:CGPointMake(INSETS+PIC_WIDTH/2, _plusButton.center.y)]];
    [positionAnim setDelegate:self];
    [positionAnim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [positionAnim setDuration:0.25f];
    
    [_plusButton.layer addAnimation:positionAnim forKey:nil];
    
    [_plusButton setCenter:CGPointMake(INSETS+PIC_WIDTH/2, _plusButton.center.y)];
    [self refreshScrollView];
}

- (IBAction)addPic:(id)sender {
    
    if (addedPicArray.count==3) {
        [self.view makeToast:@"最多添加三张图片" duration:1.5f position:@"center"];
        return;
    }
    
    // 让用户选择照片来源
    // * 用相机作为暗示按钮可以获取到更多的真实有效的照片
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"选择照片", nil];
    
    [sheet showFromTabBar:self.tabBarController.tabBar];
}


/**
 *提交
 */
- (IBAction)submit:(id)sender {
    
    
    NSString *comTime = [[PublicClass sharedManager] getNowTimeWithFormat:@"yyyy-MM-dd"];
    AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
    
    if (addedPicArray.count) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSMutableString *photoKey = [[NSMutableString alloc] init];
        [[PublicClass sharedManager] getTokenWithCompletionHandler:^(NSDictionary *dictionary, NSError *error) {
            if (!error) {
                if (dictionary[Y_Data]) {
                    QNUploadManager *upManager = [[QNUploadManager alloc] init];
                    for (int i = 0; i<addedPicArray.count; i++) {
                        
                        UIImageView *imageView =   addedPicArray[i];
                        NSData *imgData = UIImageJPEGRepresentation(imageView.image, 1.0);
                        NSString *keys = [NSString stringWithFormat:@"%d", (int)[NSDate timeIntervalSinceReferenceDate]+i];
                        [upManager putData:imgData key:keys token:dictionary[Y_Data]
                                  complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                                      [photoKey appendFormat:@"%@&#",key];
                                      if (i==(addedPicArray.count-1)) {
            
                                          NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:comTime,@"comTime",self.comTitle.text,@"compTitile",self.comDescribe.text,@"description",photoKey,@"photo",nil];
                                          NSLog(@"part:%@",parameters);
                                          [manager POST:API_BASE_URL_STRING(URL_ADDCOMPLAINTS) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                              NSDictionary *dictionary= responseObject;
                                              NSLog(@"添加投诉：%@",dictionary);
                                              if (dictionary) {
                                                  int code  =[dictionary[Y_Code] intValue];
                                                  if (1==code) {
                                                      //添加成功跳转
                                                      [self.navigationController popViewControllerAnimated:YES];
                                                  }
                                                  [self.view makeToast:dictionary[Y_Message] duration:1.8f position:@"center"];
                                                  [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                              }
                                              
                                          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                              NSLog(@"error:%@",[error localizedDescription]);
                                          }];
                                      }
                                  } option:nil];
                    }
                    
                }
            }
        }];
    }else{
        //            NSString *comTime = [[PublicClass sharedManager] getNowTimeWithFormat:@"yyyy-MM-dd"];
        //            AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:comTime,@"comTime",self.comTitle.text,@"compTitile",self.comDescribe.text,@"description",NULL_VALUE,@"photo",nil];
        [manager POST:API_BASE_URL_STRING(URL_ADDCOMPLAINTS) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dictionary= responseObject;
            if (dictionary) {
                int code  =[dictionary[Y_Code] intValue];
                if (1==code) {
                    //添加成功跳转
                    [self.navigationController popViewControllerAnimated:YES];
                }
                [self.view makeToast:dictionary[Y_Message] duration:1.5f position:@"center"];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error:%@",[error localizedDescription]);
        }];
    }
    
    
}




-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [ self.comDescribe addObserver];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [ self.comDescribe removeobserver];
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
    [picker setDelegate:self];
    // 4. 显示照片选择控制器
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - 照片选择代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    //添加图片
    UIImageView *aImageView=[[UIImageView alloc]initWithImage: info[UIImagePickerControllerEditedImage]];
    [aImageView setFrame:CGRectMake(INSETS-90, INSETS, PIC_WIDTH, PIC_HEIGHT)];
    [addedPicArray addObject:aImageView];
    [_picScroller addSubview:aImageView];
    
    for (UIImageView *img in addedPicArray) {
        
        CABasicAnimation *positionAnim=[CABasicAnimation animationWithKeyPath:@"position"];
        [positionAnim setFromValue:[NSValue valueWithCGPoint:CGPointMake(img.center.x, img.center.y)]];
        [positionAnim setToValue:[NSValue valueWithCGPoint:CGPointMake(img.center.x+INSETS+PIC_WIDTH, img.center.y)]];
        [positionAnim setDelegate:self];
        [positionAnim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [positionAnim setDuration:0.25f];
        [img.layer addAnimation:positionAnim forKey:nil];
        
        [img setCenter:CGPointMake(img.center.x+INSETS+PIC_WIDTH, img.center.y)];
    }
    
    [self refreshScrollView];
    //移动添加按钮
    dispatch_async(dispatch_get_main_queue(), ^{
        //    CABasicAnimation *positionAnim=[CABasicAnimation animationWithKeyPath:@"position"];
        //    [positionAnim setFromValue:[NSValue valueWithCGPoint:CGPointMake(_plusButton.center.x, _plusButton.center.y)]];
        //    [positionAnim setToValue:[NSValue valueWithCGPoint:CGPointMake(_plusButton.center.x+INSETS+PIC_WIDTH, _plusButton.center.y)]];
        //    [positionAnim setDelegate:self];
        //    [positionAnim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        //    [positionAnim setDuration:0.25f];
        //    [_plusButton.layer addAnimation:positionAnim forKey:nil];
        //    [_plusButton setCenter:CGPointMake(_plusButton.center.x+INSETS+PIC_WIDTH, _plusButton.center.y)];
        _plusButtonPoint.x = _plusButtonPoint.x + INSETS+PIC_WIDTH;
        _plusButton.center =_plusButtonPoint;
    });
    // 3. 关闭照片选择器
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
