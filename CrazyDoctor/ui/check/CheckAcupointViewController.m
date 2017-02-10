//
//  CheckAcupointViewController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/4.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "CheckAcupointViewController.h"
#import "LBorderView.h"
#import "MeridianStore.h"
#import "AQTool.h"
#import "UIImageView+WebCache.h"
#import "UserLoginViewController.h"
@interface CheckAcupointViewController ()

@end

@implementation CheckAcupointViewController
- (instancetype)initWithAcupoint:(Acupoint *)acupoint meridian:(Meridian *)meridian{
    self = [super init];
    if (self) {
        self.acupoint = acupoint;
        self.meridian = meridian;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initHeadView];
    [self initTableView];
    [self initBottomBtnView];
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:self.acupoint.name navigationController:self.navigationController];
    [self.view addSubview:self.headerView];
}

//初始化tableview
-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width,screen_height-self.headerView.frame.size.height-60-10) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [ColorUtils colorWithHexString:white_text_color];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark - tableViewDelegate and datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [UITableViewCell new];
        self.streamerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, (screen_width*418)/750)];
        if (self.acupoint != nil) {
            [self.streamerImgView sd_setImageWithURL:[NSURL URLWithString:self.acupoint.imageUrl] placeholderImage:nil];
        }
        self.streamerImgView.contentMode = UIViewContentModeScaleAspectFit;
        self.streamerImgView.clipsToBounds = YES;
        [cell.contentView addSubview:self.streamerImgView];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(0, (screen_width*418)/750-splite_line_height, screen_width, splite_line_height)];
        downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
        [cell.contentView addSubview:downLine];
        
        return cell;
    }else if (indexPath.row == 1){
        UITableViewCell *cell = [UITableViewCell new];
        if ([NSStringUtils isNotBlank:self.acupoint.remark]) {
            UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(general_margin, general_margin, screen_width-30, 0)];
            bgView.layer.borderWidth = splite_line_height;
            bgView.layer.borderColor = [ColorUtils colorWithHexString:common_app_text_color].CGColor;
            [cell.contentView addSubview:bgView];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 300, 50)];
            label.text = self.acupoint.remark;
            //自动折行设置
            label.lineBreakMode =NSLineBreakByWordWrapping;
            label.numberOfLines = 0;
            label.textColor = [ColorUtils colorWithHexString:common_app_text_color];
            label.font = [UIFont boldSystemFontOfSize:default_2_font_size];
            label.textAlignment = NSTextAlignmentCenter;
            //自适应高度
            CGRect Frame = label.frame;
            
            label.frame = CGRectMake(15, 15, screen_width-30,
                                     Frame.size.height =[label.text boundingRectWithSize:
                                                         CGSizeMake(Frame.size.width, CGFLOAT_MAX)
                                                                                 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                              attributes:[NSDictionary dictionaryWithObjectsAndKeys:label.font,NSFontAttributeName, nil] context:nil].size.height);
            label.frame = CGRectMake(15, 30, screen_width-30, Frame.size.height);
            
            [cell.contentView addSubview:label];
            //获取新的cell的高度
            CGRect frame = cell.frame;
            frame.size.height = label.frame.size.height+30+30 ;
            bgView.frame = CGRectMake(general_margin, general_margin, screen_width-30, label.frame.size.height+30);
            cell.frame = frame;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 2){
        UITableViewCell *cell = [UITableViewCell new];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(general_margin, 0, 3, 20)];
        lineView.backgroundColor = [ColorUtils colorWithHexString:common_app_text_color];
        [cell.contentView addSubview:lineView];
        
        UILabel *acupointPainLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, screen_width-30-15, 20)];
        acupointPainLabel.text = [NSString stringWithFormat:@"%@痛感统计",self.acupoint.name];
        acupointPainLabel.textColor = [ColorUtils colorWithHexString:common_app_text_color];
        acupointPainLabel.font = [UIFont boldSystemFontOfSize:default_1_font_size];
        [cell.contentView addSubview:acupointPainLabel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.row == 3){
        UITableViewCell *cell = [UITableViewCell new];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        LBorderView *sepImageView = [[LBorderView alloc] initWithFrame:CGRectMake(general_margin, 0, screen_width-30, 25)];
        sepImageView.borderType = BorderTypeDashed;
        sepImageView.dashPattern = 4;
        sepImageView.spacePattern = 4;
        sepImageView.borderWidth = 0.5;
        sepImageView.borderColor = [ColorUtils colorWithHexString:lighter_2_brown_color];
        [cell.contentView addSubview:sepImageView];
        
        UILabel *remindLabel = [[UILabel alloc] init];
        remindLabel.text = [NSString stringWithFormat:@"%@",self.meridian.jingLuoName];
        remindLabel.font = [UIFont boldSystemFontOfSize:smallest_font_size];
        remindLabel.textColor = [ColorUtils colorWithHexString:lighter_2_brown_color];
        remindLabel.frame = CGRectMake(15+10+15, 0, remindLabel.realWidth, 25);
        [sepImageView addSubview:remindLabel];
        
        UIImageView *hitRemindImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (25-12)/2, 10, 12)];
        hitRemindImgView.image = [UIImage imageNamed:@"icon_eye_hit_reminder"];
        [sepImageView addSubview:hitRemindImgView];

        return cell;
    }
    
    else{
        UITableViewCell *cell = [UITableViewCell new];
        
        self.painLevelView = [[PainLevelView alloc] initWithFrame:CGRectMake(general_margin, 0, screen_width-30, 180) meridian:self.meridian];
        self.painLevelView.delegate = self;
        [cell.contentView addSubview:self.painLevelView];
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return (screen_width*418)/750;
    }else if (indexPath.row == 1){
        if ([NSStringUtils isNotBlank:self.acupoint.remark]) {
            UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
            return cell.frame.size.height;
        }else{
            return 0;
        }
    }else if (indexPath.row == 2){
        return 35;
    }else if (indexPath.row == 3){
        return 25;
    }
    return 180;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
         [AQTool showImage:self.streamerImgView];//调用方法
    }
}

