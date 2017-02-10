//
//  TongueDiagnosisTestController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/27.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFHeaderView.h"
#import "TongueDiagnosisTestCell.h"
#import "ShowIMGModel.h"
@interface TongueDiagnosisTestController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,JFHeaderViewDelegate,TongueDiagnosisTestCellDelegate>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *listArray;
@property (nonatomic ,strong) NSMutableArray *modelArray;
@property (nonatomic ,strong) NSMutableDictionary *selectDict;
@property (nonatomic ,strong) NSMutableDictionary *selectSectionDict;
@property (nonatomic ,strong) NSMutableArray *selectSaveArray;
@property (nonatomic ,assign) int currentSection;

@property (nonatomic ,strong) NSMutableArray *tagIdArray;
@property (nonatomic ,strong) NSString *tongueImgUrl;

@property (nonatomic ,strong) NSMutableArray *bigArray;
@property (nonatomic ,strong) NSMutableDictionary *openDict;

-(instancetype)initWithModelArray:(NSMutableArray *)modelArray tongueImgUrl:(NSString *)tongueImgUrl;
@end
