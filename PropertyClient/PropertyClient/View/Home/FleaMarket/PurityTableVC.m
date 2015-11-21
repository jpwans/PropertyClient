//
//  PurityTableVC.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/26.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "PurityTableVC.h"
#import "PurityType.h"
#import "AddFleaMarketVC.h"
@interface PurityTableVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *arrays;
@end

@implementation PurityTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(NSArray *)arrays{
    if (_arrays==nil) {
        _arrays = [[NSMutableArray alloc] init];
        PurityType *pt1 = [[PurityType alloc] init];
        pt1.lable=@"全新";
        pt1.value =@"0";
        PurityType *pt2= [[PurityType alloc] init];
        pt2.lable=@"95新";
        pt2.value =@"1";
        PurityType *pt3 = [[PurityType alloc] init];
        pt3.lable=@"9成新";
        pt3.value =@"2";
        PurityType *pt4 = [[PurityType alloc] init];
        pt4.lable=@"8成新";
        pt4.value =@"3";
        PurityType *pt5= [[PurityType alloc] init];
        pt5.lable=@"7成新以下";
        pt5.value =@"4";
        _arrays = @[pt1,pt2,pt3,pt4,pt5];
    }
    return _arrays;
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"%lu",(unsigned long)self.arrays.count);
    return self.arrays.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString *cellIdentifier = @"cellIdentifier ";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    PurityType *purityType=  self.arrays[indexPath.row];
    cell.textLabel.text = purityType.lable;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PurityType *purityType=  self.arrays[indexPath.row];
    NSLog(@"%@",purityType.value);
    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray *viewControllers=[self.navigationController viewControllers];
        AddFleaMarketVC *controller=[viewControllers objectAtIndex:2];
        controller.purityType = purityType;
        [self.navigationController popToViewController:controller animated:YES];
    });

}


@end
