//
//  AboutUsViewController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/20.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutUsViewController : BaseViewController<UIWebViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) HeaderView *headerView;
@property (strong, nonatomic) UIWebView *webView;
@property (nonatomic ,strong) UIActivityIndicatorView *activity;
@property (nonatomic ,strong) NSString *url;
@property (nonatomic ,strong) NSString *titleStr;
@property (nonatomic ,strong) UIButton *rightPhoneBtn;
- (instancetype)initWithUrl:(NSString *)url title:(NSString *)title;
@end
