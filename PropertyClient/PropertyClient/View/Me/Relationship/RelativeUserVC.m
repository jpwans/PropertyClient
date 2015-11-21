//
//  RelativeUserVC.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/16.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "RelativeUserVC.h"
#import "UserRelationship.h"
@interface RelativeUserVC ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIPickerView *pickView;
    int   relativeIndex;
    int sexIndex;
}

@property (weak, nonatomic) IBOutlet UISegmentedControl *switchSex;

- (IBAction)switchSexAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *relativeType;
@property (weak, nonatomic) IBOutlet UITextField *relativeField;
@property (nonatomic, strong) NSMutableArray *relativetypes;
@end

@implementation RelativeUserVC

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    relativeIndex = 0;
    sexIndex =  1 ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.bounds = BOTTOM_FRAME;
    self.title =@"添加关联用户";
    [self createSaveBtn];
    pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0 ,SCREEN_HEIGHT-80, SCREEN_WIDTH, 100)];
    pickView.backgroundColor =BACKGROUND_COLOR;
    
    pickView.delegate =self;
    pickView.dataSource  =self;
    self.relativeField.inputView =pickView;
    //      [self pickerView:nil didSelectRow:relativeIndex inComponent:0];
    self.phone.keyboardType = UIKeyboardTypePhonePad;
    self.switchSex.selectedSegmentIndex = 0;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.relativeField resignFirstResponder];
}

-(NSMutableArray *)relativetypes{
    if (_relativetypes== nil) {
        _relativetypes = [[NSMutableArray alloc] init];
        // _foods数组中装着3个数组
        //        _relativetypes=[NSMutableArray arrayWithObjects:@"妻子", @"父亲",@"母亲",@"亲戚",@"租客", nil];
        AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
        
        
        [manager POST:API_BASE_URL_STRING(URL_LABELLIST) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dictionary= responseObject;
            if ([dictionary[Y_Code] intValue]==Y_Code_Success) {
                dictionary =  dictionary[Y_Data][@"records"];
                for (NSDictionary *dict in dictionary) {
                    // 创建模型对象
                    UserRelationship *userRelationship = [UserRelationship objectWithKeyValues:dict ];
                    NSLog(@"%@",userRelationship.label);
                    // 添加模型对象到数组中
                    [_relativetypes addObject:userRelationship];
                }
                NSLog(@"%lu",(unsigned long)_relativetypes.count);
                [pickView reloadAllComponents];
                [self pickerView:nil didSelectRow:relativeIndex inComponent:0];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",[error localizedDescription]);
        }];
    }
    return _relativetypes;
}


#pragma mark - 数据源方法
/**
 *  一共有多少列
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

/**
 *  第component列显示多少行
 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return self.relativetypes.count;
}

#pragma mark - 代理方法
/**
 *  第component列的第row行显示什么文字
 */
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    UserRelationship*UserRelationship = _relativetypes[row];
    return UserRelationship.label;
    
}

/**
 *  选中了第component列的第row行
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //    NSLog(@"%ld,%ld",(long)row,(long)component);
    UserRelationship*UserRelationship = _relativetypes[row];
    self.relativeField.text = UserRelationship.label;
    relativeIndex = [UserRelationship.value intValue];
    //    relativeIndex = (int)row +1;
}


-(void)createSaveBtn{
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_send"] style:UIBarButtonItemStyleBordered target:self action:@selector(saveToServer)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

-(void)saveToServer{
    [_relativeField resignFirstResponder];
    NSString *name = [self.name.text trimString];
    NSString   *sex = [NSString stringWithFormat:@"%d",sexIndex];
    NSString *phone = [self.phone.text trimString];
    NSString *relativeType = [NSString stringWithFormat:@"%d",relativeIndex];
    AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:name,@"name",phone,@"phone",sex,@"sex",relativeType,@"relativeType",nil];
    
    [manager POST:API_BASE_URL_STRING(URL_RELATIVEUSER) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary= responseObject;
        
        if (dictionary) {
            if ([dictionary[Y_Code] intValue]==Y_Code_Success) {
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            else{
                [self.view makeToast:dictionary[Y_Message] duration:1.5f position:@"top"];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",[error localizedDescription]);
    }];
    
}



- (IBAction)switchSexAction:(id)sender {
    sexIndex = self.switchSex.selectedSegmentIndex==0?1:2;
    NSLog(@"%d",sexIndex);
}
@end
