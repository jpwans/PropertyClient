//
//  MessageObject.m
//  UnisouthParents
//
//  Created by neo on 14-3-27.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import "MessageObject.h"
//#import "FMDatabase.h"
//#import "FMResultSet.h"
#import "PathService.h"
#import "MessageParse.h"
#import "TimeUtils.h"

@implementation MessageObject
@synthesize messageContent,messageDate,from_me,jid,self_jid,group_msg_from,type,delivery_status,messageType,messageId,parent_child_id;


-(NSString*)getShowMessageInfoByReceiveMessage:( MessageObject*)msg
{
    NSString *messageInfoUser;
    NSString *headMessage;
    NSString *messageInfo;
    
//    ContactDetail *cd = [ShareDelegate.databaseService.contactManager getContactDetailByJid:msg.jid];
     NSString *mContent = msg.messageContent;
    if ([mContent hasPrefix:@"{"]) {
        MessageParse *messageParse = [[MessageParse alloc] initMessageParse:mContent];
        NSDictionary * msgDictionary = [NSDictionary dictionary];
        
        if (messageParse.msg) {
            msgDictionary = (NSDictionary*)messageParse.msg ;
        }
        
        switch (messageParse.msg_type) {
            case kWCMessageTypeText:
            {
                
                if (msg.type == kWCChatTypeChat) {
                    messageInfo = [msgDictionary objectForKey:@"text"  ];
                }else{
                    messageInfo = [NSString stringWithFormat:@"%@%@",   messageInfoUser, [msgDictionary objectForKey:@"text" ]];
                }
                break;
            }
            case kWCMessageTypeImage:
            {
                if (msg.type == kWCChatTypeChat) {
                    messageInfo = @"[图片]";
                }else{
                    messageInfo = [NSString stringWithFormat:@"%@%@",   messageInfoUser, @"[图片]"] ;
                }
                
                break;
            }
            case kWCMessageTypeAudio:
            {
                
                if (msg.type == kWCChatTypeChat) {
                    messageInfo = @"[音频]";
                }else{
                    messageInfo = [NSString stringWithFormat:@"%@%@",   messageInfoUser, @"[音频]"];
                }
                break;
            }
            case kWCMessageTypeVideo:
            {
                if (msg.type == kWCChatTypeChat) {
                    messageInfo = @"[视频]";
                }else{
                    messageInfo = [NSString stringWithFormat:@"%@%@",   messageInfoUser, @"[视频]" ];
                }
                break;
            }
            default:
                break;
        }
        
    }else if( [msg.jid hasPrefix:@"unipolar_homework"] || [msg.jid hasPrefix:@"unipolar_notice"] || [msg.jid hasPrefix:@"unipolar_system"]){
        if ([msg.messageContent hasPrefix:@"<NEWS>_"]) {
            messageInfo = [NSString stringWithFormat:@"%@", [mContent componentsSeparatedByString:@"<NEWS>_"][1]];
        }else if([msg.messageContent hasPrefix:@"<USERCOMPLAIN>_"]){
            messageInfo = [mContent componentsSeparatedByString:@"_"][2];
        }else{
            messageInfo = [NSString stringWithFormat:@"%@", mContent];
        }
    }else if(messageInfo == nil || messageInfo.length == 0){
        messageInfo = [NSString stringWithFormat:@"%@%@",   messageInfoUser,mContent];
    }
    //  UIFont *font = [UIFont fontWithName:@"Arial" size:20.0f];
    return [NSString stringWithFormat:@"%@ : %@",headMessage ,messageInfo];
}

-(BOOL) sendMessageObjectByJid:(NSString*)other_jid byBody:(NSString*)message_body byMessageType:(NSInteger)message_type bySenderJid:(NSString*) senderJid  isSave:(BOOL)is_save
{
//    XMPPManager *xmppMananger = [XMPPManager sharedInstance];
//    BOOL isSuccess = NO;
//    MessageObject *mo = [[MessageObject alloc]init];
//    if ([xmppMananger connect]) {
//        mo.from_me = 1;
//        mo.messageDate  =[TimeUtils getDateFromLongReturnDate:MINUS_YYMMDDHHMMSS strDate:[TimeUtils getCurrentTimeFrom1970]] ;
//        mo.messageType = message_type;
//        mo.delivery_status = 1;
//        if (senderJid!=nil&&senderJid.length!=0) {
//            mo.self_jid = senderJid;
//        }else{
//            mo.self_jid = [[Config Instance]getUserUniqueIdentificationMobile];
//        }
//        mo.jid =  other_jid;
//        mo.messageContent = message_body;
//        mo.type = 0;
//        if (is_save == NO) {
//           [xmppMananger sendMessageNotSave:mo];
//        }else{
//             [xmppMananger sendMessage:mo];
//        }
//        isSuccess = YES;
//    }
    //return isSuccess;
    return YES;
}

@end
