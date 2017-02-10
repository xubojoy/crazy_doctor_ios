//
//  WebContainerController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/6/28.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebContainerController : BaseViewController<UIWebViewDelegate>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic, strong) UIWebView  *webview;
@property (nonatomic ,strong) NSString *content;
@property (nonatomic ,strong) NSString *titleStr;
- (instancetype)initWithContent:(NSString *)content titleStr:(NSString *)titleStr;

@end
