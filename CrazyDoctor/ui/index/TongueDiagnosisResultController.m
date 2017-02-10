//
//  TongueDiagnosisResultController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/19.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "TongueDiagnosisResultController.h"
#import "WLZShareController.h"
#import "CrazyDoctorTabbar.h"
#import "AppDelegate.h"
#import "TongueDiagnosisStore.h"
@interface TongueDiagnosisResultController ()

@end

@implementation TongueDiagnosisResultController
- (instancetype)initWithUserTongueUrl:(NSString *)userTongueUrl bodyTagIds:(NSArray *)bodyTagIds userSelectQuestions:(NSArray *)userSelectQuestions isPingHe:(BOOL)isPingHe{
    self = [super init];
    if (self) {
        self.userTongueUrl = userTongueUrl;
        self.bodyTagIds = bodyTagIds;
        self.userSelectQuestions = userSelectQuestions;
        self.isPingHe = isPingHe;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorUtils colorWithHexString:white_text_color];
//    [self setRightSwipeGestureAndAdaptive];
    self.bodyTagsArray = [NSMutableArray new];
    self.bodyTagsNameArray = [NSMutableArray new];
    [self initUI];
    [self loadData];
}

- (void)loadData{
    [SVProgressHUD showWithStatus:@"数据加载中..." maskType:SVProgressHUDMaskTypeBlack];
    [TongueDiagnosisStore confirmTongueDiagnosisTest:^(NSDictionary *dict, NSError *err) {
        [SVProgressHUD dismiss];
        if (dict != nil) {
            self.tongueDiagnoseRecord = [[TongueDiagnoseRecord alloc] initWithDictionary:dict error:nil];
            
            if (self.tongueDiagnoseRecord != nil) {
                [self.bodyTagsNameArray removeAllObjects];
                [self.bodyTagsArray removeAllObjects];
                for (NSDictionary *bodyDict in self.tongueDiagnoseRecord.bodyTags) {
                    NSLog(@">>>>>>>>>>>>>>>%@",bodyDict);
                    self.bodyTag = [[BodyTag alloc] initWithDictionary:bodyDict error:nil];
                    if (self.bodyTag != nil) {
                        [self.bodyTagsArray addObject:self.bodyTag];
                        [self.bodyTagsNameArray addObject:self.bodyTag.name];
                    }
                }
                AppStatus *as = [AppStatus sharedInstance];
                as.user.bodyTagNames = [self.bodyTagsNameArray componentsJoinedByString:@","];
                [AppStatus saveAppStatus];
                NSLog(@">>>>>>>>>更新对象>>>>>>%@",[AppStatus sharedInstance].user);
            }
        }else{
            ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
            [self.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        }
        [self.tableView reloadData];
    } userTongueUrl:self.userTongueUrl bodyTagIds:self.bodyTagIds userSelectQuestions:self.userSelectQuestions isPingHe:self.isPingHe];
}

- (void)initUI{
    [self initHeadView];
    [self initTopRemindLabelView];
    [self initTableView];
    [self initBottomBtnView];
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"舌诊结论" navigationController:self.navigationController];
    self.headerView.backBut.hidden = YES;
    [self.view addSubview:self.headerView];
    
    self.rightShareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightShareBtn.frame = CGRectMake(screen_width-24-general_padding, 30, 24, 24);
    [self.rightShareBtn setImage:[UIImage imageNamed:@"icon_share_nor"] forState:UIControlStateNormal];
    [self.rightShareBtn setImage:[UIImage imageNamed:@"icon_share_pre"] forState:UIControlStateHighlighted];
    [self.rightShareBtn addTarget:self action:@selector(rightShareResultBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.rightShareBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.rightShareBtn];
}

- (void)initTopRemindLabelView{
    self.remindBgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width, 32)];
    self.remindBgView.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    [self.view addSubview:self.remindBgView];
    
    NSString *remindStr = @"点击以下标签可查看详情哦~";
    self.remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screen_width-general_margin, 32)];
    self.remindLabel.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
    self.remindLabel.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    self.remindLabel.font = [UIFont systemFontOfSize:smaller_font_size];

    int start = (int)[remindStr rangeOfString:[NSString stringWithFormat:@"%@",@"详情"]].location;
    int length = (int)[remindStr rangeOfString:[NSString stringWithFormat:@"%@",@"详情"]].length;
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:remindStr];
    [attributedText addAttribute:NSForegroundColorAttributeName value:[ColorUtils colorWithHexString:common_app_text_color] range:NSMakeRange(start,length)];
    [attributedText addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:smaller_font_size] range:NSMakeRange(start,length)];
    self.remindLabel.attributedText = attributedText;
    self.remindLabel.textAlignment = NSTextAlignmentRight;
    [self.remindBgView addSubview:self.remindLabel];
    
//    UIButton *topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    topBtn.frame = CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width, 32);
//    [topBtn addTarget:self action:@selector(topBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    topBtn.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:topBtn];
}

//初始化tableview
-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.remindBgView.frame.origin.y+self.remindBgView.frame.size.height+5, screen_width,screen_height-self.headerView.frame.size.height-self.remindBgView.frame.size.height-59-5) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [ColorUtils colorWithHexString:white_text_color];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
}

