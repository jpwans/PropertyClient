//
//  FeedBackVC.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/7/6.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "FeedBackVC.h"

@interface FeedBackVC ()<UIAlertViewDelegate>

@end

@implementation FeedBackVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _textView.placeholder = @"您的反馈我们会将尽快给您答复。";
    [self createBtn];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/**
 *  创建提交按钮
 */
-(void)createBtn{
    UIBarButtonItem *  rightButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(submit)];
    self.navigationItem.rightBarButtonItem = rightButton;
}
-(void)submit{
    if([_textView.text trimString].length){
        AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:_textView.text,@"comment",nil];
        
        [manager POST:API_BASE_URL_STRING(URL_FEEDBACK) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dictionary= responseObject;
            if ([dictionary[Y_Code] intValue]==Y_Code_Success) {
                UIAlertView *alertView =[ [UIAlertView alloc] initWithTitle:@"提示" message:@"您的意见我们已收到，我们将尽快为您处理，感谢您的支持。" delegate:self cancelButtonTitle:@"继续吐槽" otherButtonTitles:@"下次再吐", nil];
                [alertView show];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",[error localizedDescription]);
        }];
    }
    else{
        [self.view makeToast:@"客官，还没有填写反馈信息哟。" duration:1.5f position:@"center"];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{

    if (buttonIndex==0) {
        _textView.text = @"";
    }
    else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
@end
