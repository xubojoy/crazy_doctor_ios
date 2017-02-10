//
//  IndexViewController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/3/31.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "IndexViewController.h"
#import "BAddressPickerController.h"
#import "FunctionUtils.h"
#import "PellTableViewSelect.h"
#import "ArticleDetailController.h"
#import "TongueDiagnosisResultController.h"
#import "PushSettingController.h"
#import "ReadyForTongueDiagnosisController.h"
#import "TongueDiagnosisStore.h"
#import "DiagnosisOnLeftEyesController.h"
#import "TongueDiagnosisCompareController.h"
#import "MeridianStore.h"
#import "CheckAcupointViewController.h"
#import "PushSettingController.h"
#import "MyArchivesViewController.h"
#import "BPush.h"
#import "UserStore.h"
#import "CommonDiseaseController.h"
#import "AppDelegate.h"
//#define isShow   1
@interface IndexViewController ()<BaddressPickerDelegate,BAddressPickerDataSource>

@end
@implementation IndexViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [(AppDelegate*)[UIApplication sharedApplication].delegate tabbar].tabBarController.statusBarStyle = UIStatusBarStyleDefault;
    debugMethod();
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshIndexUI) name:@"开始改善" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshIndexUI) name:notification_name_session_update object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshAcupointData:) name:@"刷新穴位" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAlertRemind) name:@"账号在另其他设备登陆" object:nil];
    //在这个页面即将出现的时候判断是否登录 再做相应的操作
   
    self.hour = [DateUtils getCurrentDateHour];
    NSDate *date = [NSDate date];
    NSString *nowStr = [DateUtils getDateByDate:date];
    NSArray *array = [nowStr componentsSeparatedByString:@" "];
    NSLog(@"date222222 = %@", array);
    NSString *datastr = array[0];
    int remarkNo = [FunctionUtils getRemarkNum:(int)self.hour];
    NSString *tmpDataStr = [NSString stringWithFormat:@"%@%d",datastr,remarkNo];
    if (![tmpDataStr isEqualToString:[AppStatus sharedInstance].remarkDataStr]) {
        NSLog(@"时间已变");
        [self loadTimeMeridianData];
        [AppStatus sharedInstance].remarkDataStr = tmpDataStr;
        [AppStatus sharedInstance].recommendAcupointTime = nowStr;
        [AppStatus saveAppStatus];
    }
    [self loadLocalReadArticleData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.autoresizesSubviews = NO;
    self.view.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    self.topBgView.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    self.bodyTagsArray = [NSMutableArray new];
    self.acupointArray = [NSMutableArray new];
    self.meridianArray = [NSMutableArray new];
    self.selectAcupointArray = [NSMutableArray new];
    self.hasReadArticles = [NSMutableSet new];
    self.meridianDictionary = [NSMutableDictionary new];
    self.currentPageNo = 1;
    self.currentTableViewStatus = table_view_status_waiting;
    [self transformEvent:event_init_load];

    self.hour = [DateUtils getCurrentDateHour];
    for (UIView *view in self.topBgView.subviews) {
        [view removeFromSuperview];
    }
    [self initHeadView];
    [self initLeftAddressBtn];
    [self initRightBtn];
    [self initTableView];
    [self initLoadingStatusView];
    [self loadDigData];
    [self loadTimeMeridianData];
}

