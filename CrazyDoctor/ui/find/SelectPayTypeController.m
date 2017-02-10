//
//  SelectPayTypeController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/8/1.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "SelectPayTypeController.h"
#import "RechargeCommonCell.h"
#import "UserStore.h"
#import "PayProcessor.h"
#import "WeiXinPayProcessor.h"
#define select_icon_x 285
#define weixin_icon_height     34
#define selected_payment_icon     6
#define pay_type_label_y         17

@interface SelectPayTypeController ()
{
    NSMutableArray *paymentTypes;
}
@end

@implementation SelectPayTypeController
- (instancetype)initWithFromType:(NSString *)type{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    [self setRightSwipeGestureAndAdaptive];
    [self initHeadView];
    [self initTableView];
    paymentTypes = [[PayProcessor sharedInstance] getPaymentTypes];
    
    self.paymentType = [[PaymentType alloc] initWithName:WALLET_PAYMENT paymentTypeIcon:@"icon_select_belt" subName:@""];
    [paymentTypes addObject:self.paymentType];

    self.paymentType = [[PayProcessor sharedInstance] getDefaultPaymentType];
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"选择支付方式" navigationController:self.navigationController];
    [self.view addSubview:self.headerView];
}

//初始化tableview
-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width,screen_height-self.headerView.frame.size.height) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark - tableViewDelegate and datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return paymentTypes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PaymentType *paymentType = paymentTypes[indexPath.row];
    
    // 渲染支付图标
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(general_margin, (80 - weixin_icon_height)/2, weixin_icon_height, weixin_icon_height)];
    image.image = [UIImage imageNamed:paymentType.paymentTypeIcon];
    [cell addSubview:image];
    
    // 渲染支付名称
    UILabel *rightLabel = [[UILabel alloc] init];
    
    if (indexPath.row == paymentTypes.count-1) {
        rightLabel.frame = CGRectMake(general_margin+general_padding+weixin_icon_height, (80-15)/2, screen_width-weixin_icon_height, 15);
    }else{
        rightLabel.frame = CGRectMake(general_margin+general_padding+weixin_icon_height, (80-43)/2, screen_width-weixin_icon_height, 15);
    }
    rightLabel.backgroundColor = [UIColor clearColor];
    rightLabel.font = [UIFont systemFontOfSize:default_1_font_size];
    rightLabel.textColor = [ColorUtils colorWithHexString:black_text_color];
    rightLabel.text = paymentType.paymentTypeName;
    [cell addSubview:rightLabel];
    
    UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(general_margin+general_padding+weixin_icon_height, (80-43)/2+15+13, screen_width-weixin_icon_height, 15)];
    subLabel.backgroundColor = [UIColor clearColor];
    subLabel.font = [UIFont systemFontOfSize:default_font_size];
    subLabel.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
    subLabel.text = paymentType.subName;
    [cell addSubview:subLabel];
    
    
    // 选中状态
//    UIImageView *selectImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_my_alipay_select_pre"]];
//    float y = (80 - selectImgView.image.size.width)/2;
//    selectImgView.frame = CGRectMake(screen_width-selectImgView.image.size.width-general_padding, y, selectImgView.image.size.width, selectImgView.image.size.width);
//    selectImgView.tag = 6;
//    [cell.contentView addSubview:selectImgView];
//    if ([self.paymentType.paymentTypeName isEqualToString:paymentType.paymentTypeName]) {
//        selectImgView.image = [UIImage imageNamed:@"icon_my_alipay_select_pre"];
//        
//    }else{
//        selectImgView.image = [UIImage imageNamed:@"icon_my_alipay_select_nor"];
//    }
    
    UIView *downSpliteLine = [[UIView alloc] initWithFrame:CGRectMake(0, 80-splite_line_height, screen_width, splite_line_height)];
    downSpliteLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
//    if (indexPath.row == paymentTypes.count-1) { // 最后一个cell的下分隔线
        [cell.contentView addSubview:downSpliteLine];
//    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //获的当前选择项
    self.paymentType = paymentTypes[indexPath.row];
//    [self renderPaymentType];
    NSLog(@">>>>>>>>>>>>>>>>>>%@",self.paymentType.paymentTypeName);
    if ([self.type isEqualToString:account_session_from_project_order_vc]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"传递支付方式" object:self.paymentType.paymentTypeName];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"传递预约医生支付方式" object:self.paymentType.paymentTypeName];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void) renderPaymentType{
    NSIndexPath *indexPath = nil;
    for (int i=0 ; i<paymentTypes.count ; i++) {
        PaymentType *paymentType = paymentTypes[i];
        indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        UIImageView *selectedImage = (UIImageView *)[cell viewWithTag:selected_payment_icon];
        if ([self.paymentType.paymentTypeName isEqualToString:paymentType.paymentTypeName]) {
            selectedImage.image = [UIImage imageNamed:@"icon_my_alipay_select_pre"];
        }else{
            selectedImage.image = [UIImage imageNamed:@"icon_my_alipay_select_nor"];
        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
