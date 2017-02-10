//
//  SportHistoryViewController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/18.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVBarChartView.h"
#import "BottomCurrentDataView.h"
#import "SharkeyData.h"
@interface SportHistoryViewController : BaseViewController<DVBarChartViewDelegate,UICollectionViewDataSource , UICollectionViewDelegate>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) DVBarChartView *chartView;
@property (nonatomic ,strong) UICollectionView *sportHistoryCollectionView;
@property (nonatomic ,strong) BottomCurrentDataView *bottomCurrentDataView;
@property (nonatomic ,strong) BottomCurrentDataView *bottomCurrentDataView1;
@property (nonatomic ,strong) BottomCurrentDataView *bottomCurrentDataView2;

@property (nonatomic, assign) int currentItem;
@property (nonatomic, assign) int previousItem;

@property (nonatomic ,assign) NSInteger numDays;
@property (nonatomic ,strong) SharkeyData *sharkeyData;
@property (nonatomic ,strong) NSMutableArray *sharkeyUserDataArray;
@property (nonatomic ,strong) NSMutableArray *stepNumArray;
@property (nonatomic ,strong) NSMutableDictionary *sharkeyUserDataDict;
@property (nonatomic ,assign) int stepMaxNum;
@property (nonatomic ,assign) float finalRate;

//@property (nonatomic ,strong) NSArray *tmpArray;
//@property (nonatomic ,strong) NSMutableDictionary *tmpDict;


@end
