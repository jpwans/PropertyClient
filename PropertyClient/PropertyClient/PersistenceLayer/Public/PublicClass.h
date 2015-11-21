//
//  PublicClass.h
//  WuYeO2O
//
//  Created by MoPellet on 15/5/14.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicClass : NSObject
{
    UIView *animationView;
    UILabel *lable;
    UIImageView *mainImageView;
}
+ (PublicClass*)sharedManager;


/**
 *获取token
 */
-(void) getTokenWithCompletionHandler: (void (^)(NSDictionary *getDictionary,NSError *error))block;
/**
 *更新的版本
 */
-(void)getNewVersionWithCompletionHandler: (void (^)(NSDictionary *dictionary,NSError *error))block;
/**
 *  获取当前时间
 */
-(NSString *)getNowTimeWithFormat:(NSString *)format;
/**
 *  对象转JSON
 */
-(NSString*)DataTOjsonString:(id)object;
/**
 *这个时间与当前时间
 */
+(NSString *) compareCurrentTime:(NSDate*) compareDate;
/**
 *照片缩小
 */
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
@end
