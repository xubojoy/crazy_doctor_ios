//
//  DiagnosisEyesResultController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/29.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "DiagnosisEyesResultController.h"
#import "CrazyDoctorTabbar.h"
#import "AppDelegate.h"
#import "EyesDiagnosisStore.h"

@interface DiagnosisEyesResultController ()

@end
static NSString *diagnosisEyesResultCellIdentifier = @"diagnosisEyesResultCell";
@implementation DiagnosisEyesResultController
- (instancetype)initWithSelectLeftIdArray:(NSMutableArray *)leftPointIdArray rightIdArray:(NSMutableArray *)rightPointIdArray{
    self = [super init];
    if (self) {
        self.leftPointIdArray = leftPointIdArray;
        self.rightPointIdArray = rightPointIdArray;
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorUtils colorWithHexString:white_text_color];
    self.eyePositionSelectArray = [NSMutableArray new];
    self.eyeOrganArray = [NSMutableArray new];
    [self initUI];
    [self loadData];
}

- (void)initUI{
    [self initHeadView];
    [self initTopRemindLabelView];
    [self initTableView];
    [self initBottomBtnView];
}

- (void)loadData{
    
    NSLog(@">>>>>>>>>>>%@-----------%@",self.leftPointIdArray,self.rightPointIdArray);
    [SVProgressHUD showWithStatus:@"数据加载中..." maskType:SVProgressHUDMaskTypeBlack];
    [EyesDiagnosisStore confirmEyesDiagnoses:^(NSDictionary *dict, NSError *err) {
        [SVProgressHUD dismiss];
        if (dict != nil) {
            self.eyeDiagnoseRecord = [[EyeDiagnoseRecord alloc] initWithDictionary:dict error:nil];
            if (self.eyeDiagnoseRecord.eyePositions.count > 0) {
                [self.eyeOrganArray removeAllObjects];
                [self.eyePositionSelectArray removeAllObjects];
                for (NSDictionary *dic in self.eyeDiagnoseRecord.eyePositions) {
                    self.eyePosition = [[EyePosition alloc] initWithDictionary:dic error:nil];
                    if (self.eyePosition != nil) {
                        [self.eyePositionSelectArray addObject:self.eyePosition];
                        [self.eyeOrganArray addObject:self.eyePosition.organ];
                    }
                }
                AppStatus *as = [AppStatus sharedInstance];
                as.user.eyeTagNames = [self.eyeOrganArray componentsJoinedByString:@","];
                [AppStatus saveAppStatus];
            }
        }else{
            ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
            [self.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        }
        [self.tableView reloadData];
    } userLeftSelectPositions:self.leftPointIdArray userRightSelectPositions:self.rightPointIdArray userLeftEyeImageUrl:@"" userRightEyeImageUrl:@""];
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"眼诊结论" navigationController:self.navigationController];
    self.headerView.backBut.hidden = YES;
    [self.view addSubview:self.headerView];
}

- (void)initTopRemindLabelView{
    self.remindBgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width, 32)];
    self.remindBgView.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    [self.view addSubview:self.remindBgView];
    
    NSString *remindStr = @"根据您的选择请注意以下脏器的调理";
    self.remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screen_width-general_margin, 32)];
    self.remindLabel.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
    self.remindLabel.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    self.remindLabel.font = [UIFont systemFontOfSize:smaller_font_size];
    
    int start = (int)[remindStr rangeOfString:[NSString stringWithFormat:@"%@",@"脏器"]].location;
    int length = (int)[remindStr rangeOfString:[NSString stringWithFormat:@"%@",@"脏器"]].length;
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:remindStr];
    [attributedText addAttribute:NSForegroundColorAttributeName value:[ColorUtils colorWithHexString:common_app_text_color] range:NSMakeRange(start,length)];
    [attributedText addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:smaller_font_size] range:NSMakeRange(start,length)];
    self.remindLabel.attributedText = attributedText;
    self.remindLabel.textAlignment = NSTextAlignmentCenter;
    [self.remindBgView addSubview:self.remindLabel];
}

//初始化tableview
-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.remindBgView.frame.origin.y+self.remindBgView.frame.size.height+5, screen_width,screen_height-self.headerView.frame.size.height-self.remindBgView.frame.size.height-59-5) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [ColorUtils colorWithHexString:white_text_color];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib *nib = [UINib nibWithNibName:@"DiagnosisEyesResultCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:diagnosisEyesResultCellIdentifier];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.eyePositionSelectArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    DiagnosisEyesResultCell *cell = [tableView dequeueReusableCellWithIdentifier:diagnosisEyesResultCellIdentifier forIndexPath:indexPath];
    if (self.eyePositionSelectArray.count > 0) {
        EyePosition *position = self.eyePositionSelectArray[indexPath.section];
        [cell renderDiagnosisEyesResultCellWithEyePosition:position row:indexPath.section];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, general_padding)];
    headerView.backgroundColor = [UIColor whiteColor];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return general_padding;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)initBottomBtnView{
    UIView *upLine = [[UIView alloc] initWithFrame:CGRectMake(0, screen_height-59, screen_width, splite_line_height)];
    upLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
    [self.view addSubview:upLine];
    
    self.startImproveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.startImproveBtn.frame = CGRectMake(general_margin, screen_height-7-45, screen_width-2*general_margin, 45);
    //    UIImage *norImage = [UIImage imageNamed:@"btn_login_nor"];
    UIImage *hightLightImage = [UIImage imageNamed:@"btn_login_pre"];
    [self.startImproveBtn setBackgroundImage:[ImageUtils resizableBgImage:hightLightImage] forState:UIControlStateNormal];
    [self.startImproveBtn setBackgroundImage:[ImageUtils resizableBgImage:hightLightImage] forState:UIControlStateHighlighted];
    [self.startImproveBtn setTitle:@"开始改善" forState:UIControlStateNormal];
    [self.startImproveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.startImproveBtn.titleLabel setFont:[UIFont systemFontOfSize:bigger_font_size]];
    [self.startImproveBtn addTarget:self action:@selector(startImproveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.startImproveBtn];
}

#pragma mark - button method

- (void)startImproveBtnClick{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"开始改善" object:nil];
     NSArray *array = @[@"眼诊脏器"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"刷新眼诊脏器数据" object:array];
    CrazyDoctorTabbar *tabBar = [(AppDelegate*)[UIApplication sharedApplication].delegate tabbar];
    //将当前的视图堆栈pop到根视图
    if ([tabBar.tabBarController selectedIndex] != tabbar_item_index_jinnang) {
        UINavigationController *navController = [tabBar getSelectedViewController];
        [navController popToRootViewControllerAnimated:NO];
        [tabBar.tabBarController setSelectedIndex:tabbar_item_index_jinnang];
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
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
