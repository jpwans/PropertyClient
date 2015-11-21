//
//  Complaints.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/19.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "Complaints.h"

@implementation Complaints

+ (instancetype)complaintsWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
    
}
- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(NSDictionary*)replacedKeyFromPropertyName
{
    return @{@"describe": @"description",@"compTitle":@"compTitile"};
}
@end