- (void)showAlertRemind{
    [self.view makeToast:@"账号在另其他设备登陆！" duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
}


- (void)loadLocalReadArticleData{
    
    NSLog(@">>>>>hasReadArticleIds>>>>>%@",[AppStatus sharedInstance].hasReadArticleIds);
    self.hasReadArticles = [AppStatus sharedInstance].hasReadArticleIds;
    [self.tableView reloadData];
}

- (void)refreshIndexUI{
    for (UIView *view in self.topBgView.subviews) {
        [view removeFromSuperview];
    }
    
    self.currentPageNo = 1;
    self.currentTableViewStatus = table_view_status_waiting;
    [self transformEvent:event_init_load];
    [self loadDigData];
//    [self loadTimeMeridianData];
}

- (void)refreshAcupointData:(NSNotification *)notifi{
    NSLog(@">>>>>>>>>通知数据>>>>>>%@",notifi.object);
    self.notifiAcupointName = notifi.object;
    self.hour = [DateUtils getCurrentDateHour];
    NSDate *date = [NSDate date];
    NSString *nowStr = [DateUtils getDateByDate:date];
    NSArray *array = [nowStr componentsSeparatedByString:@" "];
//    NSLog(@"date222222 = %@", array);
    NSString *datastr = array[0];
    int remarkNo = [FunctionUtils getRemarkNum:(int)self.hour];
    NSString *tmpDataStr = [NSString stringWithFormat:@"%@%d",datastr,remarkNo];
    [self loadTimeMeridianData];
    [AppStatus sharedInstance].remarkDataStr = tmpDataStr;
    [AppStatus sharedInstance].recommendAcupointTime = nowStr;
    [AppStatus saveAppStatus];
}

-(void) initLoadingStatusView{
    self.lsv = [[LoadingStatusView alloc] initWithFrame:CGRectMake(0, (screen_height-loading_view_height)/2, screen_width, loading_view_height)];
    self.lsv.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    [self.lsv updateStatus:network_status_loading animating:YES];
}

- (void)loadDigData{
    //    [SVProgressHUD show];
    [TongueDiagnosisStore getUserTongueDiagnoses:^(NSDictionary *tongueDiagnoseDic, NSError *err) {
        //        [SVProgressHUD dismiss];
//        NSLog(@">>>>>>>tongueDiagnoseDic>>>>>>>>%@",tongueDiagnoseDic);
        if (tongueDiagnoseDic != nil) {
            self.tongueDiagnoseRecord = [[TongueDiagnoseRecord alloc] initWithDictionary:tongueDiagnoseDic error:nil];
            if (self.tongueDiagnoseRecord != nil) {
                [self.bodyTagsArray removeAllObjects];
                for (NSDictionary *bodyDict in self.tongueDiagnoseRecord.bodyTags) {
                    //                    NSLog(@">>>>>>>>>>>>>>>%@",bodyDict);
                    self.bodyTag = [[BodyTag alloc] initWithDictionary:bodyDict error:nil];
                    if (self.bodyTag != nil) {
                        NSLog(@">>>>>>>self.bodyTag.name>>>>>>>>%@",self.bodyTag.name);
                        [self.bodyTagsArray addObject:self.bodyTag.name];
                    }
                }
            }
            
        }
        [self loadUI];
    }];
}

- (void)loadUI{
    NSLog(@">>>>>self.bodyTagsArray>>>>>>>>>>%@",self.bodyTagsArray);
    if ([[AppStatus sharedInstance] logined]) {
        if (self.bodyTagsArray.count > 0) {
            if (self.bodyTagsArray.count == 1) {
                NSString *nameStr = self.bodyTagsArray[0];
                if ([NSStringUtils isNotBlank:nameStr] && [nameStr isEqualToString:@"平和"]) {
                    self.topBgConstraints.constant = 55;
                    [self initIndexTopGentleView];
                    
                }else{
                    self.topBgConstraints.constant = 71;
                    [self initIndexTopView];
                }
            }else{
                self.topBgConstraints.constant = 71;
                [self initIndexTopView];
            }
        }else{
            self.topBgConstraints.constant = 0;
        }
        
    }else{
        self.topBgConstraints.constant = 0;
    }
    
    [self.tableView reloadData];
}


- (void)loadData:(BOOL)reload{
    DateUtils *dateSession = [[DateUtils alloc] initWithDate:[NSDate date]];
    NSLog(@"当前月份 = %@", dateSession.session);
    
//    [SVProgressHUD show];
    [ArticleStore getAllIOSRecommendArticles:^(Page *page, NSError *error) {
//        [SVProgressHUD dismiss];
        if (page != nil) {
            if (reload) {
                self.recommendArticleArray = [NSMutableArray new];
            }
            NSLog(@">>>>>>>>总数>>>>>>>%d",page.totalCount);
            for (NSDictionary *dict in page.items) {
//                NSLog(@">>>>>>>>获取文章dict>>>>>>>%@",dict);
                self.recommendArticle = [[RecommendArticle alloc] initWithDictionary:dict error:nil];
//                NSLog(@">>>>>>>>获recommendArticle>>>>>>>%@",self.recommendArticle);
                if (self.recommendArticle != nil) {
                    [self.recommendArticleArray addObject:self.recommendArticle];
                }
            }
            BOOL hasNexPage = page.totalCount > (self.currentPageNo*common_page_size);
            if (hasNexPage) {
                [self transformEvent:event_load_complete_succes];
            }else{
                [self transformEvent:event_load_complete_over];
            }
        }else if(page == nil){
            [self transformEvent:event_load_complete_fail];
            ExceptionMsg *exception = [[error userInfo] objectForKey:@"ExceptionMsg"];
            [self.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        }
        [self.tableView reloadData];
    } city:[AppStatus sharedInstance].cityName pageNo:self.currentPageNo pageSize:common_page_size];
}


#pragma mark - 初始化自定义View

- (void)loadTimeMeridianData{
    [MeridianStore getMeridiansInfo:^(NSArray *meridiansArray, NSError *err) {
        if ([meridiansArray isKindOfClass:[NSArray class]]) {
            
            for (NSDictionary *dict in meridiansArray) {
                self.meridian = [[Meridian alloc] initWithDictionary:dict error:nil];
                if (self.meridian != nil) {
                    [self.meridianDictionary setObject:self.meridian.acupoints forKey:[NSString stringWithFormat:@"%d",self.meridian.beginTime]];
                }
            }
//            NSLog(@">>>>>>>>self.meridianDictionary>保存的字典>>>>>>>>>>>%@",self.meridianDictionary);
            [AppStatus sharedInstance].meridianDict = self.meridianDictionary;
            [AppStatus saveAppStatus];
            
            if (self.hour < 23 && self.hour >=1) {
                [self.meridianArray removeAllObjects];
                for (NSDictionary *dict in meridiansArray) {
                    self.meridian = [[Meridian alloc] initWithDictionary:dict error:nil];
                    if (self.meridian != nil) {
                       
                        if (self.hour >= self.meridian.beginTime && self.hour < self.meridian.endTime) {
                            
                            [self.meridianArray addObject:self.meridian];
                            
                            if (self.meridian.acupoints.count > 0) {
                                [self.acupointArray removeAllObjects];
                                for (NSDictionary *dic in self.meridian.acupoints) {
                                    self.acupoint = [[Acupoint alloc] initWithDictionary:dic error:nil];
                                    if (self.acupoint != nil) {
                                        [self.acupointArray addObject:self.acupoint];
                                    }
                                }
                            }
//                            NSLog(@">>>>>>>>self.meridianArray>>>>>>>>>>>>%@",self.meridian);
                        }
                    }
                }
 
            }else if((self.hour >= 23) || (self.hour >= 0 && self.hour < 1)){
                [self.meridianArray removeAllObjects];
                for (NSDictionary *dict in meridiansArray) {
                    self.meridian = [[Meridian alloc] initWithDictionary:dict error:nil];
                    if (self.meridian != nil) {
                        if (self.meridian.beginTime == 23 && self.meridian.endTime == 1) {
                            
                            [self.meridianArray addObject:self.meridian];
                            
                            if (self.meridian.acupoints.count > 0) {
                                [self.acupointArray removeAllObjects];
                                for (NSDictionary *dic in self.meridian.acupoints) {
                                    self.acupoint = [[Acupoint alloc] initWithDictionary:dic error:nil];
                                    if (self.acupoint != nil) {
                                        [self.acupointArray addObject:self.acupoint];
                                    }
                                }
                            }
//                            NSLog(@">>>>>>>>self.meridianArray>>>>>>>>>>>>%@",self.meridian);
                        }
                    }
                }
            }
        }else{
            ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
            [self.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        }
        [self loadMeridianData];
    }];
}

- (void)loadMeridianData{
    if (self.meridianArray.count > 0) {
        self.meridian = self.meridianArray[0];
    }
    
     NSLog(@">>>>>>>>当前状态acupointName>>>>>>>>>%@------%@",self.acupointArray,[AppStatus sharedInstance].acupointName);
    
    if (self.acupointArray.count > 0) {
        [self.selectAcupointArray removeAllObjects];
        if ([NSStringUtils isNotBlank:[AppStatus sharedInstance].acupointName]) {
            for (Acupoint *acupoint in self.acupointArray) {
                NSLog(@">>>>>>>acupoint.name>>>>>>>>>%@",acupoint.name);
                if ([acupoint.name isEqualToString:[AppStatus sharedInstance].acupointName]) {
                    [self.selectAcupointArray addObject:acupoint];
                    break;
                }
            }
            
            if (self.selectAcupointArray.count <= 0) {
                int i = arc4random()% ((int)self.acupointArray.count);
                self.acupoint = self.acupointArray[i];
                [self.selectAcupointArray addObject:self.acupoint];
            }
        }else{
            int i = arc4random()% ((int)self.acupointArray.count);
            self.acupoint = self.acupointArray[i];
            [self.selectAcupointArray addObject:self.acupoint];
            
            [AppStatus sharedInstance].acupointName = self.acupoint.name;
            [AppStatus saveAppStatus];
        }
    }
    
    
    [self.tableView reloadData];
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"锦囊" navigationController:self.navigationController];
    self.headerView.backBut.hidden = YES;
    self.headerView.userInteractionEnabled = YES;
    [self.view addSubview:self.headerView];
    
}

//右侧定位按钮 icon_more
-(void)initLeftAddressBtn{
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(general_padding, 30, 24, 24);
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_location"] forState:UIControlStateNormal];
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_location_pre"] forState:UIControlStateHighlighted];
    [self.leftBtn addTarget:self action:@selector(showCityList:) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.leftBtn];
    [self.view bringSubviewToFront:self.leftBtn];
    

    NSString *title;
    if ([NSStringUtils isNotBlank:[AppStatus sharedInstance].cityName]) {
        if ([AppStatus sharedInstance].cityName.length > 4) {
            title = [NSString stringWithFormat:@"%@...",[[AppStatus sharedInstance].cityName substringToIndex:4]];
        }else{
            title = [AppStatus sharedInstance].cityName;
        }
    }else{
        title = @"北京市";
    }
    CGSize rectSize = [FunctionUtils getCGSizeByString:title font:default_font_size];
    self.leftTitleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftTitleBtn.frame = CGRectMake(39, 20, rectSize.width, 44);
    [self.leftTitleBtn setTitleColor:[ColorUtils colorWithHexString:common_app_text_color] forState:UIControlStateNormal];
    [self.leftTitleBtn.titleLabel setFont:[UIFont systemFontOfSize:default_font_size]];
    [self.leftTitleBtn setTitle:title forState:UIControlStateNormal];
    [self.leftTitleBtn addTarget:self action:@selector(showCityList:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftTitleBtn];
    [self.view bringSubviewToFront:self.leftTitleBtn];
}

- (void)initRightBtn{
    self.rightMsgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightMsgBtn.frame = CGRectMake(screen_width-44-44, 20, 44, 44);
    self.rightMsgBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.rightMsgBtn setImage:[UIImage imageNamed:@"icon_message"] forState:UIControlStateNormal];
    [self.rightMsgBtn setImage:[UIImage imageNamed:@"icon_message_pre"] forState:UIControlStateHighlighted];
    [self.rightMsgBtn addTarget:self action:@selector(rightMsgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.rightMsgBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.rightMsgBtn];
    
    self.rightMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightMoreBtn.frame = CGRectMake(screen_width-44, 20, 44, 44);
    [self.rightMoreBtn setImage:[UIImage imageNamed:@"icon_more"] forState:UIControlStateNormal];
    [self.rightMoreBtn setImage:[UIImage imageNamed:@"icon_more_pre"] forState:UIControlStateHighlighted];
    [self.rightMoreBtn addTarget:self action:@selector(rightMoreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.rightMoreBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.rightMoreBtn];
}

- (void)initIndexTopView{
    self.indexTopView = [[IndexTopView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 71) classifyArray:self.bodyTagsArray];
    self.indexTopView.backgroundColor = [UIColor whiteColor];
    self.indexTopView.delegate = self;
    [self.topBgView addSubview:self.indexTopView];
}

- (void)initIndexTopGentleView{
    self.indexTopGentleView = [[IndexTopGentleView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 55)];
    self.indexTopGentleView.backgroundColor = [ColorUtils colorWithHexString:lighter_brown_color];
    [self.topBgView addSubview:self.indexTopGentleView];
}

//初始化tableview
-(void)initTableView{
    self.tableView.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
}

#pragma mark - tableViewDelegate and datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
       return self.recommendArticleArray.count+2;
}
//NSString *commonCellIdentifier = [NSString stringWithFormat:@"commonCell%ld",(long)indexPath.row];
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == ([self.tableView numberOfRowsInSection:0]-1)) {
        UITableViewCell *cell = [UITableViewCell new];
        cell.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
        cell.backgroundView.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
        cell.contentView.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
        float y = 0;
        CGRect frame = self.lsv.frame;
        frame.origin.y = y;
        frame.size.height = loading_view_height;
        self.lsv.frame = frame;
        [cell.contentView addSubview:self.lsv];
        return cell;
    }else if (indexPath.row == 0){
        static NSString *indexArticleCellMeridiansIdentifier = @"indexArticleCellMeridians";
        UINib *nib = [UINib nibWithNibName:@"IndexArticleCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:indexArticleCellMeridiansIdentifier];
        IndexArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:indexArticleCellMeridiansIdentifier forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.selectAcupointArray.count > 0) {
            self.acupoint = self.selectAcupointArray[0];
            if ([self.hasReadArticles containsObject:@(self.acupoint.id)]) {
                cell.redDotImgView.hidden = YES;
            }else{
                cell.redDotImgView.hidden = NO;
            }
            [cell renderIndexArticleCellWithAcupoint:self.acupoint];
            [AppStatus sharedInstance].acupointName = nil;
            [AppStatus saveAppStatus];
        }
        
        return cell;
    }else{
        static NSString *indexArticleCellIdentifier = @"indexArticleCell";
        UINib *nib = [UINib nibWithNibName:@"IndexArticleCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:indexArticleCellIdentifier];
        IndexArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:indexArticleCellIdentifier forIndexPath:indexPath];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.recommendArticleArray.count > 0) {
            self.recommendArticle = self.recommendArticleArray[indexPath.row-1];
            if ([self.hasReadArticles containsObject:@(self.recommendArticle.id)]) {
                cell.redDotImgView.hidden = YES;
            }else{
                cell.redDotImgView.hidden = NO;
            }
            
            [cell renderIndexArticleCellWithRecommendArticle:self.recommendArticle];
            
        }
        return cell;

    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == (self.recommendArticleArray.count+1)){
        return loading_view_height;
    }else{
        return 90;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == ([tableView numberOfRowsInSection:0]-1)) {
        [self transformEvent:event_click_load];
    }else if (indexPath.row == 0) {
        IndexArticleCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.redDotImgView.hidden = YES;
        [[AppStatus sharedInstance].user addReadArticle:self.acupoint.id];
        [[AppStatus sharedInstance] addHasReadArticle:self.acupoint.id];
        [AppStatus saveAppStatus];
        CheckAcupointViewController *cavc = [[CheckAcupointViewController alloc] initWithAcupoint:self.acupoint meridian:self.meridian];
        [self.navigationController pushViewController:cavc animated:YES];
    }else{
        if (self.recommendArticleArray.count > 0) {
            IndexArticleCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.redDotImgView.hidden = YES;
            self.recommendArticle = self.recommendArticleArray[indexPath.row-1];
            [[AppStatus sharedInstance].user addReadArticle:self.recommendArticle.id];
            [[AppStatus sharedInstance] addHasReadArticle:self.recommendArticle.id];
            [AppStatus saveAppStatus];
            ArticleDetailController *nvc = [[ArticleDetailController alloc] initWithArticleId:self.recommendArticle.articleId articleTitle:self.recommendArticle.article.title articleLogo:self.recommendArticle.article.logoUrl recommendTime:(long)self.recommendArticle.createTime recommendArticleId:self.recommendArticle.id];
            [self.navigationController pushViewController:nvc animated:YES];
        }
    
    }
}

