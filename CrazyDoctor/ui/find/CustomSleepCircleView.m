//
//  CustomSleepCircleView.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/26.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "CustomSleepCircleView.h"
#define LineWidth 1

@interface CustomSleepCircleView ()
{
    CGFloat _startAngle; // 开始的角度
    NSInteger _startRate;
    NSInteger _startStep;
}
@property (nonatomic, assign) CGFloat vWidth;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) UIBezierPath *bPath;
@property (nonatomic, strong) UILabel *rateLbl;

@end

@implementation CustomSleepCircleView

- (instancetype)initWithFrame:(CGRect)frame tagartStep:(NSInteger)tagartStep realStep:(NSInteger)realStep{
    if (self = [super initWithFrame:frame]) {
        self.tagartStep = tagartStep;
        self.realStep = realStep;
        _startAngle = -90; // 从圆的最顶部开始
        _startRate = 0;
        _vWidth = frame.size.width;
        _bPath = [UIBezierPath bezierPath];
        // label
        [self configLbl];
        // 先画一个底部的圆
        [self configBgCircle];
        // 配置CAShapeLayer
        [self configShapeLayer];
        // 配置CADisplayLink
        [self configDisplayLink];
    }
    return self;
}

#pragma mark - event response

- (void)drawCircle {
    if (_startRate >= _rate) {
        _bPath = [UIBezierPath bezierPath];
        _displayLink.paused = YES;
        return;
    }
    _startRate ++;
    //    _rateLbl.text = [NSString stringWithFormat:@"%ld%%", (long)_startRate];
    [_bPath addArcWithCenter:CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5) radius:_vWidth * 0.5 startAngle:(M_PI / 180.0) * _startAngle endAngle:(M_PI / 180.0) * (_startAngle + 3.6) clockwise:YES];
    _shapeLayer.path = _bPath.CGPath;
    _startAngle += 3.6;
}

#pragma mark - public methods

- (void)startAnimation {
    if (_displayLink.paused == YES) {
        _startAngle = -90;
        _startRate = 0;
        _displayLink.paused = NO;
    }
}

#pragma mark - private methods

#pragma mark 中间显示数字的Label
- (void)configLbl {
    CGFloat rateLblX = 10;
    CGFloat rateLblW = self.frame.size.width - 2 * rateLblX;
    CGFloat rateLblH = 40;
    CGFloat rateLblY = (self.frame.size.height - rateLblH) * 0.5;
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(rateLblX, rateLblY, rateLblW, rateLblH)];
    _rateLbl = lbl;
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = [UIColor whiteColor];
    lbl.font = [UIFont systemFontOfSize:biggest_font_size];
    
    int hour = (int)self.realStep / 60; //3小时
    int minremains = (int)self.realStep % 60; //余数，20分钟
    NSLog(@">>>>>>>计算时间>>>>>>%d>>%d",hour,minremains);
    NSString *realStepStr= [NSString stringWithFormat:@"%d小时%d分钟",hour,minremains];
    int start = (int)[realStepStr rangeOfString:[NSString stringWithFormat:@"%@",@"小时"]].location;
    NSLog(@">>>>>>>>>>开始位置>>>>>>>>>%d",start);
    int length = (int)[realStepStr rangeOfString:[NSString stringWithFormat:@"%@",@"小时"]].length;
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:realStepStr];
    [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(start,length)];

    int start1 = (int)[realStepStr rangeOfString:[NSString stringWithFormat:@"%@",@"分钟"]].location;
    NSLog(@">>>>>>>>>>开始位置>>>>>>>>>%d",start);
    int length1 = (int)[realStepStr rangeOfString:[NSString stringWithFormat:@"%@",@"分钟"]].length;
    NSMutableAttributedString *attributedText1 = [[NSMutableAttributedString alloc] initWithAttributedString:attributedText];
    [attributedText1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(start1,length1)];
    
    lbl.attributedText = attributedText1;
    [self addSubview:lbl];
    
    self.tagartLabel = [[UILabel alloc] init];
    self.tagartLabel.text = [NSString stringWithFormat:@"%ld",(long)self.tagartStep];
    self.tagartLabel.font = [UIFont systemFontOfSize:small_font_size];
    self.tagartLabel.frame = CGRectMake(((293/2)-self.tagartLabel.realWidth-5-16)/2+5+16, rateLblY+rateLblH+10, self.tagartLabel.realWidth, 16);
    self.tagartLabel.textAlignment = NSTextAlignmentCenter;
    self.tagartLabel.textColor = [ColorUtils colorWithHexString:@"#faefde"];
    [self addSubview:self.tagartLabel];
    
    self.flagImageView = [[UIImageView alloc] initWithFrame:CGRectMake(((293/2)-self.tagartLabel.realWidth-5-16)/2, rateLblY+rateLblH+10, 16, 16)];
    self.flagImageView.image = [UIImage imageNamed:@"icon_fiag"];
    [self addSubview:self.flagImageView];
}

#pragma mark 底下灰色的圆
- (void)configBgCircle {
    UIBezierPath *bPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5) radius:_vWidth * 0.5 startAngle:0 endAngle:360 clockwise:YES];
    CAShapeLayer *shaperLayer = [CAShapeLayer layer];
    shaperLayer.fillColor = [UIColor clearColor].CGColor;
    shaperLayer.strokeColor = [UIColor whiteColor].CGColor;
    shaperLayer.lineWidth = LineWidth;
    shaperLayer.path = bPath.CGPath;
    [self.layer addSublayer:shaperLayer];
}

#pragma mark 配置CAShaperLayer
- (void)configShapeLayer {
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.strokeColor = [ColorUtils colorWithHexString:@"#9cbe31"].CGColor;
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    _shapeLayer.lineWidth = 3;
    [self.layer addSublayer:_shapeLayer];
}

#pragma mark 配置CADisplayLink
- (void)configDisplayLink {
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawCircle)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    _displayLink.paused = YES; // 默认暂停
}

#pragma mark - getter/setter

- (void)setRate:(NSInteger)rate {
    if (rate <= 0 || rate > 100) {
        rate = 100;
    } else {
        _rate = rate;
    }
}

@end
