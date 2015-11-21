//
//  ComplaintsDescVC.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/21.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "ComplaintsDescVC.h"
@interface ComplaintsDescVC ()
{
    NSString *phoneNum;
    UIScrollView * scrollView;
}
@end

@implementation ComplaintsDescVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_comPhone setAdjustsImageWhenHighlighted:NO];
    _callPhoneBtn.backgroundColor = BACKGROUND_COLOR;
    AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:self.compId,@"compId",nil];
    
    [manager GET:API_BASE_URL_STRING(URL_GETCOMPBYCOMID) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary= responseObject;
        if (dictionary) {
            if (dictionary[Y_Data]) {
                dictionary = dictionary[Y_Data];
                NSLog(@"%@",dictionary);
                self.comTitle.text = dictionary[@"compTitile"];
                _descTextView.text = dictionary[@"description"];
                self.comName.text =[NSString stringWithFormat:@"投诉业主：%@",  dictionary[@"wyOwner"][@"name"]];
                [self.comPhone setTitle: [NSString stringWithFormat:@"投诉业主电话：%@", dictionary[@"wyOwner"][@"phone"]] forState:UIControlStateNormal];
                phoneNum =dictionary[@"wyOwner"][@"phone"];
                self.comTtime.text =[NSString stringWithFormat:@"投诉时间：%@", dictionary[@"compTime"]];
                NSString *comOwnerId = dictionary[@"ownerId"];
                NSString *ownerId =[[Config Instance] getOwnerId];
                if ([comOwnerId isEqualToString:ownerId]) {
                    
                    UIButton *btn = [[UIButton alloc] init];
                    btn.frame = CGRectMake(0, self.view.bounds.size.height-40, SCREEN_WIDTH, 40);
                    [btn setTitle:@"取消投诉" forState:UIControlStateNormal];
                    [btn setBackgroundColor:[UIColor whiteColor]];
                    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    btn.titleLabel.font = SystemFont(15);
                    btn.layer.borderWidth = 1.0;
                    btn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
                    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
                    [btn addTarget:self action:@selector(cancelCom:) forControlEvents:UIControlEventTouchUpInside];
                    [self.view addSubview:btn];
                }
                if (dictionary[@"photo"]) {
                    NSArray * array = [dictionary[@"photo"] componentsSeparatedByString:@"&#"];
                    if (array.count-1>0) {
                        _picView.layer.masksToBounds = YES;
                        _picView.layer.cornerRadius = 6.0;
                        _picView.layer.borderWidth = 1.0;
                        _picView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
                    }
                    for (int i = 0; i<array.count-1;i++) {
                        NSString *photoId = array[i];
                        NSString *urlStr  = [NSString stringWithFormat:@"%@%@",URL_QINIU,photoId];
                        NSURL *url = [NSURL URLWithString:urlStr];
                        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0 +80*i+((_picView.frame.size.width-80*3)/4*(i+1)), 5, 80, 80)];
                        [imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"aio_image_default"]];
                        UIButton *imageBtn = [[UIButton alloc] initWithFrame:CGRectMake(0 +80*i+((_picView.frame.size.width-80*3)/4*(i+1)), 5, 80, 80)];
                        
                        [imageBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                        //                        imageBtn.tag = [array[i] longLongValue]?[array[i] longLongValue]:0;
                        imageBtn.titleLabel.text=array[i];
                        [_picView addSubview:imageBtn];
                        
                        [_picView addSubview:imgView];

                    }
                }
            }
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
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


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"投诉详情";
}


- (void)cancelCom:(id)sender {
    NSLog(@"%@",_compId);
    AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:_compId,@"compId",nil];
    NSLog(@"%@",parameters);
    [manager POST:API_BASE_URL_STRING(URL_DELETECOMPLAINTINFO) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary= responseObject;
        NSLog(@"%@",dictionary);
        if(dictionary){
            int code = [dictionary[Y_Code] intValue];
            if (code==1) {
                [self.navigationController popViewControllerAnimated:YES];
                [MBProgressHUD showSuccess:dictionary[Y_Message]];
            }else{
                [MBProgressHUD showError:dictionary[Y_Message]];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
}
- (IBAction)comPhone:(id)sender {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phoneNum];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
- (IBAction)callPhone:(id)sender {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phoneNum];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
@end
