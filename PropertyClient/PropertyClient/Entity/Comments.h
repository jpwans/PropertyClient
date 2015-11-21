//
//  Comments.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/22.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comments : NSObject
/**
 *  活动编号
 */
@property (nonatomic, copy) NSString *activityId;
/**
 *  回复时间
 */
@property (nonatomic, copy) NSString *commTime;
/**
 *  文本内容
 */
@property (nonatomic, copy) NSString *content;
/**
 *  个人ID
 */
@property (nonatomic, copy) NSString *ownerId;
/**
 *  用户名
 */
@property (nonatomic, copy) NSString *userName;
/**
 *  用户性别
 */
@property (nonatomic, copy) NSString *userSex;
/**
 *  手机
 */
@property (nonatomic, copy) NSString *phone;
/**
 *  照片
 */
@property (nonatomic, copy) NSString *photo;
@end
