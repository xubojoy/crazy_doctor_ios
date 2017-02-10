//
//  LineChartView.m
//  DrawTool
//
//  Created by li_yong on 15/7/9.
//  Copyright (c) 2015年 li_yong. All rights reserved.
//

#import "LineCustomChartView.h"
#import "CoordinateItem.h"

#define ANIMATION_DURING 2
#define LINE_WIDTH  1
#define screen_width          [UIScreen mainScreen].bounds.size.width
#define screen_height          [UIScreen mainScreen].bounds.size.height
@interface LineCustomChartView()

//折线和标点的颜色
@property (strong, nonatomic) UIColor *lineAndPointColor;

//是否动态绘制
@property (assign, nonatomic) BOOL isAnimation;

@end

@implementation LineCustomChartView

/**
 *  @author li_yong
 *
 *  构建方法
 *
 *  @param dataSource  数据源
 *  @param color       折线点和折线的颜色
 *  @param isAnimation 是否动态绘制
 *
 *  @return
 */
- (id)initWithDataSource:(NSMutableArray *)dataSource
   withLineAndPointColor:(UIColor *)color
           withAnimation:(BOOL)isAnimation
               targetNum:(int)targetNum
{
    self = [super initWithDataSource:dataSource];
    if (self)
    {
        self.lineAndPointColor = color;
        self.isAnimation = isAnimation;
        self.targetNum = targetNum;
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 1;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    CGContextRef currentCtx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(currentCtx, self.lineAndPointColor.CGColor);
    CGContextSetStrokeColorWithColor(currentCtx, self.lineAndPointColor.CGColor);
    NSMutableArray* array = [NSMutableArray array];
    for (NSInteger i = 0; i < self.dataSource.count; i++) {
        CoordinateItem *item = [self.dataSource objectAtIndex:i];
        CGFloat num = [item.coordinateYValue floatValue];
        [array addObject:[NSNumber numberWithFloat:num]];
    }
    CGFloat maxValue = [[array valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat minValue = [[array valueForKeyPath:@"@min.floatValue"] floatValue];
    NSLog(@"______maxValue________%f-----%f",maxValue,minValue);
    NSLog(@">>>>>>>>>>>纵坐标的最大值>>>>>>>>>>>%d----%d",self.maxYValue,(self.targetNum));
    
    //绘制坐标点
    NSMutableArray *coordinateArray = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *initCoordinateArray = [NSMutableArray arrayWithCapacity:0];
    for (int index = 0; index<[self.dataSource count]; index++)
    {
        CoordinateItem *item = [self.dataSource objectAtIndex:index];
        NSLog(@"______item.coordinateYValue.intValue________%d",item.coordinateYValue.intValue);
        /**
         *  self.dashedSpace/self.yNumberSpace:计算纵轴上点与点间距(1和2、2和3)
         */
        CGPoint itemCoordinate = CGPointMake(MARGIN_LEFT + index * (screen_width-90)/7,
                                             self.frame.size.height - (MARGIN_TOP + [item.coordinateYValue integerValue]*(self.dashedSpace/self.yNumberSpace)));
//        //记录坐标点
        [coordinateArray addObject:NSStringFromCGPoint(itemCoordinate)];
        if (index == 0) {
            CGContextAddArc(currentCtx, itemCoordinate.x, itemCoordinate.y, 0, 0, 2*M_PI, 1);
        }else{
            
//            if (item.coordinateYValue.floatValue == maxValue) {
//                CGContextAddArc(currentCtx, itemCoordinate.x, itemCoordinate.y, 0, 0, 2*M_PI, 1);
////                if (maxValue != 0) {
////                    UIImageView *championImgView = [[UIImageView alloc] initWithFrame:CGRectMake(itemCoordinate.x, itemCoordinate.y, 12, 12)];
////                    championImgView.image = [UIImage imageNamed:@"icon_champion"];
////                    championImgView.center = CGPointMake(itemCoordinate.x, itemCoordinate.y);
////                    [self addSubview:championImgView];
////                }
//            }else{
                CGContextAddArc(currentCtx, itemCoordinate.x, itemCoordinate.y, 4, 0, 2*M_PI, 1);
//            }
        }
        
        if (index == self.dataSource.count-1) {
            CGContextSetFillColorWithColor(currentCtx, [ColorUtils colorWithHexString:@"#fed455"].CGColor);
            CGContextSetStrokeColorWithColor(currentCtx, [ColorUtils colorWithHexString:@"#fed455"].CGColor);
        }
        CGContextFillPath(currentCtx);
        //记录初始化坐标点，方便后续动画
        itemCoordinate.y = self.frame.size.height - MARGIN_TOP;
        [initCoordinateArray addObject:NSStringFromCGPoint(itemCoordinate)];
        

    }
    CGContextSetLineWidth(currentCtx, 1);
    CGContextStrokePath(currentCtx);
    
    //绘制折线
    //避免折线虚线化
    CGContextSetLineDash(currentCtx, 0, 0, 0);
    //绘图路线
    CGMutablePathRef path = CGPathCreateMutable();
    for (int index = 0; index<[coordinateArray count] - 1; index++)
    {
        //一段折线开始点
        NSString *startPointStr = [coordinateArray objectAtIndex:index];
        CGPoint startPoint = CGPointFromString(startPointStr);
        
        //一段折线结束点
        NSString *endPointStr = [coordinateArray objectAtIndex:index+1];
        CGPoint endPoint = CGPointFromString(endPointStr);
        
        //绘制图线方法一：每一段折线都是用一个path,动画过程就变成分动动画,而且是同时执行的。
//        [self drawLineWithStartPoint:startPoint
//                        withEndPoint:endPoint];
        
        //绘制图线方法二：所有的绘图信息放在同一个path中,动画过程就变成连续的了。
        [self drawLineWithPath:path
                withStartPoint:startPoint
                  withEndPoint:endPoint];
        
        /*  使用CoreGraphics直接绘制
        CGContextMoveToPoint(currentCtx, startPoint.x, startPoint.y);
        CGContextAddLineToPoint(currentCtx, endPoint.x, endPoint.y);
         */
    }
    CGContextStrokePath(currentCtx);
    CGPathRelease(path);
}

/**
 *  @author li_yong
 *
 *  绘制折线
 *
 *  @param startPoint     折线的开始点
 *  @param endPoint       折线的结束点
 */
- (void)drawLineWithStartPoint:(CGPoint)startPoint
                  withEndPoint:(CGPoint)endPoint
{
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = 1;
    lineLayer.lineCap = kCALineCapButt;
    lineLayer.strokeColor = self.lineAndPointColor.CGColor;
    lineLayer.fillColor = nil;
    
    CGMutablePathRef linePath = CGPathCreateMutable();
    CGPathMoveToPoint(linePath, nil, startPoint.x, startPoint.y);
    CGPathAddLineToPoint(linePath, nil, endPoint.x, endPoint.y);
    lineLayer.path = linePath;
    
    if (self.isAnimation)
    {
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = ANIMATION_DURING;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        pathAnimation.autoreverses = NO;
        pathAnimation.fillMode = kCAFillModeForwards;
        [lineLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    }

//    self.clipsToBounds = YES;
    [self.layer addSublayer:lineLayer];
    CGPathRelease(linePath);
}

/**
 *  @author li_yong
 *
 *  绘制折线
 *
 *  @param path       保存绘图信息的路径
 *  @param startPoint 折线的开始点
 *  @param endPoint   折线的结束点
 */
- (void)drawLineWithPath:(CGMutablePathRef )path
          withStartPoint:(CGPoint)startPoint
            withEndPoint:(CGPoint)endPoint
{
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = LINE_WIDTH;
    lineLayer.lineCap = kCALineCapButt;
    lineLayer.strokeColor = self.lineAndPointColor.CGColor;
    lineLayer.fillColor = nil;
    
    CGPathMoveToPoint(path, nil, startPoint.x, startPoint.y);
    CGPathAddLineToPoint(path, nil, endPoint.x, endPoint.y);
    lineLayer.path = path;
    
    if (self.isAnimation)
    {
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = ANIMATION_DURING;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        pathAnimation.autoreverses = NO;
        pathAnimation.fillMode = kCAFillModeForwards;
        [lineLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    }
    
    //    self.clipsToBounds = YES;
    [self.layer addSublayer:lineLayer];
}

@end
