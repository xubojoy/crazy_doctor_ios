//
//  CheckMeridiansRegulationController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/29.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "CheckMeridiansRegulationController.h"
#import "MeridianStore.h"
#import "CheckAcupointViewController.h"
@interface CheckMeridiansRegulationController ()

@end

@implementation CheckMeridiansRegulationController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.view.backgroundColor = [ColorUtils colorWithHexString:white_text_color];
    self.hour = [DateUtils getCurrentDateHour];
    self.acupointArray = [NSMutableArray new];
    self.meridianArray = [NSMutableArray new];
    self.modelArray = [NSMutableArray new];
    
    NSLog(@">>>>>>>>hour1111111111>>>>>>>%d",(int)self.hour);
    
    [self loadData];
    [self initTableView];
}

- (void)loadData{
    [SVProgressHUD showWithStatus:@"数据加载中..." maskType:SVProgressHUDMaskTypeClear];
    [MeridianStore getMeridiansInfo:^(NSArray *meridiansArray, NSError *err) {
        [SVProgressHUD dismiss];
        if ([meridiansArray isKindOfClass:[NSArray class]]) {
            if (self.hour < 23 && self.hour >=1) {
                for (NSDictionary *dict in meridiansArray) {
                    self.meridian = [[Meridian alloc] initWithDictionary:dict error:nil];
                    if (self.meridian != nil) {
                        
                        if (self.hour >= self.meridian.beginTime && self.hour < self.meridian.endTime) {
                            
                            [self.meridianArray addObject:self.meridian];
                            
                            if (self.meridian.acupoints.count > 0) {
                                for (NSDictionary *dic in self.meridian.acupoints) {
                                    self.acupoint = [[Acupoint alloc] initWithDictionary:dic error:nil];
                                    if (self.acupoint != nil) {
                                        [self.acupointArray addObject:self.acupoint];
                                    }
                                }
                            }
//                            NSLog(@">>>>>>>>self.meridianArray>>>>>>>>>>>>%@",self.meridian);
                        }
                    }
                }
                
            }else if((self.hour >= 23) || (self.hour >= 0 && self.hour < 1)){
                for (NSDictionary *dict in meridiansArray) {
                    self.meridian = [[Meridian alloc] initWithDictionary:dict error:nil];
                    if (self.meridian != nil) {
                        
                        if (self.meridian.beginTime == 23 && self.meridian.endTime == 1) {
                            
                            [self.meridianArray addObject:self.meridian];
                            
                            if (self.meridian.acupoints.count > 0) {
                                for (NSDictionary *dic in self.meridian.acupoints) {
                                    self.acupoint = [[Acupoint alloc] initWithDictionary:dic error:nil];
                                    if (self.acupoint != nil) {
                                        [self.acupointArray addObject:self.acupoint];
                                    }
                                }
                            }
//                            NSLog(@">>>>>>>>self.meridianArray>>>>>>>>>>>>%@",self.meridian);
                        }
                    }
                }
            }
        }else{
            ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
            [self.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        }
        [self.tableView reloadData];
        [self loadMeridianData];
    }];
}

- (void)loadMeridianData{
    if (self.meridianArray.count > 0) {
        self.meridian = self.meridianArray[0];
    }
    if (self.acupointArray.count > 0) {
        for (NSInteger i = 0; i < self.acupointArray.count; i ++) {
            PainLevelModel *model = [[PainLevelModel alloc] init];
            [self.modelArray addObject:model];
        }
    }
    [self.tableView reloadData];
}

//初始化tableview
-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width,screen_height-general_height-64-tabbar_height) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [ColorUtils colorWithHexString:white_text_color];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark - tableViewDelegate and datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.acupointArray.count + 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [UITableViewCell new];
        UIImageView *streamerImgView = [[UIImageView alloc] initWithFrame:CGRectMake((screen_width-160)/2, 12, 160, 152)];
        if (self.meridian != nil) {
            [streamerImgView sd_setImageWithURL:[NSURL URLWithString:self.meridian.meridianImageUrl] placeholderImage:nil];
        }
        [cell.contentView addSubview:streamerImgView];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1){
        UITableViewCell *cell = [UITableViewCell new];
        UIImageView *meridianPicImgView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 0, screen_width-100, ((screen_width-100)*710)/540)];
        [meridianPicImgView sd_setImageWithURL:[NSURL URLWithString:self.meridian.bodyImageUrl] placeholderImage:nil];
        meridianPicImgView.contentMode = UIViewContentModeScaleAspectFit;
        meridianPicImgView.clipsToBounds = YES;
        [cell.contentView addSubview:meridianPicImgView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *checkMeridiansRegulationCellIdentifier = @"checkMeridiansRegulationCell";
        UINib *nib = [UINib nibWithNibName:@"CheckMeridiansRegulationCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:checkMeridiansRegulationCellIdentifier];
        CheckMeridiansRegulationCell *cell = [tableView dequeueReusableCellWithIdentifier:checkMeridiansRegulationCellIdentifier forIndexPath:indexPath];
        if (self.acupointArray.count > 0) {
            self.acupoint = self.acupointArray[indexPath.row-2];
            [cell renderCheckMeridiansRegulationCell:self.acupoint];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.MeridianBtn addTarget:self action:@selector(MeridianBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.MeridianBtn.tag = indexPath.row;
        PainLevelModel *model =self.modelArray[indexPath.row-2];
        [cell cellWithData:model];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 176;
    }else if (indexPath.row == 1){
        return ((screen_width-100)*710)/540;
    }
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row > 1) {
        self.acupoint = self.acupointArray[indexPath.row-2];
        if ([self.delegate respondsToSelector:@selector(didreCheckMeridiansRegulationWithAcupoint:meridian:)]) {
            [self.delegate didreCheckMeridiansRegulationWithAcupoint:self.acupoint meridian:self.meridian];
        }
    }
}

-(void)MeridianBtnClick:(UIButton *)sender
{
    NSLog(@"你选了第%ld行",(long)sender.tag);
    if (self.painLevelModel) {
        self.painLevelModel.isSelected = !self.painLevelModel.isSelected;
    }
    PainLevelModel *model = self.modelArray[sender.tag-2];
    if (!model.isSelected) {
        model.isSelected = !model.isSelected;
        self.painLevelModel = model;
    }
    [self.tableView reloadData];
    self.acupoint = self.acupointArray[sender.tag-2];
    if ([self.delegate respondsToSelector:@selector(didreCheckMeridiansRegulationWithAcupoint:meridian:)]) {
        [self.delegate didreCheckMeridiansRegulationWithAcupoint:self.acupoint meridian:self.meridian];
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
