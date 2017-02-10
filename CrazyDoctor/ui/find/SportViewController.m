//
//  SportViewController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/6/28.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "SportViewController.h"
#import "WCDSharkeyFunction.h"
#import "AppDelegate.h"
#import "SettingSportTargetController.h"
#import "SportResultRankController.h"
#import "SportHistoryViewController.h"
#import "SportDetailViewController.h"
#import "NewSharkeyData.h"
#import "UserStore.h"
#import "SleepDetail.h"
#import "SportSelectSharkeyController.h"
#import "SleepDetailViewController.h"
@interface SportViewController ()<WCDSharkeyFunctionDelegate>
@property (nonatomic, strong) Sharkey *curSharkey;
@property (nonatomic, strong) WCDSharkeyFunction *wcdsharkey;
@end

@implementation SportViewController
- (void)viewWillAppear:(BOOL)animated{
    debugMethod();
    [super viewWillAppear:animated];
    [(AppDelegate*)[UIApplication sharedApplication].delegate tabbar].tabBarController.statusBarStyle = UIStatusBarStyleLightContent;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(settingTargetNum:) name:@"设置计步目标" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectSuccessGetData:) name:@"设备连接成功" object:nil];
    [self checkBlue];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    debugMethod();
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    UIImage *bgImg = [UIImage imageNamed:@"bg_exercise"];
    self.view.layer.contents = (id) bgImg.CGImage;
    self.view.userInteractionEnabled = YES;
    self.stepNumArray = [NSMutableArray new];
    self.stepNumDict = [NSMutableDictionary new];
    self.setOffNum = 0;
    [self setRightSwipeGestureAndAdaptive];
    [self initHeadView];
    if (self.setOffNum == 0) {
        if ([AppStatus sharedInstance].sharkey == nil) {
            [self initCustomEmptyView];
        }else{
            [SVProgressHUD showWithStatus:@"数据读取中..." maskType:SVProgressHUDMaskTypeClear];
            [self immediateConnectSharkey];
            [self initUI];
        }
    }
    [self initBottomSportRankView];
}

//- (void)showZhezhao{
//    debugMethod();
//    [SVProgressHUD showWithStatus:@"数据读取中..." maskType:SVProgressHUDMaskTypeClear];
//}

- (void)checkBlue{
    debugMethod();
    self.manager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    self.manager.delegate = self;
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    debugMethod();
    
    if (central.state != CBCentralManagerStatePoweredOn) {
        NSLog(@"fail, state is off.");
        [SVProgressHUD dismiss];
        switch (central.state) {
            case CBCentralManagerStatePoweredOff:
                NSLog(@"连接失败了\n请您再检查一下您的手机蓝牙是否开启，\n然后再试一次吧");
                
                break;
            case CBCentralManagerStateResetting:
                
                break;
            case CBCentralManagerStateUnsupported:
                NSLog(@"检测到您的手机不支持蓝牙4.0\n所以建立不了连接.建议更换您\n的手机再试试。");
                
                break;
            case CBCentralManagerStateUnauthorized:
                NSLog(@"连接失败了\n请您再检查一下您的手机蓝牙是否开启，\n然后再试一次吧");
                break;
            case CBCentralManagerStateUnknown:
                
                break;
            default:
                break;
        }
        return;
    }else{
        [self performSelector:@selector(dismissSportHUDView) withObject:self afterDelay:30];
    }
}


- (void)initUI{
    debugMethod();
    [SVProgressHUD showWithStatus:@"数据读取中..." maskType:SVProgressHUDMaskTypeClear];
    if ([[AppStatus sharedInstance].targetNum intValue] == 0) {
        self.targetStepNum = 10000;
    }else{
        self.targetStepNum = [[AppStatus sharedInstance].targetNum intValue];
    }
    [self initTopDateView];
    [self initCircleView:self.targetStepNum realNum:self.stepNum];
    [self initKandKaView];

    NSInteger biao = self.targetStepNum;
    NSInteger xian = self.stepNum;
    float cha = xian-biao;
    float rate = (cha)/(float)biao;
    NSLog(@">>>>rateraterateraterate111111>>>>>>%.2f",rate);
    if (rate < 0) {
        rate = 1+rate;
    }else{
        if (biao == xian || xian >= biao) {
            rate = 1;
        }else{
            rate = rate;
        }
    }
    NSLog(@">>>>rateraterateraterate222222>>>>>>%.2f",rate);
    int finalRate = rate*100;
    
    [self initLineViewWithRate:finalRate];
    [self.sleepRecordLabel removeFromSuperview];
    [self.sleepRecordNumLabel removeFromSuperview];
    [self initSleepDataView];
    [self initTargetKmKcall];
}

- (void)connectSuccessGetData:(NSNotification *)nofit{
    self.curSharkey = (Sharkey *)nofit.object;
    NSLog(@">>>>>>>>传递过来的：%@",self.curSharkey);
    
    [self immediateConnectSharkey];
    [self.customEmptyView removeFromSuperview];
    [self initUI];
}

- (void)settingTargetNum:(NSNotification *)notifi{
    NSString *targetNum = (NSString *)notifi.object;
    self.targetStepNum = [targetNum intValue];
    NSLog(@"______________%d",[targetNum intValue]);
    [self.kandkaView removeFromSuperview];
    [self.iconImgView removeFromSuperview];
    [self.renImgView removeFromSuperview];
    [self.circleView removeFromSuperview];
    [self.downArrawImgView removeFromSuperview];
    [self.resultLabel removeFromSuperview];
    [self.resultKcalLabel removeFromSuperview];
//    [self.sleepRecordLabel removeFromSuperview];
//    [self.sleepRecordNumLabel removeFromSuperview];
    [self.downArrawImgView removeFromSuperview];
    [self.customProgressLineView removeFromSuperview];
    [self initCircleView:[targetNum intValue] realNum:self.stepNum];
    [self initTargetKmKcall];
}

