//
//  CheckIndexController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/18.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "CheckIndexController.h"
#import "ReadyForTongueDiagnosisController.h"
#import "TongueDiagnosisStore.h"
#import "TongueDiagnosisCompareController.h"
#import "DiagnosisOnLeftEyesController.h"
#import "CheckAcupointViewController.h"
#import "MeridianStore.h"
#import "UserLoginViewController.h"
@interface CheckIndexController ()

@end

@implementation CheckIndexController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [(AppDelegate*)[UIApplication sharedApplication].delegate tabbar].tabBarController.statusBarStyle = UIStatusBarStyleDefault;
    NSLog(@">>>>>>>>>>>>1111111111>>>>>>>>>>>>>%d",[AppStatus sharedInstance].isComplete);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCheckUI) name:notification_name_session_update object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadRefreshData:) name:@"刷新调理经络数据" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUI:) name:@"刷新舌诊体质数据" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshEyesUI:) name:@"刷新眼诊脏器数据" object:nil];
    NSLog(@">>>>>>>>>>>>22222222222>>>>>>>>>>>>>%d",[AppStatus sharedInstance].isComplete);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.autoresizesSubviews = NO;
    self.view.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    [self initUI];
}

#pragma mark - 初始化自定义View
- (void)initUI{
     self.currentGameStatuses = @[@"舌诊体质"];
    [self initHeadView];
    [self initCustomSegmentView];
    [self selectSegment:0];
}

- (void)refreshUI:(NSNotification *)notification{
    self.currentGameStatuses = (NSArray *)[notification object];
    [self initUI];
}

- (void)refreshCheckUI{
    self.currentGameStatuses = @[@"舌诊体质"];
    [self initHeadView];
    [self initCustomSegmentView];
    [self selectSegment:0];
}

- (void)refreshEyesUI:(NSNotification *)notification{
    self.currentGameStatuses = (NSArray *)[notification object];
    [self initHeadView];
    [self initCustomSegmentView];
    [self selectSegment:1];
}

- (void)loadRefreshData:(NSNotification *)notification{
    NSLog(@">>>>>>>>>>--------%@",[notification object]);
    self.currentGameStatuses = (NSArray *)[notification object];
    [self initHeadView];
    [self initCustomSegmentView];
    [self selectSegment:2];
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"查体" navigationController:self.navigationController];
    self.headerView.backBut.hidden = YES;
    self.headerView.userInteractionEnabled = YES;
    [self.view addSubview:self.headerView];
}

-(void)initCustomSegmentView
{
    NSArray *btnTitleArray = [[NSArray alloc] initWithObjects:@"舌诊体质",@"眼诊脏器",@"调理经络", nil];
    self.customSegmentView = [[CustomSegmentView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width, general_height)];
    [self.customSegmentView render:btnTitleArray currentIndex:[self getSelectIndex]];
    self.customSegmentView.delegate = self;
    self.customSegmentView.backgroundColor = [ColorUtils colorWithHexString:white_text_color];
    
    UIView *downSpeliteLine = [[UIView alloc] initWithFrame:CGRectMake(0, general_height-splite_line_height, screen_width, splite_line_height)];
    downSpeliteLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
    [self.customSegmentView addSubview:downSpeliteLine];
    [self.view addSubview:self.customSegmentView];
}

-(int)getSelectIndex{
    if ([self.currentGameStatuses isEqualToArray:[[NSArray alloc] initWithObjects:@"舌诊体质", nil]]) {
        NSLog(@">>>>>>>>>>>舌诊体质>>>>>>>>>>");
        return 0;
        
    }else if ([self.currentGameStatuses isEqualToArray:[[NSArray alloc] initWithObjects:@"眼诊脏器", nil]]) {
        NSLog(@">>>>>>>>>>>>眼诊脏器>>>>>>>>>>>>>");
        return 1;
    }else if ([self.currentGameStatuses isEqualToArray:[[NSArray alloc] initWithObjects:@"调理经络", nil]]) {
        NSLog(@">>>>>>>>>>>>调理经络>>>>>>>>>>>>>");
        return 2;
    }
    return 0;
}

-(void)selectSegment:(int)inx
{
    NSLog(@">>>>当前选择>>>>>>>%d",inx);
    switch (inx) {
        case 0:{
            self.tongueDiagnosisController = [[CheckTongueDiagnosisController alloc] init];
            self.tongueDiagnosisController.view.frame = CGRectMake(0, self.customSegmentView.frame.origin.y+self.customSegmentView.frame.size.height, screen_width,screen_height);
            self.tongueDiagnosisController.delegate = self;
            [self.view addSubview:self.tongueDiagnosisController.view];
        }
            break;
        case 1:{
            self.diagnosisEyesController = [[CheckDiagnosisEyesController alloc] init];
            self.diagnosisEyesController.view.frame = CGRectMake(0, self.customSegmentView.frame.origin.y+self.customSegmentView.frame.size.height, screen_width,screen_height);
            self.diagnosisEyesController.delegate = self;
            [self.view addSubview:self.diagnosisEyesController.view];
        }
            break;
        case 2:
        {
            self.meridiansRegulationController = [[CheckMeridiansRegulationController alloc] init];
            self.meridiansRegulationController.view.frame = CGRectMake(0, self.customSegmentView.frame.origin.y+self.customSegmentView.frame.size.height, screen_width,screen_height);
            self.meridiansRegulationController.delegate = self;
            [self.view addSubview:self.meridiansRegulationController.view];
            
        }
            break;
        default:
            break;
    }
}

