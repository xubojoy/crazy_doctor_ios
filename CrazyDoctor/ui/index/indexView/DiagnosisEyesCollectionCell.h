//
//  DiagnosisEyesCollectionCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/17.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EyePositionModel.h"

@interface DiagnosisEyesCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *areaBtn;


- (void)renderDiagnosisOnEyesCell:(EyePositionModel *)model row:(int)row;

@end
