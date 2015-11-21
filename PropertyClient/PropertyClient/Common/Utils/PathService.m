//
//  PathService.m
//  UnisouthParents
//
//  Created by neo on 14-4-8.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import "PathService.h"

@implementation PathService



+ (NSString *)pathForUserDataBaseFileOfUser:(NSString *)userId {
	return [[self pathForUserId:userId] stringByAppendingPathComponent:USER_DB_FILE_NAME];
}

+ (NSString *)pathForUserId:(NSString *)userId {
	if (!userId || [userId isEqualToString:@""]) {
		userId = @"0";
	}
    
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath=[documentsDirectory stringByAppendingPathComponent:userId];
	BOOL isDirectory = TRUE;
	if (![fileManager fileExistsAtPath:filePath isDirectory:&isDirectory]) {
		[fileManager createDirectoryAtPath:filePath withIntermediateDirectories:TRUE attributes:nil error:nil];
	}
	return [documentsDirectory stringByAppendingPathComponent:userId];
}


/**
 *  删除指定文件夹下所有文件
 *
 *  @param documentsPaht  文件夹路径
 */
+ (void)deleteFolderAllFileBy:(NSString*)documentsPaht
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:documentsPaht error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        //if ([[filename pathExtension] isEqualToString:extension]) { //extension 可根据扩展名删除
        [fileManager removeItemAtPath:[documentsPaht stringByAppendingPathComponent:filename] error:NULL];
        // }
    }
}



@end
