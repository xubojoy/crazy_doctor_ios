//
//  MyDiagnosticsMeridiansCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/11.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBorderView.h"
#import "DiagnoseLog.h"
@interface MyDiagnosticsMeridiansCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@property (weak, nonatomic) IBOutlet UIView *downLine;


@property (weak, nonatomic) IBOutlet UIView *bgMeridiansView;

@property (nonatomic ,strong) LBorderView *sepImageView;

@property (nonatomic ,strong) UILabel *acupointLabel;
@property (nonatomic ,strong) UILabel *painLevelLabel;

- (void)renderMyDiagnosticsMeridiansCellWithDiagnoseLog:(DiagnoseLog *)diagnoseLog;

@end
