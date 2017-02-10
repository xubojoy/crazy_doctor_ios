//
//  DiagnosisEyesResultCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/29.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "DiagnosisEyesResultCell.h"

@implementation DiagnosisEyesResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((screen_width-94-30-100)/2+15, (150-100)/2, 100, 100)];
    [self.contentView addSubview:self.logoImageView];
    [self.contentView bringSubviewToFront:self.logoImageView];
}

- (void)renderDiagnosisEyesResultCellWithEyePosition:(EyePosition *)eyePosition row:(NSInteger)row{
    if ([NSStringUtils isNotBlank:eyePosition.organ]) {
        self.titleLabel.text = eyePosition.organ;
    }
    
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:eyePosition.imgUrl] placeholderImage:[UIImage imageNamed:@"icon_default_homepage_picture"]];
    
    int remaindNum = row%4;
    
    if (remaindNum == 0) {
        UIImage *image = [UIImage imageNamed:@"bg_eye_assist_liver_r"];
        self.leftImgView.image = [self resizableBgImage:image];
        self.rightImgView.image = [UIImage imageNamed:@"bg_eye_assist_liver_red"];
    }else if (remaindNum == 1){
        UIImage *image = [UIImage imageNamed:@"bg_eye_assist_liver_bro"];
        self.leftImgView.image = [self resizableBgImage:image];
        self.rightImgView.image = [UIImage imageNamed:@"bg_eye_assist_liver_brown"];
    }else if (remaindNum == 2){
        UIImage *image = [UIImage imageNamed:@"bg_eye_assist_liver_yel"];
        self.leftImgView.image = [self resizableBgImage:image];
        self.rightImgView.image = [UIImage imageNamed:@"bg_eye_assist_liver_yellow"];
    }else{
        UIImage *image = [UIImage imageNamed:@"bg_eye_assist_liver_a"];
        self.leftImgView.image = [self resizableBgImage:image];
        self.rightImgView.image = [UIImage imageNamed:@"bg_eye_assist_liver_ash"];
    }

}

- (UIImage *)resizableBgImage:(UIImage *)image{
    CGFloat top = 20; // 顶端盖高度
    CGFloat bottom = 20 ; // 底端盖高度
    CGFloat left = 10; // 左端盖宽度
    CGFloat right = 10; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 指定为拉伸模式，伸缩后重新赋值
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    return image;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
