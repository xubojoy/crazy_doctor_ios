//
//  PushSettingController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/19.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "PushSettingController.h"
#import "UserStore.h"
@interface PushSettingController ()

@end

@implementation PushSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.autoresizesSubviews = NO;
    self.view.backgroundColor = [ColorUtils colorWithHexString:white_text_color];
    [self setRightSwipeGestureAndAdaptive];
    self.pushTimesArray = [NSMutableArray new];
    self.selectedPushTimesSet = [NSMutableSet new];
    self.timeArray = @[@"卯时5:00-7:00",@"辰时7:00-9:00",@"巳时9:00-11:00",@"午时11:00-13:00",@"未时13:00-15:00",@"申时15:00-17:00",@"酉时17:00-19:00",@"戌时19:00-21:00",@"亥时21:00-23:00",@"子时23:00-1:00"];
    self.meridianArray = @[@"大肠经当令",@"胃经当令",@"脾经当令",@"心经当令",@"小肠经当令",@"膀胱经当令",@"肾经当令",@"心包经当令",@"三焦经当令",@"胆经当令"];
    self.pushTimeArray = @[@"5",@"7",@"9",@"11",@"13",@"15",@"17",@"19",@"21",@"23"];
    
        NSLog(@">>>>>>>>当前状态保存的经络>>-----%@",[AppStatus sharedInstance].meridianDict);
    
    [self initUI];
    [self loadData];
}

- (void)initUI{
    [self initHeadView];
    [self initTableView];
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"推送提醒" navigationController:self.navigationController];
    [self.view addSubview:self.headerView];
}

//初始化tableview
-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width,screen_height-self.headerView.frame.size.height) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [ColorUtils colorWithHexString:white_text_color];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

- (void)loadData{
    
    NSLog(@">>>>>保存的状态aaaaaaa>>>>>>>>%d>>>>>%@",[AppStatus sharedInstance].user.receivePush,[AppStatus sharedInstance].user.pushTimes);
    
    if ([AppStatus sharedInstance].user.receivePush == YES) {
        [self.totalSwitch setOn:YES];
    }else{
        [self.totalSwitch setOn:NO];
    }
    
    if ([NSStringUtils isNotBlank:[AppStatus sharedInstance].user.pushTimes]) {
        NSString *pushTimes = [AppStatus sharedInstance].user.pushTimes;
        if ([FunctionUtils isDefaultPushTimes:pushTimes] == YES) {
            [AppStatus sharedInstance].defaultSwitch = YES;
            [AppStatus saveAppStatus];
            [self.defaultSwitch setOn:YES];
            [FunctionUtils startDefaultNotifi];
        }else{
            [self.defaultSwitch setOn:NO];
            AppStatus *pushStatus = [AppStatus sharedInstance];
            pushStatus.defaultSwitch = NO;
            [AppStatus saveAppStatus];
            [FunctionUtils closeDefaultNotifi];
        }
    }


    if ([NSStringUtils isNotBlank:[AppStatus sharedInstance].user.pushTimes]) {
        NSString *pushTimes = [AppStatus sharedInstance].user.pushTimes;
        if ([FunctionUtils isCustomPushTimes:pushTimes] == YES) {
             AppStatus *pushStatus = [AppStatus sharedInstance];
            pushStatus.customSwitch = YES;
            [AppStatus saveAppStatus];
            [self.customSwit setOn:YES];
        }else{
            [self.customSwit setOn:NO];
            AppStatus *pushStatus = [AppStatus sharedInstance];
            pushStatus.customSwitch = NO;
            [AppStatus saveAppStatus];
        }
    }else{
        AppStatus *pushStatus = [AppStatus sharedInstance];
        pushStatus.customSwitch = YES;
        [AppStatus saveAppStatus];
        [self.customSwit setOn:YES];
    }
    
    if ([NSStringUtils isNotBlank:[AppStatus sharedInstance].user.pushTimes]) {
        NSString *pushTimes = [AppStatus sharedInstance].user.pushTimes;
        NSArray *pushTimesTmpArray = [pushTimes componentsSeparatedByString:@","];
//        [self.pushTimesArray removeAllObjects];
        [self.selectedPushTimesSet removeAllObjects];
//        [self.pushTimesArray addObjectsFromArray:pushTimesTmpArray];
        [self.selectedPushTimesSet addObjectsFromArray:pushTimesTmpArray];
    }
    [self.tableView reloadData];
    
    NSLog(@">>>>>保存的状态sssssss>>>>>>>>%d>>>>>%d>>>>>%d",[AppStatus sharedInstance].user.receivePush,[AppStatus sharedInstance].defaultSwitch,[AppStatus sharedInstance].customSwitch);
}

