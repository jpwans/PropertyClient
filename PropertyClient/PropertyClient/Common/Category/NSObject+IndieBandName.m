//
//  NSObject+IndieBandName.m
//  UnisouthParents
//
//  Created by neo on 14-6-13.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import "NSObject+IndieBandName.h"

#import <objc/runtime.h>
static const void *IndieBandNameKey = &IndieBandNameKey;
@implementation NSObject (IndieBandName)
@dynamic indieBandName;

- (NSString *)indieBandName {
    return objc_getAssociatedObject(self, IndieBandNameKey);
}

- (void)setIndieBandName:(NSString *)indieBandName{
    objc_setAssociatedObject(self, IndieBandNameKey, indieBandName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end