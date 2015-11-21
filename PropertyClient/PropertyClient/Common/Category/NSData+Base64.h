//
//  NSData+Base64.h
//  UnisouthTeacher
//
//  Created by neo on 14-9-16.
//  Copyright (c) 2014年 Unisouth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Base64)
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;
- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)base64EncodedString;
@end