- (void)immediateConnectSharkey{
    [SVProgressHUD showWithStatus:@"数据读取中..." maskType:SVProgressHUDMaskTypeClear];
    WCDSharkeyFunction *wcd = [WCDSharkeyFunction shareInitializationt];
    [wcd setNotifyRemoteToChangeLanguage:0];
    [wcd setTimeSynchronization];
    
//    SharkeyState state = [wcd querySharkeyState];
//    if (state == SharkeyStateConnected) {
//        [wcd querySleepDataFromSharkey];
//        [wcd updatePedometerDataFromRemoteTotalNumberOfDays:0x07];
//    }else{
        NSDictionary *sharkeyInfo = @{SHARKEYPAIRTYPE_KEY:@(1), SHARKEYIDENTIFIER_KEY:[AppStatus sharedInstance].sharkey.identifier, SHARKEYMACADDRESS_KEY:[AppStatus sharedInstance].sharkey.macAddress, SHARKEYMODELNAME_KEY:[AppStatus sharedInstance].sharkey.modelName};
        Sharkey *sharkey = [wcd retrieveSharkey:sharkeyInfo];
        wcd.delegate = self;
        [wcd connectSharkey:sharkey];
//    }
}

#pragma mark -- WCDSharkeyFunctionDelegate

- (void)WCDConnectSuccessCallBck:(BOOL)flag sharkey:(Sharkey *)intactSharkey
{
    self.curSharkey = intactSharkey;
    NSLog(@"连接结果返回的intactSharkey: %@", intactSharkey);
    if (flag) {
        NSLog(@"连接成功");
//        [SVProgressHUD showWithStatus:@"数据读取中..." maskType:SVProgressHUDMaskTypeClear];
        WCDSharkeyFunction *wcd = [WCDSharkeyFunction shareInitializationt];
        [wcd setNotifyRemoteToChangeLanguage:0];
        [wcd setTimeSynchronization];
        [wcd querySleepDataFromSharkey];
        [wcd updatePedometerDataFromRemoteTotalNumberOfDays:0x07];
    }
    else {
        [SVProgressHUD showErrorWithStatus:@"连接失败!" maskType:SVProgressHUDMaskTypeClear];
        [self initCustomEmptyView];
        NSLog(@"连接失败");
    }
}


/**
 *  发送数据故障回调
 *
 *  @param result   SharkeySentDataResult
 */
- (void)WCDSharkeyDidSendFault:(SharkeySentDataResult)result
{
    NSLog(@"SharkeySentDataResult: %ld", (long)result);
}

/**
 *  sharkey响应的数据
 *
 *  @param userInfo userInfo
 */
- (void)WCDSharkeyRespond:(NSDictionary *)respondInfo
{
    NSLog(@"respondInfo: %@", respondInfo);
}

- (void)WCDPedometerDate:(NSDate *)date Count:(NSInteger)count Minute:(NSInteger)minute
{
    [self.stepNumArray addObject:@(count)];
    NSString *dateStr = [DateUtils getDateBySingleDate:date];
    NSDate *nowDate = [NSDate date];
    NSString *nowDateStr = [DateUtils getDateBySingleDate:nowDate];
    NSLog(@"时间比较 == %@-------%@",dateStr,nowDateStr);
    NSArray *dateStrArray = [dateStr componentsSeparatedByString:@" "];
    NSArray *nowDateStrArray = [nowDateStr componentsSeparatedByString:@" "];
    [self.stepNumDict setObject:@(count) forKey:dateStrArray[0]];
    if ([dateStrArray[0] isEqualToString:nowDateStrArray[0]]) {
        self.stepNum = count;
        [self.kandkaView removeFromSuperview];
        [self.iconImgView removeFromSuperview];
        [self.renImgView removeFromSuperview];
        [self.circleView removeFromSuperview];
        [self.resultLabel removeFromSuperview];
        [self.resultKcalLabel removeFromSuperview];
        [self.downArrawImgView removeFromSuperview];
        [self.customProgressLineView removeFromSuperview];
        [self initTargetKmKcall];
        [self initCircleView:self.targetStepNum realNum:count];
        WCDSharkeyFunction *wcd = [WCDSharkeyFunction shareInitializationt];
        NSInteger height;
        NSInteger weight;
        AppStatus *as = [AppStatus sharedInstance];
        if (as.user.userHeight == 0) {
            height = 170;
        }else{
            height = as.user.userHeight;
        }
        self.walkDistance = [wcd getDistanceWalk:height numStep:count];
        if (as.user.userWeight == 0) {
            weight = 60;
        }else{
            weight = as.user.userWeight;
        }
        self.walkCal = [wcd getkCalWalk:self.walkDistance weight:weight];
        [self initKandKaView];
    }
    NSLog(@"计步日期 == %@",date);
    NSLog(@"计步步数 == %ld",(long)count);
    NSLog(@"计步时长 == %ld",(long)minute);
}

- (void)WCDShackSetStepTargetCallBack:(NSData*)data{
    if(data.length == 5){
        NSLog(@"设置计步成功");
    }
}


