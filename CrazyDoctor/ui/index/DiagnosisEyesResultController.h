//
//  DiagnosisEyesResultController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/29.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiagnosisEyesResultCell.h"
#import "EyeDiagnoseRecord.h"
#import "EyePosition.h"
@interface DiagnosisEyesResultController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) UIView *remindBgView;
@property (nonatomic ,strong) UILabel *remindLabel;
@property (nonatomic ,strong) UIButton *startImproveBtn;

@property (nonatomic ,strong) EyeDiagnoseRecord *eyeDiagnoseRecord;
@property (nonatomic ,strong) EyePosition *eyePosition;

@property (nonatomic ,strong) NSMutableArray *leftPointIdArray;
@property (nonatomic ,strong) NSMutableArray *rightPointIdArray;

@property (nonatomic ,strong) NSMutableArray *eyePositionSelectArray;
@property (nonatomic ,strong) NSMutableArray *eyeOrganArray;

- (instancetype)initWithSelectLeftIdArray:(NSMutableArray *)leftPointIdArray rightIdArray:(NSMutableArray *)rightPointIdArray;

@end
