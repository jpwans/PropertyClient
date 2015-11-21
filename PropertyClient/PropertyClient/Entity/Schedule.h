//
//  Schedule.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/6/1.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Owner : NSObject
@property (nonatomic, copy) NSString *isNewRecord;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@end

@interface Schedule : NSObject
@property (nonatomic, copy) NSString *scheduleId;
@property (nonatomic, copy) NSString *isNewRecord;
@property (nonatomic, copy) NSString *repairId;
@property (nonatomic, copy) NSString *scheduleRemark;
@property (nonatomic, copy) NSString *scheduleTime;
@property (nonatomic, copy) NSString *scheduleType;
@property (nonatomic, copy) NSString *scheduleUserId;
@property (nonatomic, copy) NSString *userType;
@property (nonatomic, strong) Owner *owner;
@end

//commTime = "2015-06-12 12:22:51";
//content = 111;
//createDate = "2015-06-12 12:22:51";
//id = 6992ced70f324c80be347ff6398e6a09;
//isNewRecord = 0;
//owner =         {
//    isNewRecord = 1;
//    name = "\U4e07\U5b50\U6587";
//};
//ownerId = 03567ad68d1e40439e41f93bdc6faa4b;
//repair =         {
//    isNewRecord = 1;
//    title = "\U6211\U7684\U4fdd\U4fee";
//};
//repairId = eff27c1d29794b5fb8503b026568ca1b;
// = "2015-06-12 12:22:51";
@interface Comments : NSObject
@property (nonatomic, copy) NSString *commTime;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *isNewRecord;
@property (nonatomic, copy) NSString *ownerId;
@property (nonatomic, strong) Owner *owner;
@property (nonatomic, copy) NSString *repairId;
@property (nonatomic, copy) NSString *updateDate;
@end


