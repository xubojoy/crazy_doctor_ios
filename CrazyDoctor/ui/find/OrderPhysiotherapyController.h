//
//  OrderPhysiotherapyController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/25.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderPhysiotherapyController : BaseViewController<UIWebViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) HeaderView *headerView;
@property (strong, nonatomic) UIWebView *webView;
@property (nonatomic ,strong) UIActivityIndicatorView *activity;
@property (nonatomic ,strong) NSURL *urlStr;

- (instancetype)initWithUrl:(NSURL *)url;
@end
