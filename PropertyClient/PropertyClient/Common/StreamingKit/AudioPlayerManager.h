//
//  AudioPlayerManager.h
//  UnisouthParents
//
//  Created by neo on 14-6-13.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STKAudioPlayer.h"


@class AudioPlayerManager;
@protocol AudioPlayerManagerDelegate <NSObject>

@optional
//网络请求阶段
-(void) audioFileFromHTTP:(AudioPlayerManager*)audioPlayerManager;

//开始播放
-(void) beginPlayingAudio:(AudioPlayerManager*)audioPlayerManager;

//结束播放
-(void) stopPlayAudio:(AudioPlayerManager*)audioPlayerManager;



@end


@interface AudioPlayerManager : NSObject<STKAudioPlayerDelegate>
{
@private
	NSTimer* timer;
    
}

@property (readwrite, retain) STKAudioPlayer* audioPlayer;

@property (nonatomic, weak) id<AudioPlayerManagerDelegate> delegate;


+(AudioPlayerManager*)sharedInstance;
-(void) playFromHTTPTouched:(NSString*)audioUrl;
-(void) playFromLocalFileTouched:(NSString*)audioUrl;
-(void) stop;

@end




