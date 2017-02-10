//
//  CheckTongueDiagnosisController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/29.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TongueDiagnoseRecord.h"
#import "BodyTag.h"
#import "TopReCheckView.h"
#import "TongueDiagnosisResultCell.h"
#import "PopUpView.h"
#import "DiagnoseQaRecord.h"
#import "SubhealthyProblemCell.h"
#import "CustomEmptyView.h"
@protocol CheckTongueDiagnosisControllerDelegate <NSObject>

- (void)didreCheckTongueDiagnosisBtnClick:(UIButton *)sender;
- (void)didreCheckTongueDiagnosisEmptyBtnClick:(UIButton *)sender;

@end

@interface CheckTongueDiagnosisController : BaseViewController<UITableViewDelegate,UITableViewDataSource,TopReCheckViewDelegate,CustomEmptyViewDelegate>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) CustomEmptyView *customEmptyView;
@property (nonatomic ,strong) TongueDiagnoseRecord *tongueDiagnoseRecord;
@property (nonatomic ,strong) BodyTag *bodyTag;
@property (nonatomic ,strong) DiagnoseQaRecord *diagnoseQaRecord;
@property (nonatomic ,strong) NSMutableArray *bodyTagsArray;
@property (nonatomic ,strong) NSArray *tagsArray;
@property (nonatomic ,strong) PopUpView *popUpView;
@property (nonatomic ,strong) UIImageView *detailImagView;
@property (nonatomic ,strong) UIButton *cancelBtn;
@property (nonatomic ,strong) TopReCheckView *topReCheckView;
@property (nonatomic ,strong) NSMutableArray *diagnoseQaRecordsJsonStrArray;
@property (nonatomic ,strong) NSMutableArray *userSelectDiagnoseQaRecordsJsonResultArray;

@property (nonatomic ,assign) id<CheckTongueDiagnosisControllerDelegate> delegate;

@end
