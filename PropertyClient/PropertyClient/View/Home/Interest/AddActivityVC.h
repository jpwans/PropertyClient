//
//  AddActivityVC.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/21.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceholderTextView.h"
@interface AddActivityVC : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSMutableArray *addedPicArray;
}
@property (weak, nonatomic) IBOutlet UITextField *activityTitle;
@property (weak, nonatomic) IBOutlet UITextField *startTime;
@property (weak, nonatomic) IBOutlet UITextField *endTime;
@property (weak, nonatomic) IBOutlet UITextField *place;
@property (weak, nonatomic) IBOutlet UIPlaceholderTextView *desc;

@property (retain, nonatomic) IBOutlet UIScrollView *picScroller;
@property (retain, nonatomic) IBOutlet UIButton *plusButton;
- (IBAction)addPic:(id)sender;

- (IBAction)submitAction:(id)sender;

@end
