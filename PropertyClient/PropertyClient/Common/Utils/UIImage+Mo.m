//
//  UIImage+Mo.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/27.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "UIImage+Mo.h"

@implementation UIImage (Mo)
//name:图片名 borderWidth:圆环宽度 borderColor:圆环颜色
+(instancetype)cicleImageWithName:(UIImage *)oldImage borderWidth:(CGFloat )borderWidth borderColor:(UIColor *)borderColor{
    // 1.加载原图
//    UIImage *oldImage = [UIImage imageNamed:name];
    
    // 2.开启上下文
    CGFloat imageW = oldImage.size.width + 22 * borderWidth;
    CGFloat imageH = oldImage.size.height + 22 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

//无环裁剪    name:图片名
+(instancetype)cicleImageWithName:(NSString *)name{
    // 1.加载原图
    UIImage *oldImage = [UIImage imageNamed:name];
    
    // 2.开启上下文
    UIGraphicsBeginImageContextWithOptions(oldImage.size, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画圆
    CGRect circleRect = CGRectMake(0, 0, oldImage.size.width, oldImage.size.height);
    CGContextAddEllipseInRect(ctx, circleRect);
    
    // 5.按照当前的路径形状(圆形)裁剪, 超出这个形状以外的内容都不显示
    CGContextClip(ctx);
    
    // 6.画图
    [oldImage drawInRect:circleRect];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束
    UIGraphicsEndImageContext();
    
    return newImage;
    
    
}
@end