#pragma mark - tableViewDelegate and datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.bodyTagsArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *tongueDiagnosisResultCellIdentifier = @"tongueDiagnosisResultCell";
    UINib *nib = [UINib nibWithNibName:@"TongueDiagnosisResultCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:tongueDiagnosisResultCellIdentifier];
    TongueDiagnosisResultCell *cell = [tableView dequeueReusableCellWithIdentifier:tongueDiagnosisResultCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.bodyTagsArray.count > 0) {
        self.bodyTag = self.bodyTagsArray[indexPath.section];
        [cell renderTongueDiagnosisResultCell:self.bodyTag withSection:indexPath.section];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, general_padding)];
    headerView.backgroundColor = [UIColor whiteColor];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return general_padding;
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.bodyTag = self.bodyTagsArray[indexPath.section];
    [self popImageViewWithDetailImageUrl:self.bodyTag];
}

- (void)popImageViewWithDetailImageUrl:(BodyTag *)bodyTag{
    self.popUpView = [[PopUpView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    [self.view addSubview:self.popUpView];
    
    self.detailImagView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 80, screen_width-50, ((screen_width-50)*93)/65)];
    [self.detailImagView sd_setImageWithURL:[NSURL URLWithString:bodyTag.detailImageUrl] placeholderImage:nil];
    self.detailImagView.userInteractionEnabled = YES;
    [self.view addSubview:self.detailImagView];
    [self.view bringSubviewToFront:self.detailImagView];

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
    NSArray *array = @[@"舌诊体质"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"刷新舌诊体质数据" object:array];
    CrazyDoctorTabbar *tabBar = [(AppDelegate*)[UIApplication sharedApplication].delegate tabbar];
    if ([tabBar.tabBarController selectedIndex] != tabbar_item_index_jinnang) {
        UINavigationController *navController = [tabBar getSelectedViewController];
        [navController popToRootViewControllerAnimated:NO];
        [tabBar.tabBarController setSelectedIndex:tabbar_item_index_jinnang];
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)rightShareResultBtnClick:(UIButton *)sender{
    WLZShareController *share =[[WLZShareController alloc]init];
    [share addItem:@"微信好友" icon:@"icon_wechat_nor" hightLightIcon:@"icon_wechat_pre" block:^(WLZBlockButton *btn) {
        NSLog(@">>>>>>>>>>>>>>>>>>微信好友");
        ShareContent *shareContent = [self collectionShareContent];
        ShareSDKProcessor *shareSDKProcessor = [ShareSDKProcessor new];
        [shareSDKProcessor followWeiXinSession:sender shareContent:shareContent shareSuccessBlock:^{
            
        }];
    }];
    
    [share addItem:@"朋友圈" icon:@"icon_friends_nor" hightLightIcon:@"icon_friends_pre" block:^(WLZBlockButton *btn) {
        NSLog(@">>>>>>>>>>>>>>>>>>朋友圈");
        ShareContent *shareContent = [self collectionShareContent];
        ShareSDKProcessor *shareSDKProcessor = [ShareSDKProcessor new];
        [shareSDKProcessor followWeiXinTimeLine:sender shareContent:shareContent shareSuccessBlock:^{
            
        }];
    }];
    
    
    [share addItem:@"QQ" icon:@"icon_qq_nor" hightLightIcon:@"icon_qq_pre" block:^(WLZBlockButton *btn) {
        NSLog(@">>>>>>>>>>>>>>>>>>QQ");
        ShareContent *shareContent = [self collectionShareContent];
        ShareSDKProcessor *shareSDKProcessor = [ShareSDKProcessor new];
        [shareSDKProcessor followQQ:sender shareContent:shareContent shareSuccessBlock:^{
            
        }];
    }];
    
    [share addItem:@"新浪微博" icon:@"icon_sina_nor" hightLightIcon:@"icon_sina_pre" block:^(WLZBlockButton *btn) {
        NSLog(@">>>>>>>>>>>>>>>>>>新浪微博");
        ShareContent *shareContent = [self collectionShareContent];
        ShareSDKProcessor *shareSDKProcessor = [ShareSDKProcessor new];
        [shareSDKProcessor followSinaWeiBo:sender shareContent:shareContent shareSuccessBlock:^{
            
        }];
    }];
    [share show];
}

-(ShareContent *) collectionShareContent{
    NSString *title = share_app_title;
//    http://dwz.cn/3QYoBg
//    @"%@/projects?noFooterFlag=1&noHeaderFlag=1&isAppOpen=0",[AppStatus sharedInstance].wxpubUrl
    NSString *url = [NSString stringWithFormat:@"http://dwz.cn/3QYoBg"];
    NSString *content = @"疯狂太医";
    NSString *contentWithUrl = [NSString stringWithFormat:@"%@  %@ ", content, url];
    ShareContent *shareContent = [[ShareContent alloc] initWithTitle:title
                                                             content:content
                                                    wxSessionContent:content
                                                    sinaWeiBoContent:contentWithUrl
                                                                 url:url
                                                               image:[UIImage imageNamed:@"logo－108.png"]
                                                            imageUrl:nil
                                                          imageArray:@[[UIImage imageNamed:@"logo－108.png"]]];
    return shareContent;
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
