//
//  SportDetailViewController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/18.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SportDetailViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,assign) int targetStepNum;
@property (nonatomic ,strong) NSMutableArray *stepNumArray;

@property (nonatomic ,strong) NSMutableDictionary *stepNumDict;

@property (nonatomic ,strong) NSMutableArray *stepNumBigArray;
@property (nonatomic ,strong) NSMutableDictionary *totalDataDict;
//- (instancetype)initWithTargetStepNum:(int)targetStepNum stepNumArray:(NSMutableArray *)stepNumArray;

- (instancetype)initWithTargetStepNum:(int)targetStepNum stepNumDict:(NSMutableDictionary *)stepNumDict;

@end
