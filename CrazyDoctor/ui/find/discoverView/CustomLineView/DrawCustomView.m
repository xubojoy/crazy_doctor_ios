//
//  DrawView.m
//  DrawTool
//
//  Created by li_yong on 15/7/9.
//  Copyright (c) 2015年 li_yong. All rights reserved.
//

#import "DrawCustomView.h"
#import "CoordinateItem.h"
#import "LineCustomChartView.h"

//#define MARGIN_BETWEEN_X_POINT 50   //X轴的坐标点的间距
#define MAX_POINT_WITHIN_SCREEN 6   //一屏幕最多容纳的坐标数

@interface DrawCustomView()

//数据源
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation DrawCustomView

/**
 *  @author li_yong
 *
 *  构造方法
 *
 *  @param frame      frame
 *  @param dataSource 数据源
 *  @param type       绘图类型
 *  @isAnimation      是否动态绘制
 *
 *  @return
 */
- (id)initWithFrame:(CGRect)frame
     withDataSource:(NSMutableArray *)dataSource
           withType:(ChartViewType)type
      withAnimation:(BOOL)isAnimation
          targetNum:(int)targetNum
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.autoresizesSubviews = NO;
        self.dataSource = [NSMutableArray arrayWithArray:dataSource];
        self.chartViewType = type;
        self.isAnimation = isAnimation;
        self.targetNum = targetNum;
        [self buildView];
    }
    return self;
}

- (void)buildView
{
    self.backgroundColor = [ColorUtils colorWithHexString:@"#ffffff" alpha:0.1];

    switch (self.chartViewType)
    {
        case LineChartViewType:
        {
            //根据数据源设置图形的尺寸
            [self sizeForDataSource];
            
            
            //折线图
            LineCustomChartView *lineChartView = [[LineCustomChartView alloc] initWithDataSource:self.dataSource
                                                               withLineAndPointColor:[ColorUtils colorWithHexString:@"#9bc01d"]
                                                                       withAnimation:self.isAnimation targetNum:self.targetNum];
            lineChartView.frame = CGRectMake(0, 55, self.contentSize.width, 250);
            [self addSubview:lineChartView];
        }
            break;
        default:
            break;
    }
}

/**
 *  @author li_yong
 *
 *  根据数据源设置图形的尺寸
 */
- (void)sizeForDataSource
{
    //根据数据源的个数设置DrawView的内容Size
//    NSUInteger valueCount = [self.dataSource count];
//    if (valueCount > MAX_POINT_WITHIN_SCREEN)
//    {
//        self.contentSize = CGSizeMake(self.frame.size.width + (valueCount - MAX_POINT_WITHIN_SCREEN) * MARGIN_BETWEEN_X_POINT, self.frame.size.height);
//    }else
//    {
//        self.contentSize = CGSizeMake(self.frame.size.width - (MAX_POINT_WITHIN_SCREEN - valueCount) * MARGIN_BETWEEN_X_POINT, self.frame.size.height);
//    }
    self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
}

@end
