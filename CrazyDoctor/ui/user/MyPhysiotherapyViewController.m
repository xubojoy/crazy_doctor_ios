//
//  MyPhysiotherapyViewController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/11.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "MyPhysiotherapyViewController.h"
#import "MyPhysiotherapyCell.h"
#import "UserStore.h"
@interface MyPhysiotherapyViewController ()


@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
static NSString *myPhysiotherapyCellIdentifier = @"myPhysiotherapyCell";
@implementation MyPhysiotherapyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor cyanColor];
    self.myPhysiotherapyArray = [NSMutableArray new];
    UINib *nib = [UINib nibWithNibName:@"MyPhysiotherapyCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:myPhysiotherapyCellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
     self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    [self loadDta];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadDta];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView.mj_header endRefreshing];
    });
}

- (void)loadDta{
    [SVProgressHUD show];
    [UserStore getMyPhysiotherapy:^(NSDictionary *myDoctorDic, NSError *err) {
        [SVProgressHUD dismiss];
        if (myDoctorDic != nil) {
            NSLog(@">>>>>>>>myDoctorDicreturnCode>>>>>>%@",myDoctorDic[@"register"]);
            if ([myDoctorDic[@"returnCode"] intValue] == 1) {
                NSArray *rigisterArray = myDoctorDic[@"register"];
                [self.myPhysiotherapyArray removeAllObjects];
                for (NSDictionary *dict in rigisterArray) {
                    self.myPhysiotherapy = [[MyPhysiotherapy alloc] initWithDictionary:dict error:nil];
                    if (self.myPhysiotherapy != nil) {
                        NSLog(@">>>>>>>>>>>>%@",self.myPhysiotherapy);
                        [self.myPhysiotherapyArray addObject:self.myPhysiotherapy];
                    }
                }
            }else{
                [self.view makeToast:myDoctorDic[@"returnMessage"] duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
            }
        }else{
            ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
            [self.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        }
        [self.tableView reloadData];
    } medname:[AppStatus sharedInstance].user.mobileNo password:@"43C2578003BE487027EC3B8801FA56B9"];
}

#pragma mark - tableViewDelegate and datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.myPhysiotherapyArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyPhysiotherapyCell *cell = [tableView dequeueReusableCellWithIdentifier:myPhysiotherapyCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.myPhysiotherapyArray.count > 0) {
        self.myPhysiotherapy = self.myPhysiotherapyArray[indexPath.row];
        [cell renderMyPhysiotherapyCellWithMyPhysiotherapy:self.myPhysiotherapy title:@"理疗"];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@">>>>>>>>点击>>>>>>%d",(int)indexPath.row);
    self.myPhysiotherapy = self.myPhysiotherapyArray[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(didMyPhysiotherapyViewControllerIndexPathRow:myPhysiotherapy:)]) {
        [self.delegate didMyPhysiotherapyViewControllerIndexPathRow:indexPath.row myPhysiotherapy:self.myPhysiotherapy];
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