- (void)WCDQuerySleepDataFromSharkeyCallBack:(NSUInteger)startMinute rawData:(NSData *)rawData gatherRate:(SleepDataGatherRate)gatherRate
{
    NSLog(@"startMinute: %ld, rawData: %@, gatherRate: %ld", (unsigned long)startMinute, rawData, (long)gatherRate);
    WCDSharkeyFunction *wcd = [WCDSharkeyFunction shareInitializationt];
    SleepDataInfo *sleepInfo = [wcd analyseSleep:startMinute data:rawData gatherRate:gatherRate];
    NSLog(@"sleepDataInfo: %@", sleepInfo);
    self.sleepRecordLabel.text = @"睡眠时长";
    
//    NSInteger startDate = ((unsigned long)sleepInfo.startMinute)*60;
//    NSString *dateStr = [DateUtils stringFromLongLongIntDate:startDate*60*1000];
    NSDate *date = [NSDate date];
    
    NewSharkeyData *newSharkeyData = [[NewSharkeyData alloc] init];
    newSharkeyData.userId = [AppStatus sharedInstance].user.id;
    newSharkeyData.createTime = [DateUtils longlongintFromDate:date];
    newSharkeyData.step = self.stepNum;
    newSharkeyData.distance = self.walkDistance;
    newSharkeyData.kCall = self.walkCal;
//    NSString *startSleepDate = [DateUtils dateWithStringFromLongLongInt:(sleepInfo.startMinute-(8*60))*60*1000];
//    NSInteger startTmpDate = [DateUtils stringToTime:startSleepDate];
//    NSLog(@"转换后的时间startTmpDate: %@------%ld", startSleepDate,(long)startTmpDate);
//     NSString *yanzhengStr = [DateUtils dateWithStringFromLongLongInt:startTmpDate];
//    NSLog(@"yanzheng: %@", yanzhengStr);
//    newSharkeyData.sleepStartMinutes = startTmpDate;
    self.deepSleepArr = [NSMutableArray new];
    NSMutableArray *sleepStartTimeArray = [NSMutableArray new];
    int sleepTimeTotal = 0;
    int sleepTimeDeep = 0;
    int sleepTimeLight = 0;
    long long int start = 0;
    for (SleepSectionInfo *sleepSectionInfo in sleepInfo.sectionInfos) {
//        NSInteger startDate = (unsigned long)sleepSectionInfo.startMinute;
//        NSString *startSleepDate = [DateUtils dateWithStringFromLongLongInt:(startDate)*60*1000];
//        NSDate *startTmpDate = [DateUtils getDateByString:startSleepDate];
////         NSLog(@"startTmpDate:%@------- %@",startSleepDate, startTmpDate);
//        
//        NSInteger endDate = (unsigned long)sleepSectionInfo.endMinute;
//        NSString *endSleepDate = [DateUtils dateWithStringFromLongLongInt:(endDate)*60*1000];
//        
//        NSDate *endTmpDate = [DateUtils getDateByString:endSleepDate];
////        NSLog(@"endTmpDate:%@------- %@",endSleepDate, endTmpDate);
//        
//        SleepDetail *sleepDetail = [[SleepDetail alloc] init];
//        sleepDetail.sleepStartMinutes = [DateUtils longlongintFromDate:startTmpDate];
//        sleepDetail.sleepEndMinutes = [DateUtils longlongintFromDate:endTmpDate];
//        sleepDetail.deep = (int)sleepSectionInfo.deepMinute;
//        [self.deepSleepArr addObject:[sleepDetail toDictionary]];
        SleepDetail *sleepDetail = [self filterAvailableSleepDetail:sleepSectionInfo];
        if (sleepDetail != nil) {
            NSLog(@"++++++sleepDetail++++++%@",sleepDetail);
            long long int startBean = sleepDetail.sleepStartMinutes;
            if (start == 0) {
                start = startBean;
            } else if (start > startBean){
                start = startBean;
            }

            sleepTimeTotal += ((sleepDetail.sleepEndMinutes - sleepDetail.sleepStartMinutes) / 1000) / 60;
            sleepTimeDeep += sleepDetail.deep;
            [self.deepSleepArr addObject:[sleepDetail toDictionary]];
            [sleepStartTimeArray addObject:@(start)];
        }
    }
    
    long long int maxTime;
    
    long long int minTime;
    if (sleepStartTimeArray.count > 0) {
        [self getMaxAndMin:sleepStartTimeArray max:&maxTime min:&minTime];
        NSLog(@"最大值: %lldd,最小值: %lldd",maxTime,minTime);
        newSharkeyData.sleepStartMinutes = minTime;
    }
    
    newSharkeyData.sleepDetails = (NSMutableArray<SleepDetail> *)self.deepSleepArr;
    sleepTimeLight = sleepTimeTotal - sleepTimeDeep;
    newSharkeyData.sleepTimeTotal = sleepTimeTotal;
    newSharkeyData.sleepTimeDeep = sleepTimeDeep;
    newSharkeyData.sleepTimeLight = sleepTimeLight;
    int deephour = (int)sleepTimeTotal / 60; //3小时
    int deepminremains = (int)sleepTimeTotal % 60; //余数，20分钟
    if (deepminremains == 0) {
        self.sleepRecordNumLabel.text = [NSString stringWithFormat:@"%d小时00分钟",deephour];
    }else{
        self.sleepRecordNumLabel.text = [NSString stringWithFormat:@"%d小时%d分钟",deephour,deepminremains];
    }
    
    self.sharkeyData = [[SharkeyData alloc] init];
    self.sharkeyData.userId = newSharkeyData.userId;
    self.sharkeyData.createTime = newSharkeyData.createTime;
    self.sharkeyData.step = newSharkeyData.step;
    self.sharkeyData.distance = newSharkeyData.distance;
    self.sharkeyData.kCall = newSharkeyData.kCall;
    self.sharkeyData.sleepStartMinutes = newSharkeyData.sleepStartMinutes;
    self.sharkeyData.sleepTimeTotal = sleepTimeTotal;
    self.sharkeyData.sleepTimeDeep = sleepTimeDeep;
    self.sharkeyData.sleepTimeLight = sleepTimeLight;
    self.sharkeyData.sleepDetails = (NSMutableArray<SleepDetail> *)self.deepSleepArr;
    NSLog(@"同步手环数据---传递-------%@",self.sharkeyData);
//    NSLog(@"newSharkeyData----------%@",newSharkeyData);/
    [UserStore syncSharkeyData:^(SharkeyData *sharkeyData, NSError *err) {
        [SVProgressHUD dismiss];
        if (err == nil) {
            NSLog(@"同步手环数据----------%@",sharkeyData);
        }
    } NewSharkeyData:newSharkeyData];
}

