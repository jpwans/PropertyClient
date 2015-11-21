//
//  UITapGestureRecognizer+Add.m
//  UnisouthParents
//
//  Created by neo on 14-6-12.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import "UITapGestureRecognizer+Add.h"
#import <objc/runtime.h>
static const void *GestureRecognizerDataKey = &GestureRecognizerDataKey;



@implementation UITapGestureRecognizer (Add)



@dynamic gestureRecognizerData;

- (NSData *)gestureRecognizerData {
    return objc_getAssociatedObject(self, GestureRecognizerDataKey);
}

- (void)setGestureRecognizerData:(NSData *)gestureRecognizerData{
    objc_setAssociatedObject(self, GestureRecognizerDataKey, gestureRecognizerData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



@end
