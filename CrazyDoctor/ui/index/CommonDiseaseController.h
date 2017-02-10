//
//  CommonDiseaseController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/6/27.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstModel.h"
#import "CellFirst.h"
#import "CommonDisease.h"
#import "Pathology.h"
@interface CommonDiseaseController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) CommonDisease *commonDisease;
@property (nonatomic ,strong) Pathology *pathology;

// 分区的头部数据
@property (nonatomic, strong) NSMutableArray *arrayGroup;
// 每个分区中的详细数据
@property (nonatomic, strong) NSMutableArray *arrayList;

@property (nonatomic ,strong) NSMutableDictionary *commonDiseaseDict;
// 分区的所有数据，（包括分区的头， 和分区的详细信息）
@property (nonatomic, strong) NSMutableArray *arrayModel;
// 分区的头部控件
@property (nonatomic, strong) UILabel *labelSection;
@property (nonatomic, strong) UIImageView *imageViewSection;
// 上一个点击的section 分区头部view 的 tag值
@property (nonatomic, assign) NSInteger lastViewNum;

@end
