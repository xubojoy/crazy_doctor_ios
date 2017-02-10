//
//  MedicalRecordController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/12.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "MedicalRecordController.h"
#import "MedicalRecordCommonCell.h"
#import "MedicalRecordClassifyCell.h"
#import "MedicalRecordModel.h"
@interface MedicalRecordController ()
{
//    BOOL* _isExpand;
    //表区头名字数组
    NSArray *_nameArray;
    //当前打开的区的索引
    int _currentOpenSectionIndex;
    
    //上一个打开的区的索引
    int _lastOpenSectionIndex;
    
    
    BOOL isOpenCell;
    
}
@property(nonatomic,assign)NSInteger lastIndex;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong , nonatomic) UIImageView *arrowImgView;
@end

@implementation MedicalRecordController

- (instancetype)initWithMyDoctor:(MyDoctor *)myDoctor{
    self = [super init];
    if (self) {
        self.myDoctor = myDoctor;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    self.itemType2Array = [NSMutableArray new];
    self.itemType3Array = [NSMutableArray new];
    self.itemType7Array = [NSMutableArray new];
    self.itemTypeDict = [NSMutableDictionary new];
    self.view.autoresizesSubviews = NO;
    isOpenCell = NO;
    _nameArray = @[@"西药、成药",@"中草药",@"处置"];
    [self initHeadView];
    [self initTableView];
    [self loadItemTypeData];
    [self listArray];
}

- (void)loadItemTypeData{
    if (self.myDoctor.dcdocitemsheet.count > 0) {
        NSLog(@">>>>>>>>>>>>>>>>>>>%@",self.myDoctor.dcdocitemsheet);
        for (NSDictionary *dcdocitemsheetDict in self.myDoctor.dcdocitemsheet) {
            self.dcdocitemsheet = [[Dcdocitemsheet alloc] initWithDictionary:dcdocitemsheetDict error:nil];
            if ([self.dcdocitemsheet.itemType isEqualToString:@"2"]) {
                if (self.dcdocitemsheet != nil) {
                    for (NSDictionary *detailidDict in self.dcdocitemsheet.detailid) {
                        self.detailid = [[Detailid alloc] initWithDictionary:detailidDict error:nil];
                        if (self.detailid != nil) {
                           [self.itemType2Array addObject:self.detailid];
                        }
                    }
                    [self.itemTypeDict setObject:self.itemType2Array forKey:@(2)];
                }
            }else if ([self.dcdocitemsheet.itemType isEqualToString:@"3"]) {
                if (self.dcdocitemsheet != nil) {
                    for (NSDictionary *detailidDict in self.dcdocitemsheet.detailid) {
                        self.detailid = [[Detailid alloc] initWithDictionary:detailidDict error:nil];
                        if (self.detailid != nil) {
                            [self.itemType3Array addObject:self.detailid];
                        }
                    }
                    [self.itemTypeDict setObject:self.itemType3Array forKey:@(1)];
                }
            }else{
                if (self.dcdocitemsheet != nil) {
                    for (NSDictionary *detailidDict in self.dcdocitemsheet.detailid) {
                        self.detailid = [[Detailid alloc] initWithDictionary:detailidDict error:nil];
                        if (self.detailid != nil) {
                            [self.itemType7Array addObject:self.detailid];
                        }
                    }
                    [self.itemTypeDict setObject:self.itemType7Array forKey:@(3)];
                }
            }
        }
    }
    
    
    [self.tableView reloadData];
    NSLog(@">>>>>>self.itemType2Array:%@>>>>>self.itemType3Array:%@------%@>>>>self.itemType7Array:%@",self.itemType2Array,self.itemType3Array,self.itemType7Array,self.itemTypeDict);
}

- (NSArray *)listArray{
    if (!_listArray) {
        NSMutableArray * arr = [NSMutableArray array];
        for (NSInteger i = 1; i < 4; i ++) {
            NSMutableDictionary *infoDict = [[NSMutableDictionary alloc]init];
            NSString *name = _nameArray[i-1];
            [infoDict setValue:name forKey:@"name"];
            //封装数据模型
            MedicalRecordModel *group = [[MedicalRecordModel alloc] initWithDict:infoDict];
            [arr addObject:group];

        }
        _listArray = arr;
    }
    return _listArray;
}


//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"病历查看" navigationController:self.navigationController];
    [self.view addSubview:self.headerView];
}

- (void)initTableView{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
}