- (SleepDetail *)filterAvailableSleepDetail:(SleepSectionInfo *)sleepSectionInfo{
    
    NSInteger startDate = (unsigned long)sleepSectionInfo.startMinute;
    NSString *startSleepDate = [DateUtils dateWithStringFromLongLongInt:(startDate-(8*60))*60*1000];
    NSInteger endDate = (unsigned long)sleepSectionInfo.endMinute;
    NSString *endSleepDate = [DateUtils dateWithStringFromLongLongInt:(endDate-(8*60))*60*1000];
    
//    NSString *startStr = [DateUtils dateWithStringFromLongLongInt:sleepDetail.sleepStartMinutes];
//    NSString *endStr = [DateUtils dateWithStringFromLongLongInt:sleepDetail.sleepEndMinutes];
    
    NSInteger starttmp = [DateUtils stringToTime:startSleepDate];
    NSLog(@"startStr：%@ -> %ld",startSleepDate,(long)starttmp);
    NSString *starttmpStr = [DateUtils dateWithStringFromLongLongInt:starttmp];
    NSLog(@"startStr：%@",starttmpStr);
    NSInteger endtmp = [DateUtils stringToTime:endSleepDate];
    NSLog(@"endStr：%@ -> %ld",endSleepDate,(long)endtmp);
   NSString *endtmpStr = [DateUtils dateWithStringFromLongLongInt:endtmp];
    NSLog(@"endStr：%@",endtmpStr);
    
    NSString *datechaStr = [DateUtils getADayYearAndMonthFromDate:[NSDate date] withNumber:[NSString stringWithFormat:@"%d",(-1)]];
    
    NSInteger s12tmp = [DateUtils stringToTime:[NSString stringWithFormat:@"%@ 12:00",datechaStr]];
    NSLog(@"标准开始时间: %ld",(long)s12tmp);
    
    NSString *end12Str = [DateUtils getDateBySingleDate:[NSDate date]];
    NSArray *array = [end12Str componentsSeparatedByString:@" "];
    
    NSInteger e12tmp = [DateUtils stringToTime:[NSString stringWithFormat:@"%@ 12:00",array[0]]];
    NSString *endStr2 = [DateUtils dateWithStringFromLongLongInt:e12tmp];
    NSLog(@"标准结束时间end12Str：%@-------%ld-----%@",end12Str,(long)e12tmp,endStr2);
    
    
    SleepDetail *sleepDetail = [[SleepDetail alloc] init];
    sleepDetail.sleepStartMinutes = starttmp;
    sleepDetail.sleepEndMinutes = endtmp;
    int deepSleep = (int)sleepSectionInfo.deepMinute;
    NSLog(@"++++++深睡市场deep: +++%d-------%d",(int)sleepSectionInfo.deepMinute,deepSleep);
    if (!(starttmp > e12tmp || endtmp < s12tmp)) {
        
        if (starttmp < s12tmp) {
            sleepDetail.sleepStartMinutes = s12tmp;
        }
        if (endtmp > e12tmp) {
            sleepDetail.sleepEndMinutes = e12tmp;
        }
        
        NSLog(@"+++++开始++++%lld",sleepDetail.sleepStartMinutes);
         NSLog(@"+++++结束++++%lld",sleepDetail.sleepEndMinutes);
        
        if (s12tmp > starttmp) {
            int dYes = (int) (((s12tmp - starttmp)/1000)/ 60);
            if (deepSleep > dYes) {
                sleepDetail.deep = deepSleep - dYes;
            }
        } else if (endtmp > e12tmp) {
            NSLog(@"+++++endtmp++++%ld",(long)endtmp);
            NSLog(@"+++++e12tmp++++%ld",(long)e12tmp);
            int dToday = (int) (((endtmp - e12tmp)/1000)/ 60);
            NSLog(@"+++++dToday++++%d",dToday);
            if (deepSleep > dToday) {
                sleepDetail.deep = deepSleep - dToday;
            }
            NSLog(@"+++++e12tmp++++%ld",(long)sleepDetail.deep);
        } else {
            int d = (int) (((endtmp - starttmp)/1000) / 60);
            NSLog(@"+++++正常++%d++%ld",d,(long)sleepDetail.deep);
            if (deepSleep >= d){
                sleepDetail.deep = d;
            }else{
                sleepDetail.deep = deepSleep;
            }
        }
        
        return sleepDetail;
    }else{
        return nil;
    }
}

//计算数组的最大值,最小值,平均值

- (void)getMaxAndMin:(NSArray *)numbers max:(long long int*)max min:(long long int*)min{
    
    //假设一个值是最大或者最小值,然后跟数组中的每个数进行比较
    
    //假设的最大值
    
    *max = [numbers[0] longLongValue];
    
    //假设的最小值
    
    *min = [numbers[0] longLongValue];
    
    for (NSNumber *num in numbers) {
        
        //判断最大值
        
        if(*max < num.longLongValue){
            
            *max = num.longLongValue;
            
        }
        
        //判断最小值
        
        if(*min > num.longLongValue){
            
            *min = num.longLongValue;
        }
    }
}


//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"运动" navigationController:self.navigationController];
    self.headerView.bgImg.hidden = YES;
    self.headerView.line.hidden = YES;
    self.headerView.backgroundColor = [UIColor clearColor];
    [self.headerView.backBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.headerView.backBut setImage:[UIImage imageNamed:@"icon_shop_back"] forState:UIControlStateNormal];
    self.headerView.title.textColor = [UIColor whiteColor];
    [self.view addSubview:self.headerView];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(screen_width-10-100, 20, 100, 44);
    [rightBtn setTitle:@"历史记录" forState:UIControlStateNormal];
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:default_font_size]];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -35);
    [rightBtn addTarget:self action:@selector(historySportBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:rightBtn];
}
//无数据时
- (void)initCustomEmptyView{
    self.customEmptyView = [[CustomEmptyView alloc] initWithFrame:CGRectMake(0, (screen_height-200-64-40-51)/2, screen_width, 200) withTitle:@"请连接设备并开启蓝牙" withUnderLineTitle:@"请连接设备" color:white_text_color withLineColor:white_text_color font:smaller_font_size withLineFont:small_font_size];
    self.customEmptyView.delegate = self;
    self.customEmptyView.emptyImgView.hidden = YES;
    self.customEmptyView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.customEmptyView];
    
    UILabel *zanwuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, screen_width, 50)];
    zanwuLabel.backgroundColor = [UIColor clearColor];
    zanwuLabel.textAlignment = NSTextAlignmentCenter;
    zanwuLabel.text = @"暂无数据";
    zanwuLabel.textColor = [ColorUtils colorWithHexString:light_gray_color];
    zanwuLabel.font = [UIFont systemFontOfSize:bigger_1_font_size];
    [self.customEmptyView addSubview:zanwuLabel];
}

