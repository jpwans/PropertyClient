//
//  TelephoneHttpClinet.h
//  UnisouthParents
//
//  Created by neo on 14-3-28.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import <Foundation/Foundation.h>




typedef void(^SCHttpSuccessBlock)(NSString *soapResults);

@interface TelephoneHttpClinet : NSObject<NSURLConnectionDelegate>{
    NSMutableData *soapData;
}
-(void)postRequestWithPhoneNumber:(NSString *)number;
@end