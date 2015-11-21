//
//  FleaMarket.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/25.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FleaMarket : NSObject
/**
 *  描述信息
 */
@property (nonatomic, copy) NSString *describe;
/**
 *  跳蚤物品ID
 */
@property (nonatomic, copy) NSString *fleaMarkId;
/**
 *  物品分类
 */
@property (nonatomic, copy) NSString *goodsCategory;
/**
 *  物品名称
 */
@property (nonatomic, copy) NSString *goodsName;
/**
 *  是否公布联系方式
 */
@property (nonatomic, copy) NSString *isPhPublic;
/**
 *  姓名
 */
@property (nonatomic, copy) NSString *name;
/**
 *  原价
 */
@property (nonatomic, copy) NSString *oldPrice;
/**
 *  人员ID
 */
@property (nonatomic, copy) NSString *ownerId;
/**
 *  手机
 */
@property (nonatomic, copy) NSString *phone;
/**
 *  照片
 */
@property (nonatomic, copy) NSString *photo;
/**
 *  性别
 */
@property (nonatomic, copy) NSString *sex;
/**
 *  现价
 */
@property (nonatomic, copy) NSString *transferPrice;
/**
 *  结束时间
 */
@property (nonatomic, copy) NSString *endTime;
/**
 *  公布时间
 */
@property (nonatomic, copy) NSString *publishTime;
/**
 *  开始时间
 */
@property (nonatomic, copy) NSString *startTime;
/**
 *  照片
 */
@property (nonatomic, copy) NSString *image;
/**
 * 新旧程度
 */
@property (nonatomic, copy) NSString *purityType;
@end
