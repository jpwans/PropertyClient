//
//  PublicNetWork.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/6/18.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicNetWork : NSObject
+ (PublicNetWork*)network;
/**
 *  关于小区  电话 照片 描述
 */
-(void) aboutWithCompletionHandler: (void (^)(NSDictionary *dictionary,NSError *error))block;
@end
