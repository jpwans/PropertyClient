//
//  RepairCell.m
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/6/1.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import "RepairCell.h"
@implementation RepairCell

- (void)awakeFromNib {
    // Initialization code
//    _centerView.layer.masksToBounds = YES;
//    _centerView.layer.cornerRadius = 6.0;
//    _centerView.layer.borderWidth = 1;
//    _centerView.layer.borderColor = [UIColor blackColor].CGColor;
//    UIView  *v= [[UIView alloc] init];
//    v.frame = CGRectMake(self.bounds.origin.x, self.frame.size.height-1, self.bounds.size.width, 1);
//    v.backgroundColor = BACKGROUND_COLOR;
//    [self addSubview:v];
    _isComplete.hidden = YES;
    _isComplete.backgroundColor = RGBCOLOR(240, 84, 35);
//        _externalView.layer.masksToBounds = YES;
////        _externalView.layer.cornerRadius = 6.0;
//        _externalView.layer.borderWidth = 1;
//        _externalView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _externalView.backgroundColor = BACKGROUND_COLOR;
    self.backgroundColor = ALLBACKCOLOR;
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)click:(id)btn{
    UIButton *button = (UIButton *)btn;
    NSLog(@"%ld",(long)button.tag);
}

-(void)settingData:(RepairInfo *)repairInfo{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.repairTitle.text =repairInfo.title;
//    NSArray * picArray = [repairInfo.photo componentsSeparatedByString:@"&#"];
//    NSString *photoId = picArray[0];
//    NSString *urlStr  = [NSString stringWithFormat:@"%@%@",URL_QINIU,photoId];
//    NSURL *url = [NSURL URLWithString:urlStr];
//    
//    for (int i = 0; i<picArray.count-1;i++) {
//        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5 + i*50 +i *5, 0,50,50 )];
//        [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_QINIU,picArray[i]]] placeholderImage:[UIImage imageNamed:@"aio_image_default"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            
//        }];
//        UIButton *imageBtn = [[UIButton alloc] initWithFrame:CGRectMake(5 + i*50 +i *5, 0,50,50 )];
//        [imageBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//        imageBtn.tag = [picArray[i] longLongValue]?[picArray[i] longLongValue]:0;
//        [_picView addSubview:imageBtn];
//        [_picView addSubview:imgView];
//    }


    NSInteger index = [repairInfo.scheduleType integerValue];
    NSString *state = @"待处理";
    switch (index) {
        case 0:
            state = @"待处理";
            break;
        case 1:
            state = @"物业已知晓";
            break;
        case 2:
            state = @"维修工已派遣";
            break;
        case 3:
            state = @"确认完工待评价";
            break;
        case 4:
            state = @"已评价";
            break;
        default:
            break;
    }
 
    if (index==2&&[[[Config Instance] getRoleType] intValue]==22) {
        _isComplete.hidden = NO;
    }
    self.dealState.text = state;
    self.repairDesc.text=repairInfo.describe;
    NSRange range = {11,5};
    self.repairTime.text = [NSString stringWithFormat:@"%@~%@",[repairInfo.hopeStart substringToIndex:16],[repairInfo.hopeEnd substringWithRange:range]];
    self.repairCreateTime.text = [repairInfo.createDate substringToIndex:16];
    
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"status";
    RepairCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RepairCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
@end
