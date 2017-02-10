//
//  SettingSportTargetController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/15.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "SettingSportTargetController.h"
#import "CDAlertViewController.h"
@interface SettingSportTargetController ()

@end

@implementation SettingSportTargetController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    UIImage *bgImg = [UIImage imageNamed:@"bg_exercise"];
    self.view.layer.contents = (id) bgImg.CGImage;
    self.targetNumArray = @[@"6000",@"8000",@"10,000",@"12,000",@"14,000",@"16,000",@"18,000",@"20,000",@"22,000",@"24,000",@"其他"];
    self.currentItem = -1;
    self.previousItem = 0;
    [self initHeadView];
    [self initTopRemindView];
    [self initTableView];
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"设定运动目标" navigationController:self.navigationController];
    self.headerView.bgImg.hidden = YES;
    self.headerView.line.hidden = YES;
    self.headerView.backgroundColor = [UIColor clearColor];
    [self.headerView.backBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.headerView.backBut setImage:[UIImage imageNamed:@"icon_shop_back"] forState:UIControlStateNormal];
    self.headerView.title.textColor = [UIColor whiteColor];
    [self.view addSubview:self.headerView];
    
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(screen_width-10-44, 20, 44, 44);
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:default_font_size];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightConfirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:rightBtn];

}

- (void)initTopRemindView{
    self.remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, self.headerView.frame.size.height+45, screen_width-80, 30)];
    self.remindLabel.textColor = [ColorUtils colorWithHexString:lighter_2_brown_color];
    self.remindLabel.font = [UIFont systemFontOfSize:small_font_size];
    self.remindLabel.textAlignment = NSTextAlignmentCenter;
    self.remindLabel.text = @"根据世界卫生组织的建议，你每天需要中等强度的运动40分钟，相当于快走8000步";
    self.remindLabel.numberOfLines = 0;
    [self.view addSubview:self.remindLabel];
}

//初始化tableview
-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(40, self.remindLabel.frame.size.height+self.remindLabel.frame.origin.y+20, screen_width-80,screen_height-self.headerView.frame.size.height-self.remindLabel.frame.size.height-20-45) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark - tableViewDelegate and datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIndetifier = [NSString stringWithFormat:@"cell%d",(int)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifier];
        cell.textLabel.text = self.targetNumArray[indexPath.row];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [ColorUtils colorWithHexString:@"#b4b4b4"];
        cell.textLabel.font = [UIFont systemFontOfSize:24];
//        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
//        cell.backgroundView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *realStepStr= [NSString stringWithFormat:@"%@步",self.targetNumArray[indexPath.row]];
        UILabel *remindTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 100, 25)];
        remindTitleLabel.text = [NSString stringWithFormat:@"美国建议\n%@",realStepStr];
        remindTitleLabel.font = [UIFont systemFontOfSize:9];
        remindTitleLabel.textColor = [ColorUtils colorWithHexString:@"#faefde"];
        remindTitleLabel.textAlignment = NSTextAlignmentLeft;
        remindTitleLabel.tag = indexPath.row + 888880;
        remindTitleLabel.numberOfLines = 0;
        remindTitleLabel.hidden = YES;
        [cell.contentView addSubview:remindTitleLabel];
   
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.previousItem = self.currentItem;
    self.currentItem = (int)indexPath.row;
    if (indexPath.row == 10) {
        [self initOtherTargetNum];
    }else{
        if (self.previousItem != self.currentItem) {
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
        for (NSInteger i=0; i<11; i++) {
            if (i==self.currentItem) {
                NSIndexPath *indexPath1 = [NSIndexPath indexPathForItem:i inSection:0];
                UITableViewCell *cell = (UITableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath1];
                cell.textLabel.font = [UIFont systemFontOfSize:30];
                NSString *realStepStr= [NSString stringWithFormat:@"%@步",self.targetNumArray[indexPath.row]];
                int start = (int)[realStepStr rangeOfString:[NSString stringWithFormat:@"%@",@"步"]].location;
                int length = (int)[realStepStr rangeOfString:[NSString stringWithFormat:@"%@",@"步"]].length;
                NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:realStepStr];
                [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(start,length)];
                cell.textLabel.attributedText = attributedText;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                cell.textLabel.textColor = [UIColor whiteColor];
                cell.textLabel.backgroundColor = [UIColor clearColor];
                cell.contentView.backgroundColor = [ColorUtils colorWithHexString:@"#ffffff" alpha:0.1];
                cell.contentView.layer.cornerRadius = 2;
                cell.contentView.layer.masksToBounds = YES;
                if (i == 2) {
                    UILabel *label = (UILabel *)[cell.contentView viewWithTag:self.currentItem+888880];
                    label.hidden = NO;
                }else{
                    UILabel *label = (UILabel *)[cell.contentView viewWithTag:self.currentItem+888880];
                    label.hidden = YES;
                }
            }else{
                NSIndexPath *indexPath1 = [NSIndexPath indexPathForItem:i inSection:0];
                UITableViewCell *cell = (UITableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath1];
                cell.textLabel.font = [UIFont systemFontOfSize:24];
                cell.textLabel.text = self.targetNumArray[i];
                cell.textLabel.textColor = [ColorUtils colorWithHexString:@"#b4b4b4"];
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                cell.contentView.backgroundColor = [UIColor clearColor];
                UILabel *label = (UILabel *)[cell.contentView viewWithTag:i+888880];
                label.hidden = YES;
            }
        }
    }
}

- (void)rightConfirmBtnClick{
    NSString *targetNum;
    NSLog(@">>>>>>self.currentItem>>>>>>>>%d",self.currentItem);
    if (self.currentItem != -1) {
        targetNum = self.targetNumArray[self.currentItem];
        if ([targetNum containsString:@","]) {
            targetNum = [targetNum stringByReplacingOccurrencesOfString:@"," withString:@" "];
            targetNum = [NSStringUtils delSpaceAndNewline:targetNum];
        }
    }else{
        targetNum = @"10000";
    }
    NSLog(@"点击的目标：%@", targetNum);
    [AppStatus sharedInstance].targetNum = targetNum;
    [AppStatus saveAppStatus];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"设置计步目标" object:targetNum];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initOtherTargetNum{
    CDAlertViewController *alert = [[CDAlertViewController alloc] initWithTitle:nil image:[UIImage imageNamed:@""] message:@""];
    [alert addAction:[SHBAction actionWithTitle:@"取消" action:^{
        
    }]];
    [alert addAction:[SHBAction actionWithTitle:@"确定" action:^{
        
        NSLog(@"%@", alert.content);
        [AppStatus sharedInstance].targetNum = alert.content;
        [AppStatus saveAppStatus];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"设置计步目标" object:alert.content];
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    
    [alert show];
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
