//
//  WLZShareController.m
//  WLZShareView
//
//  Created by lijiarui on 15/11/11.
//  Copyright © 2015年 lijiarui qq:81995383. All rights reserved.
//

#import "WLZShareController.h"
#import "WLZShareItem.h"

//static CGFloat itemWidth = 80.0f;
static CGFloat itemHeight = 104.0f;
static NSInteger itemCount = 4.0f;

//子元素的边距
static CGFloat boardWidth = 10.0f;
//子元素的边距
static CGFloat boardHeight = 10.0f;

//距离父view的边距 x
static CGFloat marginX = 10.0f;
//距离父view的边距 y
static CGFloat marginY = 50.0f;

//背景alpha值
static CGFloat viewAlpha =  0.6f;


//底部BT的高度
static CGFloat endBtHeight = 54.0f;
@interface WLZShareController ()


@property(nonatomic,strong)NSMutableArray *array_items;


@property (nonatomic, strong) UIView *contentView;

@property(nonatomic,strong) UIView *darkView;


@end

@implementation WLZShareController



- (instancetype)init
{
    self = [super init];
    if ( self) {
        self.view.frame =[UIScreen mainScreen].bounds;
        
        [self setUpViews];
    }
    return self;
}

- (NSMutableArray *)array_items
{
    if (!_array_items) {
        _array_items =[NSMutableArray array];
    }
    return _array_items;
}

- (void)addItem:(NSString *)title icon:(NSString *)icon hightLightIcon:(NSString *)hightLightIcon block:(void (^)(WLZBlockButton *))block
{
    WLZShareItem *item = [[WLZShareItem alloc]init];
    [item.itemButton setBlock:^(WLZBlockButton *button){
        block(button);
        [self removeView];
    }];
  
//    item.logoImageView.image = [UIImage imageNamed:icon];
    [item.itemButton setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [item.itemButton setBackgroundImage:[UIImage imageNamed:hightLightIcon] forState:UIControlStateNormal];
    item.titleLabel.text = title;
    [self.contentView addSubview:item];
    [self.array_items addObject:item];
}

 - (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 201)];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_contentView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 13, screen_width, 20)];
        titleLabel.text = @"分享到";
        titleLabel.font = [UIFont systemFontOfSize:default_1_font_size];
        titleLabel.textColor = [ColorUtils colorWithHexString:gray_text_color];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_contentView addSubview:titleLabel];
    }
    return _contentView;
}

- (void)setUpViews
{
    _darkView = [[UIView alloc] initWithFrame:self.view.frame];
    _darkView.backgroundColor = [UIColor blackColor];
    _darkView.userInteractionEnabled=YES;
    _darkView.alpha = viewAlpha;
    [self.view addSubview:_darkView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTheDarkView)];
    [_darkView addGestureRecognizer:tap];

}

- (void)tapTheDarkView
{
    [UIView animateWithDuration:0.3 animations:^{
       
        _contentView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, _contentView.frame.size.height);
    } completion:^(BOOL finished) {
      
        [self removeView];
    }];
}

- (void)removeView
{
    
    for (UIView *views in self.view.subviews) {
        [views removeFromSuperview];
    }
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)show
{
    CGFloat itemWidth =(self.view.frame.size.width-((itemCount-1)*boardWidth)-(marginX*2))/itemCount;
    CGFloat height = 0;
    CGFloat rows = _array_items.count/itemCount +( (_array_items.count%itemCount) != 0 ?1:0);
    height = rows*itemHeight + rows*marginY;
    for (int i=0; i<_array_items.count; i++) {
        CGFloat x = (i%itemCount)*(itemWidth+boardWidth)+marginX;
        CGFloat y = floor(i/itemCount)*(itemHeight+boardHeight)+marginY;
        WLZShareItem *item =(WLZShareItem *) [_array_items objectAtIndex:i];
        item.frame = CGRectMake(x, y, itemWidth, itemHeight);
    }
    
    [_contentView addSubview:[self cancelBt:height]];
    
    [UIView animateWithDuration:0.3 animations:^{
            _contentView.frame = CGRectMake(0, self.view.frame.size.height-height-endBtHeight, self.view.frame.size.width, height+endBtHeight);
    }];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    [window.rootViewController addChildViewController:self];
    
    
}


- (WLZBlockButton * )cancelBt:(CGFloat) height
{
   
    
    WLZBlockButton * cancelBt = [[WLZBlockButton alloc]initWithFrame:CGRectMake(0, height, self.view.frame.size.width, endBtHeight)];
//    [cancelBt setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBt setImage:[UIImage imageNamed:@"icon_close_share"] forState:UIControlStateNormal];
    [cancelBt setBlock:^(WLZBlockButton *button){
        [self tapTheDarkView];
    }];
    [cancelBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBt.titleLabel.font=[UIFont systemFontOfSize:13];
    cancelBt.backgroundColor=[UIColor whiteColor];
    UIImageView *line =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screen_width, splite_line_height)];
    line.backgroundColor=[ColorUtils colorWithHexString:@"#d0d0d0"];
    [cancelBt addSubview:line];
    return cancelBt;
}

@end
