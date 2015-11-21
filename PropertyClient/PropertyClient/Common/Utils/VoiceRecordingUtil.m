//
//  VoiceRecordingUtil.m
//  UnisouthParents
//
//  Created by neo on 14-5-28.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import "VoiceRecordingUtil.h"
#import <AVFoundation/AVFoundation.h>
//#import "JSVoiceViewController.h"

#define WAVE_UPDATE_FREQUENCY   0.05

@interface VoiceRecordingUtil() <AVAudioRecorderDelegate>
{
    NSTimer * timer_;
    
   // LCVoiceHud * voiceHud_;
}
@property(nonatomic,retain) AVAudioRecorder * recorder;
@end

@implementation VoiceRecordingUtil



-(void) dealloc{
    
    if (self.recorder.isRecording) {
        [self.recorder stop];
    }
    
    self.recorder = nil;
    self.recordPath = nil;
    
}

#pragma mark - Publick Function

-(void)startRecordWithPath:(NSString *)path
{
    NSError * err = nil;
    
	AVAudioSession *audioSession = [AVAudioSession sharedInstance];
	[audioSession setCategory :AVAudioSessionCategoryPlayAndRecord error:&err];
    
	if(err){
        NSLog(@"audioSession: %@ %ld %@", [err domain], (long)[err code], [[err userInfo] description]);
        return;
	}
    
	[audioSession setActive:YES error:&err];
    
	err = nil;
	if(err){
        NSLog(@"audioSession: %@ %ld %@", [err domain], (long)[err code], [[err userInfo] description]);
        return;
	}
	
	
	//录音设置
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init];
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:44100] forKey:AVSampleRateKey];
    //录音通道数  1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    
    // NSString *strUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    /*
     [recordSetting setValue :[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
     [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
     [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
     */
    
	self.recordPath = path;
	NSURL * url = [NSURL fileURLWithPath:self.recordPath];
	
	err = nil;
	
	NSData * audioData = [NSData dataWithContentsOfFile:[url path] options: 0 error:&err];
    
	if(audioData)
	{
		NSFileManager *fm = [NSFileManager defaultManager];
		[fm removeItemAtPath:[url path] error:&err];
	}
	
	err = nil;
    
    if(self.recorder){[self.recorder stop];self.recorder = nil;}
    
	self.recorder = [[AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:&err];
    
	if(!_recorder){
        NSLog(@"recorder: %@ %ld %@", [err domain], (long)[err code], [[err userInfo] description]);
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle: @"Warning"
								   message: [err localizedDescription]
								  delegate: nil
						 cancelButtonTitle:@"OK"
						 otherButtonTitles:nil];
        [alert show];
        return;
	}
	//开启音量检测
	[_recorder setDelegate:self];
	_recorder.meteringEnabled = YES;
   
    //创建录音文件，准备录音
    if ([_recorder prepareToRecord]) {
        //开始
        [_recorder record];
    }
	
	BOOL audioHWAvailable = audioSession.inputAvailable;
	if (! audioHWAvailable) {
        UIAlertView *cantRecordAlert =
        [[UIAlertView alloc] initWithTitle: @"Warning"
								   message: @"Audio input hardware not available"
								  delegate: nil
						 cancelButtonTitle:@"OK"
						 otherButtonTitles:nil];
        [cantRecordAlert show];
        return;
	}
	
	[_recorder recordForDuration:(NSTimeInterval) 60];
    
   
    self.recordTime = 0;
    [self resetTimer];
    
	timer_ = [NSTimer scheduledTimerWithTimeInterval:WAVE_UPDATE_FREQUENCY target:self selector:@selector(detectionVoice) userInfo:nil repeats:YES];
//    
 //   [self showVoiceHudOrHide:YES];
    
}

-(void) stopRecordWithCompletionBlock:(void (^)())completion
{
    dispatch_async(dispatch_get_main_queue(),completion);
    
    [self resetTimer];
  //  [self showVoiceHudOrHide:NO];
}

#pragma mark - Timer Update

- (void)detectionVoice {
//    
//    
//    if (_recorder) {
//       [_recorder updateMeters];//刷新音量数据
//    }
//
//    
//    double lowPassResults = pow(10, (0.05 * [_recorder peakPowerForChannel:0]));
//    NSLog(@"%lf",lowPassResults);
//    
//    self.recordTime += WAVE_UPDATE_FREQUENCY;
//    
//   // JSVoiceViewController *jsVoiceVievController = [JSVoiceViewController Instance];
//    
//    //图片 小-》大
//    if (0<lowPassResults<=0.10) {
//        UIImageView *soundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 100, 50, 8)];
//        soundImageView.image = [UIImage imageNamed:@"amp1.png"];
//        [jsVoiceVievController soundImageViewBySwitch:soundImageView];
//    } if (0.1<lowPassResults<=0.20) {
//        UIImageView *soundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 100, 50, 8)];
//        soundImageView.image = [UIImage imageNamed:@"amp1.png"];
//        [jsVoiceVievController soundImageViewBySwitch:soundImageView];
//    }else if (0.20<lowPassResults<=0.30) {
//        UIImageView *soundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 90, 50, 18)];
//        soundImageView.image = [UIImage imageNamed:@"amp2.png"];
//        [jsVoiceVievController soundImageViewBySwitch:soundImageView];
//    }else if (0.3<lowPassResults<=0.4) {
//        UIImageView *soundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 80, 50, 30)];
//        soundImageView.image = [UIImage imageNamed:@"amp3.png"];
//        [jsVoiceVievController soundImageViewBySwitch:soundImageView];
//    }else if (0.4<lowPassResults<=0.5) {
//        UIImageView *soundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 70, 50, 40)];
//        soundImageView.image = [UIImage imageNamed:@"amp4.png"];
//        [jsVoiceVievController soundImageViewBySwitch:soundImageView];
//    }else if (0.5<lowPassResults<=0.6) {
//        UIImageView *soundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 60, 50, 50)];
//        soundImageView.image = [UIImage imageNamed:@"amp5.png"];
//        [jsVoiceVievController soundImageViewBySwitch:soundImageView];
//    }else if (0.6<lowPassResults<=0.7) {
//        UIImageView *soundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 50, 50, 60)];
//        soundImageView.image = [UIImage imageNamed:@"amp6.png"];
//        [jsVoiceVievController soundImageViewBySwitch:soundImageView];
//    }else if (0.7<lowPassResults<=0.9) {
//        UIImageView *soundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 40, 50, 70)];
//        soundImageView.image = [UIImage imageNamed:@"amp7.png"];
//        [jsVoiceVievController soundImageViewBySwitch:soundImageView];
//    }else {
//        UIImageView *soundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 30, 50, 80)];
//        soundImageView.image = [UIImage imageNamed:@"amp7.png"];
//        [jsVoiceVievController soundImageViewBySwitch:soundImageView];
//    }
//    
//    
//    
////    if (voiceHud_)
////    {
////        /*  发送updateMeters消息来刷新平均和峰值功率。
////         *  此计数是以对数刻度计量的，-160表示完全安静，
////         *  0表示最大输入值
////         */
////        
////        if (_recorder) {
////            [_recorder updateMeters];
////        }
////        
////        float peakPower = [_recorder averagePowerForChannel:0];
////        double ALPHA = 0.05;
////        double peakPowerForChannel = pow(10, (ALPHA * peakPower));
////        
////        [voiceHud_ setProgress:peakPowerForChannel];
////    }
//}
//
//#pragma mark - Helper Function
//
//-(void) showVoiceHudOrHide:(BOOL)yesOrNo{
//    
//    if (voiceHud_) {
//        [voiceHud_ hide];
//        voiceHud_ = nil;
//    }
//    
//    if (yesOrNo) {
//        
//        voiceHud_ = [[LCVoiceHud alloc] init];
//        [voiceHud_ show];
//        [voiceHud_ release];
//        
//    }else{
//        
//    }
}

-(void) resetTimer
{
    if (timer_) {
        [timer_ invalidate];
        timer_ = nil;
    }
}

-(void) cancelRecording
{
    if (self.recorder.isRecording) {
        [self.recorder stop];
    }
    
    self.recorder = nil;
}

- (void)cancelled {
    
  //  [self showVoiceHudOrHide:NO];
    [self resetTimer];
    [self cancelRecording];
}





@end
