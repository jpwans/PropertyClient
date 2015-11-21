//
//  GoodsCategoryTableVC.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/26.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "GoodsCategoryTableVC.h"
#import "GoodsCategory.h"
#import "AddFleaMarketVC.h"
@interface GoodsCategoryTableVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *arrays;
@end

@implementation GoodsCategoryTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
}

-(NSMutableArray *)arrays{
    if (_arrays==nil) {
        _arrays = [[NSMutableArray alloc] init];
        AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [manager POST:API_BASE_URL_STRING(URL_GETALLDITBYTYPE) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dictionary= responseObject;
            if (dictionary) {
                NSLog(@"%@",dictionary);
                if (dictionary[Y_Data]) {
                    dictionary = dictionary[Y_Data];
           
                        for (NSDictionary *dict in dictionary) {
                            // 创建模型对象
                            GoodsCategory *goodsCategory = [GoodsCategory objectWithKeyValues:dict ];
                            // 添加模型对象到数组中
                            [_arrays addObject:goodsCategory];
                        }
                        NSLog(@"count:%lu",(unsigned long)_arrays.count);
                        [self.tableView reloadData];
                }
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error:%@",[error localizedDescription]);
        }];
    }
    return  _arrays;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"%lu",(unsigned long)self.arrays.count);
    return self.arrays.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10.0f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString *cellIdentifier = @"cellIdentifier ";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    GoodsCategory *goodsCategory=  self.arrays[indexPath.row];
    cell.textLabel.text = goodsCategory.label;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     GoodsCategory *goodsCategory=  self.arrays[indexPath.row];
    NSLog(@"%@",goodsCategory.value);
    dispatch_async(dispatch_get_main_queue(), ^{

        NSArray *viewControllers=[self.navigationController viewControllers];
        AddFleaMarketVC *controller=[viewControllers objectAtIndex:2];
        controller.goodsCategory = goodsCategory;
        [self.navigationController popToViewController:controller animated:YES];
    });
    //    GoodsDetailsVC *goodsDetailsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"GoodsDetailsVC"];
    //    goodsDetailsVC.fleaMarket = fleaMarket;
    //    goodsDetailsVC.title=@"宝贝详情";
    //    [self.navigationController pushViewController:goodsDetailsVC animated:YES];
}


@end
