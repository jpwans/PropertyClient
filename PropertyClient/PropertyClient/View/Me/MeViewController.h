//
//  MeViewController.h
//  WuYeO2O
//
//  Created by MoPellet on 15/5/13.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@end
