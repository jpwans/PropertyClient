//
//  AudioPlayerManager.m
//  UnisouthParents
//
//  Created by neo on 14-6-13.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import "AudioPlayerManager.h"
#import "SampleQueueId.h"


@interface AudioPlayerManager()


@property(nonatomic,assign) int runningCount;

-(void) updateControls;
@end



@implementation AudioPlayerManager
@synthesize audioPlayer, delegate ,runningCount;



static AudioPlayerManager *sharedManager;

+(AudioPlayerManager*)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager=[[AudioPlayerManager alloc]init];
    });
    return sharedManager;
}

/**
 *  在一个视图控制器中，只定义一个播放器，在播放时，去调用setupTime，开始记录进度
 *
 *  @return return value description
 */

-(id)init
{
    self = [super init];
    if (self) {
        self.audioPlayer = [[STKAudioPlayer alloc] initWithOptions:(STKAudioPlayerOptions){ .flushQueueOnSeek = YES, .enableVolumeMixer = NO, .equalizerBandFrequencies = {50, 100, 200, 400, 800, 1600, 2600, 16000} }];
        self.audioPlayer.meteringEnabled = YES;
        self.audioPlayer.volume = 1;
    }
    return self;
}

-(void) playFromHTTPTouched:(NSString*)audioUrl{
    [self updateControls];
    NSURL* url = [NSURL URLWithString:audioUrl];
    STKDataSource* dataSource = [STKAudioPlayer dataSourceFromURL:url];
	[audioPlayer setDataSource:dataSource withQueueItemId:[[SampleQueueId alloc] initWithUrl:url andCount:0]];
}

-(void) playFromLocalFileTouched:(NSString*)audioUrl{
    [self updateControls];
    NSURL* url = [NSURL fileURLWithPath:audioUrl];
    STKDataSource* dataSource = [STKAudioPlayer dataSourceFromURL:url];
	[audioPlayer setDataSource:dataSource withQueueItemId:[[SampleQueueId alloc] initWithUrl:url andCount:0]];
}


-(void) playButtonPressed
{
	if (!audioPlayer)
	{
		return;
	}
    
	if (audioPlayer.state == STKAudioPlayerStatePaused)
	{
		[audioPlayer resume];
	}
	else
	{
		[audioPlayer pause];
	}
}

-(void) stop
{
    [audioPlayer stop];
    // [audioPlayer dispose];
    [self updateControls];
    // [audioPlayer clearQueue];
}

-(void) updateControls
{
    //  NSLog(@"clickMessageAudio==%u",audioPlayer.state);
	if (audioPlayer == nil)
	{
        //	[playButton setTitle:@"" forState:UIControlStateNormal];
	}
    else if(audioPlayer.state == STKAudioPlayerStateRunning)
    {
        //  NSLog(@"STKAudioPlayerStateRunning");
    }
    else if(audioPlayer.state == STKAudioPlayerStateBuffering)
    {
        //  NSLog(@"STKAudioPlayerStateBuffering");
    }
	else if (audioPlayer.state == STKAudioPlayerStatePaused)
	{
        //	[playButton setTitle:@"Resume" forState:UIControlStateNormal];
	}
	else if (audioPlayer.state & STKAudioPlayerStatePlaying)
	{
        //  NSLog(@"STKAudioPlayerStatePlaying");
        [self.delegate beginPlayingAudio:self];
        
	}
    else if (audioPlayer.state == STKAudioPlayerStateDisposed)
    {
        //  NSLog(@"STKAudioPlayerStateDisposed");
    }
    else if (audioPlayer.state == STKAudioPlayerStateError)
    {
        //  NSLog(@"STKAudioPlayerStateError");
    }
    else if (audioPlayer.state == STKAudioPlayerStateStopped)
    {
        // NSLog(@"STKAudioPlayerStateStopped");
        [self.delegate stopPlayAudio:self];
    }
	else
	{
        //	[playButton setTitle:@"" forState:UIControlStateNormal];
	}
}

-(void) setAudioPlayer:(STKAudioPlayer*)value
{
	if (audioPlayer)
	{
		audioPlayer.delegate = nil;
	}
    
	audioPlayer = value;
	audioPlayer.delegate = self;
	
	[self updateControls];
}

-(STKAudioPlayer*) audioPlayer
{
	return audioPlayer;
}

-(void) audioPlayer:(STKAudioPlayer*)audioPlayer stateChanged:(STKAudioPlayerState)state previousState:(STKAudioPlayerState)previousState
{
	[self updateControls];
}

-(void) audioPlayer:(STKAudioPlayer*)audioPlayer unexpectedError:(STKAudioPlayerErrorCode)errorCode
{
	[self updateControls];
}

-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didStartPlayingQueueItemId:(NSObject*)queueItemId
{
	SampleQueueId* queueId = (SampleQueueId*)queueItemId;
    
    NSLog(@"Started: %@", [queueId.url description]);
    
	[self updateControls];
}

-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didFinishBufferingSourceWithQueueItemId:(NSObject*)queueItemId
{
	[self updateControls];
    
    // This queues on the currently playing track to be buffered and played immediately after (gapless)
    
    //    if (repeatSwitch.on)
    //    {
    //        SampleQueueId* queueId = (SampleQueueId*)queueItemId;
    //
    //        NSLog(@"Requeuing: %@", [queueId.url description]);
    //
    //        [self->audioPlayer queueDataSource:[STKAudioPlayer dataSourceFromURL:queueId.url] withQueueItemId:[[SampleQueueId alloc] initWithUrl:queueId.url andCount:queueId.count + 1]];
    //    }
}

-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didFinishPlayingQueueItemId:(NSObject*)queueItemId withReason:(STKAudioPlayerStopReason)stopReason andProgress:(double)progress andDuration:(double)duration
{
	[self updateControls];
    
    SampleQueueId* queueId = (SampleQueueId*)queueItemId;
    
    NSLog(@"Finished: %@", [queueId.url description]);
}

-(void) audioPlayer:(STKAudioPlayer *)audioPlayer logInfo:(NSString *)line
{
    NSLog(@"%@", line);
}
-(void)dealloc
{
    //    [timer invalidate];
    //    timer = nil;
}

@end
