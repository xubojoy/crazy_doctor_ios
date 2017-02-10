//
//  MyArchivesViewController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/11.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "MyArchivesViewController.h"
#import "MedicalRecordController.h"
#import "PhysiotherapyRecordController.h"
#import "AddMedicalRecordController.h"
#import "OtherHospitalDetailController.h"
@interface MyArchivesViewController ()

@end

@implementation MyArchivesViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadOtherData:) name:@"添加病历完成" object:nil];
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
//    self.currentGameStatuses = @[@"自诊"];
    [self initHeadView];
    [self initCustomSegmentView];
    [self selectSegment:0];
}

- (void)loadOtherData:(NSNotification *)notification{
    NSLog(@">>>>>>>>>>--------%@",[notification object]);
    self.currentGameStatuses = (NSArray *)[notification object];
    [self initHeadView];
    [self initCustomSegmentView];
    [self selectSegment:3];
}


//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"档案" navigationController:self.navigationController];
    [self.view addSubview:self.headerView];
    
    self.rightAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightAddBtn.titleLabel.font = [UIFont systemFontOfSize:default_font_size];
    self.rightAddBtn.frame = CGRectMake(screen_width-150-15, 20, 150, 44);
    self.rightAddBtn.backgroundColor = [UIColor clearColor];
    [self.rightAddBtn setTitle:@"添加病历" forState:UIControlStateNormal];
    [self.rightAddBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.rightAddBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 90, 0, 0);
    [self.rightAddBtn addTarget:self action:@selector(rightAddBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rightAddBtn];

}

-(void)initCustomSegmentView
{
    NSArray *btnTitleArray = [[NSArray alloc] initWithObjects:@"自诊",@"理疗",@"中医大夫",@"其他医院", nil];
    self.customSegmentView = [[CustomSegmentView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width, general_height)];
    [self.customSegmentView render:btnTitleArray currentIndex:[self getSelectIndex]];
    self.customSegmentView.delegate = self;
    self.customSegmentView.backgroundColor = [ColorUtils colorWithHexString:white_text_color];
    
    UIView *downSpeliteLine = [[UIView alloc] initWithFrame:CGRectMake(0, general_height-splite_line_height, screen_width, splite_line_height)];
    downSpeliteLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
    [self.customSegmentView addSubview:downSpeliteLine];
    [self.view addSubview:self.customSegmentView];
}

//根据当前的美发卡状态获取选中的位序
-(int)getSelectIndex{
    if ([self.currentGameStatuses isEqualToArray:[[NSArray alloc] initWithObjects:@"自诊", nil]]) {
        NSLog(@">>>>>>>>>>>舌诊体质>>>>>>>>>>");
        return 0;
        
    }else if ([self.currentGameStatuses isEqualToArray:[[NSArray alloc] initWithObjects:@"理疗", nil]]) {
        NSLog(@">>>>>>>>>>>>眼诊脏器>>>>>>>>>>>>>");
        return 1;
    }else if ([self.currentGameStatuses isEqualToArray:[[NSArray alloc] initWithObjects:@"中医大夫", nil]]) {
        NSLog(@">>>>>>>>>>>>调理经络>>>>>>>>>>>>>");
        return 2;
    }else if ([self.currentGameStatuses isEqualToArray:[[NSArray alloc] initWithObjects:@"其他医院", nil]]){
        return 3;
    }
    return 0;
}

-(void)selectSegment:(int)inx
{
    NSLog(@">>>>当前选择>>>>>>>%d",inx);
    switch (inx) {
        case 0:{
            self.mdvc = [[MyDiagnosticsViewController alloc] init];
            self.mdvc.view.frame = CGRectMake(0, self.customSegmentView.frame.origin.y+self.customSegmentView.frame.size.height, screen_width,screen_height-64-general_height);
//            mdvc.delegate = self;
            [self.view addSubview:self.mdvc.view];
        }
            break;
        case 1:{
            self.mpvc = [[MyPhysiotherapyViewController alloc] init];
            self.mpvc.view.frame = CGRectMake(0, self.customSegmentView.frame.origin.y+self.customSegmentView.frame.size.height, screen_width,screen_height-64-general_height);
            self.mpvc.delegate = self;
            [self.view addSubview:self.mpvc.view];
        }
            break;
        case 2:
        {
            self.mdoctorvc = [[MyDoctorViewController alloc] init];
            self.mdoctorvc.view.frame = CGRectMake(0, self.customSegmentView.frame.origin.y+self.customSegmentView.frame.size.height, screen_width,screen_height-64-general_height);
            self.mdoctorvc.delegate = self;
            [self.view addSubview:self.mdoctorvc.view];
            
        }
            break;
        case 3:
        {
            self.ohvc = [[OtherHospitalViewController alloc] init];
            self.ohvc.view.frame = CGRectMake(0, self.customSegmentView.frame.origin.y+self.customSegmentView.frame.size.height, screen_width,screen_height-64-general_height);
            self.ohvc.delegate = self;
            [self.view addSubview:self.ohvc.view];
        }
            break;
        default:
            break;
    }
}


- (void)didMyDoctorViewControllerIndexPathRow:(NSInteger)row myDoctor:(MyDoctor *)myDoctor{
    MedicalRecordController *mrvc = [[MedicalRecordController alloc] initWithMyDoctor:myDoctor];
    [self.navigationController pushViewController:mrvc animated:YES];
}

- (void)didMyPhysiotherapyViewControllerIndexPathRow:(NSInteger)row myPhysiotherapy:(MyPhysiotherapy *)myPhysiotherapy{
    PhysiotherapyRecordController *mrvc = [[PhysiotherapyRecordController alloc] initWithMyPhysiotherapy:myPhysiotherapy];
    [self.navigationController pushViewController:mrvc animated:YES];
}

- (void)didOtherHospitalViewControllerIndexPathRow:(NSInteger)row userUploadRecord:(UserUploadRecord *)userUploadRecord{
    OtherHospitalDetailController *ohdvc = [[OtherHospitalDetailController alloc] initWithUserUploadRecord:userUploadRecord];
    [self.navigationController pushViewController:ohdvc animated:YES];
}

- (void)rightAddBtnClick{
    AddMedicalRecordController *amrvc = [[AddMedicalRecordController alloc] init];
    [self.navigationController pushViewController:amrvc animated:YES];
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