#pragma mark - UIbutton
- (void)showCityList:(UIButton *)sender{
    NSLog(@"即将弹出");
    BAddressPickerController *addressPickerDemo = [[BAddressPickerController alloc] init];
    [addressPickerDemo setDelegate:self];
    addressPickerDemo.dataSource = self;
    [self.navigationController pushViewController:addressPickerDemo animated:YES];
    
}

#pragma mark - BAddressController Delegate
-(void)addressPicker:(BAddressPickerController*)addressPicker didSelectedCity:(NSString*)city{
    NSLog(@">>>>>>>>>>返回城市>>>>>>>>>>>>%@",city);
    NSString *title;
    if (city.length > 4) {
        title = [NSString stringWithFormat:@"%@...",[city substringToIndex:4]];
    }else{
        title = city;
    }
    CGSize rectSize = [FunctionUtils getCGSizeByString:title font:default_font_size];
    self.leftTitleBtn.frame = CGRectMake(39, 20, rectSize.width, 44);
    [self.leftTitleBtn setTitle:title forState:UIControlStateNormal];
    AppStatus *as = [AppStatus sharedInstance];
    if ([[AppStatus sharedInstance] hasAddRecentCityArray:city]) {
        NSLog(@">>>>>>>>>>111111>>>>>>>>>>>>%@",city);
        [as removeRecentCityArray:city];
        [as addRecentCityArray:city];
        as.cityName = city;
        [AppStatus saveAppStatus];
    }else{
         NSLog(@">>>>>>>>>>222222>>>>>>>>>>>>%@",city);
        [as addRecentCityArray:city];
        as.cityName = city;
        [AppStatus saveAppStatus];
        NSLog(@">>>>>>>>>>333333333>>>>>>>>>>>>%@",as.recentCityArray);
    }
}

