//
//  Activity.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/21.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Activity : NSObject
/**
 *  活动ID
 */
@property (nonatomic, copy) NSString *activityId;
/**
 *  回复次数
 */
@property (nonatomic, copy) NSString *commentCount;
/**
 *  活动内容
 */
@property (nonatomic, copy) NSString *describe;
/**
 *  结束时间
 */
@property (nonatomic, copy) NSString *endtime;
/**
 *  地点
 */
@property (nonatomic, copy) NSString *place;
/**
 *  公布时间
 */
@property (nonatomic, copy) NSString *publishtime;
/**
 *  开始时间
 */
@property (nonatomic, copy) NSString *starttime;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  名字
 */
@property (nonatomic, copy) NSString *name;
/**
 *  头像
 */
@property (nonatomic, copy) NSString *photo;
/**
 *  小区名字
 */
@property (nonatomic, copy) NSString *communityName;
/**
 *  活动照片
 */
@property (nonatomic, copy) NSString *activityPhoto;
@end
