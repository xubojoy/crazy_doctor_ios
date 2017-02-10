//
//  WebContainerController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/6/28.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "WebContainerController.h"

@interface WebContainerController ()

@end

@implementation WebContainerController
- (instancetype)initWithContent:(NSString *)content titleStr:(NSString *)titleStr{
    self = [super init];
    if (self) {
        self.content = content;
        self.titleStr = titleStr;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    [self setRightSwipeGestureAndAdaptive];
    [self initHeadView];
    [self initWebView];
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:self.titleStr navigationController:self.navigationController];
    [self.view addSubview:self.headerView];
}

-(void)initWebView{
    self.webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width,screen_height-self.headerView.frame.size.height)];
    self.webview.scrollView.showsHorizontalScrollIndicator=YES;
    self.webview.userInteractionEnabled = YES;
    [self.webview setBackgroundColor:[ColorUtils colorWithHexString:common_bg_color]];
    [self.webview setOpaque:NO];
    //    self.webview.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    self.webview.scrollView.decelerationRate = 0.8;
//    self.webview.scrollView.showsVerticalScrollIndicator = NO;
    [self.webview setDelegate:self];
    [self.webview loadHTMLString:self.content baseURL:nil];
    [self.view addSubview:self.webview];
}

#pragma mark - webViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    if (webView == self.webview) {

    }
}

- (void)webViewDidFinishLoad:(UIWebView *)wb
{
    //方法2
//    if (wb == self.webview) {
//        CGFloat scrollHeight = [[self.webview stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
//        CGRect newFrame = self.webview.frame;
//        newFrame.size.height = scrollHeight;
//        self.webview.frame = newFrame;
//        
//        [self loadArticleCommentsData];
//        [self calculatorScrollViewHeight];
//    }
}

-(BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)inRequest   navigationType:(UIWebViewNavigationType)inType
{
    return YES;
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
