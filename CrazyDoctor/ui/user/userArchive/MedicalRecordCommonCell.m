//
//  MedicalRecordCommonCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/12.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "MedicalRecordCommonCell.h"

@implementation MedicalRecordCommonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentLabel.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
    self.downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
}

- (void)renderMedicalRecordCommonCellWithTitle:(NSString *)title content:(NSString *)content{
    self.titleLabel.text = title;
    if ([NSStringUtils isNotBlank:content]) {
        self.contentLabel.text = content;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
