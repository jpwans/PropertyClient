//
//  ImageUtil.m
//  UnisouthParents
//
//  Created by neo on 14-5-14.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import "ImageUtil.h"
#import "PathService.h"

@implementation ImageUtil


/**
 *  获取缩略图
 *
 *  @param img  img description
 *  @param size size description
 *
 *  @return return value description
 */
+ (UIImage *)scaleToSizeImageByOriginalImage:(UIImage *)img size:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
    
}


//保存图片到document/pathName
+ (NSString*)saveImage:(UIImage *)tempImage withName:(NSString *)imageName withPathName:(NSString*)pathName
{
    NSData *imageData ; //消耗内存
    if (UIImageJPEGRepresentation(tempImage, 0.5))
        imageData = UIImageJPEGRepresentation(tempImage, 0.5f);
    else
        imageData = UIImagePNGRepresentation(tempImage);
    
//    NSLog(@"imageData_size (byte): %d", [imageData length]);
    
    NSString *documentsDirectory = [PathService pathForUserId:pathName ]; //@"sendImages"
    NSString *fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPathToFile atomically:NO];
    return fullPathToFile;
}

@end
