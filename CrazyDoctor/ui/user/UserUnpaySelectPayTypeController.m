//
//  UserUnpaySelectPayTypeController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/8/3.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "UserUnpaySelectPayTypeController.h"
#import "RechargeCommonCell.h"
#import "UserStore.h"
#import "PayProcessor.h"
#import "WeiXinPayProcessor.h"
#import "OrderStore.h"
#import "MyOrdersController.h"
#define select_icon_x 285
#define weixin_icon_height     34
#define selected_payment_icon     6
#define pay_type_label_y         17
@interface UserUnpaySelectPayTypeController ()
{
    NSMutableArray *paymentTypes;
}

@end

@implementation UserUnpaySelectPayTypeController
- (instancetype)initWithId:(int)orderId orderType:(NSString *)orderType orderNumber:(NSString *)orderNumber{
    self = [super init];
    if (self) {
        self.orderId = orderId;
        self.orderType = orderType;
        self.orderNumber = orderNumber;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    [self setRightSwipeGestureAndAdaptive];
    self.isClick = NO;
    [self initHeadView];
    [self initTableView];
    [self initBottomBtnView];
    paymentTypes = [[PayProcessor sharedInstance] getPaymentTypes];
    
    self.paymentType = [[PaymentType alloc] initWithName:WALLET_PAYMENT paymentTypeIcon:@"icon_select_belt" subName:@""];
    [paymentTypes addObject:self.paymentType];

    
    self.paymentType = [[PayProcessor sharedInstance] getDefaultPaymentType];
    
    NSLog(@">>>>>>>>>self.orderType>>>>>>>>%@",self.orderType);
    if ([self.orderType isEqualToString:project_order_detail]) {
        [self loadProjectOrderData];
    }else{
        [self loadDoctorOrderData];
    }
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"选择支付方式" navigationController:self.navigationController];
    [self.view addSubview:self.headerView];
}


- (void)loadProjectOrderData{
    [UserStore getProjectOrderById:^(ProjectOrder *projectOrder, NSError *error) {
        if (error == nil) {
            self.projectOrder = projectOrder;
        }
    } projectOrderIdArray:@[@(self.orderId)]];

}

