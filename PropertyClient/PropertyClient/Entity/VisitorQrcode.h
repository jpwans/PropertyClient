//
//  VisitorQrcode.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/19.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VisitorQrcode : NSObject
/**
 *  二维码字符串
 */
@property (nonatomic, copy) NSString *qrcodeStr;

/**
 *  访客姓名
 */
@property (nonatomic, copy) NSString *name;
/**
 *  访客性别
 */
@property (nonatomic, assign) int sex;
/**
 *  访问小区
 */
@property (nonatomic, copy) NSString *communityName;
/**
 *  访问者电话
 */
@property (nonatomic, copy) NSString *phone;
/**
 *  是否驾车
 */
@property (nonatomic, assign) int isDrive;
@end
