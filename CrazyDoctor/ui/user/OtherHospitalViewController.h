//
//  OtherHospitalViewController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/11.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#define table_view_status_waiting 1 //等待加载状态
#define table_view_status_loading 2 //正在加载状态
#define table_view_status_load_over 3 //加载完成完成
#define table_view_status_load_fail 4 //加载失败

#define event_init_load 0 //初始加载事件
#define event_pull_up 1 //上拉事件
#define event_click_load    2 //点击加载事件
#define event_load_complete_succes 3 //加载成功事件
#define event_load_complete_fail   4 //加载失败事件
#define event_load_complete_over   5 //加载完成事件
#define event_load_data_pull_down  6//下拉事件
#import <UIKit/UIKit.h>
#import "LoadingStatusView.h"
#import "DiagnoseLog.h"
#import "UserUploadRecord.h"

@protocol OtherHospitalViewControllerDelegate <NSObject>

- (void)didOtherHospitalViewControllerIndexPathRow:(NSInteger)row userUploadRecord:(UserUploadRecord *)userUploadRecord;

@end

@interface OtherHospitalViewController : BaseViewController

@property (nonatomic ,strong) UserUploadRecord *userUploadRecord;
@property (nonatomic, strong) NSMutableArray *userUploadRecordListArray;
@property int currentTableViewStatus;//列表当前状态
@property (nonatomic, assign) int currentPageNo;
@property (strong, nonatomic) LoadingStatusView *lsv;
@property (nonatomic, assign) int currentEventType;

@property (nonatomic ,assign) id<OtherHospitalViewControllerDelegate> delegate;

@end
