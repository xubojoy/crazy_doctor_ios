//
//  DiagnosisOnEyesSelectCollectionCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/3.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "DiagnosisOnEyesSelectCollectionCell.h"

@implementation DiagnosisOnEyesSelectCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)renderDiagnosisOnEyesSelectCollectionCell:(EyePositionModel *)eyePositionModel{
    [self.selectBtn setTitle:[NSString stringWithFormat:@"%d",eyePositionModel.positionId] forState:UIControlStateNormal];
    [self.selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

@end
