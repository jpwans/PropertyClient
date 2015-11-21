//
//  DES3Util.h
//  WuYeO2O
//
//  Created by liuneo on 15/5/13.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DES3Util : NSObject


/**
 *
 *加密方法
 */
+ (NSString*)encrypt:(NSString*)plainText;
/**
 *  解密方法
 */
+ (NSString*)decrypt:(NSString*)encryptText;
@end

