//
//  CheckNetwork.h
//  UnisouthParents
//
//  Created by neo on 14-3-26.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckNetwork : NSObject <UIAlertViewDelegate>
+ (CheckNetwork *)sharedManager;

-(BOOL)isExistenceNetwork;

-(void)notReachableAlertView;

@end
