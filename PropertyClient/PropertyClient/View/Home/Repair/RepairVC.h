//
//  RepairVC.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/28.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepairVC : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *segRepair;
- (IBAction)chooseSeg:(UISegmentedControl *)sender;

@property (weak, nonatomic) IBOutlet UITableView *repairTableView;

@end
