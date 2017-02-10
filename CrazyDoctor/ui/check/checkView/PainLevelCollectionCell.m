//
//  PainLevelCollectionCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/5.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "PainLevelCollectionCell.h"

@implementation PainLevelCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.remindLabel.textColor = [ColorUtils colorWithHexString:gray_text_color];
}

- (void)renderPainLevelCollectionCellWithTitle:(NSString *)title meridian:(NSString *)meridianRemind brownStr:(NSString *)brownStr{
    [self.painLevelSelectBtn setTitle:title forState:UIControlStateNormal];
    int start = (int)[meridianRemind rangeOfString:[NSString stringWithFormat:@"%@",brownStr]].location;
    int length = (int)[meridianRemind rangeOfString:[NSString stringWithFormat:@"%@",brownStr]].length;
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:meridianRemind];
    [attributedText addAttribute:NSForegroundColorAttributeName value:[ColorUtils colorWithHexString:lighter_2_brown_color] range:NSMakeRange(start,length)];
    [attributedText addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:smaller_font_size] range:NSMakeRange(start,length)];
    self.remindLabel.attributedText = attributedText;
}

- (void)cellWithData:(PainLevelModel *)model{

    if (model.isSelected) {
        [self.painLevelSelectBtn setImage:[UIImage imageNamed:@"icon_abandon_answer_select_circle_pre"] forState:UIControlStateNormal];
        self.remindLabel.hidden = NO;
    } else {
        [self.painLevelSelectBtn setImage:[UIImage imageNamed:@"icon_abandon_answer_select_circle_nor"] forState:UIControlStateNormal];
        self.remindLabel.hidden = YES;
    }
}

- (IBAction)painLevelBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didPainLevelBtnClick:)]) {
        [self.delegate didPainLevelBtnClick:sender];
    }
}



@end
