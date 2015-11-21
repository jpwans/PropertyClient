//
//  GoodsDetailsVC.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/25.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "GoodsDetailsVC.h"

@interface GoodsDetailsVC ()
{
    NSString *phoneNum;
//    NSString *compId;
}
@end

@implementation GoodsDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self.navigationController setHidesBarsOnTap:YES];

    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.bounds = BOTTOM_FRAME;
    _arrays = [[NSMutableArray alloc] init];
    [self viewInit];
}

-(void)viewInit{
    
    _goodsDesc.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _goodsDesc.layer.borderWidth =1;
    AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    [parameters setValue:[NSString stringWithFormat:@"%ld", (long)pageNo] forKey:@"pageNo"];
//    [parameters setValue:[NSString stringWithFormat:@"%ld", (long)pageSize] forKey:@"pageSize"];
    [parameters setValue:self.fleaMarket.fleaMarkId  forKey:@"fleaMarkId"];
    [self.mmScrollPresenter setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, self.mmScrollPresenter.frame.size.height)];
//    _mmScrollPresenter.layer.borderWidth = 1;
//    _mmScrollPresenter.layer.borderColor = [UIColor blackColor].CGColor;
    
    [manager POST:API_BASE_URL_STRING(URL_GETFLEAMARKETBYID) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary= responseObject;
        if (dictionary) {
            NSLog(@"%@",dictionary);

            if ([dictionary[Y_Data][@"owner"][@"id"] isEqualToString:[[Config Instance]getOwnerId]]) {
                UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(del)];
                    self.navigationItem.rightBarButtonItem = btn;
            }
            if (dictionary[Y_Data]) {
                dictionary = dictionary[Y_Data];
                NSArray * picArray = [dictionary[@"photo"] componentsSeparatedByString:@"&#"];
                for (int i = 0; i<picArray.count-1;i++) {
                    NSLog(@"%@",picArray[i]);
                    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.mmScrollPresenter.frame.size.width, self.mmScrollPresenter.frame.size.height)];
                    [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_QINIU,picArray[i]]] placeholderImage:[UIImage imageNamed:@"aio_image_default"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        
                    }];
                    MMScrollPage *newPage =  [[MMScrollPage alloc] init];
                    [newPage.backgroundView addSubview:imgView];
                    [_arrays addObject:newPage];
                }

                [self.mmScrollPresenter addMMScrollPageArray:_arrays];
             
                self.goodsName.text = dictionary[@"goodsName"];
                self.goodsDesc.text  =dictionary[@"description"];
                self.publishTime.text = dictionary[@"updateDate"];
                self.nowPrice.text = [NSString stringWithFormat:@"￥%@",dictionary[@"transferPrice"]];
                self.oldPrice.text =  [NSString stringWithFormat:@"￥%@",dictionary[@"oldPrice"]];

                NSUInteger length = [[NSString stringWithFormat:@"￥%@",dictionary[@"oldPrice"]] length];
                
                NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",dictionary[@"oldPrice"]]];
                [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
                [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, length)];
                [_oldPrice setAttributedText:attri];
                
                [_headPhoto sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_QINIU,dictionary[@"owner"][@"photo"]]] placeholderImage:[UIImage imageNamed:@"aio_image_default"]];
                self.name.text = dictionary[@"owner"][@"name"];
                phoneNum = dictionary[@"owner"][@"phone"];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
}


-(void)del{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"您真的要抛弃您的宝贝吗?"
                                  delegate:self
                                  cancelButtonTitle:@"容我想想"
                                  destructiveButtonTitle:@"我心已绝"
                                  otherButtonTitles:nil,nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];

}
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",(long)buttonIndex);

    if (buttonIndex==0) {
        AFHTTPRequestOperationManager *manager = [RestClient getAFHTTPRequestOperationManagerPutheaderPost];
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:    _fleaMarket.fleaMarkId,@"fleaMarkId",nil];

        [manager POST:API_BASE_URL_STRING(URL_DELETEMARKETINFO) parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dictionary= responseObject;

            if (dictionary) {
                int code = [dictionary[Y_Code] intValue];
                if (code==1) {
                    [self.navigationController popViewControllerAnimated:YES];
                                [MBProgressHUD  showSuccess:@"主人不要我了，呜呜呜！"];
                }
                else{
                    [MBProgressHUD  showError:dictionary[Y_Message]];

                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",[error localizedDescription]);
        }];
    }
}
- (IBAction)callPhone:(id)sender {
    if(phoneNum.length){
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phoneNum];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

- (IBAction)smsAction:(id)sender {
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",phoneNum]]];
}
@end