- (void)didCustomEmptyBtnClick:(UIButton *)sender{
    SportSelectSharkeyController *spsvc = [[SportSelectSharkeyController alloc] init];
    [self.navigationController pushViewController:spsvc animated:YES];
}

- (void)initTopDateView{
    self.setOffNum = 0;
    self.todayLabel = [[UILabel alloc] initWithFrame:CGRectMake((screen_width-40)/2, self.headerView.frame.size.height+splite_line_height+general_padding, 40, 20)];
    self.todayLabel.text = @"今天";
    self.todayLabel.font = [UIFont boldSystemFontOfSize:default_1_font_size];
    self.todayLabel.textColor = [UIColor whiteColor];
    self.todayLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.todayLabel];
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(0, self.headerView.frame.size.height+splite_line_height, (screen_width-40)/2, 40);
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_ap_last_nor"] forState:UIControlStateNormal];
    self.leftBtn.backgroundColor = [UIColor clearColor];
    self.leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -120);
    if (self.setOffNum == -2) {
        self.leftBtn.userInteractionEnabled = NO;
    }else{
        self.leftBtn.userInteractionEnabled = YES;
    }
    self.leftBtn.tag = 99999998;
    [self.leftBtn addTarget:self action:@selector(lastAndapBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftBtn];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake((screen_width-40)/2+40, self.headerView.frame.size.height+splite_line_height, (screen_width-40)/2, 40);
    [self.rightBtn setImage:[UIImage imageNamed:@"icon_sp_next_nor"] forState:UIControlStateNormal];
    self.rightBtn.backgroundColor = [UIColor clearColor];
    self.rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -120, 0, 0);
    self.rightBtn.tag = 99999999;
    if (self.setOffNum == 0) {
        self.rightBtn.userInteractionEnabled = NO;
    }else{
        self.rightBtn.userInteractionEnabled = YES;
    }
    
    [self.rightBtn addTarget:self action:@selector(lastAndapBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rightBtn];
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.todayLabel.bottomY, screen_width, 20)];
    NSString *dateStr = [DateUtils getDateByFormatDate:[NSDate date] dateFormat:@"yyyy/M/dd HH:mm"];
    NSArray *array = [dateStr componentsSeparatedByString:@" "];
    int week = [DateUtils weekDayFromDate:[NSDate date]];
    NSString *weekStr = [DateUtils weekDayStringWithWeek:week];
    self.dateLabel.text = [NSString stringWithFormat:@"%@ %@",array[0],weekStr];
    self.dateLabel.font = [UIFont systemFontOfSize:small_font_size];
    self.dateLabel.textColor = [ColorUtils colorWithHexString:@"#faefde"];
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.dateLabel];
}

- (void)lastAndapBtnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 99999998:{
            self.setOffNum = self.setOffNum-1;
            self.rightBtn.userInteractionEnabled = YES;
            if (self.setOffNum == -2) {
                self.leftBtn.userInteractionEnabled = NO;
            }else{
                self.leftBtn.userInteractionEnabled = YES;
            }
            NSLog(@">>>>>>左侧>>>>>>>%d",self.setOffNum);
            
        }
            
            break;
        case 99999999:{
            self.setOffNum = self.setOffNum+1;
            self.leftBtn.userInteractionEnabled = YES;
            NSLog(@">>>>>>右侧>>>>>>>%d",self.setOffNum);
            if (self.setOffNum == 0) {
                self.rightBtn.userInteractionEnabled = NO;
            }else{
                self.rightBtn.userInteractionEnabled = YES;
            }
        }
            
            break;
        default:
            break;
    }
    
    if (self.setOffNum == 0) {
        self.todayLabel.text = @"今天";
    }else if (self.setOffNum == -1){
        self.todayLabel.text = @"昨天";
    }else{
        self.todayLabel.text = @"前天";
    }
    if (self.setOffNum >= -2) {
        if (self.setOffNum == 0) {
            [self refreshBtnClick];
        }else{
            NSString *dateStr = [DateUtils getADayYearAndMonthFromDate:[NSDate date] withNumber:[NSString stringWithFormat:@"%d",self.setOffNum]];
            
            NSString *dateResultStr = [dateStr stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
            NSDate *date = [DateUtils getDateByString:[NSString stringWithFormat:@"%@ 00:00 +0800",dateStr]];
            NSLog(@">>>>>>>>>>>>>%d--------%@---%@-----%@",self.setOffNum,dateStr,dateResultStr,date);
            int week = [DateUtils weekDayFromDate:date];
            NSString *weekStr = [DateUtils weekDayStringWithWeek:week];
            NSLog(@">>>>>>week>>>>>>>%d-------%@",week,weekStr);
            self.dateLabel.text = [NSString stringWithFormat:@"%@ %@",dateResultStr,weekStr];
            [self loadSomeDayData:dateStr setOffNum:self.setOffNum];
        }
    }else{
        self.setOffNum = -2;
        return;
    }
}

- (void)loadSomeDayData:(NSString *)date setOffNum:(int)setOffNum{
    [UserStore getSomeDaySharkeyData:^(SharkeyData *sharkeyData, NSError *error) {
            NSLog(@">>>>>sharkeyDataDict>>>>>>>>>%@",sharkeyData);
        if (error == nil) {
            self.sharkeyData = sharkeyData;
            [self refreshSportUI:self.sharkeyData];
        }
        
    } createTime:date];
}

