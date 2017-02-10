//
//  TongueDiagnosisTestCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/27.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "TongueDiagnosisTestCell.h"

@implementation TongueDiagnosisTestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.rightBtn.tag = rightBtn_tag;
    self.wrong.tag = wrongBtn_tag;
    self.downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
    [self.wrong setImage:[UIImage imageNamed:@"icon_abandon_answer_select_circle_pre"] forState:UIControlStateNormal];
}

- (void)renderTongueDiagnosisTestCellWithTitle:(NSString *)title{
    if ([NSStringUtils isNotBlank:title]) {
        self.titleLabel.text = title;
    }
}

- (IBAction)selectRightOrWrongBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectRightOrWrongBtnClick:)]) {
        [self.delegate didSelectRightOrWrongBtnClick:sender];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