#pragma mark - tableViewDelegate and datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 3) {
        return 10;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *totalCellIdentifier = @"totalCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:totalCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:totalCellIdentifier];
            
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(general_margin, 0, 110, 49)];
            lab.text = @"开启推送提醒";
            lab.font = [UIFont systemFontOfSize:default_1_font_size];
            lab.textColor = [ColorUtils colorWithHexString:black_text_color];
            [cell.contentView addSubview:lab];
            
            self.totalSwitch = [[LQXSwitch alloc] initWithFrame:CGRectMake(screen_width-15-48, (49-23)/2, 48, 23) onColor:[ColorUtils colorWithHexString:common_app_text_color] offColor:[ColorUtils colorWithHexString:splite_line_color] font:[UIFont systemFontOfSize:default_font_size] ballSize:20];
            
            if ([AppStatus sharedInstance].user.receivePush == YES) {
                [self.totalSwitch setOn:YES];
            }else{
                [self.totalSwitch setOn:NO];
            }
            [self.totalSwitch addTarget:self action:@selector(didPushTotalCellSwit:) forControlEvents:UIControlEventValueChanged];
            [cell.contentView addSubview:self.totalSwitch];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(general_margin, 48, screen_width-general_margin, splite_line_height)];
            downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
            [cell.contentView addSubview:downLine];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.section == 1){
        static NSString *defaultCellIdentifier = @"defaultCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultCellIdentifier];
            if ([AppStatus sharedInstance].user.receivePush == YES) {
                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(general_margin, 0, 110, 49)];
                lab.text = @"默认推送时间段";
                lab.font = [UIFont systemFontOfSize:default_1_font_size];
                lab.textColor = [ColorUtils colorWithHexString:black_text_color];
                [cell.contentView addSubview:lab];
                
                UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(general_margin+110+10, 0, 180, 49)];
                timeLab.text = @"7:00-21:00";
                timeLab.font = [UIFont systemFontOfSize:smaller_font_size];
                timeLab.textColor = [ColorUtils colorWithHexString:@"#666666"];
                [cell.contentView addSubview:timeLab];
                
                self.defaultSwitch = [[LQXSwitch alloc] initWithFrame:CGRectMake(screen_width-15-48, (49-23)/2, 48, 23) onColor:[ColorUtils colorWithHexString:common_app_text_color] offColor:[ColorUtils colorWithHexString:splite_line_color] font:[UIFont systemFontOfSize:default_font_size] ballSize:20];

                if ([NSStringUtils isNotBlank:[AppStatus sharedInstance].user.pushTimes]) {
                    NSString *pushTimes = [AppStatus sharedInstance].user.pushTimes;
                    if ([FunctionUtils isDefaultPushTimes:pushTimes] == YES) {
                        [self.defaultSwitch setOn:YES];
                    }else{
                        [self.defaultSwitch setOn:NO];
                    }
                }else{
                    [self.defaultSwitch setOn:NO];
                }
                
                [self.defaultSwitch addTarget:self action:@selector(didPushDefaultCellSwit:) forControlEvents:UIControlEventValueChanged];
                [cell.contentView addSubview:self.defaultSwitch];
                
                
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 2){
        static NSString *customCellIdentifier = @"customCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customCellIdentifier];
            if ([AppStatus sharedInstance].user.receivePush == YES) {
                UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 7)];
                grayView.backgroundColor = [ColorUtils colorWithHexString:gray_common_color];
                [cell.contentView addSubview:grayView];
                
                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(general_margin, 7, 180, 45)];
                lab.text = @"自定义推送时间段";
                lab.font = [UIFont systemFontOfSize:default_1_font_size];
                lab.textColor = [ColorUtils colorWithHexString:black_text_color];
                [cell.contentView addSubview:lab];
                
                self.customSwit = [[LQXSwitch alloc] initWithFrame:CGRectMake(screen_width-15-48, (45-23)/2+7, 48, 23) onColor:[ColorUtils colorWithHexString:common_app_text_color] offColor:[ColorUtils colorWithHexString:splite_line_color] font:[UIFont systemFontOfSize:default_font_size] ballSize:20];
                
                if ([NSStringUtils isNotBlank:[AppStatus sharedInstance].user.pushTimes]) {
                    NSString *pushTimes = [AppStatus sharedInstance].user.pushTimes;
                    if ([FunctionUtils isCustomPushTimes:pushTimes] == YES) {
                       [self.customSwit setOn:YES];
                    }else{
                        [self.customSwit setOn:NO];
                    }
                }else{
                    [self.customSwit setOn:YES];
                }
                
                [cell.contentView addSubview:self.customSwit];
                [self.customSwit addTarget:self action:@selector(customSwitClick:) forControlEvents:UIControlEventValueChanged];
                
                UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(general_margin, 51, screen_width-general_margin, splite_line_height)];
                downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
                [cell.contentView addSubview:downLine];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 3){
        if (indexPath.row == 0) {
            if ([AppStatus sharedInstance].user.receivePush == YES && [AppStatus sharedInstance].customSwitch == YES) {
                //static NSString *pushSettingCell0Identifier = @"pushSettingCell0";
                //UINib *nib = [UINib nibWithNibName:@"PushSettingCell" bundle:nil];
                //[self.tableView registerNib:nib forCellReuseIdentifier:pushSettingCell0Identifier];
                // PushSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:pushSettingCell0Identifier forIndexPath:indexPath];
                static NSString *maoshiCellIdentifier = @"maoshiCell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:maoshiCellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:maoshiCellIdentifier];
                    
                    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(general_margin, 0, 130, 45)];
                    lab.text = @"卯时5:00-7:00";
                    lab.font = [UIFont systemFontOfSize:default_font_size];
                    lab.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
                    [cell.contentView addSubview:lab];
                    
                    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(145, 0, 83, 45)];
                    timeLab.text = @"大肠经当令";
                    timeLab.font = [UIFont systemFontOfSize:smaller_font_size];
                    timeLab.textColor = [ColorUtils colorWithHexString:gray_text_color];
                    [cell.contentView addSubview:timeLab];
                    
                    self.maoshiSwit = [[LQXSwitch alloc] initWithFrame:CGRectMake(screen_width-15-48, (45-23)/2, 48, 23) onColor:[ColorUtils colorWithHexString:common_app_text_color] offColor:[ColorUtils colorWithHexString:splite_line_color] font:[UIFont systemFontOfSize:default_font_size] ballSize:20];
                    self.maoshiSwit.tag = 99990;
                    if ([self.selectedPushTimesSet containsObject:@"5"]) {
                        [self.maoshiSwit setOn:YES];
                    }else{
                        [self.maoshiSwit setOn:NO];
                    }
                    
                    [self.maoshiSwit addTarget:self action:@selector(pushSettingCellSwit:) forControlEvents:UIControlEventValueChanged];
                    
                    [cell.contentView addSubview:self.maoshiSwit];
                    
                    //                    NSString *timeStr = self.timeArray[indexPath.row];
                    //                    NSString *meridianStr = self.meridianArray[indexPath.row];
                    //[cell renderPushSettingCellWithTime:timeStr withMeridian:meridianStr];
                    UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(general_margin, 44, screen_width-general_margin, splite_line_height)];
                    downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
                    [cell.contentView addSubview:downLine];

                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                UITableViewCell *cell = [UITableViewCell new];
                return cell;
            }
            
        }else if (indexPath.row == 1){
            
            if ([AppStatus sharedInstance].user.receivePush == YES && [AppStatus sharedInstance].customSwitch == YES) {
                //                static NSString *pushSettingCell1Identifier = @"pushSettingCell1";
                //                UINib *nib = [UINib nibWithNibName:@"PushSettingCell" bundle:nil];
                //                [self.tableView registerNib:nib forCellReuseIdentifier:pushSettingCell1Identifier];
                //                PushSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:pushSettingCell1Identifier forIndexPath:indexPath];
                static NSString *chenshiCellIdentifier = @"chenshiCell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:chenshiCellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chenshiCellIdentifier];
                    
                    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(general_margin, 0, 130, 45)];
                    lab.text = @"辰时7:00-9:00";
                    lab.font = [UIFont systemFontOfSize:default_font_size];
                    lab.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
                    [cell.contentView addSubview:lab];
                    
                    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(145, 0, 83, 45)];
                    timeLab.text = @"胃经当令";
                    timeLab.font = [UIFont systemFontOfSize:smaller_font_size];
                    timeLab.textColor = [ColorUtils colorWithHexString:gray_text_color];
                    [cell.contentView addSubview:timeLab];
                    
                    self.chenshiSwit = [[LQXSwitch alloc] initWithFrame:CGRectMake(screen_width-15-48, (45-23)/2, 48, 23) onColor:[ColorUtils colorWithHexString:common_app_text_color] offColor:[ColorUtils colorWithHexString:splite_line_color] font:[UIFont systemFontOfSize:default_font_size] ballSize:20];
                    self.chenshiSwit.tag = 99991;
                    if ([self.selectedPushTimesSet containsObject:@"7"]) {
                        [self.chenshiSwit setOn:YES];
                    }else{
                        [self.chenshiSwit setOn:NO];
                    }
                    
                    [self.chenshiSwit addTarget:self action:@selector(pushSettingCellSwit:) forControlEvents:UIControlEventValueChanged];
                    
                    [cell.contentView addSubview:self.chenshiSwit];
                    
                    //                NSString *timeStr = self.timeArray[indexPath.row];
                    //                NSString *meridianStr = self.meridianArray[indexPath.row];
                    //                [cell renderPushSettingCellWithTime:timeStr withMeridian:meridianStr];
                    UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(general_margin, 44, screen_width-general_margin, splite_line_height)];
                    downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
                    [cell.contentView addSubview:downLine];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                UITableViewCell *cell = [UITableViewCell new];
                return cell;
            }
            
        }else if (indexPath.row == 2){
            if ([AppStatus sharedInstance].user.receivePush == YES && [AppStatus sharedInstance].customSwitch == YES) {
                //                static NSString *pushSettingCell2Identifier = @"pushSettingCell2";
                //                UINib *nib = [UINib nibWithNibName:@"PushSettingCell" bundle:nil];
                //                [self.tableView registerNib:nib forCellReuseIdentifier:pushSettingCell2Identifier];
                //                PushSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:pushSettingCell2Identifier forIndexPath:indexPath];
                static NSString *sishiCellIdentifier = @"sishiCell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sishiCellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sishiCellIdentifier];
                    
                    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(general_margin, 0, 130, 45)];
                    lab.text = @"巳时9:00-11:00";
                    lab.font = [UIFont systemFontOfSize:default_font_size];
                    lab.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
                    [cell.contentView addSubview:lab];
                    
                    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(145, 0, 83, 45)];
                    timeLab.text = @"脾经当令";
                    timeLab.font = [UIFont systemFontOfSize:smaller_font_size];
                    timeLab.textColor = [ColorUtils colorWithHexString:gray_text_color];
                    [cell.contentView addSubview:timeLab];
                    
                    
                    
                    self.sishiSwit = [[LQXSwitch alloc] initWithFrame:CGRectMake(screen_width-15-48, (45-23)/2, 48, 23) onColor:[ColorUtils colorWithHexString:common_app_text_color] offColor:[ColorUtils colorWithHexString:splite_line_color] font:[UIFont systemFontOfSize:default_font_size] ballSize:20];
                    self.sishiSwit.tag = 99992;
                    if ([self.selectedPushTimesSet containsObject:@"9"]) {
                        [self.sishiSwit setOn:YES];
                    }else{
                        [self.sishiSwit setOn:NO];
                    }
                    
                    [self.sishiSwit addTarget:self action:@selector(pushSettingCellSwit:) forControlEvents:UIControlEventValueChanged];
                    
                    [cell.contentView addSubview:self.sishiSwit];
                    UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(general_margin, 44, screen_width-general_margin, splite_line_height)];
                    downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
                    [cell.contentView addSubview:downLine];
                    
                    //                NSString *timeStr = self.timeArray[indexPath.row];
                    //                NSString *meridianStr = self.meridianArray[indexPath.row];
                    //                [cell renderPushSettingCellWithTime:timeStr withMeridian:meridianStr];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                UITableViewCell *cell = [UITableViewCell new];
                return cell;
            }
            
        }else if (indexPath.row == 3){
            if ([AppStatus sharedInstance].user.receivePush == YES && [AppStatus sharedInstance].customSwitch == YES) {
                //                static NSString *pushSettingCell3Identifier = @"pushSettingCell3";
                //                UINib *nib = [UINib nibWithNibName:@"PushSettingCell" bundle:nil];
                //                [self.tableView registerNib:nib forCellReuseIdentifier:pushSettingCell3Identifier];
                //                PushSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:pushSettingCell3Identifier forIndexPath:indexPath];
                static NSString *wushiCellIdentifier = @"wushiCell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:wushiCellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wushiCellIdentifier];
                    
                    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(general_margin, 0, 130, 45)];
                    lab.text = @"午时11:00-13:00";
                    lab.font = [UIFont systemFontOfSize:default_font_size];
                    lab.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
                    [cell.contentView addSubview:lab];
                    
                    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(145, 0, 83, 45)];
                    timeLab.text = @"心经当令";
                    timeLab.font = [UIFont systemFontOfSize:smaller_font_size];
                    timeLab.textColor = [ColorUtils colorWithHexString:gray_text_color];
                    [cell.contentView addSubview:timeLab];
                    
                    
                    self.wushiSwit = [[LQXSwitch alloc] initWithFrame:CGRectMake(screen_width-15-48, (45-23)/2, 48, 23) onColor:[ColorUtils colorWithHexString:common_app_text_color] offColor:[ColorUtils colorWithHexString:splite_line_color] font:[UIFont systemFontOfSize:default_font_size] ballSize:20];
                    self.wushiSwit.tag = 99993;
                    if ([self.selectedPushTimesSet containsObject:@"11"]) {
                        [self.wushiSwit setOn:YES];
                    }else{
                        [self.wushiSwit setOn:NO];
                    }
                    
                    [self.wushiSwit addTarget:self action:@selector(pushSettingCellSwit:) forControlEvents:UIControlEventValueChanged];
                    
                    [cell.contentView addSubview:self.wushiSwit];
                    UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(general_margin, 44, screen_width-general_margin, splite_line_height)];
                    downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
                    [cell.contentView addSubview:downLine];
                    
                    //                NSString *timeStr = self.timeArray[indexPath.row];
                    //                NSString *meridianStr = self.meridianArray[indexPath.row];
                    //                [cell renderPushSettingCellWithTime:timeStr withMeridian:meridianStr];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                UITableViewCell *cell = [UITableViewCell new];
                return cell;
            }
            
        }else if (indexPath.row == 4){
            if ([AppStatus sharedInstance].user.receivePush == YES && [AppStatus sharedInstance].customSwitch == YES) {
                //                static NSString *pushSettingCell4Identifier = @"pushSettingCell4";
                //                UINib *nib = [UINib nibWithNibName:@"PushSettingCell" bundle:nil];
                //                [self.tableView registerNib:nib forCellReuseIdentifier:pushSettingCell4Identifier];
                //                PushSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:pushSettingCell4Identifier forIndexPath:indexPath];
                static NSString *weishiCellIdentifier = @"weishiCell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:weishiCellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:weishiCellIdentifier];
                    
                    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(general_margin, 0, 130, 45)];
                    lab.text = @"午时13:00-15:00";
                    lab.font = [UIFont systemFontOfSize:default_font_size];
                    lab.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
                    [cell.contentView addSubview:lab];
                    
                    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(145, 0, 83, 45)];
                    timeLab.text = @"小肠经当令";
                    timeLab.font = [UIFont systemFontOfSize:smaller_font_size];
                    timeLab.textColor = [ColorUtils colorWithHexString:gray_text_color];
                    [cell.contentView addSubview:timeLab];
                    
                    
                    self.weishiSwit = [[LQXSwitch alloc] initWithFrame:CGRectMake(screen_width-15-48, (45-23)/2, 48, 23) onColor:[ColorUtils colorWithHexString:common_app_text_color] offColor:[ColorUtils colorWithHexString:splite_line_color] font:[UIFont systemFontOfSize:default_font_size] ballSize:20];
                    self.weishiSwit.tag = 99994;
                    if ([self.selectedPushTimesSet containsObject:@"13"]) {
                        [self.weishiSwit setOn:YES];
                    }else{
                        [self.weishiSwit setOn:NO];
                    }
                    [self.weishiSwit addTarget:self action:@selector(pushSettingCellSwit:) forControlEvents:UIControlEventValueChanged];
                    
                    [cell.contentView addSubview:self.weishiSwit];
                    UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(general_margin, 44, screen_width-general_margin, splite_line_height)];
                    downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
                    [cell.contentView addSubview:downLine];
                    
                    //                NSString *timeStr = self.timeArray[indexPath.row];
                    //                NSString *meridianStr = self.meridianArray[indexPath.row];
                    //                [cell renderPushSettingCellWithTime:timeStr withMeridian:meridianStr];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                UITableViewCell *cell = [UITableViewCell new];
                return cell;
            }
            
        }else if (indexPath.row == 5){
            if ([AppStatus sharedInstance].user.receivePush == YES && [AppStatus sharedInstance].customSwitch == YES) {
                //                static NSString *pushSettingCell5Identifier = @"pushSettingCell5";
                //                UINib *nib = [UINib nibWithNibName:@"PushSettingCell" bundle:nil];
                //                [self.tableView registerNib:nib forCellReuseIdentifier:pushSettingCell5Identifier];
                //                PushSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:pushSettingCell5Identifier forIndexPath:indexPath];
                static NSString *shenshiCellIdentifier = @"shenshiCell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shenshiCellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shenshiCellIdentifier];
                    
                    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(general_margin, 0, 130, 45)];
                    lab.text = @"申时15:00-17:00";
                    lab.font = [UIFont systemFontOfSize:default_font_size];
                    lab.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
                    [cell.contentView addSubview:lab];
                    
                    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(145, 0, 83, 45)];
                    timeLab.text = @"膀胱经当令";
                    timeLab.font = [UIFont systemFontOfSize:smaller_font_size];
                    timeLab.textColor = [ColorUtils colorWithHexString:gray_text_color];
                    [cell.contentView addSubview:timeLab];
                    
                    
                    self.shenshiSwit = [[LQXSwitch alloc] initWithFrame:CGRectMake(screen_width-15-48, (45-23)/2, 48, 23) onColor:[ColorUtils colorWithHexString:common_app_text_color] offColor:[ColorUtils colorWithHexString:splite_line_color] font:[UIFont systemFontOfSize:default_font_size] ballSize:20];
                    self.shenshiSwit.tag = 99995;
                    if ([self.selectedPushTimesSet containsObject:@"15"]) {
                        [self.shenshiSwit setOn:YES];
                    }else{
                        [self.shenshiSwit setOn:NO];
                    }
                    [self.shenshiSwit addTarget:self action:@selector(pushSettingCellSwit:) forControlEvents:UIControlEventValueChanged];
                    
                    [cell.contentView addSubview:self.shenshiSwit];
                    UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(general_margin, 44, screen_width-general_margin, splite_line_height)];
                    downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
                    [cell.contentView addSubview:downLine];
                    //                NSString *timeStr = self.timeArray[indexPath.row];
                    //                NSString *meridianStr = self.meridianArray[indexPath.row];
                    //                [cell renderPushSettingCellWithTime:timeStr withMeridian:meridianStr];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                UITableViewCell *cell = [UITableViewCell new];
                return cell;
            }
            
        }else if (indexPath.row == 6){
            if ([AppStatus sharedInstance].user.receivePush == YES && [AppStatus sharedInstance].customSwitch == YES) {
                //                static NSString *pushSettingCell6Identifier = @"pushSettingCell6";
                //                UINib *nib = [UINib nibWithNibName:@"PushSettingCell" bundle:nil];
                //                [self.tableView registerNib:nib forCellReuseIdentifier:pushSettingCell6Identifier];
                //                PushSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:pushSettingCell6Identifier forIndexPath:indexPath];
                static NSString *youshiCellIdentifier = @"youshiCell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:youshiCellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:youshiCellIdentifier];
                    
                    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(general_margin, 0, 130, 45)];
                    lab.text = @"酉时17:00-19:00";
                    lab.font = [UIFont systemFontOfSize:default_font_size];
                    lab.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
                    [cell.contentView addSubview:lab];
                    
                    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(145, 0, 83, 45)];
                    timeLab.text = @"肾经当令";
                    timeLab.font = [UIFont systemFontOfSize:smaller_font_size];
                    timeLab.textColor = [ColorUtils colorWithHexString:gray_text_color];
                    [cell.contentView addSubview:timeLab];
                    
                    
                    
                    self.youshiSwit = [[LQXSwitch alloc] initWithFrame:CGRectMake(screen_width-15-48, (45-23)/2, 48, 23) onColor:[ColorUtils colorWithHexString:common_app_text_color] offColor:[ColorUtils colorWithHexString:splite_line_color] font:[UIFont systemFontOfSize:default_font_size] ballSize:20];
                    self.youshiSwit.tag = 99996;
                    if ([self.selectedPushTimesSet containsObject:@"17"]) {
                        [self.youshiSwit setOn:YES];
                    }else{
                        [self.youshiSwit setOn:NO];
                    }
                    
                    [self.youshiSwit addTarget:self action:@selector(pushSettingCellSwit:) forControlEvents:UIControlEventValueChanged];
                    
                    [cell.contentView addSubview:self.youshiSwit];
                    UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(general_margin, 44, screen_width-general_margin, splite_line_height)];
                    downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
                    [cell.contentView addSubview:downLine];
                    //                NSString *timeStr = self.timeArray[indexPath.row];
                    //                NSString *meridianStr = self.meridianArray[indexPath.row];
                    //                [cell renderPushSettingCellWithTime:timeStr withMeridian:meridianStr];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                UITableViewCell *cell = [UITableViewCell new];
                return cell;
            }
            
        }else if (indexPath.row == 7){
            if ([AppStatus sharedInstance].user.receivePush == YES && [AppStatus sharedInstance].customSwitch == YES) {
                //                static NSString *pushSettingCell7Identifier = @"pushSettingCell7";
                //                UINib *nib = [UINib nibWithNibName:@"PushSettingCell" bundle:nil];
                //                [self.tableView registerNib:nib forCellReuseIdentifier:pushSettingCell7Identifier];
                //                PushSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:pushSettingCell7Identifier forIndexPath:indexPath];
                static NSString *xushiCellIdentifier = @"xushiCell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:xushiCellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:xushiCellIdentifier];
                    
                    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(general_margin, 0, 130, 45)];
                    lab.text = @"戌时19:00-21:00";
                    lab.font = [UIFont systemFontOfSize:default_font_size];
                    lab.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
                    [cell.contentView addSubview:lab];
                    
                    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(145, 0, 83, 45)];
                    timeLab.text = @"心包经当令";
                    timeLab.font = [UIFont systemFontOfSize:smaller_font_size];
                    timeLab.textColor = [ColorUtils colorWithHexString:gray_text_color];
                    [cell.contentView addSubview:timeLab];
                    
                    self.xushiSwit = [[LQXSwitch alloc] initWithFrame:CGRectMake(screen_width-15-48, (45-23)/2, 48, 23) onColor:[ColorUtils colorWithHexString:common_app_text_color] offColor:[ColorUtils colorWithHexString:splite_line_color] font:[UIFont systemFontOfSize:default_font_size] ballSize:20];
                    self.xushiSwit.tag = 99997;
                    if ([self.selectedPushTimesSet containsObject:@"19"]) {
                        [self.xushiSwit setOn:YES];
                    }else{
                        [self.xushiSwit setOn:NO];
                    }
                    [self.xushiSwit addTarget:self action:@selector(pushSettingCellSwit:) forControlEvents:UIControlEventValueChanged];
                    
                    [cell.contentView addSubview:self.xushiSwit];
                    UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(general_margin, 44, screen_width-general_margin, splite_line_height)];
                    downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
                    [cell.contentView addSubview:downLine];
                    //                NSString *timeStr = self.timeArray[indexPath.row];
                    //                NSString *meridianStr = self.meridianArray[indexPath.row];
                    //                [cell renderPushSettingCellWithTime:timeStr withMeridian:meridianStr];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                UITableViewCell *cell = [UITableViewCell new];
                return cell;
            }
            
        }else if (indexPath.row == 8){
            if ([AppStatus sharedInstance].user.receivePush == YES && [AppStatus sharedInstance].customSwitch == YES) {
                //                static NSString *pushSettingCell8Identifier = @"pushSettingCell8";
                //                UINib *nib = [UINib nibWithNibName:@"PushSettingCell" bundle:nil];
                //                [self.tableView registerNib:nib forCellReuseIdentifier:pushSettingCell8Identifier];
                //                PushSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:pushSettingCell8Identifier forIndexPath:indexPath];
                static NSString *haishiCellIdentifier = @"haishiCell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:haishiCellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:haishiCellIdentifier];
                    
                    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(general_margin, 0, 130, 45)];
                    lab.text = @"亥时21:00-23:00";
                    lab.font = [UIFont systemFontOfSize:default_font_size];
                    lab.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
                    [cell.contentView addSubview:lab];
                    
                    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(145, 0, 83, 45)];
                    timeLab.text = @"三焦经当令";
                    timeLab.font = [UIFont systemFontOfSize:smaller_font_size];
                    timeLab.textColor = [ColorUtils colorWithHexString:gray_text_color];
                    [cell.contentView addSubview:timeLab];
                    
                    
                    self.haishiSwit = [[LQXSwitch alloc] initWithFrame:CGRectMake(screen_width-15-48, (45-23)/2, 48, 23) onColor:[ColorUtils colorWithHexString:common_app_text_color] offColor:[ColorUtils colorWithHexString:splite_line_color] font:[UIFont systemFontOfSize:default_font_size] ballSize:20];
                    self.haishiSwit.tag = 99998;
                    if ([self.selectedPushTimesSet containsObject:@"21"]) {
                        [self.haishiSwit setOn:YES];
                    }else{
                        [self.haishiSwit setOn:NO];
                    }
                    
                    [self.haishiSwit addTarget:self action:@selector(pushSettingCellSwit:) forControlEvents:UIControlEventValueChanged];
                    
                    [cell.contentView addSubview:self.haishiSwit];
                    UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(general_margin, 44, screen_width-general_margin, splite_line_height)];
                    downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
                    [cell.contentView addSubview:downLine];
                    //                NSString *timeStr = self.timeArray[indexPath.row];
                    //                NSString *meridianStr = self.meridianArray[indexPath.row];
                    //                [cell renderPushSettingCellWithTime:timeStr withMeridian:meridianStr];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            else{
                UITableViewCell *cell = [UITableViewCell new];
                return cell;
            }
            
        }else if (indexPath.row == 9){
            if ([AppStatus sharedInstance].user.receivePush == YES && [AppStatus sharedInstance].customSwitch == YES) {
                //                static NSString *pushSettingCell9Identifier = @"pushSettingCell9";
                //                UINib *nib = [UINib nibWithNibName:@"PushSettingCell" bundle:nil];
                //                [self.tableView registerNib:nib forCellReuseIdentifier:pushSettingCell9Identifier];
                //                PushSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:pushSettingCell9Identifier forIndexPath:indexPath];
                static NSString *zishiCellIdentifier = @"zishiCell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:zishiCellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:zishiCellIdentifier];
                    
                    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(general_margin, 0, 130, 45)];
                    lab.text = @"子时23:00-1:00";
                    lab.font = [UIFont systemFontOfSize:default_font_size];
                    lab.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
                    [cell.contentView addSubview:lab];
                    
                    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(145, 0, 83, 45)];
                    timeLab.text = @"胆经当令";
                    timeLab.font = [UIFont systemFontOfSize:smaller_font_size];
                    timeLab.textColor = [ColorUtils colorWithHexString:gray_text_color];
                    [cell.contentView addSubview:timeLab];
                    
                    
                    self.zishiSwit = [[LQXSwitch alloc] initWithFrame:CGRectMake(screen_width-15-48, (45-23)/2, 48, 23) onColor:[ColorUtils colorWithHexString:common_app_text_color] offColor:[ColorUtils colorWithHexString:splite_line_color] font:[UIFont systemFontOfSize:default_font_size] ballSize:20];
                    self.zishiSwit.tag = 99999;
                    if ([self.selectedPushTimesSet containsObject:@"23"]) {
                        [self.zishiSwit setOn:YES];
                    }else{
                        [self.zishiSwit setOn:NO];
                    }
                    
                    [self.zishiSwit addTarget:self action:@selector(pushSettingCellSwit:) forControlEvents:UIControlEventValueChanged];
                    
                    [cell.contentView addSubview:self.zishiSwit];
                    UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(general_margin, 44, screen_width-general_margin, splite_line_height)];
                    downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
                    [cell.contentView addSubview:downLine];
                    //                NSString *timeStr = self.timeArray[indexPath.row];
                    //                NSString *meridianStr = self.meridianArray[indexPath.row];
                    //                [cell renderPushSettingCellWithTime:timeStr withMeridian:meridianStr];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                UITableViewCell *cell = [UITableViewCell new];
                return cell;
            }
            
        }else{
            UITableViewCell *cell = [UITableViewCell new];
            return cell;
        }
    }else{
        UITableViewCell *cell = [UITableViewCell new];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 49;
    } else if (indexPath.section == 1){
        if ([AppStatus sharedInstance].user.receivePush == YES) {
            return 49;
        }else{
            return 0;
        }
    }
    else if (indexPath.section == 2){
        if ([AppStatus sharedInstance].user.receivePush == YES) {
            return 52;
        }else{
            return 0;
        }
    }
    else if (indexPath.section == 3){
        if ([AppStatus sharedInstance].user.receivePush == YES &&[AppStatus sharedInstance].customSwitch == YES) {
            return 45;
        }else{
            return 0;
        }
    }
    else{
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didPushTotalCellSwit:(LQXSwitch *)sender{
    NSLog(@">>>>>>>>>>>>>>sender.superview.superview)>>>>>>>%@",sender.superview.superview);
    BOOL isButtonOn = [sender isOn];
    //    [PushSwitchStatus sharedInstance].totalSwitch = isButtonOn;
    if (isButtonOn == NO) {
        [AppStatus sharedInstance].user.receivePush = NO;
        [AppStatus saveAppStatus];
        [AppStatus sharedInstance].defaultSwitch = NO;
        [AppStatus sharedInstance].customSwitch = NO;
        [self.selectedPushTimesSet removeAllObjects];
        [FunctionUtils clearAllLocalNotifi];
        NSArray *array = @[];
        [self.selectedPushTimesSet addObjectsFromArray:array];
        [self updateUserInfoByPushTimes:[array componentsJoinedByString:@","]];
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:1];
        NSIndexSet *indexSet2 = [NSIndexSet indexSetWithIndex:2];
        NSIndexSet *indexSet3 = [NSIndexSet indexSetWithIndex:3];
        
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView reloadSections:indexSet2 withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView reloadSections:indexSet3 withRowAnimation:UITableViewRowAnimationNone];
    }else{
        [AppStatus sharedInstance].user.receivePush = YES;
        [AppStatus sharedInstance].defaultSwitch = YES;
        [AppStatus sharedInstance].customSwitch = NO;
        [AppStatus saveAppStatus];
        [self.defaultSwitch setOn:YES];
        [self.customSwit setOn:NO];
        NSArray *array = @[@"7",@"9",@"11",@"13",@"15",@"17",@"19"];
        [self.selectedPushTimesSet addObjectsFromArray:array];
        [FunctionUtils startDefaultNotifi];
        [self updateUserInfoByPushTimes:[array componentsJoinedByString:@","]];
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:1];
        NSIndexSet *indexSet2 = [NSIndexSet indexSetWithIndex:2];
        
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView reloadSections:indexSet2 withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)didPushDefaultCellSwit:(LQXSwitch *)sender{
    BOOL isButtonOn = [sender isOn];
    [AppStatus sharedInstance].defaultSwitch = isButtonOn;
    if (isButtonOn == YES && [AppStatus sharedInstance].user.receivePush == YES) {
        [AppStatus sharedInstance].defaultSwitch = YES;
        [AppStatus sharedInstance].customSwitch = NO;
        [AppStatus saveAppStatus];
        [self.customSwit setOn:NO];
        [self.selectedPushTimesSet removeAllObjects];
        NSArray *array = @[@"7",@"9",@"11",@"13",@"15",@"17",@"19"];
        [self.selectedPushTimesSet addObjectsFromArray:array];
        [FunctionUtils startDefaultNotifi];
        [self updateUserInfoByPushTimes:[array componentsJoinedByString:@","]];

    }else{
        [self.selectedPushTimesSet removeAllObjects];
        AppStatus *as = [AppStatus sharedInstance];
        as.defaultSwitch = NO;
        as.customSwitch = YES;
        [self.customSwit setOn:YES];
        [self.maoshiSwit setOn:NO];
        [self.chenshiSwit setOn:YES];
        [self.sishiSwit setOn:YES];
        [self.wushiSwit setOn:YES];
        [self.weishiSwit setOn:YES];
        [self.shenshiSwit setOn:YES];
        [self.youshiSwit setOn:YES];
        [self.xushiSwit setOn:YES];
        [self.haishiSwit setOn:NO];
        [self.zishiSwit setOn:NO];
        
        NSArray *array = @[@"7",@"9",@"11",@"13",@"15",@"17",@"19"];
        as.user.pushTimes = [array componentsJoinedByString:@","];
        [AppStatus saveAppStatus];
        [self.selectedPushTimesSet addObjectsFromArray:array];
        [FunctionUtils startDefaultNotifi];
        NSLog(@">>>>>pushTimesStrArray>>>>>>%@",array);
        [self updateUserInfoByPushTimes:[array componentsJoinedByString:@","]];
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:3];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        
    }
}

