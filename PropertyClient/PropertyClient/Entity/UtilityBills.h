//
//  UtilityBills.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/27.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UtilityBills : NSObject
 @property (nonatomic, copy) NSString *earCharge;
 @property (nonatomic, copy) NSString *earnTime;
 @property (nonatomic, copy) NSString *payCharge;
 @property (nonatomic, copy) NSString *propertyId;
@property (nonatomic, assign,getter=isOpen)  BOOL  open;
@end


@interface PayFeeInfo : NSObject
@property (nonatomic, copy) NSString *createBy;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *mouth;
@property (nonatomic, copy) NSString *paymentAmount;
@property (nonatomic, copy) NSString *recordId;
@end
