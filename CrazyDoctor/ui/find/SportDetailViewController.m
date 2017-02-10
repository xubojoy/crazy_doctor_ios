//
//  SportDetailViewController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/18.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "SportDetailViewController.h"
#import "WLZShareController.h"
#import "CoordinateItem.h"
#import "DrawView.h"
#import "SportDetailStepCell.h"
#import "WCDSharkeyFunction.h"
@interface SportDetailViewController ()<WCDSharkeyFunctionDelegate>
@property (nonatomic, strong) Sharkey *curSharkey;

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) DrawView *drawLineChartView;
@end

@implementation SportDetailViewController
//- (instancetype)initWithTargetStepNum:(int)targetStepNum stepNumArray:(NSMutableArray *)stepNumArray{
//    self = [super init];
//    if (self) {
//        self.targetStepNum = targetStepNum;
//        self.stepNumArray = stepNumArray;
//        self.stepNumArray = (NSMutableArray *)[[self.stepNumArray reverseObjectEnumerator] allObjects];
//    }
//    return self;
//}

- (instancetype)initWithTargetStepNum:(int)targetStepNum stepNumDict:(NSMutableDictionary *)stepNumDict{

    self = [super init];
    if (self) {
        self.targetStepNum = targetStepNum;
        self.stepNumDict = stepNumDict;
//        self.stepNumArray = (NSMutableArray *)[[self.stepNumArray reverseObjectEnumerator] allObjects];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    UIImage *bgImg = [UIImage imageNamed:@"bg_exercise"];
    self.view.layer.contents = (id) bgImg.CGImage;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.stepNumBigArray = [NSMutableArray new];
    self.totalDataDict = [NSMutableDictionary new];
    [self setRightSwipeGestureAndAdaptive];
    [self initHeadView];
    [self buildDataSource];
    [self buildView];
    [self initTableView];
    NSLog(@"七天数据----------%@",self.stepNumDict);
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"详情" navigationController:self.navigationController];
    self.headerView.bgImg.hidden = YES;
    self.headerView.line.hidden = YES;
    self.headerView.backgroundColor = [UIColor clearColor];
    [self.headerView.backBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.headerView.backBut setImage:[UIImage imageNamed:@"icon_shop_back"] forState:UIControlStateNormal];
    self.headerView.title.textColor = [UIColor whiteColor];
    [self.view addSubview:self.headerView];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(screen_width-10-100, 20, 100, 44);
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn setImage:[UIImage imageNamed:@"icon_share_white_nor"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"icon_share_white_pre"] forState:UIControlStateHighlighted];
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -50);
    [rightBtn addTarget:self action:@selector(rightShareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:rightBtn];
}

/**
 *  @author li_yong
 *
 *  构建数据源
 */
- (void)buildDataSource
{
    self.dataSource = [NSMutableArray arrayWithCapacity:0];
    
    DateUtils *today = [[DateUtils alloc] initWithDate:[NSDate date]];
    int week = today.week;
    NSLog(@">>>>>>>>>>>>%d",week);
    CoordinateItem *item = [[CoordinateItem alloc] initWithXValue:@""
                                                       withYValue:@"0"
                                                        withColor:[UIColor redColor]];
    [self.dataSource addObject:item];
    float totalStepNum = 0.0;
    float totalWalkDistance = 0.0;
    float totalWalkCal = 0.0;
    
    for (int i = 0; i < 7; i ++) {
//        int stepNum = [self.stepNumArray[i] intValue];
        NSString *date = [DateUtils getADayYearAndMonthFromDate:[NSDate date] withNumber:[NSString stringWithFormat:@"%d",(-6+i)]];
        int stepNum = [self.stepNumDict[date] intValue];
        
        NSLog(@">>>>>>>数据布局>>>>>>>%@>>>>>>>%@",[DateUtils weekDayStringByWeek:(i + week)%7],date);
        CoordinateItem *item1 = [[CoordinateItem alloc] initWithXValue:[DateUtils weekDayStringByWeek:(i + week)%7]
                                                            withYValue:[NSString stringWithFormat:@"%d",stepNum]
                                                             withColor:[UIColor greenColor]];
        [self.dataSource addObject:item1];
        WCDSharkeyFunction *wcd = [WCDSharkeyFunction shareInitializationt];
        NSInteger height;
        NSInteger weight;
        AppStatus *as = [AppStatus sharedInstance];
        if (as.user.userHeight == 0) {
            height = 170;
        }else{
            height = as.user.userHeight;
        }
        CGFloat walkDistance = [wcd getDistanceWalk:height numStep:stepNum];
        NSLog(@"走步公里 == %f",walkDistance);
        if (as.user.userWeight == 0) {
            weight = 60;
        }else{
            weight = as.user.userWeight;
        }
        CGFloat walkCal = [wcd getkCalWalk:walkDistance weight:weight];
        NSLog(@"走步卡路里 == %f",walkCal);
        NSMutableDictionary *stepNumDict = [NSMutableDictionary new];
        [stepNumDict setObject:@(stepNum) forKey:@"stepNum"];
        [stepNumDict setObject:[NSString stringWithFormat:@"%.2f",walkDistance] forKey:@"walkDistance"];
        [stepNumDict setObject:[NSString stringWithFormat:@"%.2f",walkCal] forKey:@"walkCal"];
        [stepNumDict setObject:[NSString stringWithFormat:@"周%@",[DateUtils weekDayStringByWeek:(i + week)%7]] forKey:@"date"];
        [self.stepNumBigArray addObject:stepNumDict];
        totalStepNum = totalStepNum + stepNum;
        totalWalkDistance = totalWalkDistance + walkDistance;
        totalWalkCal = totalWalkCal + walkCal;
    }
    [self.totalDataDict setObject:@(totalStepNum) forKey:@"stepNum"];
    [self.totalDataDict setObject:[NSString stringWithFormat:@"%.2f",totalWalkDistance] forKey:@"walkDistance"];
    [self.totalDataDict setObject:[NSString stringWithFormat:@"%.2f",totalWalkCal] forKey:@"walkCal"];
    
    self.stepNumBigArray = (NSMutableArray *)[[self.stepNumBigArray reverseObjectEnumerator] allObjects];
    [self.tableView reloadData];
}


