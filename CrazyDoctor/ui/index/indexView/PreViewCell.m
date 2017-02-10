//
//  PreViewCell.m
//  selectPIC
//
//  Created by colorful-ios on 15/11/25.
//  Copyright © 2015年 7Color. All rights reserved.
//

#import "PreViewCell.h"
#define WIDTH_PIC       self.bounds.size.width
#define HEIGHT_PIC      self.bounds.size.height

@interface PreViewCell ()
@property (nonatomic,strong) UIImageView *imageView;


@end

@implementation PreViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 25, WIDTH_PIC-100, HEIGHT_PIC-50)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.imageView.userInteractionEnabled = YES;
    [self.contentView addSubview:self.imageView];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddeNav)];
    [self.imageView addGestureRecognizer:tap];

}
- (void)hiddeNav{
    self.hiddenNAVBlock();
}

- (void)configWith:(ShowIMGModel *)model{
    // 在资源的集合中获取第一个集合，并获取其中的图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.tongueImageUrl] placeholderImage:[UIImage imageNamed:@"icon_default_homepage_picture"]];
}





@end
