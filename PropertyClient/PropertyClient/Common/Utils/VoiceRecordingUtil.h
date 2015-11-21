//
//  VoiceRecordingUtil.h
//  UnisouthParents
//
//  Created by neo on 14-5-28.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VoiceRecordingUtil : NSObject

@property(nonatomic,retain) NSString * recordPath;
@property(nonatomic) float recordTime;

-(void) startRecordWithPath:(NSString *)path;
-(void) stopRecordWithCompletionBlock:(void (^)())completion;
-(void) cancelled;

@end
