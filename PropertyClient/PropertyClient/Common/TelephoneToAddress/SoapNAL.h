//
//  SoapNAL.h
//  UnisouthParents
//
//  Created by neo on 14-3-28.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SoapNALBlock) (NSMutableString *parserXML);
@interface SoapNAL : NSObject<NSXMLParserDelegate>{
    NSXMLParser *xmlParser;
    BOOL elementFound;
}
@property(nonatomic,strong)SoapNALBlock soapBlock;
@property(nonatomic,strong)NSMutableString *soapResults;
+(SoapNAL *)shareInstance;
-(void)parserSoapXML:(NSMutableData *)soapData withParserBlock:(SoapNALBlock)block;
@end
