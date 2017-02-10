//
//  PushSettingController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/19.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PushSettingCell.h"
#import "PushSettingCommonCell.h"
#import "LQXSwitch.h"
@interface PushSettingController : BaseViewController<UITableViewDelegate,UITableViewDataSource,PushSettingCellDelegate>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) LQXSwitch *totalSwitch;
@property (nonatomic ,strong) LQXSwitch *defaultSwitch;
@property (nonatomic ,strong) LQXSwitch *customSwit;
@property (nonatomic ,strong) LQXSwitch *maoshiSwit;
@property (nonatomic ,strong) LQXSwitch *chenshiSwit;
@property (nonatomic ,strong) LQXSwitch *sishiSwit;
@property (nonatomic ,strong) LQXSwitch *wushiSwit;
@property (nonatomic ,strong) LQXSwitch *weishiSwit;
@property (nonatomic ,strong) LQXSwitch *shenshiSwit;
@property (nonatomic ,strong) LQXSwitch *youshiSwit;
@property (nonatomic ,strong) LQXSwitch *xushiSwit;
@property (nonatomic ,strong) LQXSwitch *haishiSwit;
@property (nonatomic ,strong) LQXSwitch *zishiSwit;


@property (nonatomic ,strong) NSArray *timeArray;
@property (nonatomic ,strong) NSArray *pushTimeArray;
@property (nonatomic ,strong) NSArray *meridianArray;

@property (nonatomic ,strong) NSMutableArray *pushTimesArray;
@property (nonatomic ,strong) NSMutableSet *selectedPushTimesSet;

@end
