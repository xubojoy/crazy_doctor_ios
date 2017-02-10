//
//  DiagnosisEyesCollectionCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/17.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "DiagnosisEyesCollectionCell.h"

@implementation DiagnosisEyesCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.areaBtn setTitleColor:[ColorUtils colorWithHexString:light_gray_text_color] forState:UIControlStateNormal];
    self.areaBtn.userInteractionEnabled = NO;
}

- (void)renderDiagnosisOnEyesCell:(EyePositionModel *)model row:(int)row{
    [self.areaBtn setTitle:[NSString stringWithFormat:@"%d",row] forState:UIControlStateNormal];
    self.areaBtn.titleLabel.font = [UIFont boldSystemFontOfSize:9];
    
    [self.areaBtn setTitle:[NSString stringWithFormat:@"%d",row] forState:UIControlStateNormal];
    self.areaBtn.titleLabel.font = [UIFont boldSystemFontOfSize:9];
    
    if (model.selectState)
    {
        [self.areaBtn  setBackgroundImage:[UIImage imageNamed:@"icon_ocular_region_selectpre"] forState:UIControlStateNormal];
        [self.areaBtn setTitleColor:[ColorUtils colorWithHexString:white_text_color] forState:UIControlStateNormal];
        
    }else{
        [self.areaBtn  setBackgroundImage:[UIImage imageNamed:@"icon_ocular_region_selectnor"] forState:UIControlStateNormal];
        [self.areaBtn setTitleColor:[ColorUtils colorWithHexString:light_gray_text_color] forState:UIControlStateNormal];
    }

}

@end
