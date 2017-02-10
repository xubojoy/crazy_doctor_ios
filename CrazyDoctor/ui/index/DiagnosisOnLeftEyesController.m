//
//  DiagnosisOnEyesController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/29.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "DiagnosisOnLeftEyesController.h"
#import "EyesDiagnosisStore.h"
#import "DiagnosisOnRightEyesController.h"
#import "LBorderView.h"
@interface DiagnosisOnLeftEyesController ()

@end

static NSString *diagnosisOnEyesSelectCollectionCellId = @"diagnosisOnEyesSelectCollectionCell";
@implementation DiagnosisOnLeftEyesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorUtils colorWithHexString:white_text_color];
    [self setRightSwipeGestureAndAdaptive];
    self.eyePositionArray = [NSMutableArray new];
    self.eyePositionModelArray = [NSMutableArray new];
//    self.selectModelArray = [NSMutableArray new];
    [self initHeadView];
    [self initUI];
    [self laodData];
}

- (void)initUI{
    [self initTableView];
    [self initHasSellectTagView];
//    [self initDiagnosisEyesCollectionView];
    [self initBottomView];
}

- (void)laodData{
    [EyesDiagnosisStore getUserEyesDiagnoses:^(NSDictionary *eyesDiagnoseDic, NSError *err) {
        if (eyesDiagnoseDic != nil) {
            NSArray *leftArray = eyesDiagnoseDic[@"left"];
            NSLog(@">>>>>>>>leftArray>>>>>>>>>>>>>%@",leftArray);
            for (NSDictionary *dict in leftArray) {
                NSLog(@">>>>>>>>>dict>>>>>>>>>>>>%@",dict);
                self.eyePosition = [[EyePosition alloc] initWithDictionary:dict error:nil];
                if (self.eyePosition != nil) {
                    NSLog(@">>>>>>>>>>>>>>>>>>>>>%@",self.eyePosition);
                    [self.eyePositionArray addObject:self.eyePosition];
                }
            }
        }else{
            ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
            [self.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        }
        [self initEyePositionModel];
    }];
}

- (void)initEyePositionModel{
    if (self.eyePositionArray.count > 0) {
        for (EyePosition *eyePosition in self.eyePositionArray)
        {
            NSMutableDictionary *infoDict = [[NSMutableDictionary alloc]init];
            [infoDict setValue:[NSNumber numberWithBool:NO] forKey:@"selectState"];
            [infoDict setValue:eyePosition.organ forKey:@"organ"];
            [infoDict setValue:@(eyePosition.positionId) forKey:@"positionId"];
            [infoDict setValue:eyePosition.imgUrl forKey:@"imgUrl"];
            [infoDict setValue:eyePosition.remark forKey:@"remark"];
            //封装数据模型
            EyePositionModel *eyePositionModel = [[EyePositionModel alloc] initWithDict:infoDict];
            //将数据模型放入数组中
            [self.eyePositionModelArray addObject:eyePositionModel];
        }
    }
    [self.tableView reloadData];
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"协助眼诊-左" navigationController:self.navigationController];
    [self.view addSubview:self.headerView];
}

//初始化tableview
-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width,screen_height-51-50-self.headerView.frame.size.height) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [ColorUtils colorWithHexString:white_text_color];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.layer.borderWidth = splite_line_height;
    self.tableView.layer.borderColor = [ColorUtils colorWithHexString:common_app_text_color].CGColor;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [UITableViewCell new];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        self.topRemarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screen_width, 46)];
        self.topRemarkLabel.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
        self.topRemarkLabel.font = [UIFont systemFontOfSize:smaller_font_size];
        self.topRemarkLabel.textColor = [ColorUtils colorWithHexString:gray_text_color];
        self.topRemarkLabel.text = @"请您的朋友找出数字对应区域眼白上有异物处，并勾选";
        self.topRemarkLabel.numberOfLines = 0;
        self.topRemarkLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:self.topRemarkLabel];
        return cell;
    }else if (indexPath.row == 1){
        UITableViewCell *cell = [UITableViewCell new];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        self.leftEyeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, (screen_width*256)/375)];
        
        self.leftEyeImgView.image = [UIImage imageNamed:@"icon_eye_frame_le"];
        [cell.contentView addSubview:self.leftEyeImgView];
        
        return cell;
    }
