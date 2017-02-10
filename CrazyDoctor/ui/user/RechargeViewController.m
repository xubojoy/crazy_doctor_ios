//
//  RechargeViewController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/6/27.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "RechargeViewController.h"
#import "RechargeCommonCell.h"
#import "UserStore.h"
#import "PayProcessor.h"
#import "WeiXinPayProcessor.h"
#define select_icon_x 285
#define weixin_icon_height     34
#define selected_payment_icon     6
#define pay_type_label_y         17
@interface RechargeViewController ()
{
    NSArray *paymentTypes;
}
@end

@implementation RechargeViewController
- (instancetype)initWithAccountBalance:(float)balance{
    self = [super init];
    if (self) {
        self.balance = balance;
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@">>>>>>>>>>>>>>支付成功后会不会走着>>>>>>>>>>>>>>>>>>>");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payResultPop) name:@"重新加载我的钱包页" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    [self setRightSwipeGestureAndAdaptive];
    [self initHeadView];
    [self initTableView];
    [self initBottomBtnView];
    paymentTypes = [[PayProcessor sharedInstance] getPaymentTypes];
    self.paymentType = [[PayProcessor sharedInstance] getDefaultPaymentType];
}
//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"充值" navigationController:self.navigationController];
    [self.view addSubview:self.headerView];
}

//初始化tableview
-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width,screen_height-self.headerView.frame.size.height-59) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark - tableViewDelegate and datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *chongzhiAccountCommonCellIdentifier = @"chongzhiAccountCommonCell";
            UINib *nib = [UINib nibWithNibName:@"RechargeCommonCell" bundle:nil];
            [self.tableView registerNib:nib forCellReuseIdentifier:chongzhiAccountCommonCellIdentifier];
            RechargeCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:chongzhiAccountCommonCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSString *telNo = [[AppStatus sharedInstance].user.mobileNo stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            [cell renderRechargeCommonCellWithTitle:@"充值账户" titleColor:[ColorUtils colorWithHexString:gray_text_color] content:telNo placeholder:@"" showLine:YES userEnable:NO];
            return cell;
        }else if (indexPath.row == 1){
            static NSString *accountBalanceCommonCellIdentifier = @"accountBalanceCommonCell";
            UINib *nib = [UINib nibWithNibName:@"RechargeCommonCell" bundle:nil];
            [self.tableView registerNib:nib forCellReuseIdentifier:accountBalanceCommonCellIdentifier];
            RechargeCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:accountBalanceCommonCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell renderRechargeCommonCellWithTitle:@"账户余额" titleColor:[ColorUtils colorWithHexString:gray_text_color] content:[NSString stringWithFormat:@"%.2f元",self.balance] placeholder:@"" showLine:YES userEnable:NO];
            return cell;
        }
        else{
            static NSString *chongzhiAmountCommonCellIdentifier = @"chongzhiAmountCommonCell";
            UINib *nib = [UINib nibWithNibName:@"RechargeCommonCell" bundle:nil];
            [self.tableView registerNib:nib forCellReuseIdentifier:chongzhiAmountCommonCellIdentifier];
            RechargeCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:chongzhiAmountCommonCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell renderRechargeCommonCellWithTitle:@"充值金额" titleColor:[ColorUtils colorWithHexString:common_app_text_color] content:@"" placeholder:@"请输入充值金额" showLine:NO userEnable:YES];
            self.amountTextField = cell.contentField;
            self.amountTextField.keyboardType = UIKeyboardTypeNumberPad;
            self.amountTextField.delegate = self;
            [cell.contentField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
            return cell;
        }
       
    }else{
        if (indexPath.row == 0) {
            static NSString *userCenterCommonCellIdentifier = @"fangshiCommonCell";
            UINib *nib = [UINib nibWithNibName:@"RechargeCommonCell" bundle:nil];
            [self.tableView registerNib:nib forCellReuseIdentifier:userCenterCommonCellIdentifier];
            RechargeCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:userCenterCommonCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell renderRechargeCommonCellWithTitle:@"支付方式" titleColor:[ColorUtils colorWithHexString:gray_text_color] content:@"" placeholder:@"" showLine:YES userEnable:NO];
            return cell;
        }else{
        
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            PaymentType *paymentType = paymentTypes[indexPath.row-1];
            
            // 渲染支付图标
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(general_margin, (80 - weixin_icon_height)/2, weixin_icon_height, weixin_icon_height)];
            image.image = [UIImage imageNamed:paymentType.paymentTypeIcon];
            [cell addSubview:image];
            
            // 渲染支付名称
            UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(general_margin+general_padding+weixin_icon_height, (80-43)/2, screen_width-weixin_icon_height, 15)];
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
            if (indexPath.row == paymentTypes.count-1) { // 最后一个cell的下分隔线
                [cell.contentView addSubview:downSpliteLine];
            }
            return cell;

        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 1 || indexPath.row == 2) {
            return 80;
        }else{
            return 50;
        }
    }else{
        return 50;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, screen_width, general_padding);
    headerView.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //获的当前选择项
    if (indexPath.section == 1) {
        if (indexPath.row != 0) {
            self.paymentType = [[PayProcessor sharedInstance] getPaymentTypes][indexPath.row-1];
            [self renderPaymentType];
        }
        NSLog(@">>>>>>>>>>>>>>>>>>%@",self.paymentType.paymentTypeName);
    }
}

