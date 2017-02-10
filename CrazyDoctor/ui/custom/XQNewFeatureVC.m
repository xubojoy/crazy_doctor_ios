//
//  XQNewFeatureVC.m
//  XQNewFeatureVC
//
//  Created by 徐强 on 15/10/13.
//  Copyright © 2015年 xuqiang. All rights reserved.
//

#import "XQNewFeatureVC.h"
#import "XQNewFeatureBaseVc.h"


#define screenW  self.view.bounds.size.width
#define screenH  self.view.bounds.size.height

@interface XQNewFeatureVC ()

@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, assign) NSInteger fromePage;

@end

@implementation XQNewFeatureVC

- (instancetype)initWithFeatureImagesNameArray:(NSArray *)imagesNameArray{
    
    if (self = [super init]) {
        self.imagesNameArray = imagesNameArray;
    }
    
    return self;
}

- (instancetype)initWithFeatureControllerArray:(NSArray *)controllersArray{
    
    if (self = [super init]) {
        self.controllersArray = controllersArray;
    }
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView                  = [[UIScrollView alloc] init];
    scrollView.backgroundColor                = [UIColor whiteColor];
    scrollView.frame                          = self.view.bounds;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled                  = YES;
    scrollView.bounces                        = NO;
    
    [self.view addSubview:scrollView];
    
    if (self.imagesNameArray.count == 0 && self.controllersArray.count == 0) {
        UILabel *label      = [[UILabel alloc] init];
        label.frame         = CGRectMake(0, self.view.frame.size.height/2 - 30, self.view.frame.size.width, 60);
        [scrollView addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        return;
    }
    NSUInteger count                     = self.imagesNameArray.count ? self.imagesNameArray.count : self.controllersArray.count;
    scrollView.contentSize               = CGSizeMake(screenW * count, screenH);

    if (self.imagesNameArray.count) {
        
        for (int i = 0; i<self.imagesNameArray.count; i++) {
            
            NSString *imageName    = self.imagesNameArray[i];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
            imageView.frame        = CGRectMake(screenW * i, 0, screenW, screenH);
            [scrollView addSubview:imageView];
            
            if (i == self.imagesNameArray.count - 1) {
                if (!self.completeBtn) {
                    UIButton *completeBtn           = [UIButton buttonWithType:UIButtonTypeCustom];
                    completeBtn.backgroundColor     = [UIColor clearColor];
                    [completeBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
                    self.completeBtn = completeBtn;
                    [imageView addSubview:self.completeBtn];
                }else{
                    [imageView addSubview:self.completeBtn];// 这里重复添加是因为如果不这么做,在iOS9的情况下,很奇怪,并没有添加到imageView上,打断点才会出现
                }
                
                
                imageView.userInteractionEnabled = YES;
                
                CGSize size = self.completeBtn.bounds.size;
                
                if (CGSizeEqualToSize(size, CGSizeZero)) {
                    size = CGSizeMake(self.view.frame.size.width * 0.6, 40);
                }
                 self.completeBtn.frame = CGRectMake(0, 0, screen_width, screen_height);
                
            }
            
        }
        
    }else if(self.controllersArray.count){
        
        for (int i = 0; i<self.controllersArray.count; i++) {
            
            UIViewController *vc = self.controllersArray[i];
            vc.view.frame        = CGRectMake(screenW * i, 0, screenW, screenH);
            [scrollView addSubview:vc.view];
        }
    }
    
}

- (void)completeBtnClick{
    
    if (self.completeBlock) {
        self.completeBlock();
    }
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}



@end
