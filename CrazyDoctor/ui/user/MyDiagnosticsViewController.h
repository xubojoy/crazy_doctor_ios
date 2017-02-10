//
//  MyDiagnosticsViewController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/11.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingStatusView.h"
#import "DiagnoseLog.h"

#define tongueDiagnose_type @"tongueDiagnose"
#define eyeDiagnose_type @"eyeDiagnose"
#define meridian_type @"meridian"

@interface MyDiagnosticsViewController : BaseViewController

@property (nonatomic, strong) DiagnoseLog *diagnoseLog;
@property (nonatomic, strong) NSMutableArray *diagnoseLogListArray;
@property int currentTableViewStatus;//列表当前状态
@property (nonatomic, assign) int currentPageNo;
@property (strong, nonatomic) LoadingStatusView *lsv;
@property (nonatomic, assign) int currentEventType;
@end
