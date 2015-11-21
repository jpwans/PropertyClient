//
//  ResponeBase.h
//  UnisouthParents
//
//  Created by neo on 14-3-25.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponeBase : NSObject


@property (assign, nonatomic) int code;
@property (assign, nonatomic) float version;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSArray  *data;



@end
