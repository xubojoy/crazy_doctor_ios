//
//  SportResultRankController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/18.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserSharkeyData.h"
#import "CustomSegmentView.h"
#import "SharkeySort.h"
@interface SportResultRankController : BaseViewController<UITableViewDelegate,UITableViewDataSource,CustomSegmentViewDelegate>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) CustomSegmentView *customSegmentView;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) UserSharkeyData *userSharkeyData;
@property (nonatomic ,strong) SharkeySort *sharkeySort;
@property (nonatomic ,strong) NSMutableArray *sharkeyDataArray;
@property NSArray *currentRankStatuses;
@property int currentTableViewStatus;//列表当前状态
@property (nonatomic, assign) int currentPageNo;
@property (strong, nonatomic) LoadingStatusView *lsv;
@property (nonatomic, assign) int currentEventType;

-(instancetype) initWithRankStatus:(NSArray *)rankStatuses;
@end