//    else if (indexPath.row ==2){
//        UITableViewCell *cell = [UITableViewCell new];
//        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
//        LBorderView *sepImageView = [[LBorderView alloc] initWithFrame:CGRectMake(general_margin, 0, screen_width-30, 25)];
//        sepImageView.borderType = BorderTypeDashed;
//        sepImageView.dashPattern = 4;
//        sepImageView.spacePattern = 4;
//        sepImageView.borderWidth = 0.5;
//        sepImageView.borderColor = [ColorUtils colorWithHexString:lighter_2_brown_color];
//        [cell.contentView addSubview:sepImageView];
//        
//        UILabel *remindLabel = [[UILabel alloc] init];
//        remindLabel.text = @"每个区域代表着不同的脏腑，请选择有异物的区域";
//        remindLabel.font = [UIFont boldSystemFontOfSize:smallest_font_size];
//        remindLabel.textColor = [ColorUtils colorWithHexString:lighter_2_brown_color];
//        remindLabel.frame = CGRectMake((screen_width-30-remindLabel.realWidth-10-12)/2+10+12, 0, remindLabel.realWidth, 25);
//        [sepImageView addSubview:remindLabel];
//        
//        UIImageView *hitRemindImgView = [[UIImageView alloc] initWithFrame:CGRectMake((screen_width-30-remindLabel.realWidth-10-12)/2, (25-12)/2, 10, 12)];
//        hitRemindImgView.image = [UIImage imageNamed:@"icon_eye_hit_reminder"];
//        [sepImageView addSubview:hitRemindImgView];
//
//        return cell;
//    }
    else{
//        DiagnosisOnEyesCell *cell = [tableView dequeueReusableCellWithIdentifier:diagnosisOnEyesCellIdentifier forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
//        if (self.eyePositionModelArray.count > 0) {
//            EyePositionModel *model = self.eyePositionModelArray[indexPath.row-2];
//            BOOL isFirst = (indexPath.row == 2?YES:NO);
//            BOOL isLast =(indexPath.row == ((self.eyePositionModelArray.count-1)+2)?YES:NO);
//            [cell renderDiagnosisOnEyesCell:model row:(int)indexPath.row-1 showUpLine:isFirst showDown:isLast];
//        }
        static NSString *diagnosisEyesCellIdentifier = @"diagnosisEyesCell";
        UINib *nib = [UINib nibWithNibName:@"DiagnosisEyesCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:diagnosisEyesCellIdentifier];
        

        DiagnosisEyesCell *cell = [tableView dequeueReusableCellWithIdentifier:diagnosisEyesCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        [cell renderDiagnosisEyesCell:self.eyePositionModelArray];
        cell.delegate = self;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 46;
    }else if (indexPath.row == 1){
        return (screen_width*256)/375;
    }
//    else if (indexPath.row == 2){
//        return 25;
//    }
    else{
        return 136;
    }
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (indexPath.row > 1) {
//        EyePositionModel *model = self.eyePositionModelArray[indexPath.row-2];
//        if (model.selectState) {
//            model.selectState = NO;
//            [self.selectModelArray removeObject:model];
//        }else{
//            model.selectState = YES;
//            [self.selectModelArray addObject:model];
//        }
//        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//    }
//    [self.collectionView removeFromSuperview];
//    
//    NSLog(@">>>>>>>>>>>>>>>%@",self.selectModelArray);
//}

- (void)didDiagnosisEyesCellBtnClick:(NSMutableArray *)selectedArray{
    [self.collectionView removeFromSuperview];
    self.selectModelArray = selectedArray;
    [self initDiagnosisEyesCollectionView];
    [self.collectionView reloadData];
}

- (void)initHasSellectTagView{
    self.eyeSelectIconImgView = [[UIImageView alloc] init];
    self.eyeSelectIconImgView.frame = CGRectMake(17, screen_height-101+(41/2), 17/2, 9);
    self.eyeSelectIconImgView.image = [UIImage imageNamed:@"icon_eye_label_select"];
    [self.view addSubview:self.eyeSelectIconImgView];
    
    self.selectTitleLabel = [[UILabel alloc] init];
    self.selectTitleLabel.text = @"您选择了";
    self.selectTitleLabel.frame = CGRectMake(17+(17/2)+9, screen_height-101, self.selectTitleLabel.realWidth, 50);
    self.selectTitleLabel.textColor = [ColorUtils colorWithHexString:@"#b9976c"];
    
    self.selectTitleLabel.font = [UIFont boldSystemFontOfSize:default_2_font_size];
    [self.view addSubview:self.selectTitleLabel];
    
}

- (void)initDiagnosisEyesCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumInteritemSpacing = 14.0;
    flowLayout.minimumLineSpacing      = 8.0;
    
    float x = (17+(17/2)+9+self.selectTitleLabel.realWidth+14);
    
    int itemCount = (screen_width-x-15)/30;
    int row = 0;
    int integerNum = ((int)self.selectModelArray.count)/(itemCount);
    int remandNum = ((int)self.selectModelArray.count)%(itemCount);
    if (remandNum == 0) {
        row = integerNum;
    }else{
        row = integerNum + 1;
    }
    NSLog(@">>>>当前是几行>>>>>>%d",row);
    float y = 0;
    if (row == 1) {
        y = screen_height-101+((50-16)/2);
        self.tableView.frame = CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width, screen_height-51-50-10-self.headerView.frame.size.height);
        self.selectTitleLabel.frame = CGRectMake(17+(17/2)+9, screen_height-51-50, self.selectTitleLabel.realWidth, 50);
        self.eyeSelectIconImgView.frame = CGRectMake(17, screen_height-51-50+(41/2), 17/2, 9);
    }else if (row == 3){
        y = screen_height-101-26;
         self.tableView.frame = CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width, screen_height-51-76-self.headerView.frame.size.height);
        self.selectTitleLabel.frame = CGRectMake(17+(17/2)+9, screen_height-51-76-10, self.selectTitleLabel.realWidth, 86);
        self.eyeSelectIconImgView.frame = CGRectMake(17, screen_height-51-76-10+(77/2), 17/2, 9);
    }else{
        y = screen_height-101;
         self.tableView.frame = CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width, screen_height-51-50-self.headerView.frame.size.height);
        self.selectTitleLabel.frame = CGRectMake(17+(17/2)+9, screen_height-51-50-10, self.selectTitleLabel.realWidth, 60);
        self.eyeSelectIconImgView.frame = CGRectMake(17, screen_height-51-50-10+(51/2), 17/2, 9);
    }
    [self.tableView reloadData];
   
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(x, y, screen_width-x-15, row*16+(row-1)*8) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    UINib *nib = [UINib nibWithNibName:@"DiagnosisOnEyesSelectCollectionCell" bundle: nil];
    [self.collectionView registerNib:nib
          forCellWithReuseIdentifier:diagnosisOnEyesSelectCollectionCellId];
    [self.view addSubview:self.collectionView];
    [self.view bringSubviewToFront:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.selectModelArray.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DiagnosisOnEyesSelectCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:diagnosisOnEyesSelectCollectionCellId forIndexPath:indexPath];
    if (self.eyePositionModelArray.count > 0) {
        EyePositionModel *model = self.selectModelArray[indexPath.item];
        [cell renderDiagnosisOnEyesSelectCollectionCell:model];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGSize collectionSize = {16,16};
    return collectionSize;
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
    [nextBtn setTitle:@"下一步查看右眼" forState:UIControlStateNormal];
    [nextBtn.titleLabel setFont:[UIFont systemFontOfSize:bigger_font_size]];
    [nextBtn addTarget:self action:@selector(nextCheckRightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nextBtn];
}

- (void)nextCheckRightBtnClick{
    
    NSMutableArray *selectPointIdArray = [NSMutableArray new];
    for (EyePositionModel *model in self.selectModelArray) {
        [selectPointIdArray addObject:@(model.positionId)];
    }
    
    DiagnosisOnRightEyesController *dorevc = [[DiagnosisOnRightEyesController alloc] initWithSelectLeftIdArray:selectPointIdArray];
    [self.navigationController pushViewController:dorevc animated:YES];
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
