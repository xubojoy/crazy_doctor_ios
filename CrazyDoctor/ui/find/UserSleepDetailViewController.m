//
//  UserSleepDetailViewController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/8/18.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "UserSleepDetailViewController.h"
#import "WLZShareController.h"
#import "CoordinateItem.h"
#import "DrawCustomView.h"
#import "UserSleepDetailCell.h"
#import "WCDSharkeyFunction.h"
#import "UserStore.h"
@interface UserSleepDetailViewController ()<WCDSharkeyFunctionDelegate>
@property (nonatomic, strong) Sharkey *curSharkey;

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) DrawCustomView *drawLineChartView;

@end

@implementation UserSleepDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    UIImage *bgImg = [UIImage imageNamed:@"bg_exercise"];
    self.view.layer.contents = (id) bgImg.CGImage;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.stepNumBigArray = [NSMutableArray new];
    self.stepNumArray = [NSMutableArray new];
    self.sharkeyUserDataArray = [NSMutableArray new];
    self.sharkeyUserDataDict = [NSMutableDictionary new];
    self.totalDataDict = [NSMutableDictionary new];
    [self setRightSwipeGestureAndAdaptive];
    [self initHeadView];
    [self loadSharkeyData];

}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"睡眠" navigationController:self.navigationController];
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

- (void)loadSharkeyData{
    [SVProgressHUD showWithStatus:@"数据加载中..." maskType:SVProgressHUDMaskTypeNone];
    NSString *dateStr = [DateUtils getDateByDate:[NSDate date]];
    NSArray *tmpDateArray = [dateStr componentsSeparatedByString:@" "];
    NSString *dateTmpStr = tmpDateArray[0];
    
    NSString *date = [DateUtils getADayYearAndMonthFromDate:[NSDate date] withNumber:[NSString stringWithFormat:@"%d",-6]];
//    NSLog(@">>>>>>>>>>>七天前>>>>>>>%@--------%@",date,dateTmpStr);
    [UserStore getAllSharkeyData:^(NSMutableArray *sharkeyDataArray, NSError *error) {
//                NSLog(@">>>>>>>>>>>返回所有数据>>>>>>>%@",sharkeyDataArray);
        [SVProgressHUD dismiss];
        if (sharkeyDataArray.count > 0) {
            for (NSDictionary *sharkeyDataDict in sharkeyDataArray) {
                self.sharkeyData = [[SharkeyData alloc] initWithDictionary:sharkeyDataDict error:nil];
                if (self.sharkeyData != nil) {
                    [self.sharkeyUserDataArray addObject:self.sharkeyData];
                    NSString *creatDateStr = [DateUtils dateStringWithFromLongLongInt:self.sharkeyData.createTime];
//                    NSLog(@">>>>>>creatDateStr>>>>>>>>%@",creatDateStr);
                    
                    NSArray *creatDateArray = [creatDateStr componentsSeparatedByString:@" "];
                    [self.sharkeyUserDataDict setValue:self.sharkeyData forKey:[NSString stringWithFormat:@"%@",creatDateArray[0]]];
                }
            }
            NSLog(@">>>>>>>>>self.sharkeyUserDataDict>>>>>>>%@",self.sharkeyUserDataDict);
            for (SharkeyData *sharkeyData in self.sharkeyUserDataArray) {
                [self.stepNumArray addObject:@(sharkeyData.sleepTimeTotal)];
            }
            self.stepMaxNum = [[self.stepNumArray valueForKeyPath:@"@max.floatValue"] intValue];
            NSLog(@">>>>>>maxValue最大值>>>>>>>%d",self.stepMaxNum);
            [self buildDataSource];
        }

    } beginTime:date endTime:dateTmpStr];
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
//    NSLog(@">>>>>>>>>>>>%d",week);
    CoordinateItem *item = [[CoordinateItem alloc] initWithXValue:@""
                                                       withYValue:@"0"
                                                        withColor:[UIColor redColor]];
    [self.dataSource addObject:item];
    int totalSleepNum = 0;
    
    for (int i = 0; i < 7; i ++) {
        NSString *date = [DateUtils getADayYouWantFromDate:[NSDate date] withNumber:[NSString stringWithFormat:@"%d",(-6+i)]];
       
        SharkeyData *sharkeyData = self.sharkeyUserDataDict[date];
//         NSLog(@">>>>遍历的日期>>>>>>>>%@-------%@-------%@",date,self.sharkeyUserDataDict,sharkeyData);
        int sleepMin = 0;
        if (sharkeyData != nil) {
            sleepMin = (sharkeyData.sleepTimeTotal)/60;
        }else{
            sleepMin = 0;
        }
        CoordinateItem *item1 = [[CoordinateItem alloc] initWithXValue:[DateUtils weekDayStringByWeek:(i + week)%7]
                                                            withYValue:[NSString stringWithFormat:@"%d",sleepMin]
                                                             withColor:[UIColor greenColor]];
        [self.dataSource addObject:item1];
        
        NSMutableDictionary *stepNumDict = [NSMutableDictionary new];
        [stepNumDict setObject:@(sharkeyData.sleepTimeTotal) forKey:@"sleepTimeTotal"];
        [stepNumDict setObject:[NSString stringWithFormat:@"周%@",[DateUtils weekDayStringByWeek:(i + week)%7]] forKey:@"date"];
        [self.stepNumBigArray addObject:stepNumDict];
        totalSleepNum = totalSleepNum + sharkeyData.sleepTimeTotal;
        
    }
    [self.totalDataDict setObject:@(totalSleepNum/7) forKey:@"sleepTimeTotal"];
    
    
    self.stepNumBigArray = (NSMutableArray *)[[self.stepNumBigArray reverseObjectEnumerator] allObjects];
//    NSLog(@"-------------self.totalDataDict-----%@------%@",self.totalDataDict,self.stepNumBigArray);
    [self buildView];
    [self initTableView];
    [self.tableView reloadData];
}


