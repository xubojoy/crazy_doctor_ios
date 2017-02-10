//
//  SportSelectSharkeyController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/22.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "SportSelectSharkeyController.h"
#import "SportSelectSharkeyCell.h"
#import "WCDSharkeyFunction.h"
#import "SharkeyLocal.h"
#import "AppDelegate.h"
@interface SportSelectSharkeyController ()<WCDSharkeyFunctionDelegate>
@property (nonatomic, strong) Sharkey *curSharkey;

@end

@implementation SportSelectSharkeyController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [(AppDelegate*)[UIApplication sharedApplication].delegate tabbar].tabBarController.statusBarStyle = UIStatusBarStyleDefault;
    self.manager = [[CBCentralManager alloc]initWithDelegate:self queue:dispatch_get_main_queue()];
    self.manager.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initHeadView];
    [self initTopView];
    [self initTableView];
//
    [self loadSharkeyData];
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"选择设备" navigationController:self.navigationController];
    [self.view addSubview:self.headerView];
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    if (central.state != CBCentralManagerStatePoweredOn) {
        NSLog(@"fail, state is off.");
        switch (central.state) {
            case CBCentralManagerStatePoweredOff:
                NSLog(@"连接失败了\n请您再检查一下您的手机蓝牙是否开启，\n然后再试一次吧");
            
                break;
            case CBCentralManagerStateResetting:
            
                break;
            case CBCentralManagerStateUnsupported:
                NSLog(@"检测到您的手机不支持蓝牙4.0\n所以建立不了连接.建议更换您\n的手机再试试。");

                break;
            case CBCentralManagerStateUnauthorized:
                NSLog(@"连接失败了\n请您再检查一下您的手机蓝牙是否开启，\n然后再试一次吧");
                break;
            case CBCentralManagerStateUnknown:
    
                break;
            default:
                break;
        }
        return;
    }else{
        [SVProgressHUD showWithStatus:@"设备扫描中..." maskType:SVProgressHUDMaskTypeBlack];
        [self performSelector:@selector(dismissHUDView) withObject:self afterDelay:10];
    }
}

- (void)loadSharkeyData{
    WCDSharkeyFunction *wcdsharkey= [WCDSharkeyFunction shareInitializationt];
    wcdsharkey.delegate = self;
    [wcdsharkey setNotifyRemoteToChangeLanguage:0x01];
    [wcdsharkey scanWithSharkeyType:SHARKEYALL];
}

#pragma mark -- WCDSharkeyFunctionDelegate

/**
 *  扫描回调
 *
 *  @param sharkey sharkey设备
 */
- (void)WCDSharkeyScanCallBack:(Sharkey *)crippleSharkey
{
    NSLog(@"扫描返回的crippleSharkey: %@", crippleSharkey);
    if (self.SharkeyArray == nil) {
        self.SharkeyArray = [NSMutableArray new];
    }
    
    [self.SharkeyArray addObject:crippleSharkey];
    NSLog(@"self.SharkeyArray: %@", self.SharkeyArray);
    [self.tableView reloadData];
}

/**
 *  停止扫描回调
 */
- (void)WCDSharkeyScanStop
{
    NSLog(@"ScanStop");
//    [SVProgressHUD dismiss];
//    [self.view makeToast:@"扫描完成" duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
    
}

- (void)dismissHUDView{
    [SVProgressHUD dismiss];
}

- (void)initTopView{
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height+22, screen_width, 20)];
    label1.font = [UIFont systemFontOfSize:16];
    label1.text = @"搜索sharkey设备中";
    label1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, label1.frame.origin.y+label1.frame.size.height+20, screen_width, 20)];
    label2.font = [UIFont systemFontOfSize:16];
    label2.text = @"请将sharkey设备靠近手机";
    label2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label2];
    
    UIImageView *shebei1ImgView = [[UIImageView alloc] initWithFrame:CGRectMake((screen_width-141)/2, label2.frame.origin.y+label2.frame.size.height+32, 141, 163)];
    shebei1ImgView.image = [UIImage imageNamed:@"bg_shebei1"];
    [self.view addSubview:shebei1ImgView];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(15, shebei1ImgView.frame.origin.y+shebei1ImgView.frame.size.height+20, screen_width-30, 20)];
    label3.font = [UIFont systemFontOfSize:14];
    label3.text = @"可用设备";
    label3.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label3];
    
    self.downLine = [[UIView alloc] initWithFrame:CGRectMake(0, label3.frame.origin.y+label3.frame.size.height, screen_width, splite_line_height)];
    self.downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
    [self.view addSubview:self.downLine];
}

