//
//  CommonDiseaseController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/6/27.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "CommonDiseaseController.h"
#import "UserStore.h"
#import "WebContainerController.h"
@interface CommonDiseaseController ()

@end
static NSString *const firstCellOne = @"firstCellOne";
@implementation CommonDiseaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    [self setRightSwipeGestureAndAdaptive];
    [self initHeadView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
    self.arrayGroup = [NSMutableArray new];
    self.arrayList = [NSMutableArray new];
    self.commonDiseaseDict = [NSMutableDictionary new];
    [self createView];
    [self loadData];
    self.lastViewNum = 0;
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"常见病调理" navigationController:self.navigationController];
    [self.view addSubview:self.headerView];
}

- (void)createView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width, screen_height - self.headerView.frame.size.height) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CellFirst class] forCellReuseIdentifier:firstCellOne];

    [self.view addSubview:self.tableView];
    
}

- (void)loadData {
    
    [UserStore getAllCommonDisease:^(NSArray *diseaseArray, NSError *err) {
        if (diseaseArray != nil) {
            NSLog(@">>>>>>>>>>diseaseArray>>>>>>>>%@",diseaseArray);
            for (NSDictionary *diseaseDict in diseaseArray) {
                self.commonDisease = [[CommonDisease alloc] initWithDictionary:diseaseDict error:nil];
                if (self.commonDisease != nil) {
                     NSLog(@">>>>>>>>>>self.commonDisease>>>>>>>>%@",self.commonDisease);
                    [self.arrayGroup addObject:self.commonDisease];
                    NSMutableArray *pathologyArray = [NSMutableArray new];
                    for (NSDictionary *pathologiesDict in self.commonDisease.pathologies) {
                        NSLog(@">>>>>>>>>>pathologiesDict>>>>>>>>%@",pathologiesDict);
                        self.pathology = [[Pathology alloc] initWithDictionary:pathologiesDict error:nil];
                        if (self.pathology != nil) {
                            [pathologyArray addObject:self.pathology];
                        }
                    }
                    [self.commonDiseaseDict setObject:pathologyArray forKey:self.commonDisease.name];
                }
  
            }
        }
        [self loadModelData];
        [self.tableView reloadData];
    }];    
}

- (void)loadModelData{
    self.arrayModel = [NSMutableArray array];
    for (int i = 0; i < self.arrayGroup.count; i++) {
        FirstModel *model = [FirstModel defaultModel];
        self.commonDisease = self.arrayGroup[i];
        model.name = self.commonDisease.name;
        NSArray *listArray = self.commonDiseaseDict[self.commonDisease.name];
        model.array = listArray;
        [self.arrayModel addObject:model];
    }

}

// 每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
// 分区的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrayModel.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    FirstModel *model = self.arrayModel[section];
    return model.name;
}

#pragma mark - tableview分区的头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *viewSection = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 50)];
    viewSection.backgroundColor = [UIColor whiteColor];
    viewSection.userInteractionEnabled = YES;
    // 每个view的tag值
    viewSection.tag = 200 + section;
    self.labelSection = [[UILabel alloc] initWithFrame:CGRectMake(general_margin, 0, 200, 50)];
    self.labelSection.textAlignment = NSTextAlignmentLeft;
    self.labelSection.textColor = [UIColor blackColor];
    [viewSection addSubview:self.labelSection];

    
    self.imageViewSection = [[UIImageView alloc] initWithFrame:CGRectMake(screen_width-15-20, (50-20)/2, 20, 20)];
    [viewSection addSubview:self.imageViewSection];
    
    FirstModel *model = [self.arrayModel objectAtIndex:section];
    self.labelSection.text = model.name;
    if (model.flag) {
        self.imageViewSection.image = [UIImage imageNamed:@"icon_abandon_answer_up"];
    } else {
        self.imageViewSection.image = [UIImage imageNamed:@"icon_abandon_answer_down"];
    }
    
    
    UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(0, 49, screen_width, splite_line_height)];
    downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
    [viewSection addSubview:downLine];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleZhanKai:)];
    [viewSection addGestureRecognizer:tap];
    
    return viewSection;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellFirst *cell = [tableView dequeueReusableCellWithIdentifier:firstCellOne];
    cell.model = self.arrayModel[indexPath.section];
    cell.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell backNameWithNameBlock:^(Pathology *pathology) {
        NSLog(@"%@", pathology);
        WebContainerController *wcvc = [[WebContainerController alloc] initWithContent:pathology.content titleStr:pathology.name];
        [self.navigationController pushViewController:wcvc animated:YES];
    }];
    return cell;
}

// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    FirstModel *model = [self.arrayModel objectAtIndex:indexPath.section];
    if (model.flag) {
        
        int row = 0;
        int integerNum = (int)model.array.count / 3;
        int remandNum = (int)(model.array.count)%3;
        if (remandNum == 0) {
            row = integerNum;
        }else{
            row = integerNum + 1;
        }
        return row * 40+(row-1)*10+20;
    }else{
        return 0;
    }
}

#pragma mark - 展开按钮事件
- (void)handleZhanKai:(UITapGestureRecognizer *)tap {
    FirstModel *model = [self.arrayModel objectAtIndex:tap.view.tag - 200];
    if (self.lastViewNum == tap.view.tag) { // 上次点击的view和这次的相等（即是同一个view），那么只需要把view的状态取反
        FirstModel *modelLast = [self.arrayModel objectAtIndex:self.lastViewNum - 200];
        modelLast.flag = !modelLast.flag;
    } else {
        if (self.lastViewNum) { // 不是第一次点击并且不是上次的view， 那么： 上次的 flag = no， 这次的 flag = yes
            FirstModel *modelLast = [self.arrayModel objectAtIndex:self.lastViewNum - 200];
            modelLast.flag = NO;
            model.flag = YES;
        } else { // 如果上一次的tag = 0， 说明是第一次点击，那么：直接 flag = yes
            model.flag = YES;
        }
        self.lastViewNum = tap.view.tag;
        
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
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