#pragma mark - tableViewDelegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
      return 10;
    }else{
        if (section == _currentOpenSectionIndex+1) {
            if (isOpenCell) {
                NSMutableArray *array = self.itemTypeDict[@(section)];
                return array.count + 1;
            }else{
                return 0;
            }
        }else{
            return 0;
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        static NSString *medicalRecordCommonCellIdentifier = @"MedicalRecordCommonCell";
        UINib *nib = [UINib nibWithNibName:@"MedicalRecordCommonCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:medicalRecordCommonCellIdentifier];
        MedicalRecordCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:medicalRecordCommonCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        switch (indexPath.row) {
            case 0:
                [cell renderMedicalRecordCommonCellWithTitle:@"主诉" content:self.myDoctor.cdbasicsick.expression];
                break;
            case 1:
                [cell renderMedicalRecordCommonCellWithTitle:@"体质" content:self.myDoctor.cdbasicsick.tzmc];
                break;
            case 2:
                [cell renderMedicalRecordCommonCellWithTitle:@"脉象" content:self.myDoctor.cdbasicsick.mxmc];
                break;
            case 3:
                [cell renderMedicalRecordCommonCellWithTitle:@"现病史" content:self.myDoctor.cdbasicsick.xianbs];
                break;
            case 4:
                [cell renderMedicalRecordCommonCellWithTitle:@"主要诊断" content:self.myDoctor.cdbasicsick.diagName];
                break;
            case 5:
                [cell renderMedicalRecordCommonCellWithTitle:@"诊断A" content:self.myDoctor.cdbasicsick.diagaName];
                break;
            case 6:
                [cell renderMedicalRecordCommonCellWithTitle:@"诊断B" content:self.myDoctor.cdbasicsick.diagbName];
                break;
            case 7:
                [cell renderMedicalRecordCommonCellWithTitle:@"诊断C" content:self.myDoctor.cdbasicsick.diagcName];
                break;
            case 8:
                [cell renderMedicalRecordCommonCellWithTitle:@"诊断D" content:self.myDoctor.cdbasicsick.diagdName ];
                break;
            case 9:
                [cell renderMedicalRecordCommonCellWithTitle:@"医生建议" content:self.myDoctor.cdbasicsick.blNote1];
                break;
                
            default:
                break;
        }
        return cell;
    }else{
        static NSString *medicalRecordClassifyCellIdentifier = @"medicalRecordClassifyCell";
        UINib *nib = [UINib nibWithNibName:@"MedicalRecordClassifyCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:medicalRecordClassifyCellIdentifier];
        MedicalRecordClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:medicalRecordClassifyCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
        if (indexPath.row == 0) {
            cell.nameLabel.text = @"药品名称";
            cell.guigeLabel.text = @"药品剂量";
            cell.countLabel.text = @"数量";
            cell.mgLabel.text = @"药品剂量单位";
            cell.frequencyLabel.text = @"频率";
            cell.usageLabel.text = @"单价";
            cell.dayLabel.text = @"天";
            cell.amountLabel.text = @"金额";
        }else{
            NSMutableArray *detailidArray = self.itemTypeDict[@(indexPath.section)];
            self.detailid = detailidArray[indexPath.row-1];
            [cell renderMedicalRecordClassifyCellWithDetailid:self.detailid];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section != 0) {
        return 50;
    }else{
        return 0;
    }
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section != 0) {
        XBHeaderView *header = [XBHeaderView xbHeaderViewWithTableView:tableView];
        header.button.tag = section + 1;
        header.delegate = self;
        if (self.listArray) {
//            NSLog(@">>>>>self.listArray>>>>>>%@",self.listArray);
            MedicalRecordModel *group = self.listArray[section-1];
            header.group = group;
        }
        return header;
    }else{
        return nil;
    }
}

- (void)xbHeaderView:(XBHeaderView *)view didButton:(UIButton *)sender

{
    NSLog(@">>>>>>>>>>>>>>_currentOpenSectionIndex1111111>>>>>>>>>>>>>>%d",_currentOpenSectionIndex);
    NSLog(@">>>>>>>>>>>>>>_lastOpenSectionIndex111111>>>>>>>>>>>>>>%d",_lastOpenSectionIndex);
    NSLog(@">>>>>>>>>>>>>>sender.tag1111111>>>>>>>>>>>>>>%d",(int)sender.tag);
    //先记录上次打开的区的索引
    _lastOpenSectionIndex = _currentOpenSectionIndex;
    //把当前需要打开的区的索引设为点击的区的索引
    _currentOpenSectionIndex = (int)sender.tag-2;
    
    MedicalRecordModel *group = self.listArray[sender.tag-2];
    
    NSLog(@">>>>>>>>>>>>>>_currentOpenSectionIndex2222222>>>>>>>>>>>>>>%d",_currentOpenSectionIndex);
    NSLog(@">>>>>>>>>>>>>>_lastOpenSectionIndex2222222>>>>>>>>>>>>>>%d",_lastOpenSectionIndex);
    NSLog(@">>>>>>>>>>>>>>sender.tag2222222>>>>>>>>>>>>>>%d",(int)sender.tag);
    
    
    if ((sender.tag) == _currentOpenSectionIndex) {
        isOpenCell = NO;
        group.isOpen = NO;
    }else{
        if (_currentOpenSectionIndex == _lastOpenSectionIndex) {
            isOpenCell = !isOpenCell;
            group.isOpen = isOpenCell;
        }else{
            isOpenCell = YES;
            group.isOpen = YES;
        }
    }
    for (NSInteger i = 0; i < self.listArray.count; i ++) {
        if (i != _currentOpenSectionIndex) {
            MedicalRecordModel *group = self.listArray[i];
            group.isOpen = NO;
            
        }
    }
    [self.tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    // 文字的最大尺寸
    CGSize maxSize = CGSizeMake(screen_width - 30, MAXFLOAT);
    // 计算文字的高度
    CGFloat textH;
    // c文字部分的高度
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                textH = [self.myDoctor.cdbasicsick.expression boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size.height;
                break;
            case 1:
                textH = [self.myDoctor.cdbasicsick.tzmc boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size.height;
                break;
            case 2:
                textH = [self.myDoctor.cdbasicsick.mxmc boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size.height;
                break;
            case 3:
                textH = [self.myDoctor.cdbasicsick.xianbs boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size.height;
                break;
            case 4:
                textH = [self.myDoctor.cdbasicsick.diagName boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size.height;
                break;
            case 5:
                textH = [self.myDoctor.cdbasicsick.diagaName boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size.height;
                break;
            case 6:
                textH = [self.myDoctor.cdbasicsick.diagbName boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size.height;
                break;
            case 7:
                textH = [self.myDoctor.cdbasicsick.diagcName boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size.height;
                break;
            case 8:
                textH = [self.myDoctor.cdbasicsick.diagdName boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size.height;
                break;
            case 9:
                textH = [self.myDoctor.cdbasicsick.blNote1 boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size.height;
                break;
                
            default:
                break;
        }
        return textH+25+10+1;
    }else if (indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3){
        return 50;
    }else{
        return 0;
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
