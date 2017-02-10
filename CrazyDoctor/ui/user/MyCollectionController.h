//
//  MyCollectionController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/20.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCollectionArticleCell.h"
#import "LoadingStatusView.h"
#import "UserFavArticle.h"
@interface MyCollectionController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic ,strong) UserFavArticle *userFavArticle;
@property (nonatomic, strong) NSMutableArray *userFavArticleListArray;
@property int currentTableViewStatus;//列表当前状态
@property (nonatomic, assign) int currentPageNo;
@property (strong, nonatomic) LoadingStatusView *lsv;
@property (nonatomic, assign) int currentEventType;

@property (nonatomic ,assign) int currentIndex;

@end
