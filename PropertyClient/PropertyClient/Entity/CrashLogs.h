//
//  CrashLogs.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/7/6.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CrashLogs : NSObject
@property (nonatomic, strong) NSString *logType;
@property (nonatomic, strong) NSString  *errorContent;
@end