- (void)didainLevelViewPainLevelBtnClick:(UIButton *)sender{
    NSLog(@">>>>>>>>>>>>>>>>>点击了痛感>>>>>>>>>>>%ld",(long)sender.tag);
    self.levelNum = (int)sender.tag+1;
}

- (void)initBottomBtnView{
    UIView *upLine = [[UIView alloc] initWithFrame:CGRectMake(0, screen_height-59, screen_width, splite_line_height)];
    upLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
    [self.view addSubview:upLine];
    
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.confirmBtn.frame = CGRectMake(general_margin, screen_height-7-45, screen_width-2*general_margin, 45);
    UIImage *hightLightImage = [UIImage imageNamed:@"btn_login_pre"];
    [self.confirmBtn setBackgroundImage:[ImageUtils resizableBgImage:hightLightImage] forState:UIControlStateNormal];
    [self.confirmBtn setBackgroundImage:[ImageUtils resizableBgImage:hightLightImage] forState:UIControlStateHighlighted];
    [self.confirmBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.confirmBtn.titleLabel setFont:[UIFont systemFontOfSize:bigger_font_size]];
    [self.confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.confirmBtn];
}

- (void)confirmBtnClick{
//    NSLog(@">>>>>>>>>>>>>>>>>>>%d",self.levelNum);
    if (![[AppStatus sharedInstance] logined]) {
        UserLoginViewController *ulc = [[UserLoginViewController alloc] initWithFrom:account_session_from_xuewei_detail];
        [self.navigationController pushViewController:ulc animated:YES];
        return ;
    }else{
        if (self.levelNum != 0) {
            [SVProgressHUD showWithStatus:@"" maskType:SVProgressHUDMaskTypeClear];
            [MeridianStore confirmMeridianRecord:^(NSDictionary *dict, NSError *err) {
                [SVProgressHUD dismiss];
                if (dict != nil) {
                    NSLog(@">>>>>>>>>dict>>>>>>>>>>%@",dict);
                    
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"调理经络" object:nil];
                    NSArray *array = @[@"调理经络"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"刷新调理经络数据" object:array];
                    
                    
                }else{
                    ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
                    [self.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
                }
            } userId:[AppStatus sharedInstance].user.id meridianId:self.meridian.id acupointId:self.acupoint.id level:self.levelNum];
        }else{
            [self.view makeToast:@"请选择疼痛等级！" duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        }
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
