//
//  CheckDiagnosisEyesController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/29.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopReCheckView.h"
#import "DiagnosisEyesResultCell.h"
#import "EyeDiagnoseRecord.h"
#import "EyePosition.h"
#import "CustomEmptyView.h"
@protocol CheckDiagnosisEyesControllerDelegate <NSObject>

- (void)didreCheckDiagnosisEyesBtnClick:(UIButton *)sender;

- (void)didreCheckDiagnosisEyesEmptyBtnClick:(UIButton *)sender;

@end
@interface CheckDiagnosisEyesController : BaseViewController<UITableViewDelegate,UITableViewDataSource,TopReCheckViewDelegate,CustomEmptyViewDelegate>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) TopReCheckView *topEyeReCheckView;
@property (nonatomic ,strong) CustomEmptyView *customEmptyView;
@property (nonatomic ,strong) EyeDiagnoseRecord *eyeDiagnoseRecord;
@property (nonatomic ,strong) EyePosition *eyePosition;
@property (nonatomic ,strong) NSMutableArray *eyePositionSelectArray;
@property (nonatomic ,assign) id<CheckDiagnosisEyesControllerDelegate> delegate;

@end
