//
//  RepairInfo.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/6/1.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "RepairInfo.h"

@implementation RepairInfo

-(NSDictionary*)replacedKeyFromPropertyName
{
    return @{@"describe": @"description",@"repairId":@"id"};
}
@end
