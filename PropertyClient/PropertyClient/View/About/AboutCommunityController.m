//
//  AboutCommunityController.m
//  WuYeO2O
//
//  Created by MoPellet on 15/5/13.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "AboutCommunityController.h"

@interface AboutCommunityController ()

@end

@implementation AboutCommunityController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self textViewInit];
    
    
}
/**
 *  初始化textView
 */
-(void)textViewInit{
    //    self.textView = [[UITextView  alloc] initWithFrame:CGRectMake(0,0 , SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_HEIGHT-NAVIGATION_HEIGHT)]; //初始化大小并自动释放
    //    self.textView.textColor = [UIColor blackColor];//设置textview里面的字体颜色
    //    self.textView.font = [UIFont fontWithName:@"Arial" size:18.0];//设置字体名字和字体大小
    //    self.textView.backgroundColor = [UIColor whiteColor];//设置它的背景颜色
    //    self.textView.scrollEnabled = YES;//是否可以拖动
    //    self.textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    //    self.textView.editable = NO;
    //    self.textView.text = @"";
    CHECKNETWORK
    
    
    UIWebView *webview = [[UIWebView alloc ] init];
    UIImageView *imgView = [[UIImageView alloc ] init];
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *docPath = [doc stringByAppendingPathComponent:@"about.jpeg"];
//   NSData * data = [NSData dataWithContentsOfFile:docPath];
    
    [[AnimationView animationClass] createAnimation:YES toText:nil toView:self.view];
    [[PublicNetWork network] aboutWithCompletionHandler:^(NSDictionary *dictionary, NSError *error) {
        if (!error) {
            if ([dictionary[Y_Code] intValue]==Y_Code_Success) {
                NSString *urlStr  = [NSString stringWithFormat:@"%@%@",URL_QINIU,dictionary[Y_Data][@"picture"]];
                [imgView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"aio_image_default"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    NSLog(@"%f------%f",image.size.width,image.size.height);
//                    NSData *imageData =UIImageJPEGRepresentation(image, 1.0);
//                
//                    if ( [imageData writeToFile:docPath atomically:YES]){
//                    
//                    }
// 
                    if (image.size.width>SCREEN_WIDTH) {
                        //                    CGFloat width = (SCREEN_WIDTH)*(SCREEN_WIDTH)/(image.size.width);
                        CGFloat width = SCREEN_WIDTH;
                        CGFloat height = width*(image.size.height)/(image.size.width);
                        NSLog(@"%f---%f",width,height);
                        imgView.frame = CGRectMake(0, 20+44, width, height);
                        [self.view addSubview:imgView];
                        webview.frame = CGRectMake(0, height, SCREEN_WIDTH, SCREEN_HEIGHT-height-48);
                        webview.layer.borderColor = [UIColor clearColor].CGColor;
                        [webview loadHTMLString:[NSString stringWithFormat:@"%@", dictionary[Y_Data][@"remarks"]] baseURL:nil];
                        [self.view addSubview: webview];
                        webview.backgroundColor=[UIColor clearColor];
                        for (UIView *subView in [webview subviews])
                        {
                            if ([subView isKindOfClass:[UIScrollView class]])
                            {
                                ((UIScrollView *)subView).bounces = NO; //去掉UIWebView的底图
            
                                for (UIView *scrollview in subView.subviews)
                                {
                                    if ([scrollview isKindOfClass:[UIImageView class]])
                                    { 
                                        scrollview.hidden = YES;  //上下滚动出边界时的黑色的图片 
                                    } 
                                } 
                            } 
                        }
                        [[AnimationView animationClass] hideViewToView:self.view];
                    }
                }];
 
            }
        }else{
        
            NSLog(@"%@",[error localizedDescription]);
            [[AnimationView animationClass] createAnimation:NO toText:NetError toView:self.view];
        }
    }];
    
}



@end
