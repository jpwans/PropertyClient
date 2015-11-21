//
//  Config.h
//  UnisouthParents
//
//  Created by neo on 14-3-26.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginInfo.h"


@interface Config : NSObject


//是否已经登录
@property BOOL isLogin;

//是否具备网络链接
@property BOOL isNetworkRunning;



+(Config *) Instance;
+(id)allocWithZone:(NSZone *)zone;

/**
 *  保存用户信息到沙盒
 *
 *  @param userName
 *  @param pwd
 *  @param isRemember
 */
-(void)saveLoginInfo:(LoginInfo *)log andUserName:(NSString *)username andPwd:(NSString *)pwd andIsRemember:(int) isRemember;

/**
 *  获取用户名
 *
 *  @return
 */
-(NSString *)getLoginName;
/**
 *获取业主姓名名
 */
-(NSString *)getName;
/**
 *  获取用户id
 *
 *  @return 当前登录用户id
 */
-(NSString *)getUserId;
/**
 *获取照片
 */
-(NSString *)getPhoto;
/**
 *  获取公司ID
 */
-(NSString *)getCompanyID;
//用户唯一标识  手机号
-(NSString *)getUserUniqueIdentificationMobile;

-(NSString *)getOwnerId;
/**
 *获取第几栋
 */
-(NSString *)getBuildingNo;
/**
 *获取单元号
 */
-(NSString *)getUnitNo;
/**
 *  获取偏好设置的密码
 */
-(NSString *)getPwd;
/**
 *  获取偏好设置的登陆账号
 */
-(NSString *)getUserName;


-(int)getIsRemember;

-(NSString *)getSex;

-(NSString *)getType;
/**
 *  获取手机号
 */
-(NSString *)getPhoneNum;
/**
 *  保存用户状态   运用在登录和注销处
 *
 *  @param _isLogin
 */
-(void)saveCookie:(BOOL)_isLogin;

/**
 *  查看当前用户状态
 *
 *  @return yes--在线；no--离线
 */
-(BOOL)isCookie;

- (void)myTask ;
/**
 *获取物业名称
 */
-(NSString *)getCommunityName ;
/**
 *获取小区ID
 */
-(NSString *)getCommunityId;
/**
 *获取房间ID
 */
-(NSString *)getRoomId;
/**
 *  获取房间号
 */
-(NSString *)getRoomNo;
/**
 *获取角色TYPE
 */
-(NSString *)getRoleType;
/**
 *  清空偏好设置里面的内容
 */
-(void)removeObjectFromUserDefaults;

//格式化日期
- (NSString*)getFormatterDate:(NSDate*)date;

-(NSString*)getUserDisplayName:name  user_role:(NSUInteger)userRole gender:(NSString*)gender;

-(NSString*)getGroupDisplayName:(NSString*)jid;


@end
