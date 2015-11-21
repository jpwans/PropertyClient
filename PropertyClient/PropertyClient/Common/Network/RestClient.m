//
//  RestClient.m
//  UnisouthParents
//
//  Created by neo on 14-3-24.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import "RestClient.h"

@implementation RestClient


/**
 *添加头部信息
 */
+(id)getAFHTTPRequestOperationManagerPutheader
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *phone =    [[Config Instance] getPhoneNum];
    NSString *pwd =   [[Config Instance] getPwd];
    NSString *type= [[Config Instance] getType];
    NSString *version =  [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
     NSString *roomId = [[Config Instance] getRoomId];
    NSString *parm =[NSString stringWithFormat:@"%@&#%@&#%@&#%@&#%@",phone,pwd,type,version,roomId];
    parm =   [DES3Util encrypt:parm];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:parm forHTTPHeaderField:@"user_info"];
    return  manager;
}

+(id)getAFHTTPRequestOperationManagerPutheaderPost
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *phone =    [[Config Instance] getPhoneNum];
    NSString *pwd =   [[Config Instance] getPwd];
    NSString *type= [[Config Instance] getType];
    NSString *version =  [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    NSString *roomId = [[Config Instance] getRoomId];
    NSString *parm =[NSString stringWithFormat:@"%@&#%@&#%@&#%@&#%@",phone,pwd,type,version,roomId];
    parm =   [DES3Util encrypt:parm];
    
    //      manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:parm forHTTPHeaderField:@"user_info"];
    return  manager;
}

@end
