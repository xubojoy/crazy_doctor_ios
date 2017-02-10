//
//  OtherHospitalViewController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/11.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "OtherHospitalViewController.h"
#import "MyPhysiotherapyCell.h"
#import "UserStore.h"
@interface OtherHospitalViewController ()


@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

static NSString *myPhysiotherapyCellIdentifier = @"myPhysiotherapyCell";
@implementation OtherHospitalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    self.currentPageNo = 1;
    self.currentTableViewStatus = table_view_status_waiting;
    [self transformEvent:event_init_load];
    [self initLoadingStatusView];

    UINib *nib = [UINib nibWithNibName:@"MyPhysiotherapyCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:myPhysiotherapyCellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
}

-(void) initLoadingStatusView{
    self.lsv = [[LoadingStatusView alloc] initWithFrame:CGRectMake(0, (screen_height-loading_view_height)/2, screen_width, loading_view_height)];
    self.lsv.backgroundColor = [ColorUtils colorWithHexString:white_text_color];
    [self.lsv updateStatus:network_status_loading animating:YES];
}

- (void)loadData:(BOOL)reload{
    [SVProgressHUD show];
    [UserStore getOtherHospitalRecordList:^(Page *page, NSError *error) {
        [SVProgressHUD dismiss];
        if (page != nil) {
            if (reload) {
                self.userUploadRecordListArray = [NSMutableArray new];
            }
            //            NSLog(@">>>>>>>>比赛总数>>>>>>>%d",page.totalCount);
            for (NSDictionary *dict in page.items) {
                //                NSLog(@">>>>>>>>获取比赛dict>>>>>>>%@",dict[@""]);
                self.userUploadRecord = [[UserUploadRecord alloc] initWithDictionary:dict error:nil];
                NSLog(@">>>>>>>>获userUploadRecord>>>>>>>%@",self.userUploadRecord);
                if (self.userUploadRecord != nil) {
                    [self.userUploadRecordListArray addObject:self.userUploadRecord];
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
        
    } userId:[AppStatus sharedInstance].user.id pageNo:self.currentPageNo pageSize:common_page_size];
}


#pragma mark - tableViewDelegate and datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.userUploadRecordListArray.count + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == ([self.tableView numberOfRowsInSection:0]-1)) {
        UITableViewCell *cell = [UITableViewCell new];
        cell.backgroundColor = [ColorUtils colorWithHexString:white_text_color];
        cell.backgroundView.backgroundColor = [ColorUtils colorWithHexString:white_text_color];
        cell.contentView.backgroundColor = [ColorUtils colorWithHexString:white_text_color];
        float y = 0;
        CGRect frame = self.lsv.frame;
        frame.origin.y = y;
        frame.size.height = loading_view_height;
        self.lsv.frame = frame;
        [cell.contentView addSubview:self.lsv];
        return cell;
    }else{
        MyPhysiotherapyCell *cell = [tableView dequeueReusableCellWithIdentifier:myPhysiotherapyCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.userUploadRecordListArray.count > 0) {
            self.userUploadRecord = self.userUploadRecordListArray[indexPath.row];
            [cell renderMyPhysiotherapyCellWithUserUploadRecord:self.userUploadRecord];
        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == (self.userUploadRecordListArray.count)){
        return loading_view_height;
    }else{
        return 120;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@">>>>>>>>点击>>>>>>%d",(int)indexPath.row);
    if (indexPath.row == ([tableView numberOfRowsInSection:0]-1)) {
        [self transformEvent:event_click_load];
    }else{
        self.userUploadRecord = self.userUploadRecordListArray[indexPath.row];
        if ([self.delegate respondsToSelector:@selector(didOtherHospitalViewControllerIndexPathRow:userUploadRecord:)]) {
            [self.delegate didOtherHospitalViewControllerIndexPathRow:indexPath.row userUploadRecord:self.userUploadRecord];
        }
    }
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
        
        [self.userUploadRecordListArray removeAllObjects];
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
        [self.userUploadRecordListArray removeAllObjects];
        CGRect frame = self.lsv.frame;
        frame.origin.y = 0;
        frame.size.height = loading_view_height;
        self.lsv.frame = frame;
        [self.lsv updateStatus:network_status_loading animating:YES];
        [self loadData:YES];
    }
}

-(NSString *) getNoMoreNote{
    if (self.userUploadRecordListArray.count == 0) {
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
