//
//  AddFleaMarketVC.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/25.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "AddFleaMarketVC.h"
#import <QuartzCore/QuartzCore.h>
#define  PIC_WIDTH 80
#define  PIC_HEIGHT 80
#define  INSETS 10
#define timeFormatter @"yyyy-MM-dd HH:mm"
@interface AddFleaMarketVC ()<UIActionSheetDelegate,UIPickerViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate>
{
    NSMutableArray *addedPicArray;
    NSDate *startDate;
    NSDate *endDate;
    int isPubpone ;//0为否  1为是
//    CGRect _plusButtonFrame ;//添加按钮的 frame
    CGPoint _plusButtonPoint;
    
       BOOL bKeyBoardHide;
    
}
@end

@implementation AddFleaMarketVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.goodsCategory) {
        NSString *info = [NSString stringWithFormat:@"选择分类：%@", self.goodsCategory.label];
        [self.category setTitle:info forState:UIControlStateNormal];
    }
    else{
        [self.category setTitle:@"选择分类：" forState:UIControlStateNormal];
    }
    
    if (self.purityType) {
        NSString *info = [NSString stringWithFormat:@"选择成色：%@", self.purityType.lable];
        [self.purity setTitle:info forState:UIControlStateNormal];
    }
    else{
        [self.purity setTitle:@"选择成色：" forState:UIControlStateNormal];
    }
    
        _picScroller.layer.masksToBounds = YES;
        _picScroller.layer.cornerRadius = 6.0;
        _picScroller.layer.borderWidth = 1.0;
        _picScroller.layer.borderColor = [[UIColor lightGrayColor] CGColor];

}
- (void)viewDidLoad {
    [super viewDidLoad];

//            _plusButtonFrame = [_plusButton frame];
    _plusButtonPoint = [_plusButton center ];
//    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*2); 
//        if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
//            self.edgesForExtendedLayout = UIRectEdgeNone;
//        self.view.bounds = BOTTOM_FRAME;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    self.goodsDesc.placeholder = @"详细描述下...";
    addedPicArray =[[NSMutableArray alloc]init];
    [self refreshScrollView];
    isPubpone = 1;
    
    //开始时间
    UIDatePicker * startPicker = [[UIDatePicker alloc] init];
    startPicker.datePickerMode = UIDatePickerModeDateAndTime;
    startPicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    self.startTime.inputView  = startPicker;
    [startPicker addTarget:self action:@selector(startPickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    startDate = startPicker.date;

    UIDatePicker * endPicker = [[UIDatePicker alloc] init];
    endPicker.datePickerMode = UIDatePickerModeDateAndTime;
    endPicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    self.endTime.inputView  = endPicker;
    [endPicker addTarget:self action:@selector(endPickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
}
-(void)keyboardWillHide:(NSNotification *)notification
{

    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//        _scrollView.contentSize =CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
   
  [_scrollView setContentOffset:CGPointMake(0,0) animated:NO];
    bKeyBoardHide = YES;
}

-(void)keyboardWillShow:(NSNotification *)notification
{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, keyboardFrame.origin.y);
    [_scrollView setContentOffset:CGPointMake(0,150) animated:NO];
//    _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, keyboardFrame.origin.y);
//        _scrollView.contentSize =CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*2);
//    NSLog(@"show:%f--------%f",_scrollView.frame.size.width,_scrollView.frame.size.height);
    bKeyBoardHide = NO;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.startTime resignFirstResponder];
    [self.endTime resignFirstResponder];
}

- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 设置窗口的颜色
    self.view.window.backgroundColor = self.picScroller.backgroundColor;
    
    // 0.取出键盘动画的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 1.取得键盘最后的frame
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 2.计算控制器的view需要平移的距离
    CGFloat transformY = keyboardFrame.origin.y - self.view.bounds.size.height;
    
  
    // 3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, transformY);
    }];
}

-(void)startPickerValueChanged:(UIDatePicker *)picker{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init] ;
    [dateformatter setDateFormat:timeFormatter];
    self.startTime.text =  [dateformatter stringFromDate:picker.date];
    startDate =picker.date;
}

