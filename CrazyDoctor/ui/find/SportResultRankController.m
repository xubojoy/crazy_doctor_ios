//
//  SportResultRankController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/18.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "SportResultRankController.h"
#import "SportResultRankCell.h"
#import "UserStore.h"
#import "UserSportRankCell.h"
#import "WLZShareController.h"
@interface SportResultRankController ()

@end
@implementation SportResultRankController

-(instancetype) initWithRankStatus:(NSArray *)rankStatuses{
    self = [super init];
    if (self) {
        self.currentRankStatuses = rankStatuses;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [(AppDelegate*)[UIApplication sharedApplication].delegate tabbar].tabBarController.statusBarStyle = UIStatusBarStyleDefault;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    [self initHeadView];
    
    self.currentPageNo = 1;
    self.currentTableViewStatus = table_view_status_waiting;
    [self transformEvent:event_init_load];
    [self initCustomSegmentView];
    [self initLoadingStatusView];
    [self loadMySportRank];
    [self initTableView];
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"运动排名" navigationController:self.navigationController];
    [self.view addSubview:self.headerView];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(screen_width-10-100, 20, 100, 44);
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn setImage:[UIImage imageNamed:@"icon_share_nor"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"icon_share_pre"] forState:UIControlStateHighlighted];
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -50);
    [rightBtn addTarget:self action:@selector(rightShareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:rightBtn];

}

-(void) initLoadingStatusView{
    self.lsv = [[LoadingStatusView alloc] initWithFrame:CGRectMake(0, (screen_height-loading_view_height)/2, screen_width, loading_view_height)];
    self.lsv.backgroundColor = [UIColor whiteColor];
    [self.lsv updateStatus:network_status_loading animating:YES];
}

- (void)loadMySportRank{
    NSString *typeStr = self.currentRankStatuses[0];
    [UserStore getMySportRank:^(SharkeySort *sharkeySort, NSError *error) {
        if (error == nil) {
            self.sharkeySort = sharkeySort;
        }
        [self.tableView reloadData];
    } type:typeStr];
}