//初始化tableview
-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.downLine.frame.origin.y+self.downLine.frame.size.height, screen_width,screen_height-self.downLine.frame.origin.y) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.layer.cornerRadius = 2;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark - tableViewDelegate and datasource
#pragma mark - tableViewDelegate and datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.SharkeyArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *sportSelectSharkeyCellIdentifier = @"SportSelectSharkeyCell";
    UINib *nib = [UINib nibWithNibName:@"SportSelectSharkeyCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:sportSelectSharkeyCellIdentifier];
    SportSelectSharkeyCell *cell = [tableView dequeueReusableCellWithIdentifier:sportSelectSharkeyCellIdentifier forIndexPath:indexPath];
    Sharkey *sharkey = self.SharkeyArray[indexPath.row];
    [cell renderSportSelectSharkeyCell:sharkey];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Sharkey *sharkey = self.SharkeyArray[indexPath.row];
    self.curSharkey = sharkey;
    
    [SVProgressHUD showWithStatus:@"正在连接..." maskType:SVProgressHUDMaskTypeBlack];
    WCDSharkeyFunction *wcd = [WCDSharkeyFunction shareInitializationt];
    wcd.delegate = self;
    [wcd connectSharkeyNeedPair:sharkey];
}

- (void)WCDShackHandSuccessCallBack:(Sharkey *)crippleSharkey{
    NSLog(@"需要配对过：%@",crippleSharkey);
    [SVProgressHUD showWithStatus:@"正在连接..." maskType:SVProgressHUDMaskTypeBlack];
    WCDSharkeyFunction *wcd = [WCDSharkeyFunction shareInitializationt];
    wcd.delegate = self;
    [wcd pairToSharkey:crippleSharkey];
    [SVProgressHUD showWithStatus:@"请敲击硬件..." maskType:SVProgressHUDMaskTypeBlack];
}

- (void)WCDSharkeyRealStateCallBack:(SharkeyState)sharkeyState
{
    NSLog(@"sharkey实时状态: %ld", (long)sharkeyState);
    if (sharkeyState == 13) {
        
    }else if (sharkeyState == SharkeyStateConnecting){
        [SVProgressHUD showWithStatus:@"正在连接..." maskType:SVProgressHUDMaskTypeBlack];
    }
}

- (void)WCDConnectSuccessCallBck:(BOOL)flag sharkey:(Sharkey *)intactSharkey
{
    
    self.curSharkey = intactSharkey;
    NSLog(@"连接结果返回的intactSharkey: %@", intactSharkey);
    if (flag) {
//
        NSLog(@"连接成功");
        SharkeyLocal *sharkeyLocal = [[SharkeyLocal alloc] init];
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:self.curSharkey.name forKey:@"name"];
        [dict setObject:self.curSharkey.modelName forKey:@"modelName"];
        [dict setObject:self.curSharkey.macAddress forKey:@"macAddress"];
        //    [dict setObject:self.curSharkey.firmwareVersion forKey:@"firmwareVersion"];
        //    [dict setObject:self.curSharkey.serialNumber forKey:@"serialNumber"];
        [dict setObject:self.curSharkey.identifier forKey:@"identifier"];
        [sharkeyLocal readFromJSONDictionary:dict];
        [AppStatus sharedInstance].sharkey = sharkeyLocal;
        [AppStatus saveAppStatus];
        NSLog(@"设备信息保存本地：%@============%@---------%@",dict,sharkeyLocal,[AppStatus sharedInstance].sharkey);

        [[NSNotificationCenter defaultCenter] postNotificationName:@"设备连接成功" object:self.curSharkey];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"显示遮罩" object:nil];
        [self.navigationController popViewControllerAnimated:YES];

    }
    else {
        [SVProgressHUD dismiss];
        NSLog(@"连接失败");
        [SVProgressHUD showErrorWithStatus:@"连接失败！"];
    }
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
