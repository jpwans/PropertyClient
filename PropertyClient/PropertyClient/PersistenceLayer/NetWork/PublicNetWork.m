//
//  PublicNetWork.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/6/18.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "PublicNetWork.h"

@implementation PublicNetWork
static PublicNetWork *network = nil;

+ (PublicNetWork*)network
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        network = [[super alloc] init];
    });
    return network;
}

-(void) aboutWithCompletionHandler: (void (^)(NSDictionary *dictionary,NSError *error))block{
    AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheader];
    [manager POST:API_BASE_URL_STRING(URL_ABOUTCOMMUNITY)  parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary= responseObject;
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