- (void)loadData:(BOOL)reload{
    NSString *typeStr = self.currentRankStatuses[0];
    [UserStore getUserSportRank:^(Page *page, NSError *error) {
        if (page != nil) {
            if (reload) {
                self.sharkeyDataArray = [NSMutableArray new];
            }
            NSLog(@">>>>>>>>总数>>>>>>>%d",page.totalCount);
            for (NSDictionary *dict in page.items) {
                self.userSharkeyData = [[UserSharkeyData alloc] initWithDictionary:dict error:nil];
                if (self.userSharkeyData != nil) {
                    [self.sharkeyDataArray addObject:self.userSharkeyData];
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

    } pageNo:self.currentPageNo pageSize:common_page_size type:typeStr];
}

-(void)initCustomSegmentView
{
    NSArray *btnTitleArray = [[NSArray alloc] initWithObjects:@"每天",@"每周",@"每月", nil];
    self.customSegmentView = [[CustomSegmentView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width, general_height)];
    [self.customSegmentView render:btnTitleArray currentIndex:[self getSelectIndex]];
    self.customSegmentView.delegate = self;
    self.customSegmentView.backgroundColor = [ColorUtils colorWithHexString:white_text_color];
    
    UIView *downSpeliteLine = [[UIView alloc] initWithFrame:CGRectMake(0, general_height-splite_line_height, screen_width, splite_line_height)];
    downSpeliteLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
    [self.customSegmentView addSubview:downSpeliteLine];
    [self.view addSubview:self.customSegmentView];
}

//根据当前的美发卡状态获取选中的位序
-(int)getSelectIndex{
    if ([self.currentRankStatuses isEqualToArray:[[NSArray alloc] initWithObjects:@"day", nil]]) {
        return 0;
    }else if ([self.currentRankStatuses isEqualToArray:[[NSArray alloc] initWithObjects:@"week", nil]]) {
        return 1;
    }else if ([self.currentRankStatuses isEqualToArray:[[NSArray alloc] initWithObjects:@"month", nil]]) {
        return 2;
    }
    return 0;
}

-(void)selectSegment:(int)inx
{
    switch (inx) {
        case 0:
            self.currentRankStatuses = [[NSArray alloc] initWithObjects:@"day", nil];
            break;
        case 1:
            self.currentRankStatuses = [[NSArray alloc] initWithObjects:@"week", nil];
            break;
        case 2:
            self.currentRankStatuses = [[NSArray alloc] initWithObjects:@"month", nil];
            break;
        default:
            break;
    }
    [self loadMySportRank];
    [self transformEvent:event_init_load];
}



//初始化tableview
-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.customSegmentView.frame.size.height+self.customSegmentView.frame.origin.y, screen_width,screen_height-self.headerView.frame.size.height-self.customSegmentView.frame.size.height) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
}

#pragma mark - tableViewDelegate and datasource
#pragma mark - tableViewDelegate and datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sharkeyDataArray.count + 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == ([self.tableView numberOfRowsInSection:0]-1)) {
        UITableViewCell *cell = [UITableViewCell new];
        float y = 0;
        CGRect frame = self.lsv.frame;
        frame.origin.y = y;
        frame.size.height = loading_view_height;
        self.lsv.frame = frame;
        [cell.contentView addSubview:self.lsv];
        return cell;
    }else if (indexPath.row == 0) {
        static NSString *userSportRankCellIdentifier = @"UserSportRankCell";
        UINib *nib = [UINib nibWithNibName:@"UserSportRankCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:userSportRankCellIdentifier];
        UserSportRankCell *cell = [tableView dequeueReusableCellWithIdentifier:userSportRankCellIdentifier forIndexPath:indexPath];
        if (self.sharkeySort != nil) {
            cell.userImgView.hidden = NO;
            cell.userNameLabel.hidden = NO;
            cell.userRankLabel.hidden = NO;
            cell.userGenderIngView.hidden = NO;
            cell.stepNumLabel.hidden = NO;
           [cell renderUserSportRankCell:self.sharkeySort];
        }else{
            cell.userImgView.hidden = YES;
            cell.userNameLabel.hidden = YES;
            cell.userRankLabel.hidden = YES;
            cell.userGenderIngView.hidden = YES;
            cell.stepNumLabel.hidden = YES;
        }
        return cell;
    }else{
        static NSString *sportResultRankCellIdentifier = @"SportResultRankCell";
        UINib *nib = [UINib nibWithNibName:@"SportResultRankCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:sportResultRankCellIdentifier];
        SportResultRankCell *cell = [tableView dequeueReusableCellWithIdentifier:sportResultRankCellIdentifier forIndexPath:indexPath];
        if (self.sharkeyDataArray.count > 0) {
            self.userSharkeyData = self.sharkeyDataArray[indexPath.row-1];
            [cell renderSportResultRankCell:self.userSharkeyData];
        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        if (self.sharkeySort != nil) {
            return 75;
        }else{
            return 0;
        }
    }else{
        return 75;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    //
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self transformEvent:event_load_data_pull_down];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView.mj_header endRefreshing];
    });
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
        
        [self.sharkeyDataArray removeAllObjects];
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
        [self.sharkeyDataArray removeAllObjects];
        CGRect frame = self.lsv.frame;
        frame.origin.y = 0;
        frame.size.height = loading_view_height;
        self.lsv.frame = frame;
        [self.lsv updateStatus:network_status_loading animating:YES];
        [self loadData:YES];
    }
}

-(NSString *) getNoMoreNote{
    if (self.sharkeyDataArray.count == 0) {
        return @"暂无更多";
    }
    return network_status_no_more;
}


- (void)rightShareBtnClick:(UIButton *)sender{
    
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
    NSString *url = [NSString stringWithFormat:@"http://dwz.cn/3QYoBg"];
    NSString *content = @"疯狂太医";
    NSString *contentWithUrl = [NSString stringWithFormat:@"%@  %@ ", content, url];
    ShareContent *shareContent = [[ShareContent alloc] initWithTitle:title
                                                             content:content
                                                    wxSessionContent:content
                                                    sinaWeiBoContent:contentWithUrl
                                                                 url:url
                                                               image:[UIImage imageNamed:@"logo－108.png"]
                                                            imageUrl:@""
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