-(void)endPickerValueChanged:(UIDatePicker *)picker{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init] ;
    [dateformatter setDateFormat:timeFormatter];
    self.endTime.text =  [dateformatter stringFromDate:picker.date];
    endDate = picker.date;
}
/**
 *时间比较
 */
-(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:timeFormatter];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        NSLog(@"开始时间大于结束时间");
        return 1;
    }
    else if (result == NSOrderedAscending){
        NSLog(@"开始时间小于结束时间");
        return -1;
    }
    NSLog(@"两个时间相同");
    return 0;
}

/**
 *  刷新添加照片的控件
 */
- (void)refreshScrollView
{
    CGFloat width=100*(addedPicArray.count)<300?320:100+addedPicArray.count*90;
    CGSize contentSize=CGSizeMake(width, 100);
//    [_picScroller setContentSize:contentSize];
//    [_picScroller setContentOffset:CGPointMake(width<320?0:width-320, 0) animated:YES];
//    
}

- (IBAction)addPic:(id)sender{
    if (addedPicArray.count==3) {
        [self.view makeToast:@"最多添加三张图片" duration:1.5f position:@"center"];
        return;
    }
    // * 用相机作为暗示按钮可以获取到更多的真实有效的照片
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"选择照片", nil];
    
    [sheet showFromTabBar:self.tabBarController.tabBar];
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    viewController.navigationItem.backBarButtonItem = backItem;

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
//    [positionAnim setFromValue:[NSValue valueWithCGPoint:CGPointMake(_plusButtonPoint.x, _plusButtonPoint.y)]];
//    [positionAnim setToValue:[NSValue valueWithCGPoint:CGPointMake(_plusButtonPoint.x+INSETS+PIC_WIDTH, _plusButtonPoint.y)]];
//    [positionAnim setDelegate:self];
//    [positionAnim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//    [positionAnim setDuration:0.25f];
//    [_plusButton.layer addAnimation:positionAnim forKey:nil];
//    [_plusButton setCenter:CGPointMake(_plusButtonPoint.x+INSETS+PIC_WIDTH, _plusButtonPoint.y)];
//           
//           CGRect frame = [_plusButton frame];
           
           _plusButtonPoint.x = _plusButtonPoint.x + INSETS+PIC_WIDTH;
           _plusButton.center =_plusButtonPoint;
//           NSLog(@"frame.x:%f",_plusButton.center.x);
       });
    // 3. 关闭照片选择器
    [self dismissViewControllerAnimated:YES completion:nil];
}





- (IBAction)submit:(UIBarButtonItem *)sender {
    int  i =     [self compareOneDay:startDate withAnotherDay:endDate];
    if (i!=-1) {
        [self.view makeToast:@"请检查时间是否正确" duration:1.5f position:@"center"];
        return;
    }
    if (0==addedPicArray.count) {
        [self.view makeToast:@"请添加一张照片" duration:1.5f position:@"center"];
        return;
    }
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
                                      int temp = (int) addedPicArray.count-1;//不然只能添加一张图片

                                      if (i==temp) {
                                          NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                      self.goodsName.text,@"goodsName",
                                                                      self.goodsDesc.text,@"description" ,
                                                                      [[PublicClass sharedManager] getNowTimeWithFormat:@"yyyy-MM-ddHH:mm"],@"publishTime",
                                                                      self.startTime.text,@"startTime",
                                                                      self.endTime.text,@"endTime",
                                                                      self.oldPrice.text,@"oldPrice",
                                                                      self.transferPrice.text,@"transferPrice",
                                                                      self.goodsCategory.value,@"goodsCategory",
                                                                      self.purityType.value ,@"purityType",
                                                                      [NSString stringWithFormat:@"%d",isPubpone],@"isPhPublic",
                                                                      photoKey,@"photo",nil];
                                          NSLog(@"part:%@",parameters);
                                          [manager POST:API_BASE_URL_STRING(URL_ADDFLEAMARKETS) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                              NSDictionary *dictionary= responseObject;
                                              NSLog(@"添加跳蚤市场：%@",dictionary);
                                              if (dictionary) {
                                                  NSLog(@"%@",dictionary[Y_Message]);
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
    }
}
@end
