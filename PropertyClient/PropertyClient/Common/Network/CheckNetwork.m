//
//  CheckNetwork.m
//  UnisouthParents
//
//  Created by neo on 14-3-26.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import "CheckNetwork.h"
#import "Reachability.h"

@interface CheckNetwork()
{
  UIAlertView *alertView;
}
@end


@implementation CheckNetwork

static CheckNetwork *sharedManager = nil;

+ (CheckNetwork *)sharedManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[super alloc] init];
    });
    return sharedManager;
}

-(BOOL)isExistenceNetwork
{
    //	BOOL isExistenceNetwork;
    //	Reachability *r = [Reachability reachabilityWithHostName:@"www.oschina.net"];
    //    switch ([r currentReachabilityStatus]) {
    //        case NotReachable:
    //			isExistenceNetwork=FALSE;
    //
    //            break;
    //        case ReachableViaWWAN:
    //			isExistenceNetwork=TRUE;
    //
    //            break;
    //        case ReachableViaWiFi:
    //			isExistenceNetwork=TRUE;
    //
    //            break;
    //    }
    //	return isExistenceNetwork;
    
    return YES;
}


-(void)notReachableAlertView
{
    alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络异常，请检查您的网络设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    BOOL isExistAlertView = YES;
    for (UIView *aview in [ShareDelegate.window subviews]) {
        if (aview.tag == 1111) {
            alertView = nil;
            isExistAlertView = NO;
        }
    }
    
    if (isExistAlertView) {
        [alertView show];
        alertView.tag = 1111;
        alertView = nil;
    }
}

- (void)alertView:(UIAlertView *)alertViewr clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            alertView.tag = 0;
            break;
            
        default:
            break;
    }
}

@end
