//
//  ComplaintsDescVC.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/21.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComplaintsDescVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *comTitle;
@property (weak, nonatomic) IBOutlet UILabel *comTtime;
@property (weak, nonatomic) IBOutlet UILabel *comName;
@property (weak, nonatomic) IBOutlet UIButton *comPhone;
//- (IBAction)comPhone:(id)sender;


@property (nonatomic, copy) NSString *compId;

@property (weak, nonatomic) IBOutlet UIView *picView;
@property (weak, nonatomic) IBOutlet UITextView *descTextView;

@property (weak, nonatomic) IBOutlet UIButton *callPhoneBtn;
- (IBAction)callPhone:(id)sender;

@end
