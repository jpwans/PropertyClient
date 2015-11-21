//
//  CrashLogs.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/7/6.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "CrashLogs.h"

@implementation CrashLogs
- (void)encodeWithCoder:(NSCoder *)coder
{
//     [super encodeWithCoder:coder];
    //_name 属性值进行编码（会将_name的值 存进文件）
    [coder encodeObject:_logType forKey:@"logType"];
    [coder encodeObject:_errorContent forKey:@"errorContent"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        _logType =[aDecoder decodeObjectForKey:@"logType"];
        _errorContent = [aDecoder decodeObjectForKey:@"errorContent"];
    }
    return self;
}

@end
