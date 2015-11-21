//
//  LoginDao.h
//  UnisouthParents
//
//  Created by neo on 14-3-26.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginDao : NSObject

+ (LoginDao*)sharedManager;

-(void) login:(NSString*)account pwd:(NSString*)password withCompletionHandler:(void (^)(NSDictionary *proDictionary,NSError *error))block;

-(void) loginOutWithCompletionHandler: (void (^)(NSDictionary *getDictionary,NSError *error))block;
@end
