//
//  TonguePictureCollectionCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/25.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "TonguePictureCollectionCell.h"
#define WIDTH_PIC       self.bounds.size.width
#define HEIGHT_PIC      self.bounds.size.height
@implementation TonguePictureCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.titleLabel.textColor = [ColorUtils colorWithHexString:common_app_text_color];
    self.titleLabel.backgroundColor = [ColorUtils colorWithHexString:@"#faefde"];
    self.bgImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.bgImgView.clipsToBounds = YES;
    
    [self.selectedBtn setImage:[UIImage imageNamed:@"icon_abandon_picture_select"] forState:UIControlStateSelected];
    [self.selectedBtn setImage:[UIImage imageNamed:@"icon_abandon_picture_select_nor"] forState:UIControlStateNormal];
}
- (IBAction)showBigIMGClick:(UIButton *)sender {
    NSLog(@"查看大图");
    self.previewBlock();
}

- (IBAction)imgSelectClick:(UIButton *)sender {
    NSLog(@"点击选中");
    if (self.selectedBtn.selected) {
        self.selectedBtn.selected = NO;
        self.selectedBlock(NO);
    }else{
        self.selectedBtn.selected = YES;
        self.selectedBlock(YES);
    }
}

- (void)configWithModel:(ShowIMGModel *)model{
    NSLog(@">>>>>>>>>渲染数据>>>>>>>>>>>%@",model);
    [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:model.logoUrl] placeholderImage:[UIImage imageNamed:@"icon_default_homepage_picture"]];
    if (model.selected) {
        self.selectedBtn.selected = YES;
    }else{
        self.selectedBtn.selected = NO;
    }
}

@end