#pragma mark - CheckTongueDiagnosisControllerDelegate
- (void)didreCheckTongueDiagnosisBtnClick:(UIButton *)sender{
    [self tokePhoto];
}

- (void)didreCheckTongueDiagnosisEmptyBtnClick:(UIButton *)sender{
//    if (![[AppStatus sharedInstance] logined]) {
//        UserLoginViewController *ulc = [[UserLoginViewController alloc] initWithFrom:account_session_from_user_chati];
//        [self.navigationController pushViewController:ulc animated:YES];
//        return ;
//    }else{
        [self tokePhoto];
//    }
}

#pragma mark - CheckDiagnosisEyesControllerDelegate
- (void)didreCheckDiagnosisEyesBtnClick:(UIButton *)sender{
    DiagnosisOnLeftEyesController *dolvc = [[DiagnosisOnLeftEyesController alloc] init];
    [self.navigationController pushViewController:dolvc animated:YES];
}

-(void)didreCheckDiagnosisEyesEmptyBtnClick:(UIButton *)sender{
//    if (![[AppStatus sharedInstance] logined]) {
//        UserLoginViewController *ulc = [[UserLoginViewController alloc] initWithFrom:account_session_from_user_chati];
//        [self.navigationController pushViewController:ulc animated:YES];
//        return ;
//    }else{
        DiagnosisOnLeftEyesController *dolvc = [[DiagnosisOnLeftEyesController alloc] init];
        [self.navigationController pushViewController:dolvc animated:YES];
//    }
}

#pragma mark - CheckMeridiansRegulationControllerDelegate
- (void)didreCheckMeridiansRegulationWithAcupoint:(Acupoint *)acupoint meridian:(Meridian *)meridian{
    CheckAcupointViewController *cavc = [[CheckAcupointViewController alloc] initWithAcupoint:acupoint meridian:meridian];
    [self.navigationController pushViewController:cavc animated:YES];
}

- (void)tokePhoto{
    
    self.homevc = [[HomeViewController alloc] init];
    self.homevc.delegate = self;
    [self presentViewController:self.homevc animated:YES completion:nil];
    
    self.remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, screen_width, 40)];
    self.remindLabel.backgroundColor = [UIColor clearColor];
    self.remindLabel.text = @"请伸出舌头并放在下方拍照框";
    self.remindLabel.textColor = [UIColor whiteColor];
    self.remindLabel.font = [UIFont systemFontOfSize:default_font_size];
    self.remindLabel.textAlignment = NSTextAlignmentCenter;
    [self.homevc.view addSubview:self.remindLabel];
    
//    float y = ((screen_width-40)*198)/750;
//    float h = screen_height-y-(((screen_width-40)*274)/750)-85-20;
//    
//    self.markImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, y, screen_width-40, h)];
//    //    markImgView.backgroundColor = [UIColor purpleColor];
//    self.markImgView.image = [UIImage imageNamed:@"bg_abandon_photograph_wireframe"];
//    self.markImgView.backgroundColor = [UIColor clearColor];
//    [self.homevc.view addSubview:self.markImgView];
//    
//    float tongueImgViewW = ((h-80)*384)/628;
//    UIImageView *tongueImgView = [[UIImageView alloc] initWithFrame:CGRectMake((screen_width-40-tongueImgViewW)/2, 40, tongueImgViewW, h-80)];
//    tongueImgView.image = [UIImage imageNamed:@"bg_abandon_photograph"];
//    tongueImgView.backgroundColor = [UIColor clearColor];
//    [self.markImgView addSubview:tongueImgView];
    
    self.contentCameraLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, screen_height-60-10-85, screen_width-65, 85)];
    self.contentCameraLabel.backgroundColor = [UIColor clearColor];
    NSString *contentStr = @"1.请在充足光线在拍照。\n2.刷牙及饭后不要立即做舌像自诊，会有误差。\n3.不要在吃进色素等人为染苔行为下做自诊。";
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:contentStr];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [contentStr length])];
    [self.contentCameraLabel setAttributedText:attributedString];
    self.contentCameraLabel.numberOfLines = 0;
    self.contentCameraLabel.textColor = [ColorUtils colorWithHexString:white_text_color];
    self.contentCameraLabel.font = [UIFont systemFontOfSize:small_font_size];
    self.contentCameraLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentCameraLabel sizeToFit];
    [self.homevc.view addSubview:self.contentCameraLabel];
}

-(void) homeViewController:(HomeViewController *)picker didFinishPickingMediaWithImage:(UIImage *)image{
    [picker dismissViewControllerAnimated:NO completion:nil];
//    image = [ImageUtils imageWithImageSimple:image scaledToSize:CGSizeMake(220, 220)];
    [SVProgressHUD showWithStatus:@"图片上传中..." maskType:SVProgressHUDMaskTypeBlack];
    [TongueDiagnosisStore upLoadTongueDiagnosisImg:^(NSString *imgUrl, NSError *err) {
        [SVProgressHUD dismiss];
        if (imgUrl != nil) {
            NSLog(@">>>>>>>>>>>>>>>>>>上传的舌头照片----%@",imgUrl);
            TongueDiagnosisCompareController *tdcvc = [[TongueDiagnosisCompareController alloc] initWithImage:imgUrl];
            [self.navigationController pushViewController:tdcvc animated:YES];
        }else{
            ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
            [self.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        }
    } tongueImage:image];
}

-(NSString *)getPageName
{
    return page_name_chati;
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
