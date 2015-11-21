//
//  MessageDB.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/29.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MessageDB : NSManagedObject

@property (nonatomic, retain) NSString * from;
@property (nonatomic, retain) NSString * adviceId;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSString * status;

@end
