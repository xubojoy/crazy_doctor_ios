//
//  CheckTongueDiagnosisController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/29.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "CheckTongueDiagnosisController.h"
#import "TongueDiagnosisStore.h"
#import "ReadyForTongueDiagnosisController.h"
#import "CrazyDoctorTabbar.h"
#import "AppDelegate.h"
@interface CheckTongueDiagnosisController ()

@end

@implementation CheckTongueDiagnosisController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    self.bodyTagsArray = [NSMutableArray new];
    self.diagnoseQaRecordsJsonStrArray = [NSMutableArray new];
    self.userSelectDiagnoseQaRecordsJsonResultArray = [NSMutableArray new];
    [self loadTongueDiagnosisResultData];
}

- (void)loadTongueDiagnosisResultData{
    [SVProgressHUD showWithStatus:@"数据加载中..." maskType:SVProgressHUDMaskTypeClear];
    [TongueDiagnosisStore getUserTongueDiagnoses:^(NSDictionary *tongueDiagnoseDic, NSError *err) {
        [SVProgressHUD dismiss];
        if (tongueDiagnoseDic != nil) {
            self.tongueDiagnoseRecord = [[TongueDiagnoseRecord alloc] initWithDictionary:tongueDiagnoseDic error:nil];
//            NSLog(@">>>>>>>>tongueDiagnoseRecord>>>>>>>%@",self.tongueDiagnoseRecord.diagnoseQaRecordsJson);
            if (self.tongueDiagnoseRecord != nil) {
                [self.bodyTagsArray removeAllObjects];
                for (NSDictionary *bodyDict in self.tongueDiagnoseRecord.bodyTags) {
                    self.bodyTag = [[BodyTag alloc] initWithDictionary:bodyDict error:nil];
                    if (self.bodyTag != nil) {
                        [self.bodyTagsArray addObject:self.bodyTag];
                    }
                }
                if (self.tongueDiagnoseRecord.diagnoseQaRecords.count > 0) {
                    [self.diagnoseQaRecordsJsonStrArray removeAllObjects];
                    for (NSDictionary *diagnoseQaRecordDict in self.tongueDiagnoseRecord.diagnoseQaRecords) {
//                        NSLog(@">>>>>>>>1111111>>>>>>>%@",diagnoseQaRecordDict);
                        self.diagnoseQaRecord = [[DiagnoseQaRecord alloc] initWithDictionary:diagnoseQaRecordDict error:nil];
//                        NSLog(@">>>>>>>>self.bodyTag>>>>>>>%@",self.diagnoseQaRecord);
                        if (self.diagnoseQaRecord != nil) {
                            if ([NSStringUtils isNotBlank:self.diagnoseQaRecord.userSelectQuestions] && ![self.diagnoseQaRecord.userSelectQuestions isEqualToString:@"无"]) {
                                [self.diagnoseQaRecordsJsonStrArray addObject:self.diagnoseQaRecord.userSelectQuestions];
                            }
                        }
                    }
                    if (self.diagnoseQaRecordsJsonStrArray.count > 0) {
                        [self.userSelectDiagnoseQaRecordsJsonResultArray removeAllObjects];
                        NSString *jsonStr = [self.diagnoseQaRecordsJsonStrArray componentsJoinedByString:@";;"];
                        NSLog(@">>>>>>>jsonStr>>>>>>>>%@",jsonStr);
                        NSArray *jsonArray = [jsonStr componentsSeparatedByString:@";;"];
                        [self.userSelectDiagnoseQaRecordsJsonResultArray addObjectsFromArray:jsonArray];
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
    self.topReCheckView = [[TopReCheckView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 55)];
    self.topReCheckView.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    self.topReCheckView.delegate = self;
    NSString *lastTime = [DateUtils dateWithStringFromLongLongInt:self.tongueDiagnoseRecord.createTime];
    [self.topReCheckView renderTopReCheckView:lastTime];
    [self.view addSubview:self.topReCheckView];
}


//一日照三照，有病早知道，快来自拍舌诊吧
//司外而揣内，协助眼诊为您观眼知健康
- (void)initCustomEmptyView{
    self.customEmptyView = [[CustomEmptyView alloc] initWithFrame:CGRectMake(0, (screen_height-200-64-40-51)/2, screen_width, 200) withTitle:@"一日照三照，有病早知道，快来自拍舌诊吧" withUnderLineTitle:@"自拍舌诊" color:light_gray_text_color withLineColor:lighter_2_brown_color font:smaller_font_size withLineFont:small_font_size];
    self.customEmptyView.delegate = self;
    self.customEmptyView.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    [self.view addSubview:self.customEmptyView];
}


//初始化tableview
-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topReCheckView.frame.size.height, screen_width,screen_height-self.topReCheckView.frame.size.height-general_height-64-tabbar_height) style:UITableViewStylePlain];
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
        [self loadTongueDiagnosisResultData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView.mj_header endRefreshing];
    });
}

#pragma mark - tableViewDelegate and datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.bodyTagsArray.count;
    }else{
        return self.userSelectDiagnoseQaRecordsJsonResultArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *tongueDiagnosisResultCellIdentifier = @"tongueDiagnosisResultCell";
        UINib *nib = [UINib nibWithNibName:@"TongueDiagnosisResultCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:tongueDiagnosisResultCellIdentifier];
        TongueDiagnosisResultCell *cell = [tableView dequeueReusableCellWithIdentifier:tongueDiagnosisResultCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.bodyTagsArray.count > 0) {
            self.bodyTag = self.bodyTagsArray[indexPath.row];
            [cell renderTongueDiagnosisResultCell:self.bodyTag withSection:indexPath.row];
        }
        return cell;
        
    }else{
        static NSString *subhealthyProblemCellIdentifier = @"subhealthyProblemCell";
        UINib *nib = [UINib nibWithNibName:@"SubhealthyProblemCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:subhealthyProblemCellIdentifier];
        SubhealthyProblemCell *cell = [tableView dequeueReusableCellWithIdentifier:subhealthyProblemCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.userSelectDiagnoseQaRecordsJsonResultArray.count > 0) {
            NSString *titleStr = self.userSelectDiagnoseQaRecordsJsonResultArray[indexPath.row];
            BOOL firstRow = (indexPath.row == 0?YES:NO);
             BOOL lastRow = (indexPath.row == (self.userSelectDiagnoseQaRecordsJsonResultArray.count-1)?YES:NO);
            [cell renderSubhealthyProblemCell:titleStr showUpLine:firstRow showDownLine:lastRow];
        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return 30;
    }
    return 130;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 49)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIView *leftLine = [[UIView alloc] initWithFrame:CGRectMake(general_margin, (49-13)/2, 3, 13)];
    leftLine.backgroundColor = [ColorUtils colorWithHexString:common_app_text_color];
    [headerView addSubview:leftLine];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, screen_width-30, 49)];
    if (section == 0) {
        titleLabel.text = @"根据您的选择请注意以下问题的防范";
    }else{
        titleLabel.text = @"亚健康问题表现";
    }
    titleLabel.font = [UIFont boldSystemFontOfSize:default_1_font_size];
    titleLabel.textColor = [ColorUtils colorWithHexString:common_app_text_color];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:titleLabel];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 49;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section ==0) {
        self.bodyTag = self.bodyTagsArray[indexPath.row];
        [self popImageViewWithDetailImageUrl:self.bodyTag];
    }
}

