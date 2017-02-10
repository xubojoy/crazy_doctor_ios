//
//  OrderPhysiotherapyController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/25.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "OrderPhysiotherapyController.h"
@interface OrderPhysiotherapyController ()
{
    LoadingStatusView *loading;
}
@end

@implementation OrderPhysiotherapyController

-(instancetype)initWithUrl:(NSURL *)url{
    self = [super init];
    if (self) {
        self.urlStr = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    [self setRightSwipeGestureAndAdaptive];
    [self initHeadView];
    [self loadWebView];
}

#pragma mark - 初始化自定义View
////初始化自定义导航
-(void)initHeadView{
    UIView *statusBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 20)];
    statusBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:statusBar];

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
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, screen_width, screen_height-20)];
    [self.webView setBackgroundColor:[ColorUtils colorWithHexString:common_bg_color]];
    [self.webView setOpaque:NO];
    self.webView.scrollView.decelerationRate = 0.8;
    [self.webView setDelegate:self];
    NSURLRequest *request =[NSURLRequest requestWithURL:self.urlStr];
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
    if ([shareUrl containsString:[NSString stringWithFormat:@"%@/login",[AppStatus sharedInstance].wxpubUrl]]) {
    
        [[NSNotificationCenter defaultCenter] postNotificationName:notification_name_user_login object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"账号在另其他设备登陆" object:nil];
        [((AppDelegate *)[UIApplication sharedApplication].delegate).tabbar.tabBarController setTabBarHidden:NO animated:NO];
        [((AppDelegate *)[UIApplication sharedApplication].delegate).tabbar setSelectedIndex:0];
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
       return YES;
}
-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@">>>> web load error:%@", webView.request.URL);
    [loading updateStatus:network_unconnect_note animating:NO];
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
