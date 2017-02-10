//
//  ArticleDetailController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/19.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "ArticleDetailController.h"
#import "WLZShareController.h"
#import "UserStore.h"
#import "ArticleStore.h"
#import "UserLoginViewController.h"
@interface ArticleDetailController ()

@end

@implementation ArticleDetailController
- (instancetype)initWithArticleId:(int)articleId articleTitle:(NSString *)articleTitle articleLogo:(NSString *)articleLogo recommendTime:(long)recommendTime recommendArticleId:(int)recommendArticleId{
    self = [super init];
    if (self) {
        self.articleId = articleId;
        self.articleTitle = articleTitle;
        self.articleLogo = articleLogo;
        self.recommendTime = recommendTime;
        self.recommendArticleId = recommendArticleId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    [self setRightSwipeGestureAndAdaptive];
    self.hasReadArticles = [NSMutableSet new];
    self.isCollectioned = NO;
    [self initUI];
    [self loadWebView];
    [self checkUserCollectionArticleData];
    
    NSLog(@">>>>>hasReadArticleIds>>>>>%@",[AppStatus sharedInstance].hasReadArticleIds);
    self.hasReadArticles = [AppStatus sharedInstance].hasReadArticleIds;
    if (![self.hasReadArticles containsObject:@(self.recommendArticleId)]) {
        [self updateReadCount];
    }
    
    NSLog(@">>>>articleLogo>>>>%@",self.articleLogo);
}

- (void)initUI{
    [self initHeadView];
    [self initRightBtn];
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"" navigationController:self.navigationController];
    [self.view addSubview:self.headerView];
}

- (void)initRightBtn{
    self.rightCollectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightCollectionBtn.frame = CGRectMake(screen_width-general_padding-24-14-24, 30, 24, 24);
    [self.rightCollectionBtn setImage:[UIImage imageNamed:@"icon_homepage_collect_nor"] forState:UIControlStateNormal];
//    [self.rightCollectionBtn setImage:[UIImage imageNamed:@"icon_homepage_collect_pre"] forState:UIControlStateHighlighted];
    [self.rightCollectionBtn addTarget:self action:@selector(rightCollectionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.rightCollectionBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.rightCollectionBtn];
    
    self.rightShareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightShareBtn.frame = CGRectMake(screen_width-24-general_padding, 30, 24, 24);
    [self.rightShareBtn setImage:[UIImage imageNamed:@"icon_share_nor"] forState:UIControlStateNormal];
    [self.rightShareBtn setImage:[UIImage imageNamed:@"icon_share_pre"] forState:UIControlStateHighlighted];
    [self.rightShareBtn addTarget:self action:@selector(rightShareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.rightShareBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.rightShareBtn];
}


//加载菊花
-(void)initActivityIndicatorView{
    if (self.activity == nil) {
        self.activity =[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        //    self.view.userInteractionEnabled = NO;
        //设置活动指示器的中间位置
        self.activity.center=CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2-10);
        [self.activity startAnimating];
        //添加到视图
        [self.view addSubview:self.activity];
    }
}

-(void)initStopActivityIndicatorView{
    [self.activity stopAnimating];
    self.activity.hidden = YES;
}

-(void)loadWebView{
    [[AppStatus sharedInstance] setCrazyDoctorUA];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width, screen_height-self.headerView.frame.size.height)];
    [self.webView setBackgroundColor:[ColorUtils colorWithHexString:common_bg_color]];
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    [self.webView setOpaque:NO];
    self.webView.scrollView.decelerationRate = 0.8;
    [self.webView setDelegate:self];
    AppStatus *as = [AppStatus sharedInstance];
    NSURL *nsurl =[NSURL URLWithString:[NSString stringWithFormat:@"%@/common/articles/%d?noFooterFlag=0&noHeaderFlag=0&isAppOpen=1&Authorization=%@&longitude=%f&latitude=%f&datetime=%ld",[AppStatus sharedInstance].wxpubUrl,self.articleId,as.user.accessToken,as.lastLng,as.lastLat,self.recommendTime]];
    NSURLRequest *request =[NSURLRequest requestWithURL:nsurl];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [self initActivityIndicatorView];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView{
    [self initStopActivityIndicatorView];
}


-(BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)inRequest   navigationType:(UIWebViewNavigationType)inType
{
    NSLog(@">>>>> to:%@", inRequest.URL);
    NSString *shareUrl = [NSString stringWithFormat:@"%@",inRequest.URL];
    NSLog(@">>>>> 结果:%@", shareUrl);
    return YES;
}
-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@">>>> web load error:%@", webView.request.URL);
}

