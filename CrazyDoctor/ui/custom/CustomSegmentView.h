//
//  CustomSegmentView.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/18.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define btn_seed 11000

@protocol CustomSegmentViewDelegate <NSObject>


-(void)selectSegment:(int)inx;
@end

@interface CustomSegmentView : UIView

@property (retain, nonatomic) id<CustomSegmentViewDelegate> delegate;
@property (nonatomic, strong) UIView *redLineView;
@property int currentIndex;
@property (nonatomic, strong) UIImageView *redDotImage;

-(void)render:(NSArray *)btnTitleArray currentIndex:(int)currentIndex;

-(void)selectIndex:(int)index;

-(void)renderRedDot:(int)index showRedDot:(BOOL)showRedDot;
@end
