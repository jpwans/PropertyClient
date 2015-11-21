//
//  NSString+StringCategoryUtil.m
//  UnisouthParents
//
//  Created by neo on 14-5-9.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import "NSString+StringCategoryUtil.h"

@implementation NSString (StringCategoryUtil)



/**
 *  判断字符串是否为空
 *
 *  @param str
 *
 *  @return yes-不为空； no-为空；
 */
-(Boolean) isNotEmptyOrNull:(NSString *) str {
    if (str && str.length>0) {
        return true;
    }else
        return false;
}

@end