- (void)rightMsgBtnClick:(UIButton *)sender{
    NSLog(@"右侧Msg btn");
    if (![[AppStatus sharedInstance] logined]) {
        UserLoginViewController *ulc = [[UserLoginViewController alloc] initWithFrom:account_session_from_user_home];
        [self.navigationController pushViewController:ulc animated:YES];
        return ;
    }else{
        PushSettingController *psvc = [[PushSettingController alloc] init];
        [self.navigationController pushViewController:psvc animated:YES];
    }
}

- (void)rightMoreBtnClick:(UIButton *)sender{
    NSLog(@"右侧More btn");
    // 弹出QQ的自定义视图 ,@"哪疼找哪"  ,@"icon_homepage_pain"
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(self.view.bounds.size.width-100, 64, 150, 160) selectData:@[@"自拍舌诊",@"协助眼诊",@"常见病调理",@"档         案"] images:@[@"icon_homepage_autodyne",@"icon_homepage_eye",@"icon_homepage_pain",@"icon_homepage_record"] action:^(NSInteger index) {
        NSLog(@"选择%ld",(long)index);
//        if (![[AppStatus sharedInstance] logined]) {
//            UserLoginViewController *ulc = [[UserLoginViewController alloc] initWithFrom:account_session_from_user_home];
//            [self.navigationController pushViewController:ulc animated:YES];
//            return ;
//        }else{
            if (index == 0) {
                
                [self tokePhoto];
        
            }else if (index == 1){
                DiagnosisOnLeftEyesController *dolvc = [[DiagnosisOnLeftEyesController alloc] init];
                [self.navigationController pushViewController:dolvc animated:YES];
            }else if (index == 2){
                CommonDiseaseController *cdvc = [[CommonDiseaseController alloc] init];
                [self.navigationController pushViewController:cdvc animated:YES];
            }
            else if (index == 3){
                if (![[AppStatus sharedInstance] logined]) {
                    UserLoginViewController *ulc = [[UserLoginViewController alloc] initWithFrom:account_session_from_user_home];
                    [self.navigationController pushViewController:ulc animated:YES];
                    return ;
                }else{
                    MyArchivesViewController *macv = [[MyArchivesViewController alloc] init];
                    [self.navigationController pushViewController:macv animated:YES];
                }
    
            }

//        }
    } animated:YES navController:self.navigationController];
}

