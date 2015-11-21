//
//  VisitorCard.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/18.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "VisitorCard.h"

@implementation VisitorCard


+ (instancetype)visitorWithDict:(NSDictionary *)dict{

    return [[self alloc] initWithDict:dict];

}
- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
