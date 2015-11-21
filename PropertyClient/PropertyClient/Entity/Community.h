//
//  Community.h
//  WuYeO2O
//
//  Created by MoPellet on 15/5/12.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Community : NSObject
/**
 *  小区物业ID
 */
@property (nonatomic, copy) NSString *communityId;
/**
 *  小区名称
 */
@property (nonatomic, copy) NSString *communityName;

+ (instancetype)communityWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
