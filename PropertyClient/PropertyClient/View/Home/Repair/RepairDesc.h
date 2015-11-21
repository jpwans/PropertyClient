//
//  RepairDesc.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/6/1.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepairDesc : UIViewController
@property (nonatomic, copy) NSString *repairId;
@property (weak, nonatomic) IBOutlet UILabel *repairTitle;
@property (weak, nonatomic) IBOutlet UILabel *repairTime;
@property (weak, nonatomic) IBOutlet UILabel *repairDesc;
@property (weak, nonatomic) IBOutlet UITableView *progressTableView;

@property (weak, nonatomic) IBOutlet UIView *headView;

@end
