//
//  ArticleDetailController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/19.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopUpView.h"
#import "XbPopView.h"
@interface ArticleDetailController : BaseViewController<XbPopViewDelegate,UIWebViewDelegate>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) PopUpView *popUpView;
@property (nonatomic ,strong) XbPopView *xbPopView;
@property (nonatomic ,strong) UIButton *rightCollectionBtn;
@property (nonatomic ,strong) UIButton *rightShareBtn;
@property (strong, nonatomic) UIWebView *webView;
@property (nonatomic ,strong) UIActivityIndicatorView *activity;

@property (nonatomic ,assign) BOOL isCollectioned;

@property (nonatomic,weak) UIView * downView;
@property (nonatomic,weak) UIView * bgMaskView;
@property (nonatomic ,assign) int articleId;
@property (nonatomic ,strong) NSString *articleTitle;
@property (nonatomic ,strong) NSString *articleLogo;
@property (nonatomic ,assign) long recommendTime;
@property (nonatomic ,assign) int recommendArticleId;

@property (nonatomic ,strong) NSMutableSet *hasReadArticles;

- (instancetype)initWithArticleId:(int)articleId articleTitle:(NSString *)articleTitle articleLogo:(NSString *)articleLogo recommendTime:(long)recommendTime recommendArticleId:(int)recommendArticleId;

@end
