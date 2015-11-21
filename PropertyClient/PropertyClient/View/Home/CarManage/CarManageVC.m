//
//  CarManageVC.m
//  PropertyClient
//
//  Created by MoPellet on 15/7/1.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "CarManageVC.h"
#import "CarManage.h"
#import "CarCell.h"
@interface CarManageVC()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    BOOL isFiltered; // 标识是否正在搜素
    UIView *mask;
}
@property (nonatomic, strong) NSMutableArray *arrays;
@end
@implementation CarManageVC
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    NSArray *arr = [[NSArray alloc] initWithObjects:@"1", nil];
//    NSLog(@"%@",arr[3]);
    [UIView animateWithDuration:0.3 animations:^{
        //        self.navigationController.navigationBar.alpha = 1;
        self.navigationController.navigationBar.translucent = NO;
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , 44)];
    searchBar.placeholder = @"请输入车牌号后3位";
    
    // 添加 searchbar 到 headerview
    self.tableView.tableHeaderView = searchBar;
    searchBar.delegate = self;
    // 添加一层 mask
    mask = [[UIView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height -44)];
    [self.view addSubview:mask];
    mask.backgroundColor = [UIColor blackColor];
    mask.alpha = 0;
    self.tableView.rowHeight = 70;
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    // 开始搜索时弹出 mask 并禁止 tableview 点击
    NSLog(@"searchBarTextDidBeginEditing");
    isFiltered = YES;
    searchBar.showsCancelButton = YES;
    mask.alpha = 0.3;
    self .tableView.allowsSelection = NO;
    self.tableView.scrollEnabled = NO;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) sb{
    // 点击 cancel 时去掉 mask ,reloadData
    sb.text = @"";
    [sb setShowsCancelButton:NO animated:YES];
    self.tableView.allowsSelection = YES;
    self.tableView.scrollEnabled = YES;
    [sb resignFirstResponder];
    mask.alpha = 0;
    isFiltered = NO;
    [self.tableView reloadData];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    _arrays = [[NSMutableArray alloc] init];
    AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[searchBar.text trimString],@"carNo",nil];
    
    [manager POST:API_BASE_URL_STRING(URL_FindCarNum) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary= responseObject;
        NSLog(@"%@",dictionary);
        if (dictionary[Y_Data]) {
            if (dictionary[Y_Data][@"records"]) {
                dictionary = dictionary[Y_Data][@"records"];
                _arrays = [NSMutableArray array];
                for (NSDictionary *dict in dictionary) {
                    // 创建模型对象
                    CarManage *carManage = [CarManage objectWithKeyValues:dict];
                    // 添加模型对象到数组中
                    [_arrays addObject:carManage];
                }
                [searchBar setShowsCancelButton:NO animated:YES];
                self.tableView.allowsSelection = YES;
                self.tableView.scrollEnabled = YES;
                [searchBar resignFirstResponder];
                mask.alpha = 0;
                isFiltered = NO;
                [self.tableView reloadData];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrays.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CarManage *carManage = self.arrays[indexPath.row];
    // 1.创建cell
    CarCell *cell = [CarCell cellWithTableView:tableView];
    // 2.设置数据
    [cell settingData:carManage];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"当前选中行%ld",(long)indexPath.row);
    CarManage *carManage = _arrays[indexPath.row];
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@", carManage.phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

}




@end
