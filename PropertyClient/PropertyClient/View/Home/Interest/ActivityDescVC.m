//
//  ActivityDescVC.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/21.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "ActivityDescVC.h"
#import "Comments.h"
#import "CommentsTableViewCell.h"
@interface ActivityDescVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    NSString *activityID ;
    
        UIScrollView *scrollView;
    
}
@property (weak, nonatomic) IBOutlet UITableView *commentsTableView;
@property (nonatomic, strong) NSMutableArray *arrays;
@end

@implementation ActivityDescVC


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[AnimationView animationClass ]createAnimation:YES toText:nil toView:self.view];
    [self getArrays];

    AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:self.activity.activityId,@"activityId",nil];
    [manager POST:API_BASE_URL_STRING(URL_GETACTIVITYDETAILBYID) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary= responseObject;
        [[AnimationView animationClass] hideViewToView:self.view];
        if (dictionary) {
            if (dictionary[Y_Data]) {
                dictionary = dictionary[Y_Data];
                NSLog(@"%@",dictionary);
                if (dictionary[@"activityPhoto"]) {
                    NSArray * array = [dictionary[@"activityPhoto"] componentsSeparatedByString:@"&#"];
                    for (int i = 0; i<array.count-1; i++) {
                        UIImageView *imageview = [[UIImageView alloc] init];
                        imageview.frame = CGRectMake(80*i+10+10*i, 0, 80, 80);
                        NSString *urlStr  = [NSString stringWithFormat:@"%@%@",URL_QINIU,array[i]];
                          NSURL *url = [NSURL URLWithString:urlStr];
                        [imageview sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"aio_image_default"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       
                        }];
                        UIButton *imageBtn = [[UIButton alloc] initWithFrame:CGRectMake(80*i+10+10*i, 0, 80, 80)];
                        [imageBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//                        imageBtn.tag = [array[i] longLongValue]?[array[i] longLongValue]:0;
                             imageBtn.titleLabel.text=array[i];
                        [_picView addSubview:imageBtn];
                             [_picView addSubview:imageview];
                    }
                }
                self.name.text = [NSString stringWithFormat:@"组织人：%@",dictionary[@"wyOwner"][@"name"]];
                self.activitytitle.text = dictionary[@"title"];
//                self.publishtime.text=[NSString stringWithFormat:@"报名截至时间：%@",[dictionary[@"publishtime"] substringToIndex:16]];
//                self.activityTime.text =[NSString stringWithFormat:@"%@至%@", dictionary[@"createDate"],dictionary[@"updateDate"]];
                _activityTime.text = [NSString stringWithFormat:@"报名截至时间：%@",[dictionary[@"endtime"] substringToIndex:16]];
                _countdown.text = [NSString stringWithFormat:@"开始：%@",[dictionary[@"starttime"] substringToIndex:16]];
                
                _starttime.text = [dictionary[@"starttime"] substringToIndex:16];
                _endtime.text = [dictionary[@"endtime"] substringToIndex:16];
                self.desc.text = dictionary[@"description"];
                self.place.text = dictionary[@"office"][@"name"];
            NSString *photoId = dictionary[@"wyOwner"][@"photo"];
                self.phone.text =[NSString stringWithFormat:@"联系电话：%@",dictionary[@"wyOwner"][@"phone"]];
                if ([[[Config Instance] getOwnerId] isEqualToString:dictionary[@"ownerId"]]) {
                    self.navigationItem.rightBarButtonItem =  [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(cancelActivity)];
                    activityID = dictionary[@"id"];
                }
                [self.headImageView.layer setCornerRadius:CGRectGetHeight([self.headImageView bounds]) / 2];
                self.headImageView.layer.masksToBounds = YES;
                self.headImageView.layer.borderWidth = 3;
                self.headImageView.layer.borderColor = [[UIColor clearColor] CGColor];
                self.headImageView.layer.contents = (id)[[UIImage imageNamed:@"me_head"] CGImage];
                if (photoId.length){
                    NSString *urlStr  = [NSString stringWithFormat:@"%@%@",URL_QINIU,photoId];
                    NSURL *url = [NSURL URLWithString:urlStr];
    
                    [self.headImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"me_head"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                         self.headImageView.layer.contents =(id)self.headImageView.image.CGImage;
                    }];
                    
                }
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
    _inputField.layer.borderColor =  [UIColor colorWithRed:227.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor;
    _inputField.layer.borderWidth = 1;
}


-(void)click:(id)btn{

    UIButton *button = (UIButton *)btn;
    NSLog(@"%ld",(long)button.tag);
    /**
     *  隐藏导航栏  隐藏状态栏
     */
    [self.navigationController setNavigationBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    // 1.创建UIScrollView
    scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT); // frame中的size指UIScrollView的可视范围
    scrollView.backgroundColor = [UIColor blackColor];
    UIButton *imgbtn = [[UIButton alloc] init];
    //    imgbtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [imgbtn addTarget:self action:@selector(lookImage:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:imgbtn];
    [self.view addSubview:scrollView];
    
    // 2.创建UIImageView（图片）
    UIImageView *imageView = [[UIImageView alloc] init];
    [[AnimationView animationClass ]createAnimation:YES toText:nil toView:self.view];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_QINIU,button.titleLabel.text]]
                 placeholderImage:[UIImage imageNamed:@"aio_image_default"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                     [[AnimationView animationClass] hideViewToView:self.view];
                 }];
    CGFloat imgW = imageView.image.size.width; // 图片的宽度
    CGFloat imgH = imageView.image.size.height; // 图片的高度
    imageView.frame = CGRectMake(0, 0, imgW, imgH);
    
    [scrollView addSubview:imageView];
    NSLog(@"%f",imageView.frame.size.height);
    imgbtn.frame = CGRectMake(0, 0, imageView.frame.size.width, SCREEN_HEIGHT);
    // 3.设置scrollView的属性
    if (imgW<SCREEN_HEIGHT&&imgH>SCREEN_HEIGHT) {
        imageView.frame = CGRectMake((SCREEN_WIDTH-imgW)/2, 0, imgW, imgH);
    }
    else if (imgH<SCREEN_HEIGHT) {
        imageView.frame = CGRectMake(0, (SCREEN_HEIGHT-imgH)/2, imgW, imgH);
    }
    else  if (imgW<SCREEN_WIDTH&&imgH<SCREEN_HEIGHT) {
        imageView.frame = CGRectMake((SCREEN_WIDTH-imgW)/2, (SCREEN_HEIGHT-imgH)/2, imgW, imgH);
    }
    
    // 设置UIScrollView的滚动范围（内容大小）
    scrollView.contentSize = imageView.image.size;
    
    // 隐藏水平滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    // 去掉弹簧效果
    scrollView.bounces = NO;