- (void)refreshSportUI:(SharkeyData *)sharkeyData{
    [self.downArrawImgView removeFromSuperview];
    [self.circleView removeFromSuperview];
    if (sharkeyData != nil) {
        if ([[AppStatus sharedInstance].targetNum intValue] == 0) {
            self.targetStepNum = 10000;
        }else{
            self.targetStepNum = [[AppStatus sharedInstance].targetNum intValue];
        }
        [self initCircleView:self.targetStepNum realNum:sharkeyData.step];
        
        NSString *kmStr = [NSString stringWithFormat:@"%.2f公里",sharkeyData.distance];
        int start = (int)[kmStr rangeOfString:[NSString stringWithFormat:@"%@",@"公里"]].location;
        int length = (int)[kmStr rangeOfString:[NSString stringWithFormat:@"%@",@"公里"]].length;
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:kmStr];
        [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(start,length)];
        self.kmLabel.attributedText = attributedText;
        NSString *calorieStr = [NSString stringWithFormat:@"%.2f卡路里",sharkeyData.kCall];
        int start1 = (int)[calorieStr rangeOfString:[NSString stringWithFormat:@"%@",@"卡路里"]].location;
        int length1 = (int)[calorieStr rangeOfString:[NSString stringWithFormat:@"%@",@"卡路里"]].length;
        NSMutableAttributedString *attributedText1 = [[NSMutableAttributedString alloc] initWithString:calorieStr];
        [attributedText1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(start1,length1)];
        self.calorieLabel.attributedText = attributedText1;

        self.sleepRecordLabel.text = @"睡眠时长";
        int deephour = (int)sharkeyData.sleepTimeTotal / 60; //3小时
        int deepminremains = (int)sharkeyData.sleepTimeTotal % 60; //余数，20分钟
        if (deepminremains == 0) {
            self.sleepRecordNumLabel.text = [NSString stringWithFormat:@"%d小时00分钟",deephour];
        }else{
            self.sleepRecordNumLabel.text = [NSString stringWithFormat:@"%d小时%d分钟",deephour,deepminremains];
        }
    }else{
        if ([[AppStatus sharedInstance].targetNum intValue] == 0) {
            self.targetStepNum = 10000;
        }else{
            self.targetStepNum = [[AppStatus sharedInstance].targetNum intValue];
        }
        [self initCircleView:self.targetStepNum realNum:0];
        NSString *kmStr = [NSString stringWithFormat:@"%d公里",0];
        int start = (int)[kmStr rangeOfString:[NSString stringWithFormat:@"%@",@"公里"]].location;
        int length = (int)[kmStr rangeOfString:[NSString stringWithFormat:@"%@",@"公里"]].length;
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:kmStr];
        [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(start,length)];
        self.kmLabel.attributedText = attributedText;
        NSString *calorieStr = [NSString stringWithFormat:@"%d卡路里",0];
        int start1 = (int)[calorieStr rangeOfString:[NSString stringWithFormat:@"%@",@"卡路里"]].location;
        int length1 = (int)[calorieStr rangeOfString:[NSString stringWithFormat:@"%@",@"卡路里"]].length;
        NSMutableAttributedString *attributedText1 = [[NSMutableAttributedString alloc] initWithString:calorieStr];
        [attributedText1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(start1,length1)];
        self.calorieLabel.attributedText = attributedText1;

        self.sleepRecordLabel.text = @"暂无睡眠记录";
        self.sleepRecordNumLabel.text = @"一 一";
    }
}

