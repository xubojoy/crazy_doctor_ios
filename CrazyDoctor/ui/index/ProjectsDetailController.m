//
//  ProjectsDetailController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/23.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "ProjectsDetailController.h"

@interface ProjectsDetailController ()

@end

@implementation ProjectsDetailController
- (instancetype)initWithProjectId:(int)projectId{
    self = [super init];
    if (self) {
        self.projectId = projectId;
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
    NSLog(@">>>>self.articleId>>>>%d",self.projectId);
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"理疗详情" navigationController:self.navigationController];
    [self.view addSubview:self.headerView];
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
    AppStatus *as = [AppStatus sharedInstance];
    NSURL *nsurl =[NSURL URLWithString:[NSString stringWithFormat:@"%@/projects/%d?noFooterFlag=0&noHeaderFlag=0&isAppOpen=1&Authorization=%@&longitude=%f&latitude=%f",[AppStatus sharedInstance].wxpubUrl,self.projectId,as.user.accessToken,as.lastLng,as.lastLat]];
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
