
//
//  LoginDao.m
//  UnisouthParents
//
//  Created by neo on 14-3-26.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import "LoginDao.h"

@implementation LoginDao

static LoginDao *sharedManager = nil;

+ (LoginDao*)sharedManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[super alloc] init];
    });
    return sharedManager;
}


-(void) login:(NSString*)account pwd:(NSString*)password withCompletionHandler:(void (^)(NSDictionary *proDictionary, NSError *error))block
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    password = [DES3Util encrypt:password];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:account ,@"phone",password,@"password" ,LoginType,@"type",nil];
    
    [manager POST:API_BASE_URL_STRING(URL_SUFFIX_LOGIN) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary = responseObject;
        NSLog(@"%@",dictionary[Y_Message]);
        if (block) {
            block(dictionary,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block([NSDictionary dictionary],error);
        }
    }];
    
}


-(void) loginOutWithCompletionHandler: (void (^)(NSDictionary *getDictionary,NSError *error))block
{
    AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
    
    [manager POST:API_BASE_URL_STRING(POST_LOGINOUT_URL)   parameters:nil  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary = responseObject;
        if (block) {
            block(dictionary,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block([NSDictionary dictionary],error);
        }
    }];
}




@end