- (void)initCircleView:(NSInteger)targetNum realNum:(NSInteger)realNum{
    NSInteger biao = targetNum;
    NSInteger xian = realNum;
    self.circleView = [[CustomCircleView alloc] initWithFrame:CGRectMake((screen_width - (293/2)) * 0.5, self.dateLabel.bottomY+30, 293/2, 293/2) tagartStep:biao realStep:xian];
    [self.view addSubview:self.circleView];
    float cha = xian-biao;
    float rate = (cha)/(float)biao;
    NSLog(@">>>>rateraterateraterate111111>>>>>>%.2f",rate);
    if (rate < 0) {
        rate = 1+rate;
    }else{
        if (biao == xian || xian >= biao) {
            rate = 1;
        }else{
            rate = rate;
        }
    }
    NSLog(@">>>>rateraterateraterate222222>>>>>>%.2f",rate);
    int finalRate = rate*100;
    self.circleView.rate = finalRate;
    [self.circleView startAnimation];
    
    self.downArrawImgView = [[UIImageView alloc] initWithFrame:CGRectMake((screen_width-17)/2, self.circleView.bottomY+12, 17, 14)];
    self.downArrawImgView.image = [UIImage imageNamed:@"icon_update"];
    [self.view addSubview:self.downArrawImgView];
    
    UIButton *refreshBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    refreshBtn.frame = CGRectMake(0, self.circleView.bottomY, screen_width, 40);
    refreshBtn.backgroundColor = [UIColor clearColor];
    [refreshBtn addTarget:self action:@selector(refreshBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refreshBtn];
    
    UIButton *upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    upBtn.frame = CGRectMake(0, 0, 293/2, (293/2)/2);
    upBtn.backgroundColor = [UIColor clearColor];
    [upBtn addTarget:self action:@selector(upBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.circleView addSubview:upBtn];

    UIButton *downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    downBtn.frame = CGRectMake(0, (293/2)/2, 293/2, (293/2)/2);
    downBtn.backgroundColor = [UIColor clearColor];
    [downBtn addTarget:self action:@selector(downBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.circleView addSubview:downBtn];
    [self.kandkaView removeFromSuperview];
    [self.renImgView removeFromSuperview];
    [self.customProgressLineView removeFromSuperview];
    [self initKandKaView];
    [self initLineViewWithRate:finalRate];
    
}

- (void)upBtnClick{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    if (self.stepNumDict.count > 0) {
//        NSLog(@">>>>>>>>>传递步数不为空>>>>>>>%@",self.stepNumDict);
        [dict setDictionary:self.stepNumDict];
        SportDetailViewController *sstvc = [[SportDetailViewController alloc] initWithTargetStepNum:self.targetStepNum stepNumDict:dict];
        [self.navigationController pushViewController:sstvc animated:YES];

    }else{
//        NSLog(@">>>>>>>>>传递步数为空>>>>>>>%@",self.stepNumDict);
        NSString *dateStr = [DateUtils getDateByDate:[NSDate date]];
        NSArray *tmpDateArray = [dateStr componentsSeparatedByString:@" "];
        NSString *dateTmpStr = tmpDateArray[0];
        
        NSString *date = [DateUtils getADayYearAndMonthFromDate:[NSDate date] withNumber:[NSString stringWithFormat:@"%d",-6]];
//        NSLog(@">>>>>>>>>>>七天前>>>>>>>%@--------%@",date,dateTmpStr);
        [UserStore getAllSharkeyData:^(NSMutableArray *sharkeyDataArray, NSError *error) {
//            NSLog(@">>>>>>>>>>>返回所有数据>>>>>>>%@",sharkeyDataArray);
            if (sharkeyDataArray.count > 0) {
                for (NSDictionary *sharkeyDataDict in sharkeyDataArray) {
                    self.sharkeyData = [[SharkeyData alloc] initWithDictionary:sharkeyDataDict error:nil];
                    if (self.sharkeyData != nil) {
                        NSString *creatDateStr = [DateUtils dateWithStringFromLongLongInt:self.sharkeyData.createTime];
//                        NSLog(@">>>>>>creatDateStr>>>>>>>>%@",creatDateStr);
                        
                        NSArray *creatDateArray = [creatDateStr componentsSeparatedByString:@" "];
                        [dict setValue:@(self.sharkeyData.step) forKey:[NSString stringWithFormat:@"%@",creatDateArray[0]]];

                    }
                }
                
//                NSLog(@">>>>>>dict>>>>>>>>%@",dict);
                SportDetailViewController *sstvc = [[SportDetailViewController alloc] initWithTargetStepNum:self.targetStepNum stepNumDict:dict];
                [self.navigationController pushViewController:sstvc animated:YES];

            }
            
        } beginTime:date endTime:dateTmpStr];
    }
    
//    SportDetailViewController *sstvc = [[SportDetailViewController alloc] initWithTargetStepNum:self.targetStepNum stepNumArray:self.stepNumArray];
}

- (void)downBtnClick{
    SettingSportTargetController *sstvc = [[SettingSportTargetController alloc] init];
    [self.navigationController pushViewController:sstvc animated:YES];
}

- (void)refreshBtnClick{
    NSLog(@">>>>>>>>>>>>刷新数据");
    
   [self performSelector:@selector(dismissSportHUDView) withObject:self afterDelay:10];
    if ([self.todayLabel.text isEqualToString:@"今天"]) {

        [self checkBlue];
        
        [self.stepNumArray removeAllObjects];
        self.setOffNum = 0;
        [SVProgressHUD showWithStatus:@"数据读取中..." maskType:SVProgressHUDMaskTypeClear];
        [self immediateConnectSharkey];
        [self.dateLabel removeFromSuperview];
        [self.todayLabel removeFromSuperview];
        [self.circleView removeFromSuperview];
        [self.resultLabel removeFromSuperview];
        [self.resultKcalLabel removeFromSuperview];
        [self initUI];
    }
}

- (void)initKandKaView{
    [self.kandkaView removeFromSuperview];
    self.kandkaView = [[UIView alloc] initWithFrame:CGRectMake(45, self.downArrawImgView.bottomY+52, 210, 34)];
    self.kandkaView.backgroundColor = [ColorUtils colorWithHexString:@"#704b37"];
    self.kandkaView.alpha = 0.6;
    [self.view addSubview:self.kandkaView];
    
    self.kmLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 105, 34)];
    self.kmLabel.textColor = [UIColor whiteColor];
    self.kmLabel.font = [UIFont systemFontOfSize:bigger_1_font_size];
    self.kmLabel.textAlignment = NSTextAlignmentCenter;
    NSString *kmStr = [NSString stringWithFormat:@"%.2f公里",self.walkDistance];
    int start = (int)[kmStr rangeOfString:[NSString stringWithFormat:@"%@",@"公里"]].location;
    int length = (int)[kmStr rangeOfString:[NSString stringWithFormat:@"%@",@"公里"]].length;
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:kmStr];
    [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(start,length)];
    self.kmLabel.attributedText = attributedText;
    [self.kandkaView addSubview:self.kmLabel];
    
    UIView *sepLine = [[UIView alloc] initWithFrame:CGRectMake(105, (34-16)/2, splite_line_height, 16)];
    sepLine.backgroundColor = [ColorUtils colorWithHexString:@"#76594b"];
    [self.kandkaView addSubview:sepLine];
    
    self.calorieLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 0, 105, 34)];
    self.calorieLabel.textColor = [UIColor whiteColor];
    self.calorieLabel.font = [UIFont systemFontOfSize:bigger_1_font_size];
    self.calorieLabel.textAlignment = NSTextAlignmentCenter;
    NSString *calorieStr = [NSString stringWithFormat:@"%.2f卡路里",self.walkCal];
    int start1 = (int)[calorieStr rangeOfString:[NSString stringWithFormat:@"%@",@"卡路里"]].location;
    int length1 = (int)[calorieStr rangeOfString:[NSString stringWithFormat:@"%@",@"卡路里"]].length;
    NSMutableAttributedString *attributedText1 = [[NSMutableAttributedString alloc] initWithString:calorieStr];
    [attributedText1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(start1,length1)];
    self.calorieLabel.attributedText = attributedText1;
    [self.kandkaView addSubview:self.calorieLabel];
}

