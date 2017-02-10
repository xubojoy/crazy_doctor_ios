//
//  SharkeyDetailController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/27.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "SharkeyDetailController.h"
#import "WCDSharkeyFunction.h"
@interface SharkeyDetailController ()

@end

@implementation SharkeyDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorUtils colorWithHexString:@"#f4f4f4"];
    [self initHeadView];
    if ([AppStatus sharedInstance].sharkey != nil) {
        [self initSharkeyDetailView];
        [self initBottomBtnView];
    }else{
        [self initNoneSharkeyLabel];
    }
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"设备信息" navigationController:self.navigationController];
    [self.view addSubview:self.headerView];
}

- (void)initSharkeyDetailView{
    self.sharkeyDetailView = [[SharkeyDetailView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width, 331)];
    self.sharkeyDetailView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.sharkeyDetailView];
}

- (void)initNoneSharkeyLabel{
    self.noneSharkeyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width, 331)];
    self.noneSharkeyLabel.text = @"暂无设备";
    self.noneSharkeyLabel.font = [UIFont systemFontOfSize:16];
    self.noneSharkeyLabel.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
    self.noneSharkeyLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.noneSharkeyLabel];
}


- (void)initBottomBtnView{
    self.upLine = [[UIView alloc] initWithFrame:CGRectMake(0, screen_height-59, screen_width, splite_line_height)];
    self.upLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
    [self.view addSubview:self.upLine];
    
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteBtn.frame = CGRectMake(general_margin, screen_height-7-45, screen_width-2*general_margin, 45);
    UIImage *hightLightImage = [UIImage imageNamed:@"btn_login_pre"];
    [self.deleteBtn setBackgroundImage:[ImageUtils resizableBgImage:hightLightImage] forState:UIControlStateNormal];
    [self.deleteBtn setBackgroundImage:[ImageUtils resizableBgImage:hightLightImage] forState:UIControlStateHighlighted];
    [self.deleteBtn setTitle:@"删除设备" forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.deleteBtn.titleLabel setFont:[UIFont systemFontOfSize:bigger_font_size]];
    [self.deleteBtn addTarget:self action:@selector(deleteSharkeyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.deleteBtn];
}

- (void)deleteSharkeyBtnClick{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认删除该硬件？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //点击取消按钮后控制台打印语句。
    }];
    //实例化确定按钮
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
         WCDSharkeyFunction *wcd = [WCDSharkeyFunction shareInitializationt];
        Sharkey *sharkey = [wcd currentSharkey];
        SharkeyState state = [wcd querySharkeyState];
        if (state == SharkeyStateConnected) {
            [wcd disconnectSharkey:sharkey];
        }
        
        [AppStatus sharedInstance].sharkey = nil;
        [AppStatus saveAppStatus];
        [self.sharkeyDetailView removeFromSuperview];
        [self.deleteBtn removeFromSuperview];
        [self.upLine removeFromSuperview];
        [self initNoneSharkeyLabel];
    }];
    //实例化确定按钮
    //向弹出框中添加按钮和文本框
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    //将提示框弹出
    [self presentViewController:alertController animated:YES completion:nil];
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
