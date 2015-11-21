//
//  UIImage+Mo.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/27.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Mo)
//name:图片名 borderWidth:圆环宽度 borderColor:圆环颜色
+(instancetype)cicleImageWithName:(UIImage *)oldImage borderWidth:(CGFloat )borderWidth borderColor:(UIColor *)borderColor;

//无环裁剪    name:图片名
+(instancetype)cicleImageWithName:(NSString *)Name ;
@end
