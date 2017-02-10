//
//  CheckDiagnosisEyesController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/29.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "CheckDiagnosisEyesController.h"
#import "EyesDiagnosisStore.h"
@interface CheckDiagnosisEyesController ()

@end

@implementation CheckDiagnosisEyesController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUI) name:@"刷新眼诊脏器数据" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    self.eyePositionSelectArray = [NSMutableArray new];
    
    [self loadData];
}



- (void)loadData{
    [SVProgressHUD showWithStatus:@"数据加载中..." maskType:SVProgressHUDMaskTypeClear];
    [EyesDiagnosisStore getUserEyesDiagnosesLaterRecord:^(NSDictionary *dict, NSError *err) {
        [SVProgressHUD dismiss];
        if (dict != nil) {
            self.eyeDiagnoseRecord = [[EyeDiagnoseRecord alloc] initWithDictionary:dict error:nil];
            if (self.eyeDiagnoseRecord.eyePositions.count > 0) {
                [self.eyePositionSelectArray removeAllObjects];
                for (NSDictionary *dic in self.eyeDiagnoseRecord.eyePositions) {
                    self.eyePosition = [[EyePosition alloc] initWithDictionary:dic error:nil];
                    if (self.eyePosition != nil) {
                        [self.eyePositionSelectArray addObject:self.eyePosition];
                    }
                }
            }
            [self initTopReCheckView];
            [self initTableView];
        }else{
            ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
            [self.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
            [self initCustomEmptyView];
        }
        [self.tableView reloadData];
    }];
}

- (void)initTopReCheckView{
    self.topEyeReCheckView = [[TopReCheckView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 55)];
    self.topEyeReCheckView.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    NSString *lastTime = [DateUtils dateWithStringFromLongLongInt:self.eyeDiagnoseRecord.createTime];
    [self.topEyeReCheckView renderTopReCheckView:lastTime];
    self.topEyeReCheckView.delegate = self;
    [self.view addSubview:self.topEyeReCheckView];
}

//一日照三照，有病早知道，快来自拍舌诊吧
//司外而揣内，协助眼诊为您观眼知健康
- (void)initCustomEmptyView{
    self.customEmptyView = [[CustomEmptyView alloc] initWithFrame:CGRectMake(0, (screen_height-200-64-40-51)/2, screen_width, 200) withTitle:@"司外而揣内，协助眼诊为您观眼知健康" withUnderLineTitle:@"协助眼诊" color:light_gray_text_color withLineColor:lighter_2_brown_color font:smaller_font_size withLineFont:small_font_size];
    self.customEmptyView.delegate = self;
    self.customEmptyView.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    [self.view addSubview:self.customEmptyView];
}

//初始化tableview
-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topEyeReCheckView.frame.size.height, screen_width,screen_height-self.topEyeReCheckView.frame.size.height-general_height-64-tabbar_height) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [ColorUtils colorWithHexString:white_text_color];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    //
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView.mj_header endRefreshing];
    });
}


#pragma mark - tableViewDelegate and datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.eyePositionSelectArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *diagnosisEyesResultCellIdentifier = @"diagnosisEyesResultCell";
    UINib *nib = [UINib nibWithNibName:@"DiagnosisEyesResultCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:diagnosisEyesResultCellIdentifier];
    DiagnosisEyesResultCell *cell = [tableView dequeueReusableCellWithIdentifier:diagnosisEyesResultCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.eyePositionSelectArray.count > 0) {
        EyePosition *position = self.eyePositionSelectArray[indexPath.row];
        [cell renderDiagnosisEyesResultCellWithEyePosition:position row:indexPath.row];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 49)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIView *leftLine = [[UIView alloc] initWithFrame:CGRectMake(general_margin, (49-13)/2, 3, 13)];
    leftLine.backgroundColor = [ColorUtils colorWithHexString:common_app_text_color];
    [headerView addSubview:leftLine];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, screen_width-30, 49)];
    titleLabel.text = @"根据您的选择请注意以下脏腑的调理";
    titleLabel.font = [UIFont boldSystemFontOfSize:default_1_font_size];
    titleLabel.textColor = [ColorUtils colorWithHexString:common_app_text_color];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:titleLabel];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 49;
}

- (void)didreCheckBtnClick:(UIButton *)sender{
    NSLog(@">>>>>>>>>>>>>点击了重新检查");
    if ([self.delegate respondsToSelector:@selector(didreCheckDiagnosisEyesBtnClick:)]) {
        [self.delegate didreCheckDiagnosisEyesBtnClick:sender];
    }
    //    CrazyDoctorTabbar *tabBar = [(AppDelegate *)[UIApplication sharedApplication].delegate tabbar];
    //    ReadyForTongueDiagnosisController *rdvc = [[ReadyForTongueDiagnosisController alloc] init];
    //    [self.rootNaviVCR pushViewController:rdvc animated:YES];
}

#pragma mark - CustomEmptyViewDelegate
- (void)didCustomEmptyBtnClick:(UIButton *)sender{
    NSLog(@">>>>>点击无>>>>>>>>>>");
    if ([self.delegate respondsToSelector:@selector(didreCheckDiagnosisEyesEmptyBtnClick:)]) {
        [self.delegate didreCheckDiagnosisEyesEmptyBtnClick:sender];
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
