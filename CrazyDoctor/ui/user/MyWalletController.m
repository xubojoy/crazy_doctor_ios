//
//  MyWalletController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/20.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "MyWalletController.h"
#import "MyWalletCommonCell.h"
#import "RechargeViewController.h"
#import "UserWithdrawController.h"
#import "UserStore.h"
#import "WalletRecordontroller.h"
@interface MyWalletController ()

@end

@implementation MyWalletController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@">>>>>>>>>>>>>>支付成功后会不会走着>>>>>>>>>>>>>>>>>>>");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadUserAccountData) name:@"重新加载我的钱包页" object:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    [self setRightSwipeGestureAndAdaptive];
    self.view.autoresizesSubviews = NO;
    [self initHeadView];
    [self initTableView];
    [self loadUserAccountData];
    
}

#pragma mark - 初始化自定义View

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"我的钱包" navigationController:self.navigationController];
    [self.view addSubview:self.headerView];
}

- (void)loadUserAccountData{
    [UserStore getUserAccount:^(UserAccount *userAccount, NSError *err) {
        NSLog(@">>>>>>>userAccount>>>>>>%@",userAccount);
        if (userAccount != nil) {
            self.userAccount = userAccount;
        }
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

//初始化tableview
-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width,screen_height-self.headerView.frame.size.height) style:UITableViewStylePlain];
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
        static NSString *indetifierId = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indetifierId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indetifierId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
            float height = (screen_width*172)/750;
            self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, height)];
            self.bgImageView.image = [UIImage imageNamed:@"bg_evaluate_publish"];
            self.bgImageView.userInteractionEnabled = YES;
            [cell.contentView addSubview:self.bgImageView];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, (height-50)/2, 150, 20)];
            titleLabel.text = @"钱包余额";
            titleLabel.font = [UIFont systemFontOfSize:default_font_size];
            titleLabel.textColor = [ColorUtils colorWithHexString:@"#333333"];
            [self.bgImageView addSubview:titleLabel];
            
            self.amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, (height-50)/2+20, screen_width-70, 30)];
            NSString *amountStr = [NSString stringWithFormat:@"¥ %.2f",self.userAccount.balance];
            
            NSLog(@">>>>>>>取整数部分>>>>>%d",(int)self.userAccount.balance);
            self.amountLabel.font = [UIFont boldSystemFontOfSize:default_font_size];
            self.amountLabel.textColor = [ColorUtils colorWithHexString:lighter_2_brown_color];
            int start = (int)[amountStr rangeOfString:[NSString stringWithFormat:@"%d",(int)self.userAccount.balance]].location;
            NSLog(@">>>>>>>>>>开始位置>>>>>>>>>%d",start);
            int length = (int)[amountStr rangeOfString:[NSString stringWithFormat:@"%d",(int)self.userAccount.balance]].length;
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:amountStr];
            [attributedText addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:bigger_2_font_size] range:NSMakeRange(start,length)];
            self.amountLabel.attributedText = attributedText;
            [self.bgImageView addSubview:self.amountLabel];
            
            UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(screen_width-15-20, (height-20)/2, 20, 20)];
            arrowImgView.image = [UIImage imageNamed:@"icon_arrow"];
            [self.bgImageView addSubview:arrowImgView];
            
            UILabel *recordLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width-15-20-100, 0, 100, height)];
            recordLabel.text = @"记录";
            recordLabel.font = [UIFont systemFontOfSize:default_font_size];
            recordLabel.textAlignment = NSTextAlignmentRight;
            [self.bgImageView addSubview:recordLabel];

        }
        return cell;
        
    }else if (indexPath.section == 1) {
        static NSString *userCenterCommonCellIdentifier = @"chongzhiCommonCell";
        UINib *nib = [UINib nibWithNibName:@"MyWalletCommonCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:userCenterCommonCellIdentifier];
        MyWalletCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:userCenterCommonCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell renderUserCenterCommonCellWithIcon:@"icon_mine_recharge" withTitle:@"充值"];
        return cell;
    }else{
        static NSString *userCenterCommonCellIdentifier = @"tixianCommonCell";
        UINib *nib = [UINib nibWithNibName:@"MyWalletCommonCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:userCenterCommonCellIdentifier];
        MyWalletCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:userCenterCommonCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell renderUserCenterCommonCellWithIcon:@"icon_mine_withdraw_deposit" withTitle:@"提现"];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return (screen_width*172)/750;
    }else{
        return 50;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section != 0) {
        UIView *headerView = [[UIView alloc] init];
        headerView.frame = CGRectMake(0, 0, screen_width, general_padding);
        headerView.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
        return headerView;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 10;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        NSString *url = [NSString stringWithFormat:@"%@/walletRecord?Authorization=%@&isAppOpen=1&noHeaderFlag=1&noLocationFlag=0",[AppStatus sharedInstance].wxpubUrl,[AppStatus sharedInstance].user.accessToken];
        WalletRecordontroller *wrvc = [[WalletRecordontroller alloc] initWithUrl:url];
        [self.navigationController pushViewController:wrvc animated:YES];
    }else if (indexPath.section == 1) {
        RechargeViewController *rvc = [[RechargeViewController alloc] initWithAccountBalance:self.userAccount.balance];
        [self.navigationController pushViewController:rvc animated:YES];
    }else if(indexPath.section == 2){
        UserWithdrawController *uwvc = [[UserWithdrawController alloc] initWithWithdrawAccountBalance:self.userAccount.balance];
        [self.navigationController pushViewController:uwvc animated:YES];
    }
}

- (void)recordBtnClick{
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
