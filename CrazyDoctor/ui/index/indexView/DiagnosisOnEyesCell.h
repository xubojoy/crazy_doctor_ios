//
//  DiagnosisOnEyesCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/29.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EyePositionModel.h"
@interface DiagnosisOnEyesCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIButton *areaBtn;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *leftLine;

@property (weak, nonatomic) IBOutlet UIView *rightLine;
@property (weak, nonatomic) IBOutlet UIView *downLine;

@property (weak, nonatomic) IBOutlet UIView *upLine;



- (void)renderDiagnosisOnEyesCell:(EyePositionModel *)model row:(int)row showUpLine:(BOOL)showUp showDown:(BOOL)show;

@end
