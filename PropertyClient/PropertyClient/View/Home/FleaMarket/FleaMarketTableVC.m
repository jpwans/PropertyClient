//
//  FleaMarketTableVC.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/25.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "FleaMarketTableVC.h"
#import "FleaMarketCell.h"
#import "GoodsDetailsVC.h"
#import "AnimationView.h"
@interface FleaMarketTableVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger pageNo;
    NSInteger pageSize;
    NSMutableArray *moreArrays;
  
}
@property (nonatomic, strong) NSMutableArray *arrays;

@end

@implementation FleaMarketTableVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.view.backgroundColor = BACKGROUND_COLOR;
    pageNo = 0;
    pageSize = 5;
//    _arrays=nil;
//    [self arrays];
    [self getArrays];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //    pageSize = 5;
    
    moreArrays = [[NSMutableArray alloc] init];
    [self addFooter];
    //    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    //        self.edgesForExtendedLayout = UIRectEdgeNone;
    //    self.view.bounds = BOTTOM_FRAME;
    self.tableView.rowHeight = 65;
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [ self.tableView setTableFooterView:view];
    [ self.tableView setTableHeaderView:view];
    view = nil;
    

}

-(void)getArrays{
    _arrays = [[NSMutableArray alloc] init];
    AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:[NSString stringWithFormat:@"%ld", (long)pageNo] forKey:@"pageNo"];
    [parameters setValue:[NSString stringWithFormat:@"%ld", (long)pageSize] forKey:@"pageSize"];
    [parameters setValue:[[Config Instance] getCommunityId] forKey:@"communityId"];
    [[AnimationView animationClass]createAnimation:YES toText:nil toView:self.view];
    [manager POST:API_BASE_URL_STRING(URL_GETFLEAMARKETSBYCOMMUNITYID) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary= responseObject;
        if (dictionary) {
            NSLog(@"%@",dictionary);
            if (dictionary[Y_Data]) {
                dictionary = dictionary[Y_Data];
                if (!dictionary.count) {
                        [[AnimationView animationClass]createAnimation:NO toText:nil toView:self.view];
                }
               else if (dictionary[@"records"]) {
                    [[AnimationView animationClass] hideViewToView:self.view];
                    dictionary = dictionary[@"records"];
                    for (NSDictionary *dict in dictionary) {
                        // 创建模型对象
                        FleaMarket *fleaMarket = [FleaMarket objectWithKeyValues:dict ];
                        // 添加模型对象到数组中
                        [_arrays addObject:fleaMarket];
                    }
                    [self.tableView reloadData];
                    
                    pageNo++;
                    
                }
                
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",[error localizedDescription]);
        [[AnimationView animationClass] createAnimation:NO toText:NetError toView:self.view];
        
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
    FleaMarket *fleaMarket = self.arrays[indexPath.row];
    // 1.创建cell
    FleaMarketCell *cell = [FleaMarketCell cellWithTableView:tableView];
    // 2.设置数据
    [cell settingData:fleaMarket];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FleaMarket *fleaMarket = [[FleaMarket alloc] init];
    fleaMarket = _arrays[indexPath.row];
    GoodsDetailsVC *goodsDetailsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"GoodsDetailsVC"];
    goodsDetailsVC.fleaMarket = fleaMarket;
    goodsDetailsVC.title=@"宝贝详情";
    [self.navigationController pushViewController:goodsDetailsVC animated:YES];
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
    [manager POST:API_BASE_URL_STRING(URL_GETFLEAMARKETSBYCOMMUNITYID) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary= responseObject;
        if (dictionary) {
            NSLog(@"%@",dictionary[Y_Data]);
            if (dictionary[Y_Data]) {
                dictionary = dictionary[Y_Data];
                if (dictionary[@"records"]) {
                    dictionary = dictionary[@"records"];
                    for (NSDictionary *dict in dictionary) {
                        // 创建模型对象
                        FleaMarket *fleaMarket = [FleaMarket objectWithKeyValues:dict];
                        // 添加模型对象到数组中
                        [moreArrays addObject:fleaMarket];
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
    for (FleaMarket *object in moreArray) {
        [dataCells addObject:[NSIndexPath indexPathForRow:count++ inSection:0]];
        [_arrays addObject:object];
    }
    [self.tableView insertRowsAtIndexPaths:dataCells withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    [self.tableView footerEndRefreshing];
}

-(void)dealloc{
    _arrays=nil;
}
@end
