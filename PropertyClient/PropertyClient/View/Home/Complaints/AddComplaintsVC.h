//
//  AddComplaintsVC.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/20.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceholderTextView.h"
@interface AddComplaintsVC : UIViewController
{
    NSMutableArray *addedPicArray;
}
@property (weak, nonatomic) IBOutlet UITextField *comTitle;
@property (weak, nonatomic) IBOutlet UIPlaceholderTextView *comDescribe;
@property (retain, nonatomic) IBOutlet UIScrollView *picScroller;
@property (retain, nonatomic) IBOutlet UIButton *plusButton;
- (IBAction)clearPics:(id)sender;
- (IBAction)addPic:(id)sender;

- (IBAction)submit:(id)sender;

@end
