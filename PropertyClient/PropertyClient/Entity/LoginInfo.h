//
//  LoginInfo.h
//  WuYeO2O
//
//  Created by MoPellet on 15/5/11.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginInfo : NSObject
/**
 *  小区名
 */
@property (nonatomic, strong) NSString *community;
/**
 *  小区ID
 */
@property (nonatomic, strong) NSString *communityId;
/**
 *  员工工号
 */
@property (nonatomic, strong) NSString *employeeId;

/**
 *  角色名称
 */
@property (nonatomic, strong) NSString *roleName;
/**
 *  角色类型
 */
@property (nonatomic, strong) NSString *roleType;
/**
 *  公司ID
 */
@property(nonatomic,strong)NSString *companyId;
/**
 *  公司名称
 */
@property (nonatomic, strong) NSString *company;
/**
 *  姓名
 */
@property (nonatomic, strong) NSString *name;
/**
 *  业主ID
 */
@property (nonatomic, strong) NSString *ownerId;
/**
 *  手机号
 */
@property (nonatomic, strong) NSString *phone;
/**
 *  房间id
 */
@property (nonatomic, strong) NSString *roomId;
/**
 *  房间号码
 */
@property (nonatomic, strong) NSString *roomNo;
/**
 *  性别
 */
@property (nonatomic, strong) NSString *sex;
/**
 *  登陆类型 1代表业主  2代表物业
 */
@property (nonatomic, strong) NSString *type;
/**
 *  头像
 */
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *buildingNo;
@property (nonatomic, copy) NSString *unitNo;
@end