//    self.tableView.bounces = NO;
}
-(void)lookImage:(UIButton *)btn{
    [scrollView removeFromSuperview];
//    self.tableView .bounces = YES;
    [self.navigationController setNavigationBarHidden:NO];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    //        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
}
-(void)cancelActivity{

  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"您确认取消该活动吗？" delegate:self cancelButtonTitle:@"容我想想" otherButtonTitles:@"我意已决", nil];
    [alertView show];
}



- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
            if (activityID!=nil) {
                AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
                NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:activityID,@"activityId",nil];
                NSLog(@"%@",parameters);
                [manager POST:API_BASE_URL_STRING(URL_DELETEACTIVITYINFO) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSDictionary *dictionary= responseObject;
                    if (dictionary) {
                        int code = [dictionary[Y_Code] intValue];
                        if (code==1) {
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                        [self.view makeToast:dictionary[Y_Message] duration:1.5f position:@"center"];
                    }
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"%@",[error localizedDescription]);
                }];
        
            }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view .backgroundColor =RGBCOLOR(247, 247, 247);

//    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.view.bounds = BOTTOM_FRAME;
    // 2.监听键盘的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 3.设置文本框左边显示的view
    self.inputField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
    // 永远显示
    self.inputField.leftViewMode = UITextFieldViewModeAlways;
    self.inputField.delegate = self;

    _sendBtn.backgroundColor = BACKGROUND_COLOR;

//    self.commentsTableView.backgroundColor = [UIColor whiteColor];
}
/**
 *  点击了return按钮(键盘最右下角的按钮)就会调用
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 1.添加评论
    [self addMessage:textField.text ];
    
    // 3.清空文字
    self.inputField.text = nil;
    
    // 返回YES即可
    return YES;
}

/**
 *  发送一条消息
 */
