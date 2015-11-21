//
//  MessageObject.h
//  UnisouthParents
//
//  Created by neo on 14-3-27.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import <Foundation/Foundation.h>





//0.text,1.Image,2.audio,3.video
enum kWCMessageType {
    kWCMessageTypeText = 0,
    kWCMessageTypeImage = 1,
    kWCMessageTypeAudio =2,
    kWCMessageTypeVideo=3
};

//是否阅读 0-未  1-已读
enum kWCMessageDeliveryStatus{
    kWCMessageDeliveryStatusNotRead = 0,
    kWCMessageDeliveryStatusRead = 1
};

//0.chat 1.groupchat
enum kWCChatType{
    kWCChatTypeChat = 0,
    kWCChatTypeGroupchat = 1
};

// 0-—别人发；1—我发
enum kWCMessageFromMeType{
    kWCMessageFromMeTypeOther = 0,
    kWCMessageFromMeTypeMe = 1
};

enum kWCMessageCellStyle {
    kWCMessageCellStyleMe = 0,
    kWCMessageCellStyleOther = 1,
    kWCMessageCellStyleMeWithImage=2,
    kWCMessageCellStyleOtherWithImage=3
};




@interface MessageObject : NSObject

@property (nonatomic,assign) NSInteger messageId;
@property (nonatomic,assign) NSInteger from_me;  // 0-—别人发；1—我发  --no  过来的信息怎么知道--都未别人所发
@property (nonatomic,retain) NSString *messageContent;
@property (nonatomic,retain) NSDate *messageDate;
@property (nonatomic,assign) NSInteger messageType;  //0.text,1.Image,2.audio,3.video
@property (nonatomic,retain) NSString *jid;      //别人的jid
@property (nonatomic,retain) NSString *self_jid;
@property (nonatomic,retain) NSString *group_msg_from;     //群聊直接截取后面的jid:room@conf.hcios.com/jid
@property (nonatomic,assign) NSInteger type;     //0.chat 1.groupchat
@property (nonatomic,assign) NSInteger delivery_status; //是否阅读 0-未  1-已读
@property(nonatomic,strong) NSString *parent_child_id;



-(NSString*)getShowMessageInfoByReceiveMessage:( MessageObject*)msg;

-(BOOL) sendMessageObjectByJid:(NSString*)other_jid byBody:(NSString*)message_body byMessageType:(NSInteger)message_type bySenderJid:(NSString*) senderJid  isSave:(BOOL)is_save;

@end