- (void)initTargetKmKcall{
    self.resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width-80, self.kandkaView.bottomY+20, 80-16, 15)];
    WCDSharkeyFunction *wcd = [WCDSharkeyFunction shareInitializationt];
    NSInteger height;
    NSInteger weight;
    AppStatus *as = [AppStatus sharedInstance];
    if (as.user.userHeight == 0) {
        height = 170;
    }else{
        height = as.user.userHeight;
    }
    CGFloat walkDistance = [wcd getDistanceWalk:height numStep:self.targetStepNum];
    NSLog(@"走步公里 == %f",self.walkDistance);
    if (as.user.userWeight == 0) {
        weight = 60;
    }else{
        weight = as.user.userWeight;
    }
    CGFloat walkCal = [wcd getkCalWalk:walkDistance weight:weight];
    self.resultLabel.text = [NSString stringWithFormat:@"%.2f公里",walkDistance];
    self.resultLabel.textAlignment = NSTextAlignmentRight;
    self.resultLabel.font = [UIFont systemFontOfSize:12];
    self.resultLabel.textColor = [ColorUtils colorWithHexString:@"#faefde"];
    self.resultLabel.numberOfLines = 0;
    self.resultLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.resultLabel];
    
    self.resultKcalLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width-200-16, self.kandkaView.bottomY+20+15, 200, 15)];
    self.resultKcalLabel.text = [NSString stringWithFormat:@"%.2f卡路里",walkCal];
    self.resultKcalLabel.textAlignment = NSTextAlignmentRight;
    self.resultKcalLabel.font = [UIFont systemFontOfSize:12];
    self.resultKcalLabel.textColor = [ColorUtils colorWithHexString:@"#faefde"];
    self.resultKcalLabel.numberOfLines = 0;
    self.resultKcalLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.resultKcalLabel];

}

- (void)initLineViewWithRate:(int)rate{
    self.iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, self.kandkaView.bottomY+25-(20-3)/2, 20, 20)];
    self.iconImgView.image = [UIImage imageNamed:@"icon_km"];
    [self.view addSubview:self.iconImgView];
    
    self.customProgressLineView = [[CustomProgressLineView alloc] initWithFrame:CGRectMake(45, self.kandkaView.bottomY+25, screen_width-45-80, 3) rate:rate nav:self.navigationController];
    self.customProgressLineView.backgroundColor = [UIColor purpleColor];
    self.customProgressLineView.delegate = self;
    [self.customProgressLineView startAnimation];
    [self.view addSubview:self.customProgressLineView];
    
    [self.renImgView removeFromSuperview];
    self.renImgView = [[UIImageView alloc] initWithFrame:CGRectMake(45, self.customProgressLineView.frame.origin.y-((19-3)/2)-3, 19, 24)];
    self.renImgView.image = [UIImage imageNamed:@"icon_km_calorie"];
    self.renImgView.center = CGPointMake(45, self.customProgressLineView.frame.origin.y+1);
    [self.view addSubview:self.renImgView];
}

- (void)progressRate:(NSInteger)rate{
    self.renImgView.center = CGPointMake(45+rate, self.customProgressLineView.frame.origin.y+1);
}

- (void)initSleepDataView{
    UIImageView *iconSleepImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, self.customProgressLineView.bottomY+50, 19, 21)];
    iconSleepImgView.image = [UIImage imageNamed:@"icon_sleep"];
    [self.view addSubview:iconSleepImgView];
    
    self.sleepRecordLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, self.customProgressLineView.bottomY+50, (screen_width-45-16)/2, 21)];
    self.sleepRecordLabel.text = @"暂无睡眠记录";
    self.sleepRecordLabel.textColor = [ColorUtils colorWithHexString:@"#faefde"];
    self.sleepRecordLabel.font = [UIFont systemFontOfSize:12];
    self.sleepRecordLabel.textAlignment = NSTextAlignmentLeft;
    self.sleepRecordLabel.userInteractionEnabled = YES;
    [self.view addSubview:self.sleepRecordLabel];
    
    UIButton *sleepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sleepBtn.frame = CGRectMake(0, self.customProgressLineView.bottomY, screen_width, 90);
    sleepBtn.backgroundColor = [UIColor clearColor];
    [sleepBtn addTarget:self action:@selector(sleepBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sleepBtn];
    
    self.sleepRecordNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width-16-(screen_width-45-16)/2, self.customProgressLineView.bottomY+50, (screen_width-45-16)/2, 21)];
    self.sleepRecordNumLabel.text = @"一 一";
    self.sleepRecordNumLabel.textColor = [ColorUtils colorWithHexString:@"#faefde"];
    self.sleepRecordNumLabel.font = [UIFont systemFontOfSize:12];
    self.sleepRecordNumLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:self.sleepRecordNumLabel];

}

- (void)sleepBtnClick{
    SleepDetailViewController *advc = [[SleepDetailViewController alloc] initWithSharkeyData:self.sharkeyData dateTitle:self.todayLabel.text dateStr:self.dateLabel.text];
    [self.navigationController pushViewController:advc animated:YES];
}

- (void)initBottomSportRankView{
    UIButton *sportRankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sportRankBtn.frame = CGRectMake(0, screen_height-40, screen_width, 40);
    sportRankBtn.backgroundColor = [ColorUtils colorWithHexString:@"#795b4b"];
    [sportRankBtn setTitle:@"运动排名" forState:UIControlStateNormal];
    [sportRankBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sportRankBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [sportRankBtn addTarget:self action:@selector(sportRankBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sportRankBtn];
}

- (void)sportRankBtnClick{
    SportResultRankController *srrvc = [[SportResultRankController alloc] initWithRankStatus:[NSArray arrayWithObject:@"day"]];
    [self.navigationController pushViewController:srrvc animated:YES];
}

- (void)historySportBtnClick{
    SportHistoryViewController *shvc = [[SportHistoryViewController alloc] init];
    [self.navigationController pushViewController:shvc animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.customProgressLineView.renImgView removeFromSuperview];
}

- (void)dismissSportHUDView{
    [SVProgressHUD dismiss];
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
