//
//  EvaluationVC.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/6/12.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepairInfo.h"
#import "UIPlaceholderTextView.h"
@interface EvaluationVC : UIViewController
@property (nonatomic, strong) RepairInfo *repairInfo;

- (IBAction)published:(id)sender;
@property (weak, nonatomic) IBOutlet UIPlaceholderTextView *content;
@property (weak, nonatomic) IBOutlet UISegmentedControl *goodOrBad;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *repairTitle;
@property (weak, nonatomic) IBOutlet UILabel *doorTime;

@end
