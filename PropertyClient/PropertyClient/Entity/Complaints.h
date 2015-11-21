//
//  Complaints.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/19.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Complaints : NSObject
@property (nonatomic, copy) NSString *compId;
@property (nonatomic, copy) NSString *compTime;
@property (nonatomic, copy) NSString *describe;
@property (nonatomic, copy) NSString *compTitle;
@property (nonatomic, copy) NSString *photo;



+ (instancetype)complaintsWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
