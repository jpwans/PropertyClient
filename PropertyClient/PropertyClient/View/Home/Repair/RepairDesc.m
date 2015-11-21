//
//  RepairDesc.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/6/1.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "RepairDesc.h"
#import "Schedule.h"
#import "ScheduleCell.h"
#import "UITableView+Add.h"
@interface RepairDesc ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *arrays;
@property (nonatomic, strong)NSMutableArray  *comarrays;
@end

@implementation RepairDesc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _headView.backgroundColor = BACKGROUND_COLOR;
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.bounds = BOTTOM_FRAME;
    
    
    self.progressTableView.delegate =self;
    self.progressTableView.dataSource =self;
    self.progressTableView.rowHeight = 50;
    //      [self.progressTableView setExtraCellLineHidden];
    //
//    UIView *view =[ [UIView alloc]init];
//    view.backgroundColor = [UIColor clearColor];
//    [self.progressTableView setTableFooterView:view];
//    [self.progressTableView setTableHeaderView:view];
//    view = nil;
    
}


-(NSMutableArray *)arrays{
    if (_arrays==nil) {
        _arrays=[[NSMutableArray alloc] init];
        _comarrays = [[NSMutableArray alloc] init];
        AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:self.repairId,@"repairId",nil];
        [manager POST:API_BASE_URL_STRING(URL_GETREPAIRDETAILBYREPAIRID) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dictionary= responseObject;
            NSLog(@"%@",dictionary);
            if (dictionary) {
                if (dictionary[Y_Data]) {
                    dictionary = dictionary[Y_Data];
                    self.repairTitle.text = dictionary[@"title"];
                    self.repairTime.text = [NSString stringWithFormat:@"%@至%@",    [dictionary[@"hopeStart"] substringToIndex:16],       [dictionary[@"hopeEnd"] substringToIndex:16]];
                    self.repairDesc.text = dictionary[@"description"];
                    if (dictionary[@"scheduleList"]) {
                        NSDictionary *scheduleDic = dictionary[@"scheduleList"];
                        NSLog(@"scheduleDic:%@",scheduleDic);
                        for (NSDictionary *dict in scheduleDic) {
                            //                            // 创建模型对象
                            Schedule *schedule = [Schedule objectWithKeyValues:dict ];
                            // 添加模型对象到数组中
                            [_arrays addObject:schedule];
                        }
                     
                        [self.progressTableView reloadData];
                    }
                    if (dictionary[@"commentList"]) {
                        NSDictionary *commentDic = dictionary[@"commentList"];
                        for (NSDictionary *dict in commentDic) {
                            //                            // 创建模型对象
                            Comments *comment = [Comments objectWithKeyValues:dict ];
                            // 添加模型对象到数组中
                            [_comarrays addObject:comment];
                        }
                        Comments *com = _comarrays[0];
                        NSLog(@"%@",com.content);//评价内容
                    }
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",[error localizedDescription]);
        }];
    }
    return _arrays;
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"self.arrays.count:%lu",(unsigned long)self.arrays.count);
    return self.arrays.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Schedule *schedule = self.arrays[indexPath.row];
    
    // 1.创建cell
    ScheduleCell *cell = [ScheduleCell cellWithTableView:tableView];
    
    if (indexPath.row==0) {
        cell.onLine.hidden= YES;
        cell.progressImageView.image = [UIImage imageNamed:@"time_dot2"];
    }
    if (indexPath.row==_arrays.count -1) {
        cell.underLine.hidden = YES;
        cell.progressImageView.frame = CGRectMake(cell.progressImageView.frame.origin.x, cell.progressImageView.frame.origin.y, 15, 15);
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // 2.设置数据
    [cell settingData:schedule];
    return cell;
}


@end
