//
//  TongueDiagnosisResultController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/19.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TongueDiagnosisResultCell.h"
#import "TongueDiagnoseRecord.h"
#import "BodyTag.h"
#import "PopUpView.h"
@interface TongueDiagnosisResultController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) UIButton *rightShareBtn;
@property (nonatomic ,strong) UIButton *startImproveBtn;
@property (nonatomic ,strong) UIView *remindBgView;
@property (nonatomic ,strong) UILabel *remindLabel;

@property (nonatomic ,strong) NSString *userTongueUrl;
@property (nonatomic ,strong) NSArray *bodyTagIds;
@property (nonatomic ,strong) NSArray *userSelectQuestions;
@property (nonatomic ,strong) TongueDiagnoseRecord *tongueDiagnoseRecord;
@property (nonatomic ,strong) BodyTag *bodyTag;
@property (nonatomic ,strong) NSMutableArray *bodyTagsArray;
@property (nonatomic ,strong) NSMutableArray *bodyTagsNameArray;
@property (nonatomic ,strong) PopUpView *popUpView;

@property (nonatomic ,strong) UIImageView *detailImagView;
@property (nonatomic ,strong) UIButton *cancelBtn;
@property (nonatomic ,assign) BOOL isPingHe;

- (instancetype)initWithUserTongueUrl:(NSString *)userTongueUrl bodyTagIds:(NSArray *)bodyTagIds userSelectQuestions:(NSArray *)userSelectQuestions isPingHe:(BOOL)isPingHe;
@end
