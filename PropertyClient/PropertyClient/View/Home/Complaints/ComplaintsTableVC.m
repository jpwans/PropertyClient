//
//  ComplaintsTableVC.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/19.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "ComplaintsTableVC.h"
#import "ComplaintsCell.h"
#import "ComplaintsDescVC.h"

@interface ComplaintsTableVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger pageNo;
    NSInteger pageSize;
    NSMutableArray *moreArrays;
}
@property (nonatomic, strong) NSMutableArray *arrays;
@end

@implementation ComplaintsTableVC
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.view.backgroundColor = BACKGROUND_COLOR;
    //    _arrays=nil;
    pageNo = 0;
    //    [self arrays];
    [self getArrays];
    self.tableView.backgroundColor = ALLBACKCOLOR;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    moreArrays = [[NSMutableArray alloc] init];
    [self addFooter];
    pageSize = 5;
    //    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    //        self.edgesForExtendedLayout = UIRectEdgeNone;
    //    self.view.bounds = BOTTOM_FRAME;
    self.tableView.rowHeight = 100;
}
-(void)getArrays{
    _arrays = [[NSMutableArray alloc] init];
    AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:[NSString stringWithFormat:@"%ld", (long)pageNo] forKey:@"pageNo"];
    [parameters setValue:[NSString stringWithFormat:@"%ld", (long)pageSize] forKey:@"pageSize"];
    [[AnimationView animationClass]createAnimation:YES toText:nil toView:self.view];
    [manager POST:API_BASE_URL_STRING(URL_GETCOMPLAINTS) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary= responseObject;
        if (dictionary) {
            if (dictionary[Y_Data]) {
                
                dictionary = dictionary[Y_Data];
                if (dictionary.count) {
                    [[AnimationView animationClass]hideViewToView:self.view];
                }
                else {
                    [[AnimationView animationClass]createAnimation:NO toText:nil toView:self.view];
                    return ;
                }
                if (dictionary[@"records"]) {
                    dictionary = dictionary[@"records"];
                    for (NSDictionary *dict in dictionary) {
                        // 创建模型对象
                        Complaints *com =  [ Complaints objectWithKeyValues:dict ];
                        // 添加模型对象到数组中
                        [_arrays addObject:com];
                    }
                    [self.tableView reloadData];
                    pageNo++;
                }}
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
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
    
    Complaints *complaints = self.arrays[indexPath.row];
    // 1.创建cell
    ComplaintsCell *cell = [ComplaintsCell cellWithTableView:tableView];
    // 2.设置数据
    [cell settingData:complaints];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    UITableViewCell *cell =  [tableView cellForRowAtIndexPath:indexPath];
    Complaints *complaints = [[Complaints alloc] init];
    complaints = _arrays[indexPath.row];
    NSLog(@"%@",complaints.compId);
    ComplaintsDescVC *comDescVC=   [self.storyboard instantiateViewControllerWithIdentifier:@"complaintsDesc"];
    comDescVC.compId = complaints.compId;
    [self.navigationController pushViewController:comDescVC animated:YES];
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
    NSLog(@"%@",parameters);
    [manager POST:API_BASE_URL_STRING(URL_GETCOMPLAINTS) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary= responseObject;
        if (dictionary) {
            if (dictionary[Y_Data]) {
                dictionary = dictionary[Y_Data];
                if (dictionary[@"records"]) {
                    dictionary = dictionary[@"records"];
                    for (NSDictionary *dict in dictionary) {
                        // 创建模型对象
                        Complaints *com =  [ Complaints objectWithKeyValues:dict ];
                        // 添加模型对象到数组中
                        [moreArrays addObject:com];
                    }
                    [self resetComplaintsArrayDataResource:moreArrays];
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

- (void)resetComplaintsArrayDataResource:(NSArray *)moreArray
{
    [self.tableView beginUpdates];
    NSMutableArray *dataCells = [NSMutableArray array];
    NSInteger count = _arrays.count;
    for (Complaints *object in moreArray) {
        [dataCells addObject:[NSIndexPath indexPathForRow:count++ inSection:0]];
        [_arrays addObject:object];
    }
    [self.tableView insertRowsAtIndexPaths:dataCells withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    [self.tableView footerEndRefreshing];
}

@end
