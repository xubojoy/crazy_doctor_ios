//
//  SleepDetailViewController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/25.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "SleepDetailViewController.h"
#import "SleepDetailCell.h"
#import "UserSleepDetailViewController.h"
#import "UserStore.h"
#import "NSDate+TimeCategory.h"
@interface SleepDetailViewController ()

@end

@implementation SleepDetailViewController
- (instancetype)initWithSharkeyData:(SharkeyData *)sharkeyData dateTitle:(NSString *)dateTitle dateStr:(NSString *)dateStr{
    self = [super init];
    if (self) {
        self.sharkeyData = sharkeyData;
        self.dateTitle = dateTitle;
        self.dateStr = dateStr;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    UIImage *bgImg = [UIImage imageNamed:@"bg_exercise"];
    self.view.layer.contents = (id) bgImg.CGImage;
    self.sleepDetailArray = [NSMutableArray new];
    [self initHeadView];
    [self initBgScrollView];
    [self initUI];
    [self loadDeepSleepData];
}
- (void)initUI{
    [self initTopDateView];
    [self initSleepQualityView];
    [self initCircleView:(24*60) realNum:self.sharkeyData.sleepTimeTotal];
    [self initDeepAndLightSleepView];
    [self initTableView];
}

- (void)loadDeepSleepData{
    if (self.sharkeyData.sleepDetails.count > 0) {
        for (NSDictionary *sleepDetailDict in self.sharkeyData.sleepDetails) {
//            NSLog(@">>>>>>>>>睡眠详情sleepDetail>>>>%@",sleepDetailDict);
            self.sleepDetail = [[SleepDetail alloc] initWithDictionary:sleepDetailDict error:nil];
            if (self.sleepDetail != nil) {
                [self.sleepDetailArray addObject:self.sleepDetail];
            }
        }
//        NSLog(@">>>>>>>>>睡眠详情self.sleepDetailArray>>>>%@",self.sleepDetailArray);
    }
//    [self initTableView];
    [self.tableView reloadData];
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
}

- (void)initBgScrollView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height+general_padding, screen_width, screen_height-self.headerView.frame.size.height-general_padding)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(screen_width, 200000);
    [self.view addSubview:self.scrollView];
}

- (void)initTopDateView{
    UILabel *todayLabel = [[UILabel alloc] initWithFrame:CGRectMake((screen_width-40)/2, 0, 40, 20)];
    todayLabel.text = self.dateTitle;
    todayLabel.font = [UIFont boldSystemFontOfSize:default_1_font_size];
    todayLabel.textColor = [UIColor whiteColor];
    todayLabel.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:todayLabel];
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, todayLabel.bottomY, screen_width, 20)];
//    NSString *dateStr = [DateUtils getDateByPickerDate:[NSDate date]];
//    NSArray *array = [dateStr componentsSeparatedByString:@" "];
//    int week = [DateUtils weekDayFromDate:[NSDate date]];
//    NSString *weekStr = [DateUtils weekDayStringWithWeek:week];
    self.dateLabel.text = self.dateStr;
    self.dateLabel.font = [UIFont systemFontOfSize:small_font_size];
    self.dateLabel.textColor = [ColorUtils colorWithHexString:@"#faefde"];
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:self.dateLabel];
    
    self.sleepQuerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.dateLabel.bottomY, screen_width, 20)];
    self.sleepQuerLabel.textColor = [UIColor whiteColor];
    self.sleepQuerLabel.text = @"睡眠质量";
    self.sleepQuerLabel.textAlignment =NSTextAlignmentCenter;
    self.sleepQuerLabel.font = [UIFont systemFontOfSize:14];
    [self.scrollView addSubview:self.sleepQuerLabel];
}

- (void)initSleepQualityView{
    self.sleepQualityImgView = [[UIImageView alloc] initWithFrame:CGRectMake((screen_width-28)/2, self.sleepQuerLabel.bottomY+12, 28, 28)];
    self.sleepQualityImgView.image = [UIImage imageNamed:@"icon_you"];
    [self.scrollView addSubview:self.sleepQualityImgView];
}