- (void)buildView
{
    self.drawLineChartView = [[DrawView alloc] initWithFrame:CGRectMake(10, self.headerView.frame.size.height, screen_width-20, 305)
                                                   withDataSource:self.dataSource
                                                         withType:LineChartViewType
                                                    withAnimation:YES targetNum:self.targetStepNum];
    //只有当视图加载出来(即显示出来的时候才会调用drawRect方法)
    self.drawLineChartView.layer.cornerRadius = 2;
    self.drawLineChartView.layer.masksToBounds = YES;
    [self.view addSubview:self.drawLineChartView];
 
    NSString *date = [DateUtils getADayYearAndMonthFromDate:[NSDate date] withNumber:[NSString stringWithFormat:@"%d",0]];
    int stepNum = [self.stepNumDict[date] intValue];
    
    UILabel *todaySleepLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, self.drawLineChartView.frame.size.width-40-15, 20)];
    todaySleepLabel.text = [NSString stringWithFormat:@"%d步",stepNum];
    todaySleepLabel.textColor = [UIColor whiteColor];
    todaySleepLabel.font = [UIFont systemFontOfSize:15];
    todaySleepLabel.textAlignment = NSTextAlignmentRight;
    todaySleepLabel.backgroundColor = [UIColor clearColor];
    [self.drawLineChartView addSubview:todaySleepLabel];
    
    UILabel *todayLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, self.drawLineChartView.frame.size.width-40-15, 20)];
    todayLabel.text = @"今天";
    todayLabel.textColor = [UIColor whiteColor];
    todayLabel.font = [UIFont systemFontOfSize:14];
    todayLabel.textAlignment = NSTextAlignmentRight;
    todayLabel.backgroundColor = [UIColor clearColor];
    [self.drawLineChartView addSubview:todayLabel];

}

//初始化tableview
-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, self.drawLineChartView.frame.size.height+self.drawLineChartView.frame.origin.y+15, screen_width-20,screen_height-self.drawLineChartView.frame.size.height-self.headerView.frame.size.height-20-15) style:UITableViewStylePlain];
//    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [ColorUtils colorWithHexString:@"#ffffff" alpha:0.1];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.layer.cornerRadius = 2;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark - tableViewDelegate and datasource
#pragma mark - tableViewDelegate and datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *sportDetailStepCellIdentifier = @"SportDetailStepCell1";
        UINib *nib = [UINib nibWithNibName:@"SportDetailStepCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:sportDetailStepCellIdentifier];
        SportDetailStepCell *cell = [tableView dequeueReusableCellWithIdentifier:sportDetailStepCellIdentifier forIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.backgroundView.backgroundColor = [UIColor clearColor];
        [cell renderSportDetailStepCell:self.totalDataDict row:indexPath.row];
        return cell;
    }else{
        static NSString *sportDetailStepCellIdentifier = @"SportDetailStepCell";
        UINib *nib = [UINib nibWithNibName:@"SportDetailStepCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:sportDetailStepCellIdentifier];
        SportDetailStepCell *cell = [tableView dequeueReusableCellWithIdentifier:sportDetailStepCellIdentifier forIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.backgroundView.backgroundColor = [UIColor clearColor];
        if (self.stepNumBigArray.count > 0) {
            NSDictionary *dict = self.stepNumBigArray[indexPath.row-1];
            [cell renderSportDetailStepCell:dict row:indexPath.row];
        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width-20, 30)];
    headerView.backgroundColor = [ColorUtils colorWithHexString:@"#684a39"];
    NSArray *array = @[@"日期",@"步数",@"公里",@"卡路里"];
    for (int i = 0; i < 4; i ++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(((screen_width-20)/4)*i, 0, (screen_width-20)/4, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:default_font_size];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = array[i];
        [headerView addSubview:label];
    }
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
