//
//  TongueDiagnosisTestController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/27.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "TongueDiagnosisTestController.h"
#import "TongueDiagnosisResultController.h"
#import "UserLoginViewController.h"
@interface TongueDiagnosisTestController ()

@end

@implementation TongueDiagnosisTestController
-(instancetype)initWithModelArray:(NSMutableArray *)modelArray tongueImgUrl:(NSString *)tongueImgUrl{
    self = [super init];
    if (self) {
        self.modelArray = modelArray;
        self.tongueImgUrl = tongueImgUrl;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    
    NSLog(@">>>>>>>>>>>>>>%@",self.modelArray);
    self.selectDict = [NSMutableDictionary new];
    self.selectSectionDict = [NSMutableDictionary new];
    self.selectSaveArray = [NSMutableArray new];
    self.tagIdArray = [NSMutableArray new];
    self.bigArray = [NSMutableArray new];
    self.openDict = [NSMutableDictionary new];
    self.currentSection = 0;
    [self setRightSwipeGestureAndAdaptive];
    [self initUI];
    [self listArray];
}

- (NSArray *)listArray{
    if (!_listArray) {
        NSMutableArray * arr = [NSMutableArray array];
        for (ShowIMGModel *model in self.modelArray) {
            
            NSMutableDictionary *infoDict = [[NSMutableDictionary alloc]init];
            [infoDict setValue:[NSNumber numberWithBool:YES] forKey:@"isOpen"];
            [infoDict setValue:model.bodyTagQuestions forKey:@"bodyTagQuestions"];
            [infoDict setValue:model.detailImageUrl forKey:@"detailImageUrl"];
            [infoDict setValue:model.logoUrl forKey:@"logoUrl"];
            [infoDict setValue:model.name forKey:@"name"];
            [infoDict setValue:model.nameUrl forKey:@"nameUrl"];
            [infoDict setValue:model.remark forKey:@"remark"];
            [infoDict setValue:model.tongueImageUrl forKey:@"tongueImageUrl"];
            [infoDict setValue:@(model.id) forKey:@"id"];
            if ([NSStringUtils isNotBlank:model.bodyTagQuestions]) {
                NSArray *array = [model.bodyTagQuestions componentsSeparatedByString:@";;"];
                [infoDict setValue:array forKey:@"groups"];
            }
            
            //封装数据模型
            ModelGroups *group = [[ModelGroups alloc] initWithDict:infoDict];
            [self.openDict setValue:[NSNumber numberWithBool:YES] forKey:[NSString stringWithFormat:@"%d",group.id]];
            [arr addObject:group];
        }
        _listArray = arr;
    }
    return _listArray;
}

- (void)initUI{
    [self initHeadView];
    [self tableView];
    [self initBottomView];
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"舌诊对比-舌象" navigationController:self.navigationController];
    [self.view addSubview:self.headerView];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width, screen_height-self.headerView.frame.size.height-51)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)initBottomView{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, screen_height-51, screen_width, splite_line_height)];
    lineView.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
    [self.view addSubview:lineView];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(general_margin, lineView.bottomY+((51-40)/2), screen_width-30, 40);
    
    UIImage *hightLightImage = [UIImage imageNamed:@"btn_login_pre"];
    [nextBtn setBackgroundImage:[ImageUtils resizableBgImage:hightLightImage] forState:UIControlStateNormal];
    [nextBtn setBackgroundImage:[ImageUtils resizableBgImage:hightLightImage] forState:UIControlStateHighlighted];
    [nextBtn setTitle:@"完成" forState:UIControlStateNormal];
    [nextBtn.titleLabel setFont:[UIFont systemFontOfSize:bigger_font_size]];
    [nextBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nextBtn];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listArray.count;;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.listArray.count > 0) {
            ModelGroups *group = self.listArray[section];
        if (group.isOpen == YES) {
            return group.groups.count;
        }else{
            return 0;
        }
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tongueDiagnosisTestCellIdentifier = [NSString stringWithFormat:@"tongueDiagnosisTestCell%d%d",(int)indexPath.section,(int)indexPath.row];
    UINib *nib = [UINib nibWithNibName:@"TongueDiagnosisTestCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:tongueDiagnosisTestCellIdentifier];
    TongueDiagnosisTestCell *cell = [tableView dequeueReusableCellWithIdentifier:tongueDiagnosisTestCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    if (self.listArray) {
        ModelGroups *group = self.listArray[indexPath.section];
        if (group.groups.count > 0) {
           NSString *title = group.groups[indexPath.row];
            [cell renderTongueDiagnosisTestCellWithTitle:[NSString stringWithFormat:@"%d.%@",(int)indexPath.row+1,title]];
            NSArray *titleArray = [cell.titleLabel.text componentsSeparatedByString:@"."];
            if (titleArray.count > 0) {
                NSString *tagStr = titleArray[1];
                [self.selectDict setObject:@"B" forKey:[NSString stringWithFormat:@"%@****%d",tagStr,group.id]];
            }
        }
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    JFHeaderView *header = [JFHeaderView jfHeadViewWithTableView:tableView];
    header.button.tag = section + 1;
    header.delegate = self;
    if (self.listArray) {
        ModelGroups *group = self.listArray[section];
        NSLog(@">>>>>>>名称>>>>>>>>%@",group.name);
        header.group = group;
        header.label.text = [NSString stringWithFormat:@"与您相似的舌象%d",(int)section+1];
    }
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)jfHeaderView:(JFHeaderView *)view didButton:(UIButton *)sender
{
    ModelGroups *group = self.listArray[sender.tag-1];
    NSString *modelIdStr = [NSString stringWithFormat:@"%d",group.id];
    BOOL isOpenCell = [self.openDict[modelIdStr] boolValue];
    isOpenCell = !isOpenCell;
    if (isOpenCell == YES) {
        [self.openDict setValue:[NSNumber numberWithBool:YES] forKey:[NSString stringWithFormat:@"%d",group.id]];
        group.isOpen = YES;
        
    }else{
        [self.openDict setValue:[NSNumber numberWithBool:NO] forKey:[NSString stringWithFormat:@"%d",group.id]];
        group.isOpen = NO;
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag-1] withRowAnimation:UITableViewRowAnimationNone];
}

//
- (void)didSelectRightOrWrongBtnClick:(UIButton *)sender{

    TongueDiagnosisTestCell *cell = (TongueDiagnosisTestCell *)sender.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//    NSLog(@">>>>>>%d>>>%d",(int)indexPath.section,(int)indexPath.row);
    NSArray *titleArray = [cell.titleLabel.text componentsSeparatedByString:@"."];
    ModelGroups *group = self.listArray[indexPath.section];
    if (titleArray.count > 0) {
        NSString *tagStr = titleArray[1];
        switch (sender.tag) {
            case rightBtn_tag:
            {
                [cell.rightBtn setImage:[UIImage imageNamed:@"icon_abandon_answer_select_circle_pre"] forState:UIControlStateNormal];
                [cell.wrong setImage:[UIImage imageNamed:@"icon_abandon_answer_select_circle_nor"] forState:UIControlStateNormal];
                [self.selectDict setObject:@"A" forKey:[NSString stringWithFormat:@"%@****%d",tagStr,group.id]];
            }
                break;
            case wrongBtn_tag:
            {
                [cell.rightBtn setImage:[UIImage imageNamed:@"icon_abandon_answer_select_circle_nor"] forState:UIControlStateNormal];
                [cell.wrong setImage:[UIImage imageNamed:@"icon_abandon_answer_select_circle_pre"] forState:UIControlStateNormal];
                [self.selectDict setObject:@"B" forKey:[NSString stringWithFormat:@"%@****%d",tagStr,group.id]];
            }
                break;
                
            default:
                break;
        }
    }
}

- (void)completeBtnClick{
    
    if (![[AppStatus sharedInstance] logined]) {
        UserLoginViewController *ulc = [[UserLoginViewController alloc] initWithFrom:account_session_from_user_tongueDiagnosisTest];
        [self.navigationController pushViewController:ulc animated:YES];
        return ;
    }else{
        
        NSInteger num = 0;
        for (NSInteger i = 0; i < self.listArray.count; i++) {
            ModelGroups *group = self.listArray[i];
            num = num + group.groups.count;
        }
        if (self.selectDict.count != num) {
            [self.view makeToast:@"请完成所有题目！" duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        }else{
            for (NSString *key in self.selectDict.allKeys) {
                NSString *valueStr = self.selectDict[key];
                if ([valueStr isEqualToString:@"A"]) {
                    [self.selectSaveArray addObject:key];
                }
            }
            
            for (int i = 0; i < self.listArray.count; i++) {
                ModelGroups *group = self.listArray[i];
                if (![group.name isEqualToString:@"平和"]) {
                    NSMutableArray *smallTagArray = [NSMutableArray new];
                    for (NSString *tagStr in self.selectSaveArray) {
                        NSArray *tagsArray = [tagStr componentsSeparatedByString:@"****"];
                        NSLog(@">>>>>>>%@",tagsArray);
                        int tagId = [tagsArray[1] intValue];
                        NSString *tagTmpStr = tagsArray[0];
                        if ((tagId == group.id) && [NSStringUtils isNotBlank:tagTmpStr]) {
                            [smallTagArray addObject:tagTmpStr];
                        }
                    }
                    NSString *appendStr = [smallTagArray componentsJoinedByString:@";;"];
                    NSLog(@">>>appendStr>>>>%@",appendStr);
                    [self.bigArray addObject:appendStr];
                }
            }
            
            NSMutableArray *bigbigArray = [NSMutableArray new];
            for (NSString *str in self.bigArray) {
                if ([NSStringUtils isBlank:str]) {
                    [bigbigArray addObject:@"无"];
                }else{
                    [bigbigArray addObject:str];
                }
            }
            
            NSLog(@">>>self.bigArray>>>>%@",self.bigArray);
            
            for (ShowIMGModel *model in self.modelArray) {
                if (![model.name isEqualToString:@"平和"]) {
                    [self.tagIdArray addObject:[NSString stringWithFormat:@"%d",model.id]];
                }
            }
            
            BOOL isPingHe = NO;
            for (ShowIMGModel *model in self.modelArray) {
                if ([model.name isEqualToString:@"平和"]) {
                    isPingHe = YES;
                }
            }
            
            TongueDiagnosisResultController *rdvc = [[TongueDiagnosisResultController alloc] initWithUserTongueUrl:self.tongueImgUrl bodyTagIds:self.tagIdArray userSelectQuestions:bigbigArray isPingHe:isPingHe];
            [self.navigationController pushViewController:rdvc animated:YES];
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
