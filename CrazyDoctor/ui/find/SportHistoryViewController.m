//
//  SportHistoryViewController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/18.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "SportHistoryViewController.h"
#import "WLZShareController.h"
#import "SportHistoryCollectionViewCell.h"
#import "UserStore.h"
@interface SportHistoryViewController ()

@end
//static NSString *sportHistoryCollectionViewCellId = @"SportHistoryCollectionViewCell";
@implementation SportHistoryViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self calculateDayCount];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    UIImage *bgImg = [UIImage imageNamed:@"bg_exercise"];
    self.view.layer.contents = (id) bgImg.CGImage;
    self.sharkeyUserDataArray = [NSMutableArray new];
    self.sharkeyUserDataDict = [NSMutableDictionary new];
//    self.tmpDict = [NSMutableDictionary new];
    self.stepNumArray = [NSMutableArray new];
    self.stepMaxNum = 0;
    [self setRightSwipeGestureAndAdaptive];
    [self initHeadView];
    [self loadSharkeyData];
}

- (void)calculateDayCount{
    NSInteger tmpNumDays = [DateUtils numberOfDaysFromTodayByTime:@"2016-7-1" timeStringFormat:@"yyyy/MM/dd"];
    
    self.numDays = labs((long)tmpNumDays/1000);
    NSLog(@">>>>>>>>相差天数>>>>>>%ld",(long)self.numDays);
    self.currentItem = (int)self.numDays;
    self.previousItem = 0;
    [self initUI];
    [self.sportHistoryCollectionView reloadData];
}

- (void)initUI{
    [self initSportHistoryCollectionView];
    [self initBottomCurrentDataView];
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"历史记录" navigationController:self.navigationController];
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
    [UserStore getAllSharkeyData:^(NSMutableArray *sharkeyDataArray, NSError *error) {
//        NSLog(@">>>>>>>>>>>返回所有数据>>>>>>>%@",sharkeyDataArray);
        [SVProgressHUD dismiss];
        if (sharkeyDataArray.count > 0) {
            for (NSDictionary *sharkeyDataDict in sharkeyDataArray) {
                self.sharkeyData = [[SharkeyData alloc] initWithDictionary:sharkeyDataDict error:nil];
                if (self.sharkeyData != nil) {
                    [self.sharkeyUserDataArray addObject:self.sharkeyData];
                    NSString *creatDateStr = [DateUtils dateStringWithFromLongLongInt:self.sharkeyData.createTime];
                    NSLog(@">>>>>>creatDateStr>>>>>>>>%@",creatDateStr);
                    NSArray *creatDateArray = [creatDateStr componentsSeparatedByString:@" "];
                    [self.sharkeyUserDataDict setValue:self.sharkeyData forKey:[NSString stringWithFormat:@"%@",creatDateArray[0]]];
                }
            }
            
            if (self.sharkeyUserDataArray.count > 0) {
                self.sharkeyData = self.sharkeyUserDataArray[0];
                NSString *creatDateStr = [DateUtils dateWithStringFromLongLongInt:self.sharkeyData.createTime];
                NSArray *creatDateArray = [creatDateStr componentsSeparatedByString:@" "];
                NSInteger tmpNumDays = [DateUtils numberOfDaysFromTodayByTime:creatDateArray[0] timeStringFormat:@"yyyy/MM/dd"];
                self.numDays = labs((long)tmpNumDays/1000);
//                NSLog(@">>>>>>>>相差天数>>>>>>%ld",(long)self.numDays);
                self.currentItem = (int)self.numDays;
                self.previousItem = 0;
                [self initUI];
            }
            
            for (SharkeyData *sharkeyData in self.sharkeyUserDataArray) {
                [self.stepNumArray addObject:@(sharkeyData.step)];
            }
            self.stepMaxNum = [[self.stepNumArray valueForKeyPath:@"@max.floatValue"] intValue];
//            NSLog(@">>>>>>maxValue最大值>>self.sharkeyUserDataDict:%@>>>>>>%d",self.sharkeyUserDataDict,self.stepMaxNum);
        }
        [self.sportHistoryCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:(self.numDays) inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
        [self refreshBottomCurrentDataView:self.numDays];
        [self.sportHistoryCollectionView reloadData];
    } beginTime:@"2016-7-1" endTime:dateTmpStr];
}