#pragma mark - IndexTopDelegate

- (void)didTongueDiagnosisReadyBtnClick:(UIButton *)sender{
//    if (![[AppStatus sharedInstance] logined]) {
//        UserLoginViewController *ulc = [[UserLoginViewController alloc] initWithFrom:account_session_from_user_home];
//        [self.navigationController pushViewController:ulc animated:YES];
//        return ;
//    }else{
        [self tokePhoto];
//    }
}

- (void)tokePhoto{
    self.homevc = [[HomeViewController alloc] init];
    self.homevc.delegate = self;
    [self presentViewController:self.homevc animated:YES completion:nil];
    
    self.remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, screen_width, 40)];
    self.remindLabel.backgroundColor = [UIColor clearColor];
    self.remindLabel.text = @"请伸出舌头并放在下方拍照框";
    self.remindLabel.textColor = [UIColor whiteColor];
    self.remindLabel.font = [UIFont systemFontOfSize:default_2_font_size];
    self.remindLabel.textAlignment = NSTextAlignmentCenter;
    [self.homevc.view addSubview:self.remindLabel];
    
//    float y = ((screen_width-40)*198)/750;
//    float h = screen_height-y-(((screen_width-40)*274)/750)-85-20;
//    
//    self.markImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, y, screen_width-40, h)];
//    //    markImgView.backgroundColor = [UIColor purpleColor];
//    self.markImgView.image = [UIImage imageNamed:@"bg_abandon_photograph_wireframe"];
//    self.markImgView.backgroundColor = [UIColor clearColor];
//    [self.homevc.view addSubview:self.markImgView];
//    
//    float tongueImgViewW = ((h-80)*384)/628;
//    UIImageView *tongueImgView = [[UIImageView alloc] initWithFrame:CGRectMake((screen_width-40-tongueImgViewW)/2, 40, tongueImgViewW, h-80)];
//    tongueImgView.image = [UIImage imageNamed:@"bg_abandon_photograph"];
//    tongueImgView.backgroundColor = [UIColor clearColor];
//    [self.markImgView addSubview:tongueImgView];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, screen_height-60-10-85, screen_width-65, 85)];
    self.contentLabel.backgroundColor = [UIColor clearColor];
    NSString *contentStr = @"1.请在充足光线在拍照。\n2.刷牙及饭后不要立即做舌像自诊，会有误差。\n3.不要在吃进色素等人为染苔行为下做自诊。";
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:contentStr];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [contentStr length])];
    [self.contentLabel setAttributedText:attributedString];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.textColor = [ColorUtils colorWithHexString:white_text_color];
    self.contentLabel.font = [UIFont systemFontOfSize:small_font_size];
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentLabel sizeToFit];
    [self.homevc.view addSubview:self.contentLabel];
    
}

