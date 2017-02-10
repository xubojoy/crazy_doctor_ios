//
//  UserSleepDetailViewController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/8/18.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharkeyData.h"
@interface UserSleepDetailViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,assign) int targetStepNum;
@property (nonatomic ,strong) SharkeyData *sharkeyData;
@property (nonatomic ,strong) NSMutableArray *stepNumBigArray;

@property (nonatomic ,strong) NSMutableArray *sharkeyUserDataArray;
@property (nonatomic ,strong) NSMutableArray *stepNumArray;
@property (nonatomic ,strong) NSMutableDictionary *sharkeyUserDataDict;
@property (nonatomic ,assign) int stepMaxNum;
@property (nonatomic ,assign) float finalRate;
@property (nonatomic ,strong) NSMutableDictionary *totalDataDict;


@end