-(void) renderPaymentType{
    NSIndexPath *indexPath = nil;
    for (int i=0 ; i<[[PayProcessor sharedInstance] getPaymentTypes].count ; i++) {
        PaymentType *paymentType = [[PayProcessor sharedInstance] getPaymentTypes][i];
        indexPath = [NSIndexPath indexPathForRow:i+1 inSection:1];
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
    
    self.rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rechargeBtn.frame = CGRectMake(general_margin, screen_height-7-45, screen_width-2*general_margin, 45);
    UIImage *hightLightImage = [UIImage imageNamed:@"btn_login_pre"];
    [self.rechargeBtn setBackgroundImage:[ImageUtils resizableBgImage:hightLightImage] forState:UIControlStateNormal];
    [self.rechargeBtn setBackgroundImage:[ImageUtils resizableBgImage:hightLightImage] forState:UIControlStateHighlighted];
    [self.rechargeBtn setTitle:@"立即充值" forState:UIControlStateNormal];
    [self.rechargeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rechargeBtn.titleLabel setFont:[UIFont systemFontOfSize:bigger_font_size]];
    [self.rechargeBtn addTarget:self action:@selector(rechargeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rechargeBtn];
}

-(void)textFieldDidChanged:(UITextField *)textField
{
    
    if (textField == self.amountTextField) {
        
        NSLog(@">>>>>self.price>>>>>>>>>%f",self.price);
        if ([self.amountTextField.text floatValue] > 5000) {
            self.amountTextField.text = [self.amountTextField.text substringToIndex:(int)self.amountTextField.text.length-1];
            self.price = [self.amountTextField.text floatValue];
            [self.view makeToast:@"金额不能大于5000" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(screen_width/2, 200)]];
            return;
        }else{
            self.price = [self.amountTextField.text floatValue];
        }
        
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.amountTextField) {
        //如果输入的是“.”  判断之前已经有"."或者字符串为空
        if ([string isEqualToString:@"."] && ([textField.text rangeOfString:@"."].location != NSNotFound || [textField.text isEqualToString:@""])) {
            return NO;
        }
        //拼出输入完成的str,判断str的长度大于等于“.”的位置＋4,则返回false,此次插入string失败 （"379132.424",长度10,"."的位置6, 10>=6+4）
        NSMutableString *str = [[NSMutableString alloc] initWithString:textField.text];
        [str insertString:string atIndex:range.location];
        if (str.length >= [str rangeOfString:@"."].location+4){
            return NO;
        }
    }
    return YES;
}

- (void)rechargeBtnClick{
    NSLog(@">>>>>>>>>>>>>>%f",self.price);
    if (self.price <= 0) {
        [self.view makeToast:@"金额须大于0" duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        return;
    }
    
    [UserStore userAccountRecharges:^(UserAccountRecharge *userAccountRecharge, NSError *err) {
        if (err == nil) {
            NSLog(@">>>>>>>>userAccountRechargeuserAccountRechargeuserAccountRechargeuserAccountRecharge：%@",userAccountRecharge);
            self.userAccountRecharge = userAccountRecharge;
            PayProcessor *payProcessor = [PayProcessor sharedInstance];
            if ([self.paymentType isTenPay]) {
                WeiXinPayProcessor * wxpay = [WeiXinPayProcessor sharedInstance];
                wxpay.delegate = payProcessor;
                [wxpay doWeixinpay:@"疯狂太医" outTradeNo:userAccountRecharge.orderNumber totalPrice:userAccountRecharge.price buyer:[AppStatus sharedInstance].user.name tradeType:@"APP" type:type_recharge navigationController:self.navigationController];
            }else{
                AlipayProceessor *ap = [AlipayProceessor sharedInstance];
                AlixPayOrder *payOrder = [ap buildAlixPayOrderByHdcOrder:userAccountRecharge type:type_recharge subject:@"充值"];
                [ap doAlipay:payOrder paymentType:self.paymentType.paymentTypeName type:type_recharge navigationController:self.navigationController];
            }

        }else{
            ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
            [self.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        }
    } price:self.price];
}

- (void)payResultPop{
    [self.navigationController popViewControllerAnimated:YES];
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