- (void)loadDoctorOrderData{
    [UserStore getDoctorOrderById:^(DoctorOrder *doctorOrder, NSError *error) {
        if (error == nil) {
            self.doctorOrder = doctorOrder;
        }
    } doctorOrderIdArray:[NSArray arrayWithObject:@(self.orderId)]];
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
//    rightLabel.frame = CGRectMake(general_margin+general_padding+weixin_icon_height, (80-43)/2, screen_width-weixin_icon_height, 15);
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
    UIImageView *selectImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_my_alipay_select_pre"]];
    float y = (80 - selectImgView.image.size.width)/2;
    selectImgView.frame = CGRectMake(screen_width-selectImgView.image.size.width-general_padding, y, selectImgView.image.size.width, selectImgView.image.size.width);
    selectImgView.tag = 6;
    [cell.contentView addSubview:selectImgView];
    if ([self.paymentType.paymentTypeName isEqualToString:paymentType.paymentTypeName]) {
        selectImgView.image = [UIImage imageNamed:@"icon_my_alipay_select_pre"];
        
    }else{
        selectImgView.image = [UIImage imageNamed:@"icon_my_alipay_select_nor"];
    }
    
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
    [self renderPaymentType];
    NSLog(@">>>>>>>>>>>>>>>>>>%@",self.paymentType.paymentTypeName);
    
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


- (void)initBottomBtnView{
    UIView *upLine = [[UIView alloc] initWithFrame:CGRectMake(0, screen_height-59, screen_width, splite_line_height)];
    upLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
    [self.view addSubview:upLine];
    
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.confirmBtn.frame = CGRectMake(general_margin, screen_height-7-45, screen_width-2*general_margin, 45);
    UIImage *hightLightImage = [UIImage imageNamed:@"btn_login_pre"];
    [self.confirmBtn setBackgroundImage:[ImageUtils resizableBgImage:hightLightImage] forState:UIControlStateNormal];
    [self.confirmBtn setBackgroundImage:[ImageUtils resizableBgImage:hightLightImage] forState:UIControlStateHighlighted];
    [self.confirmBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.confirmBtn.titleLabel setFont:[UIFont systemFontOfSize:bigger_font_size]];
    [self.confirmBtn addTarget:self action:@selector(confirmOrderBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.confirmBtn];
}

- (void)confirmOrderBtnClick{
    NSLog(@">>>>>>>>>>>>>>>>>>%@",self.paymentType.paymentTypeName);
    if ([self.orderType isEqualToString:project_order_detail]) {
        PayProcessor *payProcessor = [PayProcessor sharedInstance];
        if ([self.paymentType.paymentTypeName isEqualToString:TEN_PAYMENT]) {
            WeiXinPayProcessor * wxpay = [WeiXinPayProcessor sharedInstance];
            wxpay.delegate = payProcessor;
            [wxpay doWeixinpay:@"疯狂太医" outTradeNo:self.projectOrder.orderNo totalPrice:self.projectOrder.orderPrice buyer:[AppStatus sharedInstance].user.name tradeType:@"APP" type:type_project navigationController:self.navigationController];
        }else if([self.paymentType.paymentTypeName isEqualToString:ALI_APP_PAYMENT]){
            AlipayProceessor *ap = [AlipayProceessor sharedInstance];
            AlixPayOrder *payOrder = [ap buildAlixPayOrderByProjectOrder:self.projectOrder type:type_project subject:self.projectOrder.projectName];
            [ap doAlipay:payOrder paymentType:self.paymentType.paymentTypeName type:type_project navigationController:self.navigationController];
        }else{
            [OrderStore payUserProjectOrderByorderNumber:^(NSDictionary *projectDict, NSError *err) {
                if (err == nil) {
                    [self popSuccessView];
                }else{
                    ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
                    [self.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
                }
            } projectOrderNumber:self.orderNumber];
        }
    }else{
        PayProcessor *payProcessor = [PayProcessor sharedInstance];
        if ([self.paymentType.paymentTypeName isEqualToString:TEN_PAYMENT]) {
            WeiXinPayProcessor * wxpay = [WeiXinPayProcessor sharedInstance];
            wxpay.delegate = payProcessor;
            [wxpay doWeixinpay:@"疯狂太医" outTradeNo:self.doctorOrder.orderNo totalPrice:self.doctorOrder.orderPrice buyer:[AppStatus sharedInstance].user.name tradeType:@"APP" type:type_doctor navigationController:self.navigationController];
        }else if([self.paymentType.paymentTypeName isEqualToString:ALI_APP_PAYMENT]){
            AlipayProceessor *ap = [AlipayProceessor sharedInstance];
            AlixPayOrder *payOrder = [ap buildAlixPayOrderByDoctorOrder:self.doctorOrder type:type_doctor subject:@"预约医生"];
            [ap doAlipay:payOrder paymentType:self.paymentType.paymentTypeName type:type_doctor navigationController:self.navigationController];
        }else{
            [OrderStore payUserDoctorOrderByorderNumber:^(NSDictionary *doctorDict, NSError *err) {
                if (err == nil) {
                    [self popSuccessView];
                }else{
                    ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
                    [self.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
                }
            } doctorOrderNumber:self.orderNumber];
            
        }
    }
}


- (void)popSuccessView{
    self.popUpView = [[PopUpView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    [self.view addSubview:self.popUpView];
    
    self.xbPopView = [[XbPopView alloc] initWithFrame:CGRectMake((screen_width-280)/2, 205, 280, 155) remindImg:@"bg_word_subscribe_success"];
    self.xbPopView.userInteractionEnabled = YES;
    self.xbPopView.delegate = self;
    if (self.isClick == NO) {
        [self performSelector:@selector(didCancelBtnClick:) withObject:nil afterDelay:3.0f];
    }
    
    //下拉动画
    [UIView animateWithDuration:0.2 animations:^{
        self.xbPopView.center =  CGPointMake(screen_width/2, screen_height/2);
    }];
    [self.view addSubview:self.xbPopView];
    [self.view bringSubviewToFront:self.xbPopView];
    
}

- (void)didCancelBtnClick:(UIButton *)sender{
    self.isClick = YES;
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(didCancelBtnClick:) object:nil];
    [self.popUpView removeFromSuperview];
    [self.xbPopView removeFromSuperview];
    [self.navigationController popToRootViewControllerAnimated:NO];
    CrazyDoctorTabbar *tabBar = [(AppDelegate*)[UIApplication sharedApplication].delegate tabbar];
    [tabBar.tabBarController setSelectedIndex:tabbar_item_index_me];
    
    UINavigationController *navController = [tabBar getSelectedViewController];
    NSString *url;
    if ([self.orderType isEqualToString:project_order_detail]) {
       url = [NSString stringWithFormat:@"%@/myOrders?Authorization=%@&isAppOpen=1&noHeaderFlag=1&noLocationFlag=0&orderType=projects",[AppStatus sharedInstance].wxpubUrl,[AppStatus sharedInstance].user.accessToken];
    }else{
        url = [NSString stringWithFormat:@"%@/myOrders?Authorization=%@&isAppOpen=1&noHeaderFlag=1&noLocationFlag=0&orderType=doctors",[AppStatus sharedInstance].wxpubUrl,[AppStatus sharedInstance].user.accessToken];
    }
    MyOrdersController *mcvc = [[MyOrdersController alloc] initWithUrl:url];
    [navController pushViewController:mcvc animated:YES];
    [tabBar.tabBarController setTabBarHidden:YES animated:YES];
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
