//
//  WalletRecordontroller.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/28.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WalletRecordontroller : BaseViewController<UIWebViewDelegate,UIScrollViewDelegate>
@property (strong, nonatomic) UIWebView *webView;
@property (nonatomic ,strong) UIActivityIndicatorView *activity;
@property (nonatomic ,strong) NSString *url;
- (instancetype)initWithUrl:(NSString *)url;

@end
