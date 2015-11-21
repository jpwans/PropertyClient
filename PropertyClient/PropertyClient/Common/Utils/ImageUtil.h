//
//  ImageUtil.h
//  UnisouthParents
//
//  Created by neo on 14-5-14.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageUtil : NSObject

+ (UIImage *)scaleToSizeImageByOriginalImage:(UIImage *)img size:(CGSize)size;

+ (NSString*)saveImage:(UIImage *)tempImage withName:(NSString *)imageName withPathName:(NSString*)pathName;

@end
