//
//  MyCollectionController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/20.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "MyCollectionController.h"
#import "ArticleDetailController.h"
#import "UserStore.h"
@interface MyCollectionController ()

@end

@implementation MyCollectionController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    [self setRightSwipeGestureAndAdaptive];
    self.currentIndex = 0;
    self.currentPageNo = 1;
    self.currentTableViewStatus = table_view_status_waiting;
    [self transformEvent:event_init_load];
    
    [self initUI];
    [self initLoadingStatusView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) initLoadingStatusView{
    self.lsv = [[LoadingStatusView alloc] initWithFrame:CGRectMake(0, (screen_height-loading_view_height)/2, screen_width, loading_view_height)];
    self.lsv.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    [self.lsv updateStatus:network_status_loading animating:YES];
}

- (void)loadData:(BOOL)reload{
    [SVProgressHUD show];
    [UserStore getAllUserCollectionArticles:^(Page *page, NSError *error) {
        [SVProgressHUD dismiss];
        if (page != nil) {
            if (reload) {
                self.userFavArticleListArray = [NSMutableArray new];
            }
            //            NSLog(@">>>>>>>>比赛总数>>>>>>>%d",page.totalCount);
            for (NSDictionary *dict in page.items) {
                //                NSLog(@">>>>>>>>获取比赛dict>>>>>>>%@",dict[@""]);
                self.userFavArticle = [[UserFavArticle alloc] initWithDictionary:dict error:nil];
                NSLog(@">>>>>>>>获userFavArticle>>>>>>>%@",self.userFavArticle);
                if (self.userFavArticle != nil) {
                    [self.userFavArticleListArray addObject:self.userFavArticle];
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
    } pageNo:self.currentPageNo pageSize:common_page_size];
}

#pragma mark - 初始化自定义View

- (void)initUI{
    [self initHeadView];
    [self initTableView];
}
//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"我的收藏" navigationController:self.navigationController];
    [self.view addSubview:self.headerView];
    
}

//初始化tableview
-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width,screen_height-self.headerView.frame.size.height) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
}

#pragma mark - tableViewDelegate and datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.userFavArticleListArray.count + 1;
}

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
    }else{
        static NSString *indexArticleCellIdentifier = @"MyCollectionArticleCell";
        UINib *nib = [UINib nibWithNibName:@"MyCollectionArticleCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:indexArticleCellIdentifier];
        MyCollectionArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:indexArticleCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.deleteFavBtn addTarget:self action:@selector(deleteFavBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.currentIndex = (int)indexPath.row;
        if (self.userFavArticleListArray.count > 0) {
            self.userFavArticle = self.userFavArticleListArray[indexPath.row];
            [cell renderMyCollectionArticleCellWithUserFavArticle:self.userFavArticle];
        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == (self.userFavArticleListArray.count)){
        return loading_view_height;
    }else{
        return 90;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == ([tableView numberOfRowsInSection:0]-1)) {
        [self transformEvent:event_click_load];
    }else{
        if (self.userFavArticleListArray.count > 0) {
            self.userFavArticle = self.userFavArticleListArray[indexPath.row];
            ArticleDetailController *nvc = [[ArticleDetailController alloc] initWithArticleId:self.userFavArticle.articleId articleTitle:self.userFavArticle.articleTitle articleLogo:self.userFavArticle.logoUrl recommendTime:0 recommendArticleId:0];
            [self.navigationController pushViewController:nvc animated:YES];
        }
    }
}

- (void)deleteFavBtnClick:(UIButton *)sender{
    NSLog(@"____________%d---------%@",self.currentIndex,sender.superview.superview);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认删除该收藏？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //点击取消按钮后控制台打印语句。
    }];
    //实例化确定按钮
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        MyCollectionArticleCell *cell = (MyCollectionArticleCell *)sender.superview.superview;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        NSLog(@"____________%d",(int)indexPath.row);
        self.userFavArticle = self.userFavArticleListArray[indexPath.row];
        [UserStore userDeleteFavArticle:^(NSError *err) {
            if (err == nil) {
                [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                [[AppStatus sharedInstance].user removeFavArticle:self.userFavArticle.articleId];
                [self.userFavArticleListArray removeObjectAtIndex:indexPath.row];
                [self.tableView setEditing:NO animated:YES];
                [self.tableView reloadData];
            }else
            {
                [SVProgressHUD showErrorWithStatus:@"删除失败"];
            }
            
        } articleId:self.userFavArticle.articleId];

    }];
    //实例化确定按钮
    //向弹出框中添加按钮和文本框
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    //将提示框弹出
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
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

#pragma mark - 状态机模式实现刷新
-(void)transformEvent:(int)eventType{
    self.currentEventType = eventType;
    if((self.currentTableViewStatus == table_view_status_waiting
        || self.currentTableViewStatus == table_view_status_load_over)
       && eventType == event_init_load){
        
        //正在加载中禁止用户产生交互
        
        [self.userFavArticleListArray removeAllObjects];
        self.currentTableViewStatus = table_view_status_loading;
        [self.lsv updateStatus:network_status_loading animating:YES];
        
        self.currentPageNo = 1;
        //        [self.tableView headerEndRefreshing];
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
        [self.userFavArticleListArray removeAllObjects];
        CGRect frame = self.lsv.frame;
        frame.origin.y = 0;
        frame.size.height = loading_view_height;
        self.lsv.frame = frame;
        [self.lsv updateStatus:network_status_loading animating:YES];
        [self loadData:YES];
    }
}

-(NSString *) getNoMoreNote{
    if (self.userFavArticleListArray.count == 0) {
        return @"暂无更多";
    }
    return network_status_no_more;
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
