//
//  MailVC.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/28.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "MailVC.h"
#import "CoreDateManager.h"
#import "MessageDB.h"
#import "MessageCell.h"
#import "MsgInfoTableView.h"
#import "MessageDB.h"
#import "RepairVC.h"
@interface MailVC ()<UITableViewDataSource,UITableViewDelegate>
{
    CoreDateManager *coreManager;
}

@property (nonatomic, strong) NSMutableArray *arrays;
@end

@implementation MailVC


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.3 animations:^{
//        self.navigationController.navigationBar.alpha = 1;
            self.navigationController.navigationBar.translucent = NO;
    }];
    self.navigationController.view.backgroundColor = BACKGROUND_COLOR;
    [self getArrays];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    coreManager = [[CoreDateManager alloc] init];
    NSLog(@"%lu",(unsigned long)_arrays.count);
    self.tableView.rowHeight = 60;
    self.view.backgroundColor = ALLBACKCOLOR;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newMsgCome:) name:Notif_XMPP_NewMsg object:nil];
}

-(void)newMsgCome:(NSNotification *)notifacation
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        _arrays = [[NSMutableArray alloc] init];
        _arrays=[coreManager msgGroupByType];
        dispatch_async(dispatch_get_main_queue(),^{
            [self.tableView reloadData];
        });
    });
}



-(void)getArrays{
    _arrays = [[NSMutableArray alloc] init];
    //      _arrays= [coreManager selectData:0 andOffset:0];
    
    _arrays=[coreManager msgGroupByType];
    //    dispatch_async(dispatch_get_main_queue(), ^{
    [self.tableView reloadData];
    //    });
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrays.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    MessageDB *messageDB = self.arrays[indexPath.row];
    // 1.创建cell
    MessageCell *cell = [MessageCell cellWithTableView:tableView];
    // 2.设置数据
    [cell settingData:messageDB];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageCell *cell = (MessageCell*) [tableView cellForRowAtIndexPath:indexPath];
    cell.isReadImage.image=nil;
    
    MessageDB *messageDB =self.arrays[indexPath.row];
    [coreManager updateMessageByAdviceId:messageDB.adviceId];
    MsgInfoTableView *msgInfoTableView = [self.storyboard instantiateViewControllerWithIdentifier:@"MsgInfoTableView"];
    msgInfoTableView.adviceType = messageDB.type;
    int type= [messageDB.type intValue];
    NSString *typeTitle = @"小区提醒";
    RepairVC *repairVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RepairVC"];
    switch (type) {
        case 0:
            
            typeTitle = @"小区通知";
            msgInfoTableView.title =typeTitle;
            [self.navigationController pushViewController:msgInfoTableView animated:YES];
            break;
        case 1:
            
            typeTitle = @"紧急通知";
            msgInfoTableView.title =typeTitle;
            [self.navigationController pushViewController:msgInfoTableView animated:YES];
            break;
        case 2:
            typeTitle = @"报修通知";
            
            [self.navigationController pushViewController:repairVC animated:YES];
            
            break;
        case 3:
            typeTitle = @"物业费通知";
            break;
        default:
            
            typeTitle = @"小区提醒";
            break;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"点击了删除");
        MessageDB *messageDB = _arrays[indexPath.row];
        [coreManager deleteByType:messageDB.type];
        [self.arrays removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section
{
    return 8.0 ;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Notif_XMPP_NewMsg object:nil];
}

@end
