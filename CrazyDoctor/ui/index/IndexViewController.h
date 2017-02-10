//
//  IndexViewController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/3/31.
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
#import "IndexArticleCell.h"
#import "IndexTopView.h"
#import "IndexTopGentleView.h"
#import "TongueDiagnoseRecord.h"
#import "BodyTag.h"
#import "HomeViewController.h"
#import "Meridian.h"
#import "Acupoint.h"
#import "UserCenterViewController.h"
#import "ArticleStore.h"
#import "RecommendArticle.h"
@interface IndexViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,IndexTopViewDelegate,HomeViewControllerDelegate>
@property (nonatomic, strong) HeaderView *headerView;
//@property (nonatomic, strong) UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *topBgView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topBgConstraints;

@property (nonatomic ,strong) IndexTopView *indexTopView;
@property (nonatomic ,strong) IndexTopGentleView *indexTopGentleView;
@property (nonatomic ,strong) UIButton *leftLocationBtn;
@property (nonatomic ,strong) UIButton *leftBtn;
@property (nonatomic ,strong) UIButton *leftTitleBtn;
@property (nonatomic ,strong) UIButton *rightMsgBtn;
@property (nonatomic ,strong) UIButton *rightMoreBtn;

@property (nonatomic ,strong) TongueDiagnoseRecord *tongueDiagnoseRecord;
@property (nonatomic ,strong) BodyTag *bodyTag;
@property (nonatomic ,strong) NSMutableArray *bodyTagsArray;

@property (nonatomic ,strong) UILabel *remindLabel;
@property (nonatomic ,strong) UIImageView *markImgView;
@property (nonatomic ,strong) UILabel *contentLabel;
@property (nonatomic ,strong) HomeViewController *homevc;

@property (nonatomic ,strong) Meridian *meridian;
@property (nonatomic ,strong) Acupoint *acupoint;
@property (nonatomic ,strong) NSMutableArray *meridianArray;
@property (nonatomic ,strong) NSMutableArray *acupointArray;
@property (nonatomic ,strong) NSMutableArray *selectAcupointArray;
@property (nonatomic ,assign) NSInteger hour;

@property (nonatomic ,strong) UIActivityIndicatorView *activity;

@property (nonatomic ,strong) RecommendArticle *recommendArticle;
@property (nonatomic ,strong) NSMutableArray *recommendArticleArray;

@property (nonatomic ,strong) NSMutableSet *hasReadArticles;
@property (nonatomic ,strong) NSMutableDictionary *meridianDictionary;

@property (nonatomic ,strong) NSString *notifiAcupointName;

@property int currentTableViewStatus;//列表当前状态
@property (nonatomic, assign) int currentPageNo;
@property (strong, nonatomic) LoadingStatusView *lsv;
@property (nonatomic, assign) int currentEventType;

@property (nonatomic, assign) BOOL isShowMyInfo;

@end
