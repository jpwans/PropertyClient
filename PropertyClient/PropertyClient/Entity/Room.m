//
//  Room.m
//  WuYeO2O
//
//  Created by MoPellet on 15/5/12.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "Room.h"

@implementation Room
+ (instancetype)roomWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
