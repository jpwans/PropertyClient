//
//  CacheUtil.m
//  UnisouthParents
//
//  Created by neo on 14-5-13.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import "CacheUtil.h"

@implementation CacheUtil


/**
 *  获取短信里的图片
 *
 *  @param imageName imageName description
 *  @param image_url image_url description
 *  @param block     block description
 */
+(void)getMessageImageByImagenameAndUrl:(NSString*)imageName byFileCatalog:(NSString*)fileCatalog  imageUrl:(NSString*)image_url withCompletionHandler:(void(^)( UIImage *uiImage))block
{
    
     UIImage *userHeadImage = nil;
    
//    SDImageCache *sdImageCache = [[SDImageCache alloc] initWithNamespace:fileCatalog];
    SDImageCache *sdImageCache = [SDImageCache sharedImageCache];
    
    //内存
    userHeadImage = [sdImageCache imageFromMemoryCacheForKey:imageName];
    if (userHeadImage == nil) {
        //本地缓存
        userHeadImage = [sdImageCache imageFromDiskCacheForKey:imageName];
        if (userHeadImage == nil) {
            //网络
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                UIImage *userNetworkHeadImage = nil;
                if (imageName.length>0) {
                    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[image_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
                    userNetworkHeadImage = [UIImage imageWithData:data];
                    [sdImageCache storeImage:userNetworkHeadImage forKey:imageName toDisk:YES];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        block(userNetworkHeadImage);
                    });
                }
            });
           
        }else{
             [sdImageCache storeImage:userHeadImage forKey:imageName toDisk:NO];
             block(userHeadImage);
        }
    }else{
         block(userHeadImage);
    }
   
}


@end