- (void)customSwitClick:(LQXSwitch *)customSwit
{
    NSLog(@">>>>>>>>点击了自定义时间>>>>>>");
    BOOL isButtonOn = [customSwit isOn];
    NSLog(@">>>>>>自定义>>>>>>>>>>>>>>>%d",isButtonOn);
    [AppStatus sharedInstance].customSwitch = isButtonOn;
    if (isButtonOn == YES && [AppStatus sharedInstance].user.receivePush == YES) {
        [self.selectedPushTimesSet removeAllObjects];
        [AppStatus sharedInstance].defaultSwitch = NO;
        [AppStatus sharedInstance].customSwitch = YES;
        AppStatus *as = [AppStatus sharedInstance];
        as.user.pushTimes = @"";
        [AppStatus saveAppStatus];
        [self.defaultSwitch setOn:NO];
        [FunctionUtils startCustomNotifiByTimes:nil];
        [self updateUserInfoByPushTimes:as.user.pushTimes];
        [self.maoshiSwit setOn:NO];
        [self.chenshiSwit setOn:YES];
        [self.sishiSwit setOn:YES];
        [self.wushiSwit setOn:YES];
        [self.weishiSwit setOn:YES];
        [self.shenshiSwit setOn:YES];
        [self.youshiSwit setOn:YES];
        [self.xushiSwit setOn:YES];
        [self.haishiSwit setOn:NO];
        [self.zishiSwit setOn:NO];
        
        NSArray *array = @[@"7",@"9",@"11",@"13",@"15",@"17",@"19"];
        as.user.pushTimes = [array componentsJoinedByString:@","];
        [AppStatus saveAppStatus];
        [self.selectedPushTimesSet addObjectsFromArray:array];
        NSLog(@">>>>>pushTimesStrArray>>>>>>%@",array);
        [self updateUserInfoByPushTimes:[array componentsJoinedByString:@","]];
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:3];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    }else{
        
        [AppStatus sharedInstance].defaultSwitch = YES;
        [AppStatus sharedInstance].customSwitch = NO;
        [AppStatus saveAppStatus];
        [self.defaultSwitch setOn:YES];
        [self.selectedPushTimesSet removeAllObjects];
        NSArray *array = @[@"7",@"9",@"11",@"13",@"15",@"17",@"19"];
        [self.selectedPushTimesSet addObjectsFromArray:array];
//        NSLog(@">>>>>selectedPushTimesSet开启默认>>>>>>%@",self.selectedPushTimesSet);
        [FunctionUtils startDefaultNotifi];
        
        AppStatus *as = [AppStatus sharedInstance];
        as.user.pushTimes = [array componentsJoinedByString:@","];
        [AppStatus saveAppStatus];
        NSLog(@">>>>>pushTimesStrArray>>>>>>%@",array);
        [self updateUserInfoByPushTimes:[array componentsJoinedByString:@","]];
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:3];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)pushSettingCellSwit:(LQXSwitch *)sender{
    PushSettingCell *cell = (PushSettingCell *)sender.superview.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSLog(@">>>>>>>>>>>>sender.superview.superview.superview>>>>>>>>>>>>%@---%ld--%ld",sender.superview.superview,(long)indexPath.section,(long)sender.tag);
    switch (sender.tag) {
        case 99990:
        {
            BOOL isButtonOn = [sender isOn];
            NSLog(@">>>>>>>>>>>>maoshiSwitch>>isButtonOn>>>>>>>>>>>>%d",isButtonOn);
            if (isButtonOn == YES) {
                [self.selectedPushTimesSet addObject:@"5"];
            
                [FunctionUtils scheduleLocalNotification:@"05:01" notificationId:@"notificationId5" content:[FunctionUtils getAcupointByTimeStr:@"5"]];
            }else{
                [self.selectedPushTimesSet removeObject:@"5"];
                [FunctionUtils removeLocalNotification:@"notificationId5"];
            }
        }
            break;
        case 99991:
        {
            BOOL isButtonOn = [sender isOn];
            if (isButtonOn == YES) {
                [self.selectedPushTimesSet addObject:@"7"];
                [FunctionUtils scheduleLocalNotification:@"07:01" notificationId:@"notificationId7" content:[FunctionUtils getAcupointByTimeStr:@"7"]];
            }else{
                [self.selectedPushTimesSet removeObject:@"7"];
                [FunctionUtils removeLocalNotification:@"notificationId7"];
            }
        }
            break;
        case 99992:
        {
            BOOL isButtonOn = [sender isOn];
            if (isButtonOn == YES) {
                [self.selectedPushTimesSet addObject:@"9"];
                [FunctionUtils scheduleLocalNotification:@"09:01" notificationId:@"notificationId9" content:[FunctionUtils getAcupointByTimeStr:@"9"]];
            }else{
                [self.selectedPushTimesSet removeObject:@"9"];
                [FunctionUtils removeLocalNotification:@"notificationId9"];
            }
        }
            break;
        case 99993:
        {
            BOOL isButtonOn = [sender isOn];
            if (isButtonOn == YES) {
                [self.selectedPushTimesSet addObject:@"11"];
               
                [FunctionUtils scheduleLocalNotification:@"11:01" notificationId:@"notificationId11" content:[FunctionUtils getAcupointByTimeStr:@"11"]];
            }else{
                [self.selectedPushTimesSet removeObject:@"11"];
                [FunctionUtils removeLocalNotification:@"notificationId11"];
            }
        }
            break;
        case 99994:
        {
            BOOL isButtonOn = [sender isOn];
            if (isButtonOn == YES) {
                [self.selectedPushTimesSet addObject:@"13"];
               
                [FunctionUtils scheduleLocalNotification:@"13:01" notificationId:@"notificationId13" content:[FunctionUtils getAcupointByTimeStr:@"13"]];
            }else{
                [self.selectedPushTimesSet removeObject:@"13"];
                [FunctionUtils removeLocalNotification:@"notificationId13"];
            }
            
        }
            break;
        case 99995:
        {
            BOOL isButtonOn = [sender isOn];
            if (isButtonOn == YES) {
                [self.selectedPushTimesSet addObject:@"15"];
               
                [FunctionUtils scheduleLocalNotification:@"15:01" notificationId:@"notificationId15" content:[FunctionUtils getAcupointByTimeStr:@"15"]];
            }else{
                [self.selectedPushTimesSet removeObject:@"15"];
                [FunctionUtils removeLocalNotification:@"notificationId15"];
            }
        }
            break;
        case 99996:
        {
            BOOL isButtonOn = [sender isOn];
            if (isButtonOn == YES) {
                [self.selectedPushTimesSet addObject:@"17"];
                
                [FunctionUtils scheduleLocalNotification:@"17:01" notificationId:@"notificationId17" content:[FunctionUtils getAcupointByTimeStr:@"17"]];
            }else{
                [self.selectedPushTimesSet removeObject:@"17"];
                [FunctionUtils removeLocalNotification:@"notificationId17"];
            }
        }
            break;
        case 99997:
        {
            BOOL isButtonOn = [sender isOn];
            if (isButtonOn == YES) {
                [self.selectedPushTimesSet addObject:@"19"];
                
                [FunctionUtils scheduleLocalNotification:@"19:01" notificationId:@"notificationId19" content:[FunctionUtils getAcupointByTimeStr:@"19"]];
            }else{
                [self.selectedPushTimesSet removeObject:@"19"];
                [FunctionUtils removeLocalNotification:@"notificationId19"];
            }
        }
            break;
        case 99998:
        {
            BOOL isButtonOn = [sender isOn];
            if (isButtonOn == YES) {
                [self.selectedPushTimesSet addObject:@"21"];
               
                [FunctionUtils scheduleLocalNotification:@"21:01" notificationId:@"notificationId21" content:[FunctionUtils getAcupointByTimeStr:@"21"]];
            }else{
                [self.selectedPushTimesSet removeObject:@"21"];
                [FunctionUtils removeLocalNotification:@"notificationId21"];
            }
        }
            break;
        case 99999:
        {
            BOOL isButtonOn = [sender isOn];
            if (isButtonOn == YES) {
                [self.selectedPushTimesSet addObject:@"23"];
                
                [FunctionUtils scheduleLocalNotification:@"23:01" notificationId:@"notificationId23" content:[FunctionUtils getAcupointByTimeStr:@"23"]];
            }else{
                [self.selectedPushTimesSet removeObject:@"23"];
                [FunctionUtils removeLocalNotification:@"notificationId23"];
            }
        }
            break;
            
        default:
            break;
    }
    NSMutableArray *pushTimesStrArray = [NSMutableArray new];
    for (NSObject *obj in self.selectedPushTimesSet) {
        [pushTimesStrArray addObject:obj];
        NSLog(@"%@",obj);
    }
    NSLog(@">>>>>pushTimesStrArray>>>>>>%@",pushTimesStrArray);
    [self updateUserInfoByPushTimes:[pushTimesStrArray componentsJoinedByString:@","]];
}

