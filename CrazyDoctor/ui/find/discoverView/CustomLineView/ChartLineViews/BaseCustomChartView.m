//
//  BaseChartView.m
//  DrawTool
//
//  Created by li_yong on 15/7/9.
//  Copyright (c) 2015年 li_yong. All rights reserved.
//

#import "BaseCustomChartView.h"
#import "CoordinateItem.h"

@interface BaseCustomChartView()

@end

@implementation BaseCustomChartView

/**
 *  @author li_yong
 *
 *  构造函数
 *
 *  @param dataSource 数据源
 *
 *  @return
 */
- (id)initWithDataSource:(NSMutableArray *)dataSource
{
    self = [super init];
    if (self)
    {
        self.dataSource = dataSource;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //绘制坐标系
    [self drawCoordinate];
}

- (void)drawCoordinate
{
    CGContextRef currentCtx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(currentCtx, [[UIColor grayColor] CGColor]);
    CGContextSetLineWidth(currentCtx, 0.5);
    
    //1.绘制X轴和y轴
    //第一种方法绘制四条线
//    CGPoint poins[] = {CGPointMake(MARGIN_LEFT, MARGIN_TOP),
//                       CGPointMake(self.frame.size.width - MARGIN_LEFT, MARGIN_TOP),
//                       CGPointMake(self.frame.size.width - MARGIN_LEFT, self.frame.size.height - MARGIN_TOP),
//                       CGPointMake(MARGIN_LEFT, self.frame.size.height - MARGIN_TOP)};
//    CGContextAddLines(currentCtx,poins,4);
//    CGContextClosePath(currentCtx);
//    CGContextStrokePath(currentCtx);
    
    
   
    
    /*
    //第二种方法绘制一个矩形
    CGContextMoveToPoint(currentCtx, MARGIN_LEFT, MARGIN_TOP);
    CGContextSetLineWidth(currentCtx, 0.1);
    CGContextSetRGBStrokeColor(currentCtx, 0.5, 0.5, 0.5, 1);
    CGContextAddRect(currentCtx, CGRectMake(MARGIN_LEFT, MARGIN_TOP, self.frame.size.width - 2*MARGIN_LEFT, self.frame.size.height - 2*MARGIN_TOP));
    CGContextClosePath(currentCtx);
    CGContextStrokePath(currentCtx);
    */
    
    //2.绘制虚线(暂时设置纵坐标分5个区间)
    
    
    NSLog(@">>>>>>>>>>标记的纵坐标>>>>>>>>>>>>>%@",self.dataSource);
    
    //虚线间距
    self.dashedSpace = (CGFloat)(self.frame.size.height - 2*MARGIN_TOP)/Y_SECTION;
    
    CGFloat lengthsy[2] = {5,5};
    CGContextSetLineDash(currentCtx, 0, lengthsy, 1);
    CGContextMoveToPoint(currentCtx, MARGIN_LEFT, MARGIN_TOP + self.dashedSpace * 5);
    CGContextAddLineToPoint(currentCtx, MARGIN_LEFT, 0);
    CGContextStrokePath(currentCtx);
    
    CGFloat lengthsx[2] = {5,5};
    CGContextSetLineDash(currentCtx, 0, lengthsx, 1);
    CGContextMoveToPoint(currentCtx, MARGIN_LEFT, MARGIN_TOP + self.dashedSpace * 5);
    CGContextAddLineToPoint(currentCtx, self.frame.size.width - MARGIN_LEFT+20, MARGIN_TOP + self.dashedSpace * 5);
    CGContextStrokePath(currentCtx);

    
    //设置虚线属性
    CGFloat lengths[2] = {5,5};
    CGContextSetLineDash(currentCtx, 0, lengths, 1);
    for(int index = 0; index<Y_SECTION; index++)
    {
        CGContextMoveToPoint(currentCtx, MARGIN_LEFT, MARGIN_TOP + self.dashedSpace * index);
        CGContextAddLineToPoint(currentCtx, self.frame.size.width - MARGIN_LEFT+20, MARGIN_TOP + self.dashedSpace * index);
    }
    CGContextStrokePath(currentCtx);
    
    //3.设置纵坐标值
    self.maxYValue = [self compareForMaxValue];
    if (self.maxYValue == 0) {
        self.maxYValue = 24;
    }
    
    self.yNumberSpace = self.maxYValue/Y_SECTION;
    NSLog(@"----------self.maxYValue---->self.yNumberSpace>>>>>>>>%d>>>>%d",self.maxYValue,self.yNumberSpace);
    
    for (int index = 0; index<Y_SECTION+1; index++)
    {
        CGPoint centerPoint = CGPointMake(MARGIN_LEFT/2, MARGIN_TOP + self.dashedSpace * index);
        CGRect bounds = CGRectMake(0, 0, MARGIN_LEFT-5, 15);
        NSString *labelText = [NSString stringWithFormat:@"%d",self.yNumberSpace * (Y_SECTION - index)];
        NSLog(@"---------labelText>>>>>>>>%@",labelText);
        int yNum = [labelText intValue];
        UILabel *yNumber = [self createLabelWithCenter:centerPoint
                                            withBounds:bounds
                                              withText:[NSString stringWithFormat:@"%dh",yNum]
                                     withtextAlignment:NSTextAlignmentRight];
        [self addSubview:yNumber];
    }
    
    //4.设置横坐标值
    for (int index = 0; index<[self.dataSource count]; index++)
    {
        CGPoint centerPoint = CGPointMake(MARGIN_LEFT + (screen_width-90)/7 * index, self.frame.size.height - MARGIN_TOP/2 - 4);
        CGRect bounds = CGRectMake(0, 0, (screen_width-90)/7, 15);
        CoordinateItem *item = [self.dataSource objectAtIndex:index];
        UILabel *xNumber = [self createLabelWithCenter:centerPoint
                                           withBounds:bounds
                                             withText:item.coordinateXValue
                                    withtextAlignment:NSTextAlignmentCenter];
        xNumber.font = [UIFont boldSystemFontOfSize:15];
        if (index == [self.dataSource count]-1) {
           xNumber.textColor = [ColorUtils colorWithHexString:@"#fed455"];
        }else{
            xNumber.textColor = [ColorUtils colorWithHexString:@"#828f24"];
        }
        [self addSubview:xNumber];
    }
}

/**
 *  @author li_yong
 *
 *  获取最大的纵坐标值
 */
- (int)compareForMaxValue
{
    __block int maxYValue = 0;
    //获取最大的纵坐标值
    [self.dataSource enumerateObjectsUsingBlock:^(CoordinateItem *obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"-------遍历y>>>>>>>>%d",[obj.coordinateYValue intValue]);
        if ([obj.coordinateYValue intValue] >= maxYValue)
        {
           maxYValue = [obj.coordinateYValue intValue];
            NSLog(@"---------maxYValue111111111111>>>>>>>>%d",maxYValue);
        }
    }];
    //获取最大的纵坐标值整数
    if((maxYValue % Y_SECTION) != 0)
    {
        NSLog(@"---------maxYValue2222222222>>>>>>>>%d",maxYValue);
        maxYValue = maxYValue + (Y_SECTION - maxYValue % Y_SECTION);
        NSLog(@"---------maxYValue3333333333>>>>>>>>%d",maxYValue);
    }
    return maxYValue;
}

/**
 *  @author li_yong
 *
 *  UILabel的工厂方法
 *
 *  @param centerPoint   label的中心
 *  @param bounds        label的大小
 *  @param labelText     label的内容
 *  @param textAlignment label的内容排版方式
 *
 *  @return
 */
- (UILabel *)createLabelWithCenter:(CGPoint)centerPoint
                        withBounds:(CGRect)bounds
                          withText:(NSString *)labelText
                 withtextAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] init];
    label.center = centerPoint;
    label.bounds = bounds;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [ColorUtils colorWithHexString:@"#efd6bc"];
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = textAlignment;
    label.text = labelText;
    
    return label;
}

@end
