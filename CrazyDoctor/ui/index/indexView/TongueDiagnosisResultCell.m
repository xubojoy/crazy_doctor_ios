//
//  TongueDiagnosisResultCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/19.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "TongueDiagnosisResultCell.h"

@implementation TongueDiagnosisResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.featureLabel = [[UILabel alloc] init];
    self.featureLabel.textColor = [ColorUtils colorWithHexString:white_text_color];
    self.featureLabel.font = [UIFont boldSystemFontOfSize:default_font_size];
    [self.contentView addSubview:self.featureLabel];
    
    self.titleBgImageView.contentMode = UIViewContentModeCenter;
    self.titleBgImageView.clipsToBounds = YES;
}

- (void)renderTongueDiagnosisResultCell:(BodyTag *)bodyTag withSection:(NSInteger)section{
    if ([NSStringUtils isNotBlank:bodyTag.remark]) {
        NSString *remarkStr = [NSString stringWithFormat:@"[%@]",bodyTag.remark];
        NSDictionary *attribute = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:default_font_size]};
        CGSize featureLabelSize = [remarkStr boundingRectWithSize:CGSizeMake(screen_width, 0)
                                                               options:
                                   NSStringDrawingTruncatesLastVisibleLine |
                                   NSStringDrawingUsesLineFragmentOrigin |
                                   NSStringDrawingUsesFontLeading
                                                            attributes:attribute
                                                               context:nil].size;
        self.featureLabel.text = remarkStr;
        self.featureLabel.textAlignment = NSTextAlignmentCenter;
        float featureLabelLeft = screen_width-105-15+((105-featureLabelSize.width)/2);
        self.featureLabel.frame = CGRectMake(featureLabelLeft, 5+50, featureLabelSize.width, 20);
    }
    
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:bodyTag.nameUrl] placeholderImage:nil];
    
    if (section == 0) {
        if ([NSStringUtils isNotBlank:bodyTag.name] && [bodyTag.name isEqualToString:@"平和"]) {
            self.titleBgImageView.image = [UIImage imageNamed:@"conclusion_abandon_gree"];
            self.rightImageView.image = [UIImage imageNamed:@"conclusion_abandon_green"];
        }else{
            self.titleBgImageView.image = [UIImage imageNamed:@"conclusion_abandon_re"];
            self.rightImageView.image = [UIImage imageNamed:@"conclusion_abandon_red"];
        }
        
    }else if (section == 1){
        self.titleBgImageView.image = [UIImage imageNamed:@"conclusion_abandon_brownn"];
        self.rightImageView.image = [UIImage imageNamed:@"conclusion_abandon_brownness"];
    }else{
        self.titleBgImageView.image = [UIImage imageNamed:@"conclusion_abandon_yell"];
        self.rightImageView.image = [UIImage imageNamed:@"conclusion_abandon_yellow"];
    }
}

- (UIImage *)resizableBgImage:(UIImage *)image{
    CGFloat top = 0; // 顶端盖高度
    CGFloat bottom = 0 ; // 底端盖高度
    CGFloat left = ((screen_width-30)*48)/69-30; // 左端盖宽度
    CGFloat right = (screen_width - 30)-(((screen_width - 30)*21)/69); // 右端盖宽度
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