-(void) homeViewController:(HomeViewController *)picker didFinishPickingMediaWithImage:(UIImage *)image{
    [picker dismissViewControllerAnimated:NO completion:nil];
    [SVProgressHUD showWithStatus:@"图片上传中..." maskType:SVProgressHUDMaskTypeBlack];
    [[UserStore sharedStore] upLoadImg:^(NSString *imgUrl, NSError *err) {
        [SVProgressHUD dismiss];
        if (imgUrl != nil) {
            NSLog(@">>>>>>>>>>>>>>>>>>上传的舌头照片----%@",imgUrl);
            TongueDiagnosisCompareController *tdcvc = [[TongueDiagnosisCompareController alloc] initWithImage:imgUrl];
            [self.navigationController pushViewController:tdcvc animated:YES];
        }else{
            ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
            [self.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        }
    } tongueImage:image];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    //
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadDigData];
        [self refreshAcupointData];
        [self transformEvent:event_load_data_pull_down];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView.mj_header endRefreshing];
    });
}

- (void)refreshAcupointData{
    self.hour = [DateUtils getCurrentDateHour];
    NSDate *date = [NSDate date];
    NSString *nowStr = [DateUtils getDateByDate:date];
    NSArray *array = [nowStr componentsSeparatedByString:@" "];
    NSLog(@"date222222 = %@", array);
    NSString *datastr = array[0];
    int remarkNo = [FunctionUtils getRemarkNum:(int)self.hour];
    NSString *tmpDataStr = [NSString stringWithFormat:@"%@%d",datastr,remarkNo];
    if (![tmpDataStr isEqualToString:[AppStatus sharedInstance].remarkDataStr]) {
        NSLog(@"时间已变");
        [self loadTimeMeridianData];
        [AppStatus sharedInstance].remarkDataStr = tmpDataStr;
        [AppStatus sharedInstance].recommendAcupointTime = nowStr;
        [AppStatus saveAppStatus];
    }

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentSize.height > 0 && scrollView.contentOffset.y > (scrollView.contentSize.height-scrollView.frame.size.height)) {
        [self transformEvent:event_pull_up];
    }
}

