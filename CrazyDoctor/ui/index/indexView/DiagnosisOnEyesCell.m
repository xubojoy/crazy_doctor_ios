//
//  DiagnosisOnEyesCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/29.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "DiagnosisOnEyesCell.h"

@implementation DiagnosisOnEyesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.areaBtn setTitleColor:[ColorUtils colorWithHexString:light_gray_text_color] forState:UIControlStateNormal];
    
    self.leftLine.backgroundColor = [ColorUtils colorWithHexString:common_app_text_color];
    self.rightLine.backgroundColor = [ColorUtils colorWithHexString:common_app_text_color];
    self.downLine.backgroundColor = [ColorUtils colorWithHexString:common_app_text_color];
    self.upLine.backgroundColor = [ColorUtils colorWithHexString:common_app_text_color];
}

- (void)renderDiagnosisOnEyesCell:(EyePositionModel *)model row:(int)row showUpLine:(BOOL)showUp showDown:(BOOL)show{
    if ([NSStringUtils isNotBlank:model.remark]) {
        self.titleLabel.text = model.remark;
    }
    
    if (showUp) {
        self.upLine.hidden = NO;
    }else{
        self.upLine.hidden = YES;
    }
    
    if (show) {
        self.downLine.hidden = NO;
    }else{
        self.downLine.hidden = YES;
    }
    
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
