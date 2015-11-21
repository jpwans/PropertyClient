//
//  MsgInfoTableView.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/29.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "MsgInfoTableView.h"
#import "Msg.h"
#import "MsgInfoCell.h"
@interface MsgInfoTableView (){
    NSInteger pageNo;
    NSInteger pageSize;
    NSMutableArray *moreArrays;
}
@property (nonatomic, strong) NSMutableArray *arrays;
@end

@implementation MsgInfoTableView

-(void )viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getArrays
     ];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    pageNo = 0;
    pageSize = 5;
    
    moreArrays = [[NSMutableArray alloc] init];
    [self addFooter];
//    self.tableView.rowHeight = 115;
    self.tableView.backgroundColor = ALLBACKCOLOR;
    self.tableView.delegate =self;
}
-(void)getArrays{
    _arrays = [[NSMutableArray alloc] init];
    AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:[NSString stringWithFormat:@"%ld", (long)pageNo] forKey:@"pageNo"];
    [parameters setValue:[NSString stringWithFormat:@"%ld", (long)pageSize] forKey:@"pageSize"];
    [parameters setValue:self.adviceType forKey:@"adviceType"];
    [[AnimationView animationClass ]createAnimation:YES toText:nil toView:self.view];
    [manager POST:API_BASE_URL_STRING(URL_FINDADVICELIST) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary= responseObject;
        if (dictionary) {
            if (dictionary[Y_Data]) {
                dictionary = dictionary[Y_Data];
                if (dictionary[@"records"]) {
                        [[AnimationView animationClass ]hideViewToView:self.view];
                    dictionary = dictionary[@"records"];
                    for (NSDictionary *dict in dictionary) {
                        // 创建模型对象
                        Msg *msg = [Msg objectWithKeyValues:dict ];
                        // 添加模型对象到数组中
                        [_arrays addObject:msg];
                    }
                    [self.tableView reloadData];
                    pageNo++;
                }
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",[error localizedDescription]);
                         [[AnimationView animationClass ]createAnimation:NetError toText:nil toView:self.view];
    }];

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
    Msg *msg = self.arrays[indexPath.row];
    // 1.创建cell
    MsgInfoCell *cell = [MsgInfoCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // 2.设置数据
    [cell settingData:msg];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {


    MsgInfoCell *cell = (MsgInfoCell *)[self tableView:tableView  cellForRowAtIndexPath:indexPath];

    
    return cell.frame.size.height;
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
    [parameters setValue:self.adviceType forKey:@"adviceType"];
    [manager POST:API_BASE_URL_STRING(URL_FINDADVICELIST) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary= responseObject;
        if (dictionary) {
            if (dictionary[Y_Data]) {
                dictionary = dictionary[Y_Data];
                if (dictionary[@"records"]) {
                    dictionary = dictionary[@"records"];
                    for (NSDictionary *dict in dictionary) {
                        // 创建模型对象
                        Msg *msg = [Msg objectWithKeyValues:dict ];
                        // 添加模型对象到数组中
                        [moreArrays addObject:msg];
                    }
                    [self resetMsgArrayDataResource:moreArrays];
                    pageNo++;
                }
                else{
                    [self.view.superview makeToast:Not_History_Data duration:1.0f position:@"bottom"];
                    [self.tableView footerEndRefreshing];
                    return;
                }
            }
            else{
                [self.view.superview makeToast:Not_History_Data duration:1.0f position:@"bottom"];
                [self.tableView footerEndRefreshing];
                return;
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
    
}

- (void)resetMsgArrayDataResource:(NSArray *)moreArray
{
    [self.tableView beginUpdates];
    NSMutableArray *dataCells = [NSMutableArray array];
    NSInteger count = _arrays.count;
    for (Msg *object in moreArray) {
        [dataCells addObject:[NSIndexPath indexPathForRow:count++ inSection:0]];
        [_arrays addObject:object];
    }
    [self.tableView insertRowsAtIndexPaths:dataCells withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    [self.tableView footerEndRefreshing];
}


@end
