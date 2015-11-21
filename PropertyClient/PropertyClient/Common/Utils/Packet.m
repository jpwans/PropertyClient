//
//  Packet.m
//  UnisouthParents
//
//  Created by neo on 14-5-6.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import "Packet.h"




@implementation Packet



- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(NSString*)getPacketID{
    
    
    return nil;
}

-(NSString*)randomString
{
    char numbersAndLetters[72];
    NSString *numbersAndLettersString= @"0123456789abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    strcpy(numbersAndLetters,(char *)[numbersAndLettersString UTF8String]);

    char randBuffer[5] ;
    for (int i=0; i<5; i++) {
        int value = arc4random() % (71+1);
        randBuffer[i] = numbersAndLetters[value];
    }
    return [NSString stringWithUTF8String:numbersAndLetters];
}

@end
