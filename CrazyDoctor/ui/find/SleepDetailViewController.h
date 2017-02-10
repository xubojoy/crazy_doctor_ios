//
//  SleepDetailViewController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/25.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSleepCircleView.h"
#import "DeepAndLightSleepView.h"
#import "SharkeyData.h"
#import "SleepDetail.h"
@interface SleepDetailViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) UILabel *dateLabel;
@property (nonatomic ,strong) UILabel *sleepQuerLabel;
@property (nonatomic ,strong) UIImageView *sleepQualityImgView;
@property (nonatomic ,strong) CustomSleepCircleView *circleView;
@property (nonatomic ,strong) DeepAndLightSleepView *deepAndLightSleepView;
@property (nonatomic ,strong) SharkeyData *sharkeyData;
@property (nonatomic ,strong) NSString *dateTitle;
@property (nonatomic ,strong) NSString *dateStr;

@property (nonatomic ,strong) SleepDetail *sleepDetail;
@property (nonatomic ,strong) NSMutableArray *sleepDetailArray;

- (instancetype)initWithSharkeyData:(SharkeyData *)sharkeyData dateTitle:(NSString *)dateTitle dateStr:(NSString *)dateStr;

@end
