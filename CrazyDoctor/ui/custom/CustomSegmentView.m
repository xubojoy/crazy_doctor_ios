//
//  CustomSegmentView.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/18.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "CustomSegmentView.h"
#import "UILabel+Custom.h"

#define red_line_view_height 2
@implementation CustomSegmentView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
    }
    return self;
}

-(void)render:(NSArray *)btnTitleArray currentIndex:(int)currentIndex
{
    float x = 0;
    float btnWidth = self.frame.size.width/btnTitleArray.count;
    
    self.redLineView = [[UIView alloc] init];
    self.redLineView.backgroundColor = [ColorUtils colorWithHexString:common_app_text_color];
    [self addSubview:self.redLineView];
    
    for (int i = 0; i < btnTitleArray.count; i ++) {
        UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        x = i*btnWidth;
        
        selectBtn.frame = CGRectMake(x, 0, btnWidth, general_cell_height);
        [selectBtn setTitle:[btnTitleArray objectAtIndex:i] forState:UIControlStateNormal];
        selectBtn.tag = [self getBtnTag:i];
        [selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [selectBtn setTitleColor:[ColorUtils colorWithHexString:gray_text_color] forState:UIControlStateNormal];
        [self addSubview:selectBtn];
        
        
        UIView *separateLine = [[UIView alloc] initWithFrame:CGRectMake(i*btnWidth, (40-15)/2, splite_line_height, general_space)];
        separateLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
        [self addSubview:separateLine];
        
    }
    
    
    [self selectIndex:currentIndex];
}

-(int)getBtnTag:(int)index{
    return btn_seed + index;
}

-(int)getInxByBtnTag:(int)tag{
    return tag - btn_seed;
}

-(void)selectIndex:(int)index{
    static int currentSelectButtonTag = 0;
    static int previousSelectButtonTag = btn_seed;
    
    currentSelectButtonTag = [self getBtnTag:index];
    
    UIButton *previousBtn=(UIButton *)[self viewWithTag:previousSelectButtonTag];
    
    [previousBtn setTitleColor:[ColorUtils colorWithHexString:gray_text_color] forState:UIControlStateNormal];
    
    UIButton *currentBtn = (UIButton *)[self viewWithTag:currentSelectButtonTag];
    [currentBtn setTitleColor:[ColorUtils colorWithHexString:common_app_text_color] forState:UIControlStateNormal];
    previousSelectButtonTag = currentSelectButtonTag;
    
    [self.redLineView removeFromSuperview];
    float btnTitleWidth = currentBtn.titleLabel.realWidth;
    float x = (currentBtn.frame.size.width - btnTitleWidth)/2;
    self.redLineView.frame = CGRectMake(x, self.frame.size.height-red_line_view_height, btnTitleWidth, red_line_view_height);
    [currentBtn addSubview:self.redLineView];
    
    self.currentIndex = index;
    [self.delegate selectSegment:index];
}

-(void)renderRedDot:(int)index showRedDot:(BOOL)showRedDot{
    index = btn_seed+index;  // 外面直接传第几个就可以，不用知道是从多少开始的。
    UIButton *btn = (UIButton *)[self viewWithTag:index];
    float width = btn.frame.size.width;
    float titleLabelWidth = btn.titleLabel.realWidth;
    width = width - ( (width-titleLabelWidth)/2 - 5 );
    
    if (self.redDotImage == nil) {
        self.redDotImage = [[UIImageView alloc] init];
        [btn addSubview:self.redDotImage];
    }
    self.redDotImage.frame = CGRectMake(width, (general_cell_height - red_dot_width)/2, red_dot_width, red_dot_width);
    self.redDotImage.image = [UIImage imageNamed:@"red_dot"];
    [self.redDotImage setHidden:(showRedDot==YES?NO:YES)];
}

-(void)selectBtnClick:(UIButton *)sender
{
    int index = [self getInxByBtnTag:(int)sender.tag];
    if(index == self.currentIndex){
        return ;
    }
    [self selectIndex:index];
}
@end
