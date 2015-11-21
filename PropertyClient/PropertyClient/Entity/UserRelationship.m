//
//  UserRelationship.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/6/17.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "UserRelationship.h"

@implementation UserRelationship
-(NSDictionary*)replacedKeyFromPropertyName
{
    return @{@"describe": @"description",@"relaId":@"id"};
}
@end
