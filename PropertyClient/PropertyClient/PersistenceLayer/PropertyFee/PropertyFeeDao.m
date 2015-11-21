//
//  PropertyFeeDao.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/27.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "PropertyFeeDao.h"

@implementation PropertyFeeDao
static PropertyFeeDao *sharedManager = nil;

+ (PropertyFeeDao*)sharedManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[super alloc] init];
    });
    return sharedManager;
}

@end