- (void)checkUserCollectionArticleData{
    [SVProgressHUD show];
    [UserStore checkUserCollectionArticle:^(NSDictionary *collectionDict, NSError *err) {
        [SVProgressHUD dismiss];
        if (err == nil) {
            if (collectionDict != nil) {
                NSLog(@">>>>>>>已收藏--%@",collectionDict);
                [[AppStatus sharedInstance].user addFavArticle:self.articleId];
                
                [self.rightCollectionBtn setImage:[UIImage imageNamed:@"icon_homepage_collect_pre"] forState:UIControlStateNormal];
            }else{
                NSLog(@">>>>>>>没有收藏--");
                self.isCollectioned = NO;
            }
        }
        else{
            ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
            [self.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        }
        
    } articleId:self.articleId];
    NSLog(@">>>>>>>self.isCollectioned>>>>>%d",self.isCollectioned);
}

- (void)updateReadCount{
    [ArticleStore updateArticleReadCount:^(NSDictionary *dict, NSError *err) {
        
    } articleId:self.articleId];
}


#pragma mark - button method
- (void)rightCollectionBtnClick:(UIButton *)sender{
    if (![[AppStatus sharedInstance] logined]) {
        UserLoginViewController *ulc = [[UserLoginViewController alloc] initWithFrom:account_session_from_user_articleDetail];
        [self.navigationController pushViewController:ulc animated:YES];
        return ;
    }else{
        [SVProgressHUD show];
        AppStatus * appStatus = [AppStatus sharedInstance];
        BOOL hasCollected = [appStatus.user hasAddFavArticle:self.articleId];
        if (hasCollected) {
            [UserStore userDeleteFavArticle:^(NSError *err) {
                [SVProgressHUD dismiss];
                if (err == nil) {
                    [[AppStatus sharedInstance].user removeFavArticle:self.articleId];
                   [self.rightCollectionBtn setImage:[UIImage imageNamed:@"icon_homepage_collect_nor"] forState:UIControlStateNormal];
                }
                
            } articleId:self.articleId];
        }else{
            [UserStore confirmCollectionArticle:^(NSDictionary *collectionDict, NSError *err) {
                [SVProgressHUD dismiss];
                if (collectionDict != nil) {
                    NSLog(@">>>>>收藏成功>>>%@",collectionDict);
                    [[AppStatus sharedInstance].user addFavArticle:self.articleId];
                    [self initPopUpView];
                    [self.rightCollectionBtn setImage:[UIImage imageNamed:@"icon_homepage_collect_pre"] forState:UIControlStateNormal];
                }else{
                    ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
                    [self.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
                }
                
            } articleId:self.articleId];
        }
    }
}

-(void)initPopUpView{
    self.popUpView = [[PopUpView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    [self.view addSubview:self.popUpView];
    
    self.xbPopView = [[XbPopView alloc] initWithFrame:CGRectMake((screen_width-280)/2, 205, 280, 155) remindImg:@"bg_word_collect_success"];
    self.xbPopView.delegate = self;
    //下拉动画
    [UIView animateWithDuration:0.2 animations:^{
        self.xbPopView.center =  CGPointMake(screen_width/2, screen_height/2);
    }];
    [self.view addSubview:self.xbPopView];
    [self.view bringSubviewToFront:self.xbPopView];
}

- (void)rightShareBtnClick:(UIButton *)sender{
    WLZShareController *share =[[WLZShareController alloc]init];
    [share addItem:@"微信好友" icon:@"icon_wechat_nor" hightLightIcon:@"icon_wechat_pre" block:^(WLZBlockButton *btn) {
        NSLog(@">>>>>>>>>>>>>>>>>>微信好友");
        ShareContent *shareContent = [self collectionShareContent];
        ShareSDKProcessor *shareSDKProcessor = [ShareSDKProcessor new];
        [shareSDKProcessor followWeiXinSession:sender shareContent:shareContent shareSuccessBlock:^{
            
        }];
    }];
    
    [share addItem:@"朋友圈" icon:@"icon_friends_nor" hightLightIcon:@"icon_friends_pre" block:^(WLZBlockButton *btn) {
        NSLog(@">>>>>>>>>>>>>>>>>>朋友圈");
        ShareContent *shareContent = [self collectionShareContent];
        ShareSDKProcessor *shareSDKProcessor = [ShareSDKProcessor new];
        [shareSDKProcessor followWeiXinTimeLine:sender shareContent:shareContent shareSuccessBlock:^{
            
        }];
    }];
    
    
    [share addItem:@"QQ" icon:@"icon_qq_nor" hightLightIcon:@"icon_qq_pre" block:^(WLZBlockButton *btn) {
        NSLog(@">>>>>>>>>>>>>>>>>>QQ");
        ShareContent *shareContent = [self collectionShareContent];
        ShareSDKProcessor *shareSDKProcessor = [ShareSDKProcessor new];
        [shareSDKProcessor followQQ:sender shareContent:shareContent shareSuccessBlock:^{
            
        }];
    }];
    
    [share addItem:@"新浪微博" icon:@"icon_sina_nor" hightLightIcon:@"icon_sina_pre" block:^(WLZBlockButton *btn) {
        NSLog(@">>>>>>>>>>>>>>>>>>新浪微博");
        ShareContent *shareContent = [self collectionShareContent];
        ShareSDKProcessor *shareSDKProcessor = [ShareSDKProcessor new];
        [shareSDKProcessor followSinaWeiBo:sender shareContent:shareContent shareSuccessBlock:^{
            
        }];
    }];
    [share show];
}

-(ShareContent *) collectionShareContent{
    
    NSLog(@">>>>articleLogosdfhdkjhfjsdhfjhsd>>>>%@",self.articleLogo);
    
    NSArray *imageArray = [NSArray new];
    if ([NSStringUtils isNotBlank:self.articleLogo]) {
        imageArray = @[self.articleLogo];
    }else{
        imageArray = @[[UIImage imageNamed:@"logo－108.png"]];
    }
    
    AppStatus *as = [AppStatus sharedInstance];
    NSString *title = share_app_title;
    NSURL *nsurl =[NSURL URLWithString:[NSString stringWithFormat:@"%@/common/articles/%d?noFooterFlag=0&noHeaderFlag=1&isAppOpen=1&longitude=%f&latitude=%f",[AppStatus sharedInstance].wxpubUrl,self.articleId,as.lastLng,as.lastLat]];
    NSString *url = [NSString stringWithFormat:@"%@",nsurl];
    NSString *content = self.articleTitle;;
    NSString *contentWithUrl = [NSString stringWithFormat:@"%@  %@ ", content, url];
    ShareContent *shareContent = [[ShareContent alloc] initWithTitle:title
                                                             content:content
                                                    wxSessionContent:content
                                                    sinaWeiBoContent:contentWithUrl
                                                                 url:url
                                                               image:nil
                                                            imageUrl:self.articleLogo
                                                          imageArray:imageArray];
    return shareContent;
}

- (void)didCancelBtnClick:(UIButton *)sender{
    [self.popUpView removeFromSuperview];
    [self.xbPopView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