- (void)initSportHistoryCollectionView{
    // 推荐专家
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0.0;//item间距(最小值)
    flowLayout.minimumLineSpacing = 5.0;//行间距(最小值)
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.sportHistoryCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,self.headerView.frame.size.height, screen_width, ((674/2)-self.headerView.frame.size.height)-30)
                                                     collectionViewLayout:flowLayout];
    self.sportHistoryCollectionView.delegate = self;
    self.sportHistoryCollectionView.dataSource = self;
    self.sportHistoryCollectionView.showsHorizontalScrollIndicator = NO;
    
    
    self.sportHistoryCollectionView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.sportHistoryCollectionView];
    
    UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.sportHistoryCollectionView.frame.size.height-20, (self.numDays+1)*37, splite_line_height)];
    downLine.backgroundColor = [ColorUtils colorWithHexString:@"#684e45"];
    [self.sportHistoryCollectionView addSubview:downLine];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.numDays+1;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sportHistoryCollectionViewCellId = [NSString stringWithFormat:@"SportHistoryCollectionViewCell%d",(int)indexPath.item];
    UINib *nib = [UINib nibWithNibName:@"SportHistoryCollectionViewCell" bundle: nil];
    [self.sportHistoryCollectionView registerNib:nib
                      forCellWithReuseIdentifier:sportHistoryCollectionViewCellId];
    SportHistoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:sportHistoryCollectionViewCellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    NSString *date = [DateUtils getADayYouWantFromDate:[NSDate date] withNumber:[NSString stringWithFormat:@"%ld",((long)indexPath.item)-((long)self.numDays)]];
    NSString *keyStr = [NSString stringWithFormat:@"%@",date];
    self.sharkeyData = [self.sharkeyUserDataDict objectForKey:keyStr];
    int height = ((674/2)-64)-30;
    int barHeight;
    if (self.sharkeyData.step == 0 || self.stepMaxNum == 0) {
        barHeight = 0;
    }else{
        barHeight = (self.sharkeyData.step*height)/((float)self.stepMaxNum);
    }
    NSLog(@">>>>>>>>%@>>>>>%f>>>>%d------%d",self.sharkeyData,((float)height/(float)self.stepMaxNum),(int)self.sharkeyData.step,barHeight);
    if (indexPath.row == self.currentItem) {
        cell.barView.backgroundColor = [UIColor whiteColor];
    }
    [cell renderSportHistoryCollectionViewCell:barHeight dateStr:date];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(32,((674/2)-self.headerView.frame.size.height)-30);
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>%ld",(long)indexPath.item);
    self.previousItem = self.currentItem;
    self.currentItem = (int)indexPath.row;
    if (self.previousItem != self.currentItem) {
        [self.sportHistoryCollectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    }
    for (NSInteger i=0; i<self.numDays+1; i++) {
        if (i==self.currentItem) {
            NSIndexPath *indexPath1 = [NSIndexPath indexPathForItem:i inSection:0];
            SportHistoryCollectionViewCell *cell = (SportHistoryCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath1];
            cell.barView.backgroundColor = [UIColor whiteColor];
        }else{
            NSIndexPath *indexPath1 = [NSIndexPath indexPathForItem:i inSection:0];
            SportHistoryCollectionViewCell *cell = (SportHistoryCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath1];
            cell.barView.backgroundColor = [ColorUtils colorWithHexString:@"#9bc01d"];
        }
    }
    [self refreshBottomCurrentDataView:(long)indexPath.item];
}

- (void)refreshBottomCurrentDataView:(long)row{
    NSString *date = [DateUtils getADayYouWantFromDate:[NSDate date] withNumber:[NSString stringWithFormat:@"%ld",(row)-((long)self.numDays)]];
    self.sharkeyData = [self.sharkeyUserDataDict objectForKey:date];
    NSLog(@">>>>>dasharkeyDatate>>>>>>>>>%@",self.sharkeyData);
    [self.bottomCurrentDataView renderBottomCurrentDataViewWithremindTitile:@"步数" numStr:[NSString stringWithFormat:@"%d",(int)self.sharkeyData.step]];
    float distance;
    if (self.sharkeyData.distance == 0) {
        distance = 0;
    }else{
        distance = self.sharkeyData.distance;
    }
    [self.bottomCurrentDataView1 renderBottomCurrentDataViewWithremindTitile:@"里程" numStr:[NSString stringWithFormat:@"%.2f",distance]];
    [self.bottomCurrentDataView2 renderBottomCurrentDataViewWithremindTitile:@"卡路里" numStr:[NSString stringWithFormat:@"%d",(int)self.sharkeyData.kCall]];
}

- (void)initBottomCurrentDataView{

    self.bottomCurrentDataView = [[BottomCurrentDataView alloc] initWithFrame:CGRectMake(53, self.sportHistoryCollectionView.frame.size.height+self.sportHistoryCollectionView.frame.origin.y+20, screen_width-53, 50)];
    self.bottomCurrentDataView.backgroundColor = [UIColor clearColor];
    [self.bottomCurrentDataView renderBottomCurrentDataViewWithremindTitile:@"步数" numStr:[NSString stringWithFormat:@"%d",0]];
    [self.view addSubview:self.bottomCurrentDataView];
    
    self.bottomCurrentDataView1 = [[BottomCurrentDataView alloc] initWithFrame:CGRectMake(53+25, self.bottomCurrentDataView.frame.size.height+self.bottomCurrentDataView.frame.origin.y+31, screen_width-53-25, 50)];
    self.bottomCurrentDataView1.backgroundColor = [UIColor clearColor];
    [self.bottomCurrentDataView1 renderBottomCurrentDataViewWithremindTitile:@"里程" numStr:@"0"];
    [self.view addSubview:self.bottomCurrentDataView1];
    
    self.bottomCurrentDataView2 = [[BottomCurrentDataView alloc] initWithFrame:CGRectMake(53+50, self.bottomCurrentDataView1.frame.size.height+self.bottomCurrentDataView1.frame.origin.y+31, screen_width-53-50, 50)];
    self.bottomCurrentDataView2.backgroundColor = [UIColor clearColor];
    [self.bottomCurrentDataView2 renderBottomCurrentDataViewWithremindTitile:@"卡路里" numStr:@"0"];
    [self.view addSubview:self.bottomCurrentDataView2];
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
