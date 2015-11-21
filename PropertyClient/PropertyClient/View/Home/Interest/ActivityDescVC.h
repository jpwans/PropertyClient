//
//  ActivityDescVC.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/21.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"
@interface ActivityDescVC : UIViewController

@property (nonatomic, strong) Activity *activity;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *activitytitle;
@property (weak, nonatomic) IBOutlet UILabel *publishtime;
@property (weak, nonatomic) IBOutlet UILabel *activityTime;
@property (weak, nonatomic) IBOutlet UILabel *countdown;
@property (weak, nonatomic) IBOutlet UILabel *starttime;
@property (weak, nonatomic) IBOutlet UILabel *endtime;

@property (weak, nonatomic) IBOutlet UILabel *place;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
- (IBAction)sendAction:(id)sender;

- (IBAction)replyAction:(id)sender;
//@property (weak, nonatomic) IBOutlet UIButton *activeBtn;
//- (IBAction)activeAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *picView;



@end