- (void)initCircleView:(NSInteger)targetNum realNum:(NSInteger)realNum{

    NSInteger biao = targetNum;
    NSInteger xian = realNum;
    self.circleView = [[CustomSleepCircleView alloc] initWithFrame:CGRectMake((screen_width - (293/2)) * 0.5, self.sleepQualityImgView.bottomY+23, 293/2, 293/2) tagartStep:biao realStep:xian];
    self.circleView.tagartLabel.hidden = YES;
    self.circleView.flagImageView.hidden = YES;
    [self.scrollView addSubview:self.circleView];
    float cha = xian-biao;
    float rate = (cha)/(float)biao;
    NSLog(@">>>>rateraterateraterate111111>>>>>>%.2f",rate);
    if (rate < 0) {
        rate = 1+rate;
    }else{
        if (biao == xian) {
            rate = 1;
        }else{
            rate = rate;
        }
    }
    NSLog(@">>>>rateraterateraterate222222>>>>>>%.2f",rate);
    int finalRate = rate*100;
    self.circleView.rate = finalRate;
    [self.circleView startAnimation];
    
    UIImageView *iconSleepImgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.circleView.frame.size.width-19)/2, 20, 19, 21)];
    iconSleepImgView.image = [UIImage imageNamed:@"icon_sleep"];
    [self.circleView addSubview:iconSleepImgView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.circleView.frame.size.height-28-20), self.circleView.frame.size.width, 20)];
    label.text = @"睡眠时长";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [ColorUtils colorWithHexString:@"#efd6bc"];
    label.textAlignment = NSTextAlignmentCenter;
    [self.circleView addSubview:label];
    
    
    UIButton *sleepDetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sleepDetailBtn.frame = CGRectMake((screen_width - (293/2))/2,  self.sleepQualityImgView.bottomY+23, 293/2, 293/2);
    [sleepDetailBtn addTarget:self action:@selector(sleepDetailBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sleepDetailBtn];
}

- (void)initDeepAndLightSleepView{
    self.deepAndLightSleepView = [[DeepAndLightSleepView alloc] initWithFrame:CGRectMake(0, self.circleView.bottomY+42, screen_width, 55)];
    self.deepAndLightSleepView.backgroundColor = [UIColor clearColor];
    [self.deepAndLightSleepView renderDeepAndLightSleepView:self.sharkeyData];
    [self.scrollView addSubview:self.deepAndLightSleepView];
}

//初始化tableview
-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, self.deepAndLightSleepView.frame.size.height+self.deepAndLightSleepView.frame.origin.y+15, screen_width-20,screen_height-(self.deepAndLightSleepView.frame.size.height+self.deepAndLightSleepView.frame.origin.y+15)) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [ColorUtils colorWithHexString:@"#ffffff" alpha:0.1];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.layer.cornerRadius = 2;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.scrollView addSubview:self.tableView];
    NSLog(@">>>>>>>>self.sleepDetailArray个数>>>>%d",(int)self.sleepDetailArray.count);
}

#pragma mark - tableViewDelegate and datasource
#pragma mark - tableViewDelegate and datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sleepDetailArray.count + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *sleepDetailCellIdentifier = @"SleepDetailCell1";
        UINib *nib = [UINib nibWithNibName:@"SleepDetailCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:sleepDetailCellIdentifier];
        SleepDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:sleepDetailCellIdentifier forIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.backgroundView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        cell.titleLabel.text = @"睡眠开始时间";
        cell.deepSleepTimeLabel.hidden = YES;
        if (self.sharkeyData != nil) {
            NSString *dateStr = [DateUtils dateStringWithFromLongLongInt:self.sharkeyData.sleepStartMinutes];
            NSLog(@">>>>>>睡眠开始时间>>>>>>>>%@",dateStr);
            NSArray *dateArray = [dateStr componentsSeparatedByString:@" "];
            cell.timeLongLabel.text = dateArray[1];
        }
        return cell;
    }else{
        static NSString *sleepDetailCellIdentifier = @"SleepDetailCell";
        UINib *nib = [UINib nibWithNibName:@"SleepDetailCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:sleepDetailCellIdentifier];
        SleepDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:sleepDetailCellIdentifier forIndexPath:indexPath];
        cell.deepSleepTimeLabel.hidden = NO;
        cell.titleLabel.text = @"深睡时间";
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.backgroundView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        if (self.sleepDetailArray.count > 0) {
            SleepDetail *sleepDetail = self.sleepDetailArray[indexPath.row-1];
            [cell renderSleepDetailCellWithSleepDetail:sleepDetail];
        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGRect tableViewFrame = self.tableView.frame;
    tableViewFrame.size.height = (self.sleepDetailArray.count+1)*55;
    self.tableView.frame = tableViewFrame;
    self.scrollView.contentSize = CGSizeMake(screen_width, 64+20+60+28+12+23+293/2+42+55+(self.sleepDetailArray.count+1)*55);
    return 55;
}

- (void)sleepDetailBtnClick{
    UserSleepDetailViewController *usdvc = [[UserSleepDetailViewController alloc] init];
    [self.navigationController pushViewController:usdvc animated:YES];
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
