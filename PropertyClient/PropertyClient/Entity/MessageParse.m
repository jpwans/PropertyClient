//
//  MessageAnalysis.m
//  UnisouthParents
//
//  Created by neo on 14-5-6.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import "MessageParse.h"


@implementation MessageParse
@synthesize msg_type,time,msg,file,child_id;




-(MessageParse*)initMessageParse:(NSString*) messageString
{
    MessageParse *messageParse ;
    if (self = [super init]) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[   messageString dataUsingEncoding:NSUTF8StringEncoding]  options:NSJSONReadingMutableContainers error:nil];
        BOOL isJson =   [NSJSONSerialization isValidJSONObject:dictionary];
        if(isJson){
            messageParse = [MessageParse objectWithKeyValues:dictionary];
        }else
            return nil;
    }
    return messageParse;
}


-(NSString*)getMessageForText:(MessageParse*)messageParse
{
    NSDictionary * msgDictionary = nil;
   
    if (messageParse.msg) {
        msgDictionary = (NSDictionary*)messageParse.msg ;
    }else
        return nil;
    return  [msgDictionary objectForKey:@"text" ];
}


-(MessageFileParse*)getMessageForFile:(MessageParse*)messageParse
{
   NSDictionary * fileDictionary = nil;
    if (messageParse.file) {
         fileDictionary =  (NSDictionary*)messageParse.file ;
    }else
        return nil;
   MessageFileParse *messageFileParse = [MessageFileParse objectWithKeyValues:fileDictionary];
   return messageFileParse;
}


#pragma mark 组装协议

-(NSString*)getTextMessageForMsgtype:(int)msg_typet stringByMsg:(NSString*) msgText stringByFile:(NSString*) fileText
{
    NSTimeInterval currentTime=[[NSDate date] timeIntervalSince1970]*1000;
    //double i=currentTime;      //NSTimeInterval返回的是double类型
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",msg_typet] ,@"msg_type",[NSNumber numberWithDouble:currentTime] ,@"time",msgText,@"msg" ,fileText,@"file",nil];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted  error:nil];
    NSString *jsonString ;
    if (jsonData) {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

-(NSString*)getFileTextForUrl:(NSString*)url fileName:(NSString*)name fileLength:(NSString*)length
{
   NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:url,@"url",name,@"name",length,@"length" ,nil];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted  error:nil];
    NSString *jsonString ;
    if (jsonData) {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}



@end