- (void)popImageViewWithDetailImageUrl:(BodyTag *)bodyTag{
     UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.popUpView = [[PopUpView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    [window addSubview:self.popUpView];
    [window bringSubviewToFront:self.popUpView];
    
    self.detailImagView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 80, screen_width-50, ((screen_width-50)*93)/65)];
    [self.detailImagView sd_setImageWithURL:[NSURL URLWithString:bodyTag.detailImageUrl] placeholderImage:nil];
    self.detailImagView.userInteractionEnabled = YES;
    [window addSubview:self.detailImagView];
    [window bringSubviewToFront:self.detailImagView];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(screen_width-50-100, 0, 100, 100);
    self.cancelBtn.imageEdgeInsets = UIEdgeInsetsMake(-50, 0, 0, -50);
    [self.cancelBtn setImage:[UIImage imageNamed:@"icon_popup_abandon_cancel"] forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.detailImagView addSubview:self.cancelBtn];
}

- (void)cancelBtnClick{
    [self.popUpView removeFromSuperview];
    [self.detailImagView removeFromSuperview];
}

- (void)didreCheckBtnClick:(UIButton *)sender{
    NSLog(@">>>>>>>>>>>>>点击了重新检查");
    if ([self.delegate respondsToSelector:@selector(didreCheckTongueDiagnosisBtnClick:)]) {
        [self.delegate didreCheckTongueDiagnosisBtnClick:sender];
    }
}

#pragma mark - CustomEmptyViewDelegate
- (void)didCustomEmptyBtnClick:(UIButton *)sender{
    NSLog(@">>>>>点击无>>>>>>>>>>");
    if ([self.delegate respondsToSelector:@selector(didreCheckTongueDiagnosisEmptyBtnClick:)]) {
        [self.delegate didreCheckTongueDiagnosisEmptyBtnClick:sender];
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
