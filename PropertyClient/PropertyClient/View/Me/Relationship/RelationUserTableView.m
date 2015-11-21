//
//  RelationUserTableView.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/29.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "RelationUserTableView.h"
#import "RelativeUser.h"
#import "RelativeUserCell.h"
#import "RelativeUserVC.h"
@interface RelationUserTableView ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    NSIndexPath * delIndexPath;
}
@property (nonatomic, strong) NSMutableArray *arrays;
@end

@implementation RelationUserTableView



/**
 *  创建添加按钮
 */
-(void)createAddBtn{
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addRelative:)];
    
    self.navigationItem.rightBarButtonItem = rightButton;
}
-(void)addRelative:(id)btn{
    
    RelativeUserVC *relativeUserVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RelativeUserVC"];
    [self.navigationController pushViewController:relativeUserVC animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.rowHeight =80;
    
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [ self.tableView setTableFooterView:view];
    [ self.tableView setTableHeaderView:view];
    view = nil;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self createAddBtn];
    [self getArrays];
}
/**
 *  添加数据到数组
 */
-(void)getArrays{
    _arrays = [[NSMutableArray alloc] init];
    AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [manager POST:API_BASE_URL_STRING(URL_RELATIVELIST) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary= responseObject;
        if (dictionary) {
            NSLog(@"%@",dictionary);
            if (dictionary[Y_Data]) {
                int code = [dictionary[Y_Code] intValue];
                if (1==code) {
                    dictionary = dictionary[Y_Data];
                    if (dictionary[@"records"]) {
                        dictionary = dictionary[@"records"];
                        for (NSDictionary *dict in dictionary) {
                            // 创建模型对象
                            RelativeUser *relativeUser = [RelativeUser objectWithKeyValues:dict ];
                            // 添加模型对象到数组中
                            [_arrays addObject:relativeUser];
                        }
                        [self.tableView reloadData];
                        
                    }
                }
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",[error localizedDescription]);
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
    RelativeUser *relativeUser = self.arrays[indexPath.row];
    //     1.创建cell
    RelativeUserCell *cell = [RelativeUserCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // 2.设置数据
    [cell settingData:relativeUser];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 6.0;
    cell.layer.borderWidth = 1.0;
    cell.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        delIndexPath = indexPath;
        
        UIActionSheet *sheet = [[UIActionSheet alloc]  initWithTitle:@"您确定和对方解除关系吗？" delegate:self cancelButtonTitle:@"容我想想" destructiveButtonTitle:@"毫不犹豫" otherButtonTitles:nil, nil];
        [sheet showInView:self.view];
        
    }
    
}
#pragma mark - ActionSheet代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        RelativeUser *relativeUser = self.arrays[delIndexPath.row];
        AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:relativeUser.relativeId,@"relativeId",nil];
        
        [manager POST:API_BASE_URL_STRING(URL_DELETERELATIVEINFO) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dictionary= responseObject;
            NSLog(@"%@",dictionary);
            if (dictionary) {
                if ([dictionary[Y_Code] intValue]==Y_Code_Success) {
                    [_arrays removeObjectAtIndex:delIndexPath.row];
                    // Delete the row from the data source.
                    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:delIndexPath] withRowAnimation:UITableViewRowAnimationFade];
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",[error localizedDescription]);
        }];
    }
}


@end
