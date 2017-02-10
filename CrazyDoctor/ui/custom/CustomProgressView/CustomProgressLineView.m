//
//  CustomProgressLineView.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/6/30.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "CustomProgressLineView.h"
#define LineWidth 6

@interface CustomProgressLineView ()
{
    NSInteger _startRate;
}
@property (nonatomic, assign) CGFloat vWidth;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) UIBezierPath *bPath;
@property (nonatomic, strong) UILabel *rateLbl;


@end

@implementation CustomProgressLineView

- (instancetype)initWithFrame:(CGRect)frame rate:(NSInteger)rate nav:(UINavigationController *)nav{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        self.layer.cornerRadius = 1.5;
        self.layer.masksToBounds = YES;
        self.rate = rate;
        self.navcontroller = nav;
        
//        self.renImgView = [[UIImageView alloc] initWithFrame:CGRectMake((screen_width - 200) * 0.5, self.frame.origin.y-((19-3)/2), 19, 24)];
//        self.renImgView.image = [UIImage imageNamed:@"icon_km_calorie"];
//        [self.navcontroller.view addSubview:self.renImgView];

        _startRate = 0;
        _vWidth = frame.size.width;
        _bPath = [UIBezierPath bezierPath];
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
    if (self.rate < 0 || self.rate > 100) {
        self.rate = 100;
    } else {
        self.rate = self.rate;
    }
    float n = (float)self.rate/100;
    float pro = self.frame.size.width/100;
    float w = self.frame.size.width*n;
    if (_startRate >= w) {
        _bPath = [UIBezierPath bezierPath];
        _displayLink.paused = YES;
        return;
    }
    _startRate  = _startRate + pro;
    [_bPath moveToPoint:CGPointMake(0, 0.0)];
    // Draw the lines
    [_bPath addLineToPoint:CGPointMake(_startRate, 0.0)];
    _shapeLayer.path = _bPath.CGPath;
    
    if ([self.delegate respondsToSelector:@selector(progressRate:)]) {
        [self.delegate progressRate:_startRate];
    }
//    self.renImgView.center = CGPointMake((screen_width - 200) * 0.5+_startRate, self.frame.origin.y+1);
//    [self bringSubviewToFront:self.renImgView];
}

#pragma mark - public methods

- (void)startAnimation {
    if (_displayLink.paused == YES) {
        _startRate = 0;
        _displayLink.paused = NO;
    }
}

#pragma mark - private methods

#pragma mark 底下灰色的圆
- (void)configBgCircle {
    UIBezierPath *bPath = [UIBezierPath bezierPath];
    [bPath moveToPoint:CGPointMake(0, 0.0)];
    // Draw the lines
    [bPath addLineToPoint:CGPointMake(self.frame.size.width, 0.0)];
    CAShapeLayer *shaperLayer = [CAShapeLayer layer];
    shaperLayer.fillColor = [UIColor whiteColor].CGColor;
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
    _shapeLayer.lineWidth = LineWidth;
    [self.layer addSublayer:_shapeLayer];
}

#pragma mark 配置CADisplayLink
- (void)configDisplayLink {
//    if (self.renImgView == nil) {
//            }
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawCircle)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    _displayLink.paused = YES; // 默认暂停
}

@end
