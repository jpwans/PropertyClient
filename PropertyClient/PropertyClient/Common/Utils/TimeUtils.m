//
//  TimeUtils.m
//  UnisouthParents
//
//  Created by neo on 14-5-5.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import "TimeUtils.h"

static NSString * const DATE_MATCH = @"^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$";



@implementation TimeUtils


-(id)init
{
    if (self=[super init]) {
    
        weekArray = [[NSArray alloc] initWithObjects: @"星期天", @"星期一", @"星期二",@"星期三", @"星期四", @"星期五", @"星期六",nil];
    }
    return self;
}




/**
 * 从String中返回日期
 *
 * @param strFormat
 * @param strDate
 * @return
 */
+(NSDate*) getDateFromString:(NSString*) strFormat stringDate:(NSString*) strDate
{
    NSDateFormatter * dm = [[NSDateFormatter alloc]init];
    [dm setDateFormat:strFormat];
    NSDate * newdate = [dm dateFromString:strDate];
    return newdate;
}

/**
 *  从date从返回string
 *
 *  @param strFormat strFormat description
 *  @param date      date description
 *
 *  @return return value description
 */
+(NSString*) getStringFromDate:(NSString*) strFormat stringDate:(NSDate*) date
{
    NSDateFormatter * dm = [[NSDateFormatter alloc]init];
    [dm setDateFormat:strFormat];
    return [dm stringFromDate:date];
}
/**
 *  格式化string 日期
 *
 *  @param strFormat strFormat description
 *  @param strDate   strDate description
 *
 *  @return return value description
 */
+(NSString*) getStringFromString:(NSString*) strFormat stringDate:(NSString*) strDate
{
    NSDate *date = [TimeUtils getDateFromString:strFormat stringDate:strDate];
    NSString *newDateStr = [TimeUtils getStringFromDate:strFormat stringDate:date];
    return newDateStr;
}

/**
 * 从long中返回日期
 *
 * @param String
 *            strFormat
 * @param long strDate
 * @return
 */
+(NSString*)getDateFromLong:(NSString*)strFormat  strDate:(long long)strDate
{
    if (strDate > 0) {
        @try {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter  setDateFormat:strFormat];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:strDate/1000];
            return  [dateFormatter stringFromDate:date];
        }
        @catch (NSException *exception) {
            return nil;
        }
        @finally {
            
        }
    }
    return nil;
}


/**
 *从long中返回日期NSDate类型
 *
 *  @param strFormat strFormat description
 *  @param strDate   strDate description
 *
 *  @return return value description
 */
+(NSDate*)getDateFromLongReturnDate:(NSString*)strFormat  strDate:(long long)strDate
{
    if (strDate > 0) {
        @try {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter  setDateFormat:strFormat];
           return [NSDate dateWithTimeIntervalSince1970:strDate/1000];
        }
        @catch (NSException *exception) {
            return nil;
        }
        @finally {
            
        }
    }
    return nil;
}


/**
 *  获取自1970年以来的秒数
 *
 *  @return return value description
 */
+(long long) getCurrentTimeFrom1970
{
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970]*1000;
    double i=time;
    return i;
}


/**
 *  获取详细时间信息
 *
 *  @param strDate 创建日期毫秒
 *
 *  @return value description
 */
+ (NSString *)getTimeFromCreateDate:(long long)strDate
{
    NSString *dateString = NULL_VALUE;
    if (strDate > 0) {
        NSDate *currentDate = [NSDate date];
        NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:strDate/1000];
        long timeInterval = (long)[currentDate timeIntervalSinceDate:createDate];
        if (timeInterval < 60) {
            dateString = @"1分钟之前";
//            dateString = [NSString stringWithFormat:@"%ld秒之前", timeInterval];
        }
        else {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:CURRENT_TIME];
            long day = timeInterval/(3600*24);
            if(day > 0) {
                if (day > 10)
                    dateString = [formatter stringFromDate:createDate];
                else {
                    dateString = [NSString stringWithFormat:@"%li天之前", day];
                }
            } else {
//                int hour = timeInterval%(3600*24)/3600;
                long hour = timeInterval/3600;
                if (hour > 0)
                    dateString = [NSString stringWithFormat:@"%li小时之前", hour];
                else {
//                    int minute = timeInterval%3600/60;
                    long minute = timeInterval/60;
                    dateString = [NSString stringWithFormat:@"%li分钟之前", minute];
                }
            }
            
            formatter = nil;
        }
    }
    
    return dateString;
}

/**
 *
 * @param strDate
 * @return 返回显示时间
 */