- (void)buildView
{
    
    int target = 0;
    if (self.stepMaxNum == 0) {
        target = 24;
    }else{
        target = self.stepMaxNum;
    }
    NSLog(@">>>>目标时间>>>>>>%d>>>>>>>>>%d",target,self.stepMaxNum);
    self.drawLineChartView = [[DrawCustomView alloc] initWithFrame:CGRectMake(10, self.headerView.frame.size.height, screen_width-20, 305)
                                              withDataSource:self.dataSource
                                                    withType:LineChartViewType
                                               withAnimation:YES targetNum:target];
    //只有当视图加载出来(即显示出来的时候才会调用drawRect方法)
    self.drawLineChartView.layer.cornerRadius = 2;
    self.drawLineChartView.layer.masksToBounds = YES;
    [self.view addSubview:self.drawLineChartView];
    
    
    
    UILabel *remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 35, 40)];
    remindLabel.text = @"睡眠\n时长";
    remindLabel.textColor = [UIColor whiteColor];
    remindLabel.font = [UIFont systemFontOfSize:14];
    remindLabel.textAlignment = NSTextAlignmentRight;
    remindLabel.backgroundColor = [UIColor clearColor];
    remindLabel.numberOfLines = 0;
    [self.drawLineChartView addSubview:remindLabel];
    
    NSString *date = [DateUtils getADayYouWantFromDate:[NSDate date] withNumber:[NSString stringWithFormat:@"%d",0]];
//    NSString *tmpDate = [date stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
//    NSLog(@">>>>>jintian>>>>>>>%@",date);
    
    SharkeyData *sharkeyData = self.sharkeyUserDataDict[date];
//    NSLog(@">>>>>sharkeyData>>>>>>>%@",sharkeyData);
    int hour = sharkeyData.sleepTimeTotal / 60; //3小时
    int minremains = sharkeyData.sleepTimeTotal % 60; //余数，20分钟

    
    UILabel *todaySleepLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, self.drawLineChartView.frame.size.width-40-15, 20)];
    todaySleepLabel.text = [NSString stringWithFormat:@"%d小时%d分",hour,minremains];
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
        static NSString *sportDetailStepCellIdentifier = @"UserSleepDetailCell1";
        UINib *nib = [UINib nibWithNibName:@"UserSleepDetailCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:sportDetailStepCellIdentifier];
        UserSleepDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:sportDetailStepCellIdentifier forIndexPath:indexPath];
        cell.contentView.backgroundColor = [ColorUtils colorWithHexString:@"#684a39"];
        cell.backgroundColor = [ColorUtils colorWithHexString:@"#684a39"];
        cell.backgroundView.backgroundColor = [ColorUtils colorWithHexString:@"#684a39"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell renderUserSleepDetailCell:self.totalDataDict row:indexPath.row];
        return cell;
    }else{
        static NSString *sportDetailStepCellIdentifier = @"UserSleepDetailCell";
        UINib *nib = [UINib nibWithNibName:@"UserSleepDetailCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:sportDetailStepCellIdentifier];
        UserSleepDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:sportDetailStepCellIdentifier forIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.backgroundView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.stepNumBigArray.count > 0) {
            NSDictionary *dict = self.stepNumBigArray[indexPath.row-1];
            [cell renderUserSleepDetailCell:dict row:indexPath.row];
        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width-20, 30)];
//    headerView.backgroundColor = [ColorUtils colorWithHexString:@"#684a39"];
//    NSArray *array = @[@"日期",@"步数",@"公里",@"卡路里"];
//    for (int i = 0; i < 4; i ++) {
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(((screen_width-20)/4)*i, 0, (screen_width-20)/4, 30)];
//        label.backgroundColor = [UIColor clearColor];
//        label.textColor = [UIColor whiteColor];
//        label.font = [UIFont systemFontOfSize:default_font_size];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.text = array[i];
//        [headerView addSubview:label];
//    }
//    
//    return headerView;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 30;
//}


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
