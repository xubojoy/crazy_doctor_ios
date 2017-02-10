//
//  DiagnosisEyesResultCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/29.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EyePosition.h"
@interface DiagnosisEyesResultCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *rightImgView;


@property (weak, nonatomic) IBOutlet UIImageView *leftImgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *logoImgView;

@property (nonatomic ,strong) UIImageView *logoImageView;



- (void)renderDiagnosisEyesResultCellWithEyePosition:(EyePosition *)eyePosition row:(NSInteger)row;

@end