- (void)addMessage:(NSString *)text
{
    // 1.数据模型
    Comments *comments = [[Comments alloc] init];
    comments.content = text;
    // 设置数据模型的时间
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    comments.commTime = [fmt stringFromDate:now];
    comments.activityId = self.activity.activityId;
    comments.photo = [[Config Instance] getPhoto];
    comments.userName = [[Config Instance] getName];
    comments.userSex = [[Config Instance] getSex];
    [self.arrays insertObject:comments atIndex:0];
    AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:comments.activityId,@"activityId",comments.content,@"content",nil];
    [manager POST:API_BASE_URL_STRING(URL_ADDACTCOMMENT) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary= responseObject;
        if (dictionary) {
            int code = [dictionary[Y_Code] intValue];
            if (1==code) {
                    [self.commentsTableView reloadData];
//                 4.自动滚动表格到最后一行
                NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.commentsTableView scrollToRowAtIndexPath:firstPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
                [_inputField resignFirstResponder];
            }
            else{
                [self.view makeToast:dictionary[Y_Message] duration:1.5f position:@"center"];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
    
//    // 3.刷新表格
//    [self.commentsTableView reloadData];
    
//    // 4.自动滚动表格到最后一行
////    NSIndexPath *lastPath = [NSIndexPath indexPathForRow:self.arrays.count - 1 inSection:0];
//        NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.commentsTableView scrollToRowAtIndexPath:firstPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 设置窗口的颜色
    self.view.window.backgroundColor = self.commentsTableView.backgroundColor;
    
    // 0.取出键盘动画的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 1.取得键盘最后的frame
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 2.计算控制器的view需要平移的距离
    CGFloat transformY = keyboardFrame.origin.y -  self.view.superview.bounds.size.height;
    // 3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, transformY);
    }];
}

-(void)getArrays{
    _arrays = [[NSMutableArray alloc] init];
    AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:self.activity.activityId,@"activityId",nil];
    [manager POST:API_BASE_URL_STRING(URL_GETALLCOMMENTBYACTIVITYID) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary= responseObject;
        NSLog(@"%@",dictionary);
        if (dictionary) {
            if (dictionary[Y_Data]) {
                dictionary = dictionary[Y_Data];
                if (dictionary[@"records"]) {
                    dictionary = dictionary[@"records"];
                    for (NSDictionary *dict in dictionary) {
                        // 创建模型对象
                        Comments *comments = [Comments objectWithKeyValues:dict ];
                        // 添加模型对象到数组中
                        [_arrays addObject:comments];
                    }
                    //                        NSLog(@"count:%lu",(unsigned long)_arrays.count);
                    [self.commentsTableView reloadData];
                }
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
            [[AnimationView animationClass ]createAnimation:NO toText:NetError toView:self.view];
    }];

}
//-(NSMutableArray *)arrays{
//    if (_arrays==nil) {
//        _arrays = [[NSMutableArray alloc] init];
//        AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
//        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:self.activity.activityId,@"activityId",nil];
//        [manager POST:API_BASE_URL_STRING(URL_GETALLCOMMENTBYACTIVITYID) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSDictionary *dictionary= responseObject;
//            NSLog(@"%@",dictionary);
//            if (dictionary) {
//                if (dictionary[Y_Data]) {
//                    dictionary = dictionary[Y_Data];
//                    if (dictionary[@"records"]) {
//                        dictionary = dictionary[@"records"];
//                        for (NSDictionary *dict in dictionary) {
//                            // 创建模型对象
//                            Comments *comments = [Comments objectWithKeyValues:dict ];
//                            // 添加模型对象到数组中
//                            [_arrays addObject:comments];
//                        }
//                        //                        NSLog(@"count:%lu",(unsigned long)_arrays.count);
//                        [self.commentsTableView reloadData];
//                    }
//                }
//            }
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"%@",[error localizedDescription]);
//        }];
//    }
//    return  _arrays;
//}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrays.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 8.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Comments *comments = self.arrays[indexPath.row];
    // 1.创建cell
    CommentsTableViewCell *cell = [CommentsTableViewCell cellWithTableView:tableView];
    // 2.设置数据
    [cell settingData:comments];
    return cell;
}
/**
 *
 *自定义行高
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (IBAction)sendAction:(id)sender {
    [self addMessage: _inputField.text ];
    self.inputField.text = nil;
}

- (IBAction)replyAction:(id)sender {
    [self.inputField becomeFirstResponder];
}
- (IBAction)activeAction:(UIButton *)sender {
//    if (b==1) {
//        NSLog(@"取消活动");
//    }
//    else {
//        NSLog(@"参加活动");
////            [self addMessage:textField.text ];
//    }
}
@end