//+ (NSString *)getTimeFromCreateDate:(long long)strDate
//{
//    NSString *retStr = NULL_VALUE;
//    if (strDate > 0) {
//        long long
//    }
//}
//
//public static String getTimeFromCreateDate(long strDate) {
//    Log.d(TAG, "strDate == " + strDate);
//    Log.d(TAG,
//          "System.currentTimeMillis() == " + System.currentTimeMillis());
//    String timeStr = "";
//    if (strDate > 0) {
//        long tempTime = System.currentTimeMillis() - strDate;
//        long seconds = tempTime / 1000;
//        timeStr = seconds + "秒之前";
//        if (seconds > 60) {
//            long minute = seconds / 60;
//            timeStr = minute + "分钟之前";
//            if (minute > 60) {
//                long hour = minute / 60;
//                timeStr = hour + "小时之前";
//                if (hour > 24) {
//                    long day = hour / 24;
//                    timeStr = day + "天之前";
//                }
//            }
//        }
//    }
//    return timeStr;
//}

///**
// * 从Date中返回日期
// *
// * @param strFormat
// * @param date
// * @return
// */
//public static String getDateFromDate(String strFormat, Date date) {
//    SimpleDateFormat dateformat = new SimpleDateFormat(strFormat);
//    return dateformat.format(date);
//}
//
//public static String getTimeStr(long interval) {
//    if (interval < 60 * 1000) {
//        String sec = String.valueOf(interval / 1000);
//        if (Integer.parseInt(sec) < 10) {
//            sec = "0" + sec;
//        }
//        return "00:" + "00:" + sec;
//    } else if (interval < 60 * 60 * 1000) {
//        String min = String.valueOf(interval / (60 * 1000));
//        String sec = String.valueOf((interval % (60 * 1000)) / 1000);
//        if (Integer.parseInt(min) < 10) {
//            min = "0" + min;
//        }
//        if (Integer.parseInt(sec) < 10) {
//            sec = "0" + sec;
//        }
//        return "00:" + min + ":" + sec;
//    } else {
//        String hour = String.valueOf(interval / (60 * 60 * 1000));
//        String min = String.valueOf((interval % (60 * 60 * 1000))
//                                    / (60 * 1000));
//        String sec = String
//        .valueOf(((interval % (60 * 60 * 1000)) % (60 * 1000)) / 1000);
//        if (Integer.parseInt(hour) < 10) {
//            hour = "0" + hour;
//        }
//        if (Integer.parseInt(min) < 10) {
//            min = "0" + min;
//        }
//        if (Integer.parseInt(sec) < 10) {
//            sec = "0" + sec;
//        }
//        return hour + ":" + min + ":" + sec;
//    }
//}
//
//public static String getTimeStrMMSS(long interval) {
//    if (interval < 60 * 1000) {
//        String sec = String.valueOf(interval / 1000);
//        if (Integer.parseInt(sec) < 10) {
//            sec = "0" + sec;
//        }
//        return "00:" + sec;
//    } else {
//        String min = String.valueOf(interval / (60 * 1000));
//        String sec = String.valueOf((interval % (60 * 1000)) / 1000);
//        if (Integer.parseInt(min) < 10) {
//            min = "0" + min;
//        }
//        if (Integer.parseInt(sec) < 10) {
//            sec = "0" + sec;
//        }
//        return min + ":" + sec;
//    }
//}
//
//public static String getTimeYYYYMMDD(String time) {
//    String formatTime = time.substring(0, time.indexOf("T"));
//    // SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/DD");
//    // String formatTime = format.format(new Date(time));
//    return formatTime;
//    
//}
//
//public static String getWeek(Context context) {
//    Calendar cal = Calendar.getInstance();
//    cal.setTime(new Date());
//    int index = cal.get(Calendar.DAY_OF_WEEK) - 1;
//    return weekArray[index];
//}
//
///**
// * 返回星期加日期
// *
// * @return
// */
//public static String getWeekDay(int week) {
//    Calendar cd = Calendar.getInstance();
//    // 获得今天是一周的第几天，星期日是第一天，星期二是第二天......
//    int dayOfWeek = cd.get(Calendar.DAY_OF_WEEK);
//    int mondayPlus;
//    if (dayOfWeek == 1) {
//        mondayPlus = -6;
//    } else {
//        mondayPlus = 2 - dayOfWeek;
//    }
//    GregorianCalendar currentDate = new GregorianCalendar();
//    currentDate.add(GregorianCalendar.DATE, mondayPlus + week);
//    Date monday = currentDate.getTime();
//    SimpleDateFormat dateformat = new SimpleDateFormat(SLASH_MMDD);
//    String preMonday = dateformat.format(monday);
//    return weekArray[week + 1] + "\n" + preMonday;
//}
//
//public static String getNowTime() {
//    Time time = new Time();
//    time.setToNow();
//    int hour = time.hour; // 0-23
//    int minute = time.minute;
//    String hourTemp;
//    if (hour > 12) {
//        hour = hour - 12;
//        hourTemp = "PM " + hour;
//    } else {
//        hourTemp = "AM " + hour;
//    }
//    String minuteTemp = "";
//    if (minute < 10) {
//        minuteTemp = "0" + minute;
//    } else {
//        minuteTemp = String.valueOf(minute);
//    }
//    return hourTemp + ":" + minuteTemp;
//}




@end
