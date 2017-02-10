//
//  ServiceProtocolController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/6.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceProtocolController : BaseViewController<UIWebViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) HeaderView *headerView;
@property (strong, nonatomic) UIWebView *webView;
@property (nonatomic ,strong) UIActivityIndicatorView *activity;

@property (nonatomic ,strong) NSString *urlStr;
@property (nonatomic ,strong) NSString *titleStr;

- (instancetype)initWithUrl:(NSString *)url titleStr:(NSString *)titleStr;

@end
