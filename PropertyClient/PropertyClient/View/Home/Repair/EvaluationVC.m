//
//  EvaluationVC.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/6/12.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "EvaluationVC.h"

@interface EvaluationVC ()

@end

@implementation EvaluationVC


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSArray * picArray = [_repairInfo.photo componentsSeparatedByString:@"&#"];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_QINIU,picArray[0]]] placeholderImage:[UIImage imageNamed:@"aio_image_default"]];
    _repairTitle.text = _repairInfo.title;
    _doorTime.text = [NSString stringWithFormat:@"上门时间：%@至%@",    [_repairInfo.hopeStart substringToIndex:16],    [_repairInfo.hopeEnd substringToIndex:16]];
    _content.placeholder=@"写点评价吧，对大家帮助很大哦";
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)published:(id)sender{
    if (!_content.text.length) {
        [self.view makeToast:@"您还没有写任何评价哦" duration:1.5f position:@"center"];
        return;
    }
    AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:_repairInfo.repairId,@"repairId",_content.text,@"content",nil];
    [manager POST:API_BASE_URL_STRING(URL_ADDREPAIRCOMMENT) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary= responseObject;
        NSLog(@"%@",dictionary);
        NSLog(@"%@",dictionary[Y_Message]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];

}

@end
