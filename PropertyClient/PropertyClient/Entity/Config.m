//
//  Config.m
//  UnisouthParents
//
//  Created by neo on 14-3-26.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import "Config.h"

@implementation Config

@synthesize isLogin;
@synthesize isNetworkRunning;

static Config * instance = nil;
+(Config *) Instance
{
    @synchronized(self)
    {
        if(nil == instance)
        {
            [self new];
        }
    }
    return instance;
}

+(id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if(instance == nil)
        {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    return nil;
}



-(void)saveLoginInfo:(LoginInfo *)log andUserName:(NSString *)username andPwd:(NSString *)pwd andIsRemember:(int) isRemember
{
    
    [self removeObjectFromUserDefaults];
    [SYSTEM_USERDEFAULTS setObject:log.companyId forKey:Y_COMPANYID];
    [SYSTEM_USERDEFAULTS setObject:log.unitNo forKey:Y_unitNo];
    [SYSTEM_USERDEFAULTS setObject:log.buildingNo forKey:Y_buildingNo];
    [SYSTEM_USERDEFAULTS setObject:log.type forKey:Y_TYPE];
    [SYSTEM_USERDEFAULTS setObject:log.roomId forKey:Y_ROOMID]; //Y_ROOMNO
    [SYSTEM_USERDEFAULTS setObject:log.roomNo forKey:Y_ROOMNO]; //Y_ROOMNO
    [SYSTEM_USERDEFAULTS setObject:log.name forKey:Y_NAME];
    [SYSTEM_USERDEFAULTS setObject:log.communityId forKey:Y_COMMUNITYID];
    [SYSTEM_USERDEFAULTS setObject:log.community forKey:Y_COMMUNITY];
    [SYSTEM_USERDEFAULTS setObject:username forKey:Y_USERNAME];
    [SYSTEM_USERDEFAULTS setObject:log.roleType forKey:Y_ROLE_TYPE];
    [SYSTEM_USERDEFAULTS setObject:pwd forKey:Y_PWD];
    [SYSTEM_USERDEFAULTS setInteger:isRemember forKey:Y_UIS_REMEMBER];
    [SYSTEM_USERDEFAULTS setObject:log.ownerId forKey:Y_OWNERID];
    [SYSTEM_USERDEFAULTS setObject:log.phone forKey:Y_PHONE];
    [SYSTEM_USERDEFAULTS setObject:log.sex forKey:Y_SEX];
    
    [SYSTEM_USERDEFAULTS setObject:log.employeeId forKey:Y_employeeId];
    [SYSTEM_USERDEFAULTS setObject:log.roleName forKey:Y_roleName];
    [SYSTEM_USERDEFAULTS setObject:log.company forKey:Y_company];
    
    
    if (log.photo) {
        [SYSTEM_USERDEFAULTS setObject:log.photo forKey:Y_PHOTO];
    }
    else{
        [SYSTEM_USERDEFAULTS setObject:NULL_VALUE forKey:Y_PHOTO];
    }
    
    [SYSTEM_USERDEFAULTS synchronize];
    
}

/**
 *  清空偏好设置里面的内容
 */
-(void)removeObjectFromUserDefaults{
    NSDictionary * dict = [SYSTEM_USERDEFAULTS dictionaryRepresentation];
    for (id key in dict) {
        [SYSTEM_USERDEFAULTS removeObjectForKey:key];
    }
    [SYSTEM_USERDEFAULTS synchronize];
}
/**
 *  登陆名
 *
 *  @return <#return value description#>
 */
-(NSString *)getLoginName
{
    return [SYSTEM_USERDEFAULTS objectForKey:Y_USERNAME];
}

-(NSString *)getName{
    return [SYSTEM_USERDEFAULTS objectForKey:Y_NAME];
}
-(NSString *)getOwnerId
{
    return [SYSTEM_USERDEFAULTS objectForKey:Y_OWNERID];
}


-(NSString *)getRoomId
{
    return[SYSTEM_USERDEFAULTS objectForKey:Y_ROOMID];
}
-(NSString *)getRoomNo
{
    return[SYSTEM_USERDEFAULTS objectForKey:Y_ROOMNO];
}

-(NSString *)getCompanyID{
    return [SYSTEM_USERDEFAULTS objectForKey:Y_COMPANYID];
}

-(NSString *)getBuildingNo
{
    return [SYSTEM_USERDEFAULTS objectForKey:Y_buildingNo];
}
-(NSString *)getUnitNo
{
    return [SYSTEM_USERDEFAULTS objectForKey:Y_unitNo];
}

/**
 *  获取偏好设置的密码
 */
-(NSString *)getPwd
{
    return [SYSTEM_USERDEFAULTS objectForKey:Y_PWD];
}
/**
 *  获取手机号
 */
-(NSString *)getPhoneNum{
    return [SYSTEM_USERDEFAULTS objectForKey:Y_PHONE];
}
/**
 *  获取偏好设置的登陆账号
 */
-(NSString *)getUserName
{
    return [SYSTEM_USERDEFAULTS objectForKey:Y_USERNAME];
}
-(NSString *)getType{
    return [SYSTEM_USERDEFAULTS objectForKey:Y_TYPE];
}

-(int)getIsRemember
{
    return [SYSTEM_USERDEFAULTS integerForKey:Y_UIS_REMEMBER];
}

/**
 *获取照片
 */
-(NSString *)getPhoto{
    return [SYSTEM_USERDEFAULTS objectForKey:Y_PHOTO];
}

-(NSString *)getCommunityName {
    return   [SYSTEM_USERDEFAULTS objectForKey:Y_COMMUNITY];
}
-(NSString *)getCommunityId {
    return   [SYSTEM_USERDEFAULTS objectForKey:Y_COMMUNITYID];
}


-(NSString *)getSex
{
    return [SYSTEM_USERDEFAULTS objectForKey:Y_SEX];
}

-(NSString *)getRoleType
{
    return [SYSTEM_USERDEFAULTS objectForKey:Y_ROLE_TYPE] ;
}

-(void)saveCookie:(BOOL)_isLogin
{
    [SYSTEM_USERDEFAULTS removeObjectForKey:@"cookie"];
    [SYSTEM_USERDEFAULTS setObject:_isLogin ? @"1" : @"0" forKey:@"cookie"];
    [SYSTEM_USERDEFAULTS synchronize];
}

-(BOOL)isCookie
{
    NSString * value = [SYSTEM_USERDEFAULTS objectForKey:@"cookie"];
    if (value && [value isEqualToString:@"1"]) {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)myTask {
    sleep(3);
}




- (NSString*)getFormatterDate:(NSDate*)date
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    NSCalendar *calendar = [NSCalendar currentCalendar];//日历
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *formatterDate = [date copy];
    NSDate *endDate = [formatter dateFromString: [formatter stringFromDate:date]] ;
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date] toDate:endDate options:0];
    long year = [components year];
    long month = [components month];
    long day = [components day];
    //三天以内更改显示格式
    NSString *messageDate;
    //  NSString *title;
    if (year == 0 && month == 0 && day < 3) {
        if (day == 0) {
            //   title = NSLocalizedString(@"今天",@"11");
            [formatter setDateFormat:@"HH:mm"];
            messageDate =[NSString stringWithFormat:@"%@",[formatter stringFromDate:formatterDate]];
        } else if (day == 1) {
            //  title = NSLocalizedString(@"昨天",nil);
            [formatter setDateFormat:@"HH:mm"];
            messageDate =[NSString stringWithFormat:@"%@%@",@"昨天",[formatter stringFromDate:formatterDate]];
        }else if (day == 2) {
            //  title = NSLocalizedString(@"前天",nil);
            [formatter setDateFormat:@"HH:mm"];
            messageDate =[NSString stringWithFormat:@"%@%@",@"前天",[formatter stringFromDate:formatterDate]];
        }
    }else if(year>0){
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        messageDate =[NSString stringWithFormat:@"%@",[formatter stringFromDate:formatterDate]];
    }else{
        [formatter setDateFormat:@"MM-dd HH:mm"];
        messageDate =[NSString stringWithFormat:@"%@",[formatter stringFromDate:formatterDate]];
    }
    
    return messageDate;
}


/**
 *  获取聊天用户的展示名
 *
 *  @param userRole 角色
 *  @param gender   性别
 *
 *  @return
 */
-(NSString*)getUserDisplayName:name  user_role:(NSUInteger)userRole gender:(NSString*)gender
{
    NSString *displayName;
    //    if (userRole == kWCContectRoleTypeParents) {
    if ([gender isEqualToString:@"F"]) {
        displayName = [NSString stringWithFormat:@"%@%@",name,@"妈妈"];
    }else{
        displayName = [NSString stringWithFormat:@"%@%@",name,@"爸爸"];
    }
    //else{
    //        displayName = name;
    //    }
    return displayName;
}

/**
 *  获取群展示名
 *
 *  @param jid jid
 *
 *  @return
 */
-(NSString*)getGroupDisplayName:(NSString*)jid
{
    NSString  *displayName = [jid componentsSeparatedByString:@"@"][0];
    if ([jid hasPrefix:@"clz-"]) {
        displayName = [displayName componentsSeparatedByString:@"-"][3];
    }
    
    return displayName;
}


@end
