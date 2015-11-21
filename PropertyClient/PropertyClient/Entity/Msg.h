//
//  Msg.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/29.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Msg : NSObject
@property (nonatomic, copy) NSString *adviceId;
@property (nonatomic, copy) NSString *adviceType;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *publishDate;
@property (nonatomic, copy) NSString *publishPerson;
@property (nonatomic, copy) NSString *publishStatus;
@end
