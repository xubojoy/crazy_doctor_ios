//
//  SelectCouponController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/8/1.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "SelectCouponController.h"
#import "SelectCouponCell.h"
#import "UserStore.h"
@interface SelectCouponController ()

@end

@implementation SelectCouponController
- (instancetype)initWithFromType:(NSString *)type{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    [self initHeadView];
    self.couponArray = [NSMutableArray new];
    [self loadData];
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"我的优惠券" navigationController:self.navigationController];
    [self.view addSubview:self.headerView];
}

- (void)loadData{
    [UserStore getAllUnusedRedEnvelope:^(NSMutableArray *redEnvelopeArray, NSError *error) {
        if (error == nil) {
            if (redEnvelopeArray.count > 0) {
                for (NSDictionary *redEnvelopeDict in redEnvelopeArray) {
                    self.redEnvelope = [[RedEnvelope alloc] initWithDictionary:redEnvelopeDict error:nil];
                    if (self.redEnvelope != nil) {
                        [self.couponArray addObject:self.redEnvelope];
                    }
                }
                [self initTableView];
                [self.tableView reloadData];
                 NSLog(@">>>>>>>>>>self.couponArray: ----%@",self.couponArray);
            }else{
                [self initCustomEmptyView];
            }
        }
        
    } status:@"usable"];
}

//一日照三照，有病早知道，快来自拍舌诊吧
//司外而揣内，协助眼诊为您观眼知健康
- (void)initCustomEmptyView{
    self.customEmptyView = [[CustomEmptyView alloc] initWithFrame:CGRectMake(0, (screen_height-200-64-40-51)/2, screen_width, 200) withTitle:@"您暂时没有优惠券呦~" withUnderLineTitle:@"" color:light_gray_text_color withLineColor:lighter_2_brown_color font:smaller_font_size withLineFont:small_font_size];
    self.customEmptyView.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    [self.view addSubview:self.customEmptyView];
}

//初始化tableview
-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width,screen_height-self.headerView.frame.size.height) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
}

#pragma mark - tableViewDelegate and datasource
#pragma mark - tableViewDelegate and datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.couponArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *selectCouponCellIdentifier = @"SelectCouponCell";
    UINib *nib = [UINib nibWithNibName:@"SelectCouponCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:selectCouponCellIdentifier];
    SelectCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:selectCouponCellIdentifier forIndexPath:indexPath];
    if (self.couponArray.count > 0) {
        self.redEnvelope = self.couponArray[indexPath.row];
        [cell renderSelectCouponCell:self.redEnvelope];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 142;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.couponArray.count > 0) {
        self.redEnvelope = self.couponArray[indexPath.row];
        if ([self.type isEqualToString:account_session_from_project_order_vc]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"选择优惠券" object:self.redEnvelope];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"预约医生选择优惠券" object:self.redEnvelope];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    //
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.couponArray removeAllObjects];
        [self loadData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView.mj_header endRefreshing];
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
