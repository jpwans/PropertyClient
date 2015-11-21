//
//  Room.h
//  WuYeO2O
//
//  Created by MoPellet on 15/5/12.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Room : NSObject
@property (nonatomic, copy) NSString *buildingNo;
@property (nonatomic, copy) NSString *roomId;
@property (nonatomic, copy) NSString *roomNo;
@property (nonatomic, copy) NSString *unitNo;

+ (instancetype)roomWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
