//
//  DiagnosisOnEyesSelectCollectionCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/3.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EyePositionModel.h"
@interface DiagnosisOnEyesSelectCollectionCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

- (void)renderDiagnosisOnEyesSelectCollectionCell:(EyePositionModel *)eyePositionModel;

@end
