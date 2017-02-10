//
//  JFHeaderView.m
//  JFList
//
//  Created by 李俊峰 on 16/2/28.
//  Copyright © 2016年 李俊峰. All rights reserved.
//

#import "JFHeaderView.h"

@interface JFHeaderView ()


@end

@implementation JFHeaderView

+ (JFHeaderView *)jfHeadViewWithTableView:(UITableView *)tableView
{
    static NSString * JFHeaderViewID = @"JFHeaderView";
    JFHeaderView * headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:JFHeaderViewID];
    if (headView == nil) {
        headView = [[JFHeaderView alloc]initWithReuseIdentifier:JFHeaderViewID];
        headView.contentView.backgroundColor = [UIColor whiteColor];
    }
    return headView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView * _line = [[UIView alloc] initWithFrame:CGRectMake(0, 100-splite_line_height, screen_width, splite_line_height)];
        _line.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
        [self.contentView addSubview:_line];

        
        self.logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(general_margin, general_margin, 100, 70)];
        self.logoImageView.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:self.logoImageView];
        
    }
    return self;
}

- (void)setGroup:(ModelGroups *)group
{
    _group = group;
    if (_group) {
//        self.label.text = _group.name;
        if ([group.name isEqualToString:@"平和"]) {
            self.imageArrow.hidden = YES;
            self.labelNum.text = @"";
        }else{
            self.imageArrow.hidden = NO;
            self.labelNum.text = @"请回答以下问题";
        }
        
        [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:_group.logoUrl] placeholderImage:[UIImage imageNamed:@"icon_default_homepage_picture"]];
        [self setArrowImageViewWithIfUnfold:self.group.isOpen];
        
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageArrow.frame = CGRectMake(screen_width-18-20, (self.frame.size.height-20)/2, 20, 20);
    self.label.frame = CGRectMake(CGRectGetMaxX(self.logoImageView.frame)+17, 29, screen_width-132-38, 20);
    self.button.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.labelNum.frame = CGRectMake(CGRectGetMaxX(self.logoImageView.frame)+17, 29+20+14, screen_width-132-38, 20);
}

- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.font = [UIFont boldSystemFontOfSize:bigger_1_font_size];
        _label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_label];
    }
    return _label;
}

- (UILabel *)labelNum{
    if (!_labelNum) {
        _labelNum = [[UILabel alloc]init];
        _labelNum.font = [UIFont systemFontOfSize:13.0];
        _labelNum.textAlignment = NSTextAlignmentLeft;
        _labelNum.textColor = [ColorUtils colorWithHexString:gray_text_color];
//        _labelNum.text = @"请回答以下问题";
        [self.contentView addSubview:_labelNum];
    }
    return _labelNum;
}

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button];
    }
    return _button;
}

- (UIImageView *)imageArrow{
    if (!_imageArrow) {
        _imageArrow = [[UIImageView alloc] init];
        _imageArrow.image = [UIImage imageNamed:@"icon_abandon_answer_down"];
        [self.contentView addSubview:_imageArrow];
    }
    return _imageArrow;
}

-(void)buttonClick:(UIButton *)sender
{
    self.group.isOpen =! self.group.isOpen;
    
    if ([self.delegate respondsToSelector:@selector(jfHeaderView:didButton:)]) {
        [self.delegate jfHeaderView:self didButton:sender];
    }
}
/**
 *   设置图片箭头旋转
 */
-(void)setArrowImageViewWithIfUnfold:(BOOL)unfold
{
    double degree;
    if(unfold){
        degree = M_PI;
    } else {
        degree = 0;
    }
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.imageArrow.layer.transform = CATransform3DMakeRotation(degree, 0, 0, 1);
    } completion:NULL];
}

@end
