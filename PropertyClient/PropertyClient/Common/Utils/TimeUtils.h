//
//  TimeUtils.h
//  UnisouthParents
//
//  Created by neo on 14-5-5.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//


#import <Foundation/Foundation.h>

#define TAG  @"TimeUtils"

#define MINUS_YYMMDDHHMMSS @"yyyy-MM-dd HH:mm:ss"
#define MINUS_YYMMDDHHMM @"yyyy-MM-dd HH:mm"
#define MINUS_YYMMDD @"yyyy-MM-dd"

#define SLASH_YYMMDDHHMMSS @"yyyy/MM/dd HH:mm:ss"
#define SLASH_YYMMDDHHMM @"yyyy/MM/dd HH:mm"
#define SLASH_YYMMDD @"yyyy/MM/dd"
#define SLASH_MMDD @"MM/dd"

#define UNSIGNED_YYMMDDHHMMSS @"yyyyMMdd HH:mm:ss"
#define UNSIGNED_YYMMDDHHMM @"yyyyMMdd HH:mm"
#define UNSIGNED_YYMMDD @"yyyyMMdd"
#define UNSIGNED_MMDD @"MMdd"
#define UNSIGNED_HHMMSS @"HHmmss"

#define DOT_YYMMDDHHMMSS @"yyyy.MM.dd HH:mm:ss"
#define DOT_YYMMDDHHMM @"yyyy.MM.dd HH:mm"
#define DOT_YYMMDD @"yyyy.MM.dd"
#define DOT_MMDD @"MM.dd"
#define DOT_HHMM @"HH:mm"
#define CURRENT_DATE @"yyyy年MM月dd日"
#define CURRENT_TIME @"yyyy年MM月dd日 HH:mm"
#define BIRTH_TIME @"yyyy年MM月dd日 EEEE"
#define CURRENT_MONTH @"MM月dd日"


@interface TimeUtils : NSObject
{
    NSArray *weekArray;
}

+(NSString*)getDateFromLong:(NSString*)strFormat  strDate:(long long)strDate;

+(NSDate*) getDateFromString:(NSString*) strFormat stringDate:(NSString*) strDate;

+(NSString*) getStringFromDate:(NSString*) strFormat stringDate:(NSDate*) date;

+(NSString*) getStringFromString:(NSString*) strFormat stringDate:(NSString*) strDate;

+(NSDate*)getDateFromLongReturnDate:(NSString*)strFormat  strDate:(long long)strDate;

+(NSString *)getTimeFromCreateDate:(long long)strDate;

+(long long) getCurrentTimeFrom1970;
@end
