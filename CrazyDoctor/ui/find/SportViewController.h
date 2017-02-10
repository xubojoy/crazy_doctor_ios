//
//  SportViewController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/6/28.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCircleView.h"
#import "CustomProgressLineView.h"
#import "CustomEmptyView.h"
#import "SharkeyData.h"
#import <CoreBluetooth/CoreBluetooth.h>
@interface SportViewController : BaseViewController<CustomProgressLineViewDelegate,CustomEmptyViewDelegate,CBCentralManagerDelegate>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) UILabel *dateLabel;
@property (nonatomic ,strong) CustomEmptyView *customEmptyView;
@property (nonatomic ,strong) CustomCircleView *circleView;
@property (nonatomic ,strong) UIImageView *downArrawImgView;
@property (nonatomic ,strong) UIImageView *iconImgView;
@property (nonatomic ,strong) CustomProgressLineView *customProgressLineView;
@property (nonatomic ,strong) UIImageView *renImgView;
@property (nonatomic ,strong) UIView *kandkaView;

@property (strong , nonatomic) CBCentralManager *manager;//中央设备

@property (nonatomic ,strong) UILabel *kmLabel;
@property (nonatomic ,strong) UILabel *calorieLabel;

@property (nonatomic ,strong) UILabel *sleepRecordLabel;
@property (nonatomic ,strong) UILabel *sleepRecordNumLabel;

@property (nonatomic ,assign) NSInteger stepNum;
@property (nonatomic ,assign) CGFloat walkDistance;
@property (nonatomic ,assign) CGFloat walkCal;
@property (nonatomic ,strong) UILabel *resultLabel;
@property (nonatomic ,strong) UILabel *resultKcalLabel;
@property (nonatomic ,strong) NSMutableArray *deepSleepArr;
@property (nonatomic ,assign) int targetStepNum;

@property (nonatomic ,strong) SharkeyData *sharkeyData;

@property (nonatomic ,strong) NSMutableArray *stepNumArray;
@property (nonatomic ,strong) NSMutableDictionary *stepNumDict;

@property (nonatomic ,assign) int setOffNum;

@property (nonatomic ,strong) UIButton *leftBtn;
@property (nonatomic ,strong) UIButton *rightBtn;
@property (nonatomic ,strong) UILabel *todayLabel;


@end
