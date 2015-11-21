//
//  PublicClass.m
//  WuYeO2O
//
//  Created by MoPellet on 15/5/14.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "PublicClass.h"

@implementation PublicClass

static PublicClass *sharedManager = nil;
+ (PublicClass*)sharedManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[super alloc] init];
    });
    return sharedManager;
}

/**
 *获取token
 */
-(void) getTokenWithCompletionHandler: (void (^)(NSDictionary *getDictionary,NSError *error))block{
    
    AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
    [manager GET:API_BASE_URL_STRING(URL_TOKEN) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary= responseObject;
        if (block) {
            block(dictionary,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block([NSDictionary dictionary],error);
        }
    }];
    
    
}

-(void)getNewVersionWithCompletionHandler: (void (^)(NSDictionary *dictionary,NSError *error))block{
//    NSString *version =  [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    NSString *companyId =  [[Config Instance]getCompanyID];
    AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:Y_APP_VERSION,@"version",companyId,@"companyId",VERSIONTYPE,@"versionType",nil];
    [manager POST:API_BASE_URL_STRING(URL_UPNDATEVERSION) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary= responseObject;
        if (block) {
            block(dictionary,nil);
        }
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (block) {
                  block([NSDictionary dictionary],error);
              }
          }];
}

-(NSString *)getNowTimeWithFormat:(NSString *)format{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:format];
      return [dateformatter stringFromDate:senddate];
}

-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}


+(NSString *) compareCurrentTime:(NSDate*) compareDate
{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
       timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"马上"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分后",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小后",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天后",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月后",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年后",temp];
    }
    
    return  result;
}

//-(void)enlargePhoto:(long)index maskView:(UIScrollView *)scrollView view:(UIView *)targetView{
//
//    scrollView = [[UIScrollView alloc] init];
//    scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT); // frame中的size指UIScrollView的可视范围
//    scrollView.backgroundColor = [UIColor blackColor];
//    UIButton *imgbtn = [[UIButton alloc] init];
//    //    imgbtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    [imgbtn addTarget:self action:@selector(lookImage:) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:imgbtn];
//    [targetView addSubview:scrollView];
//    
//    // 2.创建UIImageView（图片）
//    UIImageView *imageView = [[UIImageView alloc] init];
//    [[AnimationView animationClass ]createAnimation:YES toText:nil toView:targetView];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%ld",URL_QINIU,index]]
//                 placeholderImage:[UIImage imageNamed:@"aio_image_default"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                     [[AnimationView animationClass] hideViewToView:targetView];
//                 }];
//    CGFloat imgW = imageView.image.size.width; // 图片的宽度
//    CGFloat imgH = imageView.image.size.height; // 图片的高度
//    imageView.frame = CGRectMake(0, 0, imgW, imgH);
//    
//    [scrollView addSubview:imageView];
//    NSLog(@"%f",imageView.frame.size.height);
//    imgbtn.frame = CGRectMake(0, 0, imageView.frame.size.width, SCREEN_HEIGHT);
//    // 3.设置scrollView的属性
//    if (imgW<SCREEN_HEIGHT&&imgH>SCREEN_HEIGHT) {
//        imageView.frame = CGRectMake((SCREEN_WIDTH-imgW)/2, 0, imgW, imgH);
//    }
//    else if (imgH<SCREEN_HEIGHT) {
//        imageView.frame = CGRectMake(0, (SCREEN_HEIGHT-imgH)/2, imgW, imgH);
//    }
//    else  if (imgW<SCREEN_WIDTH&&imgH<SCREEN_HEIGHT) {
//        imageView.frame = CGRectMake((SCREEN_WIDTH-imgW)/2, (SCREEN_HEIGHT-imgH)/2, imgW, imgH);
//    }
//    
//    // 设置UIScrollView的滚动范围（内容大小）
//    scrollView.contentSize = imageView.image.size;
//    
//    // 隐藏水平滚动条
//    scrollView.showsHorizontalScrollIndicator = NO;
//    scrollView.showsVerticalScrollIndicator = NO;
//    // 去掉弹簧效果
//    scrollView.bounces = NO;
//
//}
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

//+(NSString *)convertMD5:(NSString *)str{
//
//    char[] a = str.toCharArray();
//    for (int i = 0; i < a.length; i++){
//        a[i] = (char) (a[i] ^ 't');
//    }
//    String s = new String(a);
//    return s;
//}

//public static String convertMD5(string inStr){
//    
//    char[] a = inStr.toCharArray();
//    for (int i = 0; i < a.length; i++){
//        a[i] = (char) (a[i] ^ 't');
//    }
//    String s = new String(a);
//    return s;
//    
//}

 @end


