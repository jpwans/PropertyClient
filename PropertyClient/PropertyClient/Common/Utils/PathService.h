//
//  PathService.h
//  UnisouthParents
//
//  Created by neo on 14-4-8.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PathService : NSObject




//取得用户数据库文件的路径
+ (NSString *)pathForUserDataBaseFileOfUser:(NSString *)userId;
//取得某个用户id全部资源类型文件的目录
+ (NSString *)pathForUserId:(NSString *)userId;

+ (void)deleteFolderAllFileBy:(NSString*)documentsPaht;

@end
