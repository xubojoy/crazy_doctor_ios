//
//  DiscoverIndexController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/18.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "DiscoverIndexController.h"
#import "OrderPhysiotherapyController.h"
#import "SportViewController.h"
#import "GlucometerViewController.h"
#import "BloodPressureController.h"
@interface DiscoverIndexController ()


@end

@implementation DiscoverIndexController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [(AppDelegate*)[UIApplication sharedApplication].delegate tabbar].tabBarController.statusBarStyle = UIStatusBarStyleDefault;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initHeadView];
    [self initUI];
}

- (void)initUI{
    [self initTableView];
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"发现" navigationController:self.navigationController];
    self.headerView.backBut.hidden = YES;
    [self.view addSubview:self.headerView];
}

//初始化tableview
-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width,screen_height-tabbar_height-self.headerView.frame.size.height) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark - tableViewDelegate and datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *discoverIndexCellIdentifier = @"discoverIndexCell";
    UINib *nib = [UINib nibWithNibName:@"DiscoverIndexCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:discoverIndexCellIdentifier];
    DiscoverIndexCell *cell = [tableView dequeueReusableCellWithIdentifier:discoverIndexCellIdentifier forIndexPath:indexPath];
    if (indexPath.row == 0) {
        [cell renderDiscoverIndexCellWith:@"icon_discover_doctor" title:@"预约医生"];
    }else if (indexPath.row == 1){
        [cell renderDiscoverIndexCellWith:@"icon_discover_physcial_therapy_nor" title:@"预约理疗"];
    }else if (indexPath.row == 2){
        [cell renderDiscoverIndexCellWith:@"icon_discover_sport" title:@"运     动"];
    }
//    else if (indexPath.row == 3){
//        [cell renderDiscoverIndexCellWith:@"icon_discover_glucometer" title:@"血 糖 仪"];
//    }else if (indexPath.row == 4){
//        [cell renderDiscoverIndexCellWith:@"icon_discover_blood_pressure" title:@"血 压 计"];
//    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   AppStatus *as = [AppStatus sharedInstance];
    if (indexPath.row == 0) {
        NSURL *nsurl =[NSURL URLWithString:[NSString stringWithFormat:@"%@/doctors?noFooterFlag=0&noHeaderFlag=1&isAppOpen=1&Authorization=%@&longitude=%f&latitude=%f",[AppStatus sharedInstance].wxpubUrl,as.user.accessToken,as.lastLng,as.lastLat]];
        OrderPhysiotherapyController *opvc = [[OrderPhysiotherapyController alloc] initWithUrl:nsurl];
        [self.navigationController pushViewController:opvc animated:YES];
       
        
    }
    if (indexPath.row ==1) {
        NSURL *nsurl =[NSURL URLWithString:[NSString stringWithFormat:@"%@/projects?noFooterFlag=0&noHeaderFlag=1&isAppOpen=1&Authorization=%@&longitude=%f&latitude=%f",[AppStatus sharedInstance].wxpubUrl,as.user.accessToken,as.lastLng,as.lastLat]];
        OrderPhysiotherapyController *opvc = [[OrderPhysiotherapyController alloc] initWithUrl:nsurl];
        [self.navigationController pushViewController:opvc animated:YES];
       
    }else if (indexPath.row == 2){
        if (![AppStatus sharedInstance].logined) {
            UserLoginViewController *ulc = [[UserLoginViewController alloc] init];
            [self.navigationController pushViewController:ulc animated:YES];
            return ;
        }else{
            SportViewController *spvc = [[SportViewController alloc] init];
            [self.navigationController pushViewController:spvc animated:YES];
        }
    }
//    else if (indexPath.row == 3){
//        GlucometerViewController *spvc = [[GlucometerViewController alloc] init];
//        [self.navigationController pushViewController:spvc animated:YES];
//    }else if (indexPath.row == 4){
//        BloodPressureController *spvc = [[BloodPressureController alloc] init];
//        [self.navigationController pushViewController:spvc animated:YES];
//    }
}

- (void)didOrderPhysiotheraprBtnClick:(UIButton *)sender{
    DiscoverIndexCell *cell = (DiscoverIndexCell *)sender.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    AppStatus *as = [AppStatus sharedInstance];
    if (indexPath.row == 0) {
        NSURL *nsurl =[NSURL URLWithString:[NSString stringWithFormat:@"%@/doctors?noFooterFlag=0&noHeaderFlag=1&isAppOpen=1&Authorization=%@&longitude=%f&latitude=%f",[AppStatus sharedInstance].wxpubUrl,[AppStatus sharedInstance].user.accessToken,as.lastLng,as.lastLat]];
        OrderPhysiotherapyController *opvc = [[OrderPhysiotherapyController alloc] initWithUrl:nsurl];
        [self.navigationController pushViewController:opvc animated:YES];
    }
    if (indexPath.row ==1) {
        NSURL *nsurl =[NSURL URLWithString:[NSString stringWithFormat:@"%@/projects?noFooterFlag=0&noHeaderFlag=1&isAppOpen=1&Authorization=%@&longitude=%f&latitude=%f",[AppStatus sharedInstance].wxpubUrl,[AppStatus sharedInstance].user.accessToken,as.lastLng,as.lastLat]];
        OrderPhysiotherapyController *opvc = [[OrderPhysiotherapyController alloc] initWithUrl:nsurl];
        [self.navigationController pushViewController:opvc animated:YES];
    }else if (indexPath.row == 2){
        if (![AppStatus sharedInstance].logined) {
            UserLoginViewController *ulc = [[UserLoginViewController alloc] init];
            [self.navigationController pushViewController:ulc animated:YES];
            return ;
        }else{
            SportViewController *spvc = [[SportViewController alloc] init];
            [self.navigationController pushViewController:spvc animated:YES];
        }
    }
//    else if (indexPath.row == 3){
//        GlucometerViewController *spvc = [[GlucometerViewController alloc] init];
//        [self.navigationController pushViewController:spvc animated:YES];
//    }else if (indexPath.row == 4){
//        BloodPressureController *spvc = [[BloodPressureController alloc] init];
//        [self.navigationController pushViewController:spvc animated:YES];
//    }
    
}

-(NSString *)getPageName
{
    return page_name_discover;
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
