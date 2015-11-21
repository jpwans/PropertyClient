//
//  UIPlaceholderTextView.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/20.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPlaceholderTextView : UITextView
@property(nonatomic, strong) NSString *placeholder;     //占位符

-(void)addObserver;//添加通知
-(void)removeobserver;//移除通知
@end
