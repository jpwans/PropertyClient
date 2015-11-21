//
//  ActivityTableVC.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/21.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "ActivityTableVC.h"
#import "ActivityTableViewCell.h"
#import "ActivityDescVC.h"
@interface ActivityTableVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger pageNo;
    NSInteger pageSize;
    NSMutableArray *moreArrays;
  }
@property (nonatomic, strong) NSMutableArray *arrays;

@end

@implementation ActivityTableVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.view.backgroundColor = BACKGROUND_COLOR;
    pageNo = 0;
    pageSize = 5;
    [self getArrays];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    moreArrays = [[NSMutableArray alloc] init];
    [self addFooter];
    self.tableView.rowHeight = 135;
    
//    UIView *view =[ [UIView alloc]init];
//    view.backgroundColor = [UIColor clearColor];
//    [ self.tableView setTableFooterView:view];
//    [ self.tableView setTableHeaderView:view];
//    view = nil;
    
    
}
-(void)getArrays{
    _arrays = [[NSMutableArray alloc] init];
    AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:[NSString stringWithFormat:@"%ld", (long)pageNo] forKey:@"pageNo"];
    [parameters setValue:[NSString stringWithFormat:@"%ld", (long)pageSize] forKey:@"pageSize"];
    [parameters setValue:[[Config Instance] getCommunityId] forKey:@"communityId"];
    [[AnimationView animationClass]createAnimation:YES toText:nil toView:self.view];
    [manager POST:API_BASE_URL_STRING(URL_GETALLACTIVITYBYID) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary= responseObject;
        if (dictionary) {
            NSLog(@"%@",dictionary);
            if (dictionary[Y_Data]) {
                dictionary = dictionary[Y_Data];
                if (dictionary[@"records"]) {
                    [[AnimationView animationClass] hideViewToView:self.view];
                    dictionary = dictionary[@"records"];
                    
                    for (NSDictionary *dict in dictionary) {
                        // 创建模型对象
                        Activity *activity = [Activity objectWithKeyValues:dict ];
                        // 添加模型对象到数组中
                        [_arrays addObject:activity];
                    }
                    [self.tableView reloadData];
                    pageNo++;
                }
                else{
                    [[AnimationView animationClass] createAnimation:NO toText:nil toView:self.view];
                }
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[AnimationView animationClass]createAnimation:NO toText:NetError toView:self.view];
    }];
}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrays.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Activity *activity = self.arrays[indexPath.row];
    // 1.创建cell
    ActivityTableViewCell *cell = [ActivityTableViewCell cellWithTableView:tableView];
    // 2.设置数据
    [cell settingData:activity];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Activity *activity = [[Activity alloc] init];
    activity = _arrays[indexPath.row];
    ActivityDescVC *activityDescVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ActivityDescVC"];
    activityDescVC.activity = activity;
    activityDescVC.title=@"活动";
    [self.navigationController pushViewController:activityDescVC animated:YES];
}

#pragma mark - LoadMoreData
- (void)addFooter
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加上拉刷新尾部控件
    [self.tableView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [vc loadMoreData];
    }];
}

- (void)loadMoreData
{
    
    AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:[NSString stringWithFormat:@"%ld", (long)pageNo] forKey:@"pageNo"];
    [parameters setValue:[NSString stringWithFormat:@"%ld", (long)pageSize] forKey:@"pageSize"];
    [parameters setValue:[[Config Instance] getCommunityId] forKey:@"communityId"];
    [manager POST:API_BASE_URL_STRING(URL_GETALLACTIVITYBYID) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary= responseObject;
        if (dictionary) {
            if (dictionary[Y_Data]) {
                dictionary = dictionary[Y_Data];
                if (dictionary[@"records"]) {
                    dictionary = dictionary[@"records"];
                    for (NSDictionary *dict in dictionary) {
                        // 创建模型对象
                        Activity *activity =  [ Activity objectWithKeyValues:dict ];
                        // 添加模型对象到数组中
                        [moreArrays addObject:activity];
                    }
                    [self resetActivityArrayDataResource:moreArrays];
                    pageNo++;
                }
                else{
                    [self.view.superview makeToast:Not_History_Data duration:1.0f position:@"bottom"];
                    [self.tableView footerEndRefreshing];
                    return;
                }
            }
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
    
}

- (void)resetActivityArrayDataResource:(NSArray *)moreArray
{
    [self.tableView beginUpdates];
    NSMutableArray *dataCells = [NSMutableArray array];
    NSInteger count = _arrays.count;
    for (Activity *object in moreArray) {
        [dataCells addObject:[NSIndexPath indexPathForRow:count++ inSection:0]];
        [_arrays addObject:object];
    }
    [self.tableView insertRowsAtIndexPaths:dataCells withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    [self.tableView footerEndRefreshing];
}

@end
