//
//  UIImage+Caegory.m
//  UnisouthParents
//
//  Created by neo on 14-8-27.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import "UIImage+Caegory.h"

@implementation UIImage (Caegory)


/**
 *  通过颜色生成一个纯色的图片
 *
 *  @param color
 *  @param size
 *
 *  @return uiimage
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
