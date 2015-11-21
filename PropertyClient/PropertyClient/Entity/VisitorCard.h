//
//  VisitorCard.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/18.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VisitorCard : NSObject
/**
 *  访客姓名
 */
@property (nonatomic, copy) NSString *name;
/**
 *  访客电话
 */
@property (nonatomic, copy) NSString *phone;
/**
 *  访问状态
 */
@property (nonatomic, copy) NSString *visitState;
/**
 *  访客证ID
 */
@property (nonatomic, copy) NSString *visitId;
/**
 *  小区
 */
@property (nonatomic, copy) NSString *community;
/**
 *  小区ID
 */
@property (nonatomic, copy) NSString *communityId;
/**
 *  访问时间
 */
@property (nonatomic, copy) NSString *visitTime;
/**
 *  是否开车
 */
@property (nonatomic, copy) NSString *isDrive;
/**
 *  二维码字符串
 */
@property (nonatomic, copy) NSString  *qrcode;
/**
 *  性别
 */
@property (nonatomic, copy) NSString *sex;
/**
 *创建时间
 */
@property (nonatomic, copy) NSString *createDate;



+ (instancetype)visitorWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
