//
//  DoctorDetailController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/23.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorDetailController : BaseViewController<UIWebViewDelegate>
@property (nonatomic, strong) HeaderView *headerView;
@property (strong, nonatomic) UIWebView *webView;
@property (nonatomic ,strong) UIActivityIndicatorView *activity;
@property (nonatomic ,assign) int doctorId;

- (instancetype)initWithDoctorId:(int)doctorId;

@end