- (void)updateUserInfoByPushTimes:(NSString *)pushTimes{
    [SVProgressHUD show];
    [[UserStore sharedStore] updateUserInfo:^(User *user, NSError *err) {
        [SVProgressHUD dismiss];
        if (user != nil) {
            NSLog(@">>>>>>>user.avatarUrl>>>>>>>>>%@",user);
        }else{
            
        }
    } userId:[AppStatus sharedInstance].user.id
                                       name:[AppStatus sharedInstance].user.name
                                  avatarUrl:[AppStatus sharedInstance].user.avatarUrl
                                 userGender:[AppStatus sharedInstance].user.userGender
                                userSetCity:[AppStatus sharedInstance].user.userSetCity
                                 userRoleId:[AppStatus sharedInstance].user.userRoleId
                                receivePush:[AppStatus sharedInstance].user.receivePush
                                  pushTimes:pushTimes
                                    userJob:[AppStatus sharedInstance].user.userJob
                                   userType:[AppStatus sharedInstance].user.userType
                                   realName:[AppStatus sharedInstance].user.realName
                                  birthCity:[AppStatus sharedInstance].user.birthCity
                                  userMarry:[AppStatus sharedInstance].user.userMarry
                                   birthday:[AppStatus sharedInstance].user.birthday
                                 userHeight:[AppStatus sharedInstance].user.userHeight
                                 userWeight:[AppStatus sharedInstance].user.userWeight
                                   userIDNo:[AppStatus sharedInstance].user.userIDNo
                         pastMedicalHistory:[AppStatus sharedInstance].user.pastMedicalHistory];
    
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
