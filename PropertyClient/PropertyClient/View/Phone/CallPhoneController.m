//
//  CallPhoneController.m
//  WuYeO2O
//
//  Created by MoPellet on 15/5/11.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "CallPhoneController.h"

@interface CallPhoneController ()
{
    NSString *phoneNun;
}
- (IBAction)callPhone:(id)sender;

@end

@implementation CallPhoneController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.view.backgroundColor = RGBCOLOR(230, 230, 230);
    self.view.backgroundColor = [UIColor whiteColor];
    [[PublicNetWork network] aboutWithCompletionHandler:^(NSDictionary *dictionary, NSError *error) {
        if (!error) {
            if ([dictionary[Y_Code] intValue]==Y_Code_Success) {
                            phoneNun = dictionary[Y_Data][@"phone"];
                        }
        }else {
            NSLog(@"%@",    [error localizedDescription]);
        }
    }];
}



- (IBAction)callPhone:(id)sender {

    if (phoneNun.length>0) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phoneNun];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    else{
        [self.view makeToast:@"该小区还未设置电话，敬请期待" duration:1.5f position:@"center"];
    }
 

}
@end