-(void)transformEvent:(int)eventType{
    self.currentEventType = eventType;
    if((self.currentTableViewStatus == table_view_status_waiting
        || self.currentTableViewStatus == table_view_status_load_over)
       && eventType == event_init_load){
        
        [self.recommendArticleArray removeAllObjects];
        self.currentTableViewStatus = table_view_status_loading;
        [self.lsv updateStatus:network_status_loading animating:YES];

        self.currentPageNo = 1;
        //加载数据
        [self loadData:YES];
    }else if (self.currentTableViewStatus == table_view_status_waiting && eventType == event_pull_up) {
        
        //更新加载状态视图到正在加载的效果

        [self.lsv updateStatus:network_status_loading animating:YES];
       
        self.currentPageNo ++;
        self.currentTableViewStatus = table_view_status_loading;
        
        //加载数据
        [self loadData:NO];
    }else if(self.currentTableViewStatus == table_view_status_loading && eventType == event_load_complete_fail){
        
        //更新加载状态视图到加载失败的效果
        [self.lsv updateStatus:network_request_fail animating:NO];
        self.currentPageNo = self.currentPageNo - 1;
        
        self.currentTableViewStatus = table_view_status_load_fail;
    }else if(self.currentTableViewStatus == table_view_status_loading && eventType == event_load_complete_over){
        
        [self.lsv updateStatus:[self getNoMoreNote] animating:NO];
        
        self.currentTableViewStatus = table_view_status_load_over;
    }else if(self.currentTableViewStatus == table_view_status_loading && eventType == event_load_complete_succes){

        [self.lsv updateStatus:network_status_loading animating:YES];
        self.currentTableViewStatus = table_view_status_waiting;
    }else if(self.currentTableViewStatus == table_view_status_load_fail
             && (eventType == event_pull_up || eventType == event_click_load)
             && [[AppStatus sharedInstance] isConnetInternet]){
        self.currentTableViewStatus = table_view_status_loading;
        
        [self.lsv updateStatus:network_status_loading animating:YES];
       
        //加载数据
        self.currentPageNo = self.currentPageNo + 1;
        [self loadData:NO];
    }else if ((self.currentTableViewStatus == table_view_status_waiting || self.currentTableViewStatus == table_view_status_load_over) && eventType == event_load_data_pull_down){
        // 下拉刷新
        self.currentTableViewStatus = table_view_status_loading;
        self.currentPageNo = 1;
        [self.recommendArticleArray removeAllObjects];
        CGRect frame = self.lsv.frame;
        frame.origin.y = 0;
        frame.size.height = loading_view_height;
        self.lsv.frame = frame;
        [self.lsv updateStatus:network_status_loading animating:YES];
        [self loadData:YES];
    }
}

-(NSString *) getNoMoreNote{
    if (self.recommendArticleArray.count == 0) {
        return @"暂无更多";
    }
    return network_status_no_more;
}


-(NSString *)getPageName
{
    return page_name_jinnang;
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
