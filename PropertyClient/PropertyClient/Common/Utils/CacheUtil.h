//
//  CacheUtil.h
//  UnisouthParents
//
//  Created by neo on 14-5-13.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDImageCache.h"

@interface CacheUtil : NSObject


+(void)getMessageImageByImagenameAndUrl:(NSString*)imageName byFileCatalog:(NSString*)fileCatalog  imageUrl:(NSString*)image_url withCompletionHandler:(void(^)( UIImage *uiImage))block;

@end
