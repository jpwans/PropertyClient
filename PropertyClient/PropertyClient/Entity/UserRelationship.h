//
//  UserRelationship.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/6/17.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserRelationship : NSObject
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *describe;
@property (nonatomic, strong) NSString *relaId;
@property (nonatomic, strong) NSString *isNewRecord;
@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSString *parentId;
@property (nonatomic, strong) NSString *remarks;
@property (nonatomic, strong) NSString *sort;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *updateDate;
@property (nonatomic, strong) NSString *value;
@end
