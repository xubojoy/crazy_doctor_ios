//
//  XBHeaderView.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/16.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "XBHeaderView.h"

@implementation XBHeaderView

+ (XBHeaderView *)xbHeaderViewWithTableView:(UITableView *)tableView
{
    static NSString * XBHeaderViewID = @"XBHeaderView";
    XBHeaderView * headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:XBHeaderViewID];
    if (headView == nil) {
        headView = [[XBHeaderView alloc]initWithReuseIdentifier:XBHeaderViewID];
        headView.contentView.backgroundColor = [UIColor whiteColor];
    }
    return headView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView * _line = [[UIView alloc] initWithFrame:CGRectMake(0, 50-splite_line_height, screen_width, splite_line_height)];
        _line.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
        [self.contentView addSubview:_line];
    }
    return self;
}

- (void)setGroup:(MedicalRecordModel *)group
{
    _group = group;
    if (_group) {
        self.label.text = group.name;
        [self setArrowImageViewWithIfUnfold:self.group.isOpen];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageArrow.frame = CGRectMake(screen_width-15-20, (self.frame.size.height-20)/2, 20, 20);
    self.label.frame = CGRectMake(general_margin, 0, screen_width-15-20, 50);
    self.button.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.font = [UIFont systemFontOfSize:default_1_font_size];
        _label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_label];
    }
    return _label;
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
    
    if ([self.delegate respondsToSelector:@selector(xbHeaderView:didButton:)]) {
        [self.delegate xbHeaderView:self didButton:sender];
    }
}
/**
 *   设置图片箭头旋转
 */
-(void)setArrowImageViewWithIfUnfold:(BOOL)unfold
{
    NSLog(@">>>>>>>>箭头>>>>>>>>>%d",unfold);
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
