//
//  AboutUsViewController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/20.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "AboutUsViewController.h"
#import "CoreMediaFuncManagerVC.h"
@interface AboutUsViewController ()

@end

@implementation AboutUsViewController
- (instancetype)initWithUrl:(NSString *)url title:(NSString *)title{
    self = [super init];
    if (self) {
        self.url = url;
        self.titleStr = title;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    [self setRightSwipeGestureAndAdaptive];
    [self initUI];
}

#pragma mark - 初始化自定义View

- (void)initUI{
    [self initHeadView];
    [self loadWebView];
}
//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:self.titleStr navigationController:self.navigationController];
    [self.view addSubview:self.headerView];
    
    self.rightPhoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightPhoneBtn.frame = CGRectMake(screen_width-44, 20, 44, 44);
    [self.rightPhoneBtn setImage:[UIImage imageNamed:@"icon_phone32"] forState:UIControlStateNormal];
    [self.rightPhoneBtn setImage:[UIImage imageNamed:@"icon_phone32"] forState:UIControlStateHighlighted];
    [self.rightPhoneBtn addTarget:self action:@selector(rightPhoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.rightPhoneBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.rightPhoneBtn];
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
    [self.webView setOpaque:NO];
    self.webView.scrollView.decelerationRate = 0.8;
    
    [self.webView setDelegate:self];
    NSURL *nsurl =[NSURL URLWithString:self.url];
    NSURLRequest *request =[NSURLRequest requestWithURL:nsurl];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    [self.activity removeFromSuperview];
    self.activity = nil;
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

- (void)rightPhoneBtnClick{
    [CoreMediaFuncManagerVC call:service_phone_1 inViewController:self failBlock:^{
        NSLog(@"不能打");
    }];
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
