//
//  UserWithdrawController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/6/27.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "UserWithdrawController.h"
#import "RechargeCommonCell.h"
#import "UserStore.h"
@interface UserWithdrawController ()

@end

@implementation UserWithdrawController
- (instancetype)initWithWithdrawAccountBalance:(float)balance{
    self = [super init];
    if (self) {
        self.balance = balance;
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
    [self initBottomBtnView];
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
    self.tableView.scrollEnabled = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark - tableViewDelegate and datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *userCenterCommonCellIdentifier = @"tixianCommonCell";
        UINib *nib = [UINib nibWithNibName:@"RechargeCommonCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:userCenterCommonCellIdentifier];
        RechargeCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:userCenterCommonCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell renderRechargeCommonCellWithTitle:@"提现金额" titleColor:[ColorUtils colorWithHexString:common_app_text_color] content:@"" placeholder:[NSString stringWithFormat:@"本次申请最多可提现%.2f",self.balance] showLine:NO userEnable:YES];
        cell.contentField.keyboardType = UIKeyboardTypeNumberPad;
        [cell.contentField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
        return cell;
    }else if (indexPath.section == 1){
        static NSString *userCenterCommonCellIdentifier = @"zhanghaoCommonCell";
        UINib *nib = [UINib nibWithNibName:@"RechargeCommonCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:userCenterCommonCellIdentifier];
        RechargeCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:userCenterCommonCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell renderRechargeCommonCellWithTitle:@"账号" titleColor:[ColorUtils colorWithHexString:common_app_text_color] content:@"" placeholder:@"请输入您的支付宝账号/手机号" showLine:NO userEnable:YES];
        [cell.contentField addTarget:self action:@selector(accountTextFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
        return cell;

    }else{
        static NSString *userCenterCommonCellIdentifier = @"nicknameCommonCell";
        UINib *nib = [UINib nibWithNibName:@"RechargeCommonCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:userCenterCommonCellIdentifier];
        RechargeCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:userCenterCommonCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell renderRechargeCommonCellWithTitle:@"昵称" titleColor:[ColorUtils colorWithHexString:common_app_text_color] content:@"" placeholder:@"请输入您的支付宝昵称" showLine:NO userEnable:YES];
        [cell.contentField addTarget:self action:@selector(nickNameTextFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] init];
    if (section != 0) {
        if (section == 1) {
            headerView.frame = CGRectMake(0, 0, screen_width, general_padding);
            
            UILabel *remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(general_margin, 0, screen_width-30, 36)];
            remindLabel.text = @"提现到支付宝";
            remindLabel.textAlignment = NSTextAlignmentLeft;
            remindLabel.font = [UIFont systemFontOfSize:default_2_font_size];
            [headerView addSubview:remindLabel];
            
        }else if (section == 2){
            headerView.frame = CGRectMake(0, 0, screen_width, general_padding);
        }
    }
    headerView.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 36;
    }else if (section == 2){
        return 10;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
}

- (void)initBottomBtnView{
    UIView *upLine = [[UIView alloc] initWithFrame:CGRectMake(0, screen_height-59, screen_width, splite_line_height)];
    upLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
    [self.view addSubview:upLine];
    
    self.withDrawBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.withDrawBtn.frame = CGRectMake(general_margin, screen_height-7-45, screen_width-2*general_margin, 45);
    UIImage *hightLightImage = [UIImage imageNamed:@"btn_login_pre"];
    [self.withDrawBtn setBackgroundImage:[ImageUtils resizableBgImage:hightLightImage] forState:UIControlStateNormal];
    [self.withDrawBtn setBackgroundImage:[ImageUtils resizableBgImage:hightLightImage] forState:UIControlStateHighlighted];
    [self.withDrawBtn setTitle:@"立即提现" forState:UIControlStateNormal];
    [self.withDrawBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.withDrawBtn.titleLabel setFont:[UIFont systemFontOfSize:bigger_font_size]];
    [self.withDrawBtn addTarget:self action:@selector(withDrawBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.withDrawBtn];
}

-(void)textFieldDidChanged:(UITextField *)textField
{
    self.withDrawPrice = [textField.text floatValue];
    NSLog(@">>>>>self.withDrawPrice>>>>>>>>>%f",self.withDrawPrice);
}

-(void)accountTextFieldDidChanged:(UITextField *)textField
{
    self.accountStr = textField.text;
    NSLog(@">>>>>self.accountStr>>>>>>>>>%@",self.accountStr);
}

-(void)nickNameTextFieldDidChanged:(UITextField *)textField
{
    self.nickNameStr = textField.text;
    NSLog(@">>>>>nickNameStr>>>>>>>>>%@",self.nickNameStr);
}


- (void)withDrawBtnClick{
    if (self.withDrawPrice <= 0) {
        [self.view makeToast:@"金额须大于0" duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        return;
    }else if (self.withDrawPrice > self.balance){
        [self.view makeToast:@"金额不能大于钱包余额" duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        return;
    }
    if (self.accountStr == nil || self.accountStr.length == 0) {
        [self.view makeToast:@"账号不能为空" duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        return;
    }
    
    if (self.accountStr == nil || self.accountStr.length == 0) {
        [self.view makeToast:@"昵称不能为空" duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        return;
    }
    [SVProgressHUD showWithStatus:@"提交中..." maskType:SVProgressHUDMaskTypeClear];
    [UserStore userAccountCashs:^(UserAccountCash *userAccountCash, NSError *err) {
        [SVProgressHUD dismiss];
        if (err == nil) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"重新加载我的钱包页" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
            [self.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        }
        
    } price:self.withDrawPrice accountNo:self.accountStr accountName:self.nickNameStr];
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
