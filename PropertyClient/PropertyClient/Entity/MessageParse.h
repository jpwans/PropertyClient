//
//  MessageAnalysis.h
//  UnisouthParents
//
//  Created by neo on 14-5-6.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageFileParse.h"

@interface MessageParse : NSObject

@property(nonatomic,assign) int msg_type;
@property(nonatomic,strong) NSString *time;
@property(nonatomic,strong) NSString *msg;
@property(nonatomic,strong) NSString *file;
@property(nonatomic,strong) NSString *child_id;



-(MessageParse*)initMessageParse:(NSString*) messageString;

-(NSString*)getMessageForText:(MessageParse*)messageParse;

-(MessageFileParse*)getMessageForFile:(MessageParse*)messageParse;

-(NSString*)getTextMessageForMsgtype:(int)msg_type stringByMsg:(NSString*) msgText stringByFile:(NSString*) fileText;

-(NSString*)getFileTextForUrl:(NSString*)url fileName:(NSString*)name fileLength:(NSString*)length;

@end
