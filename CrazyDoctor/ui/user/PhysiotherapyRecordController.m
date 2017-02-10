//
//  PhysiotherapyRecordController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/13.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "PhysiotherapyRecordController.h"
#import "MedicalRecordCommonCell.h"
#import "UserStore.h"
@interface PhysiotherapyRecordController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PhysiotherapyRecordController
- (instancetype)initWithMyPhysiotherapy:(MyPhysiotherapy *)myPhysiotherapy{
    self = [super init];
    if (self) {
        self.myPhysiotherapy = myPhysiotherapy;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor purpleColor];
    self.view.autoresizesSubviews = NO;
    self.myPhysiDcdocitemsheetDict = [NSMutableDictionary new];
    self.myPhysiDcdocitemsheetArray = [NSMutableArray new];
    [self initHeadView];
    [self initTableView];
    [self loadaData];
    
    NSLog(@">>>>>>>>>>>>>>>>%@",self.myPhysiotherapy.dcdocitemsheet);
}

- (void)loadaData{
    if (self.myPhysiotherapy.dcdocitemsheet.count > 0) {
        for (NSDictionary *dict in self.myPhysiotherapy.dcdocitemsheet) {
            self.myPhysiDcdocitemsheet = [[MyPhysiDcdocitemsheet alloc] initWithDictionary:dict error:nil];
            NSLog(@">>>>>>>myPhysiDcdocitemsheet>>>>>>>>>%@",self.myPhysiDcdocitemsheet);
            if (self.myPhysiDcdocitemsheet != nil) {
                [self.myPhysiDcdocitemsheetArray addObject:self.myPhysiDcdocitemsheet];
            }

        }
        for (NSInteger i = 0; i< self.myPhysiDcdocitemsheetArray.count; i ++) {
            MyPhysiDcdocitemsheet *myPhysiDcdocitemsheet = self.myPhysiDcdocitemsheetArray[i];
            NSMutableArray *array = [NSMutableArray new];
            for (NSDictionary *ptmsDocitemdetailDic in myPhysiDcdocitemsheet.ptmsDocitemdetail) {
                PtmsDocitemdetail *ptmsDocitemdetail = [[PtmsDocitemdetail alloc] initWithDictionary:ptmsDocitemdetailDic error:nil];
                if (ptmsDocitemdetail != nil) {
                    if ([NSStringUtils isNotBlank:ptmsDocitemdetail.itemInfo]) {
                        [array addObject:ptmsDocitemdetail.itemInfo];
                    }
                }
                
            }
            [self.myPhysiDcdocitemsheetDict setObject:array forKey:@(myPhysiDcdocitemsheet.itemType)];
        }
    }
    [self.tableView reloadData];
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 13;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        static NSString *medicalRecordCommonCellIdentifier = @"MedicalRecordCommonCell";
        UINib *nib = [UINib nibWithNibName:@"MedicalRecordCommonCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:medicalRecordCommonCellIdentifier];
        MedicalRecordCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:medicalRecordCommonCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        switch (indexPath.row) {
            case 0:
            {
                NSMutableArray *strArray = self.myPhysiDcdocitemsheetDict[@(4)];
                NSString *str = [strArray componentsJoinedByString:@"、"];
                [cell renderMedicalRecordCommonCellWithTitle:@"脏腑体查小结" content:str];
            }
              
                break;
            case 1:
            {
                NSMutableArray *strArray = self.myPhysiDcdocitemsheetDict[@(5)];
                NSString *str = [strArray componentsJoinedByString:@"、"];
                [cell renderMedicalRecordCommonCellWithTitle:@"经络体查小结" content:str];
            }
                break;
            case 2:
            {
            
                NSMutableArray *strArray = self.myPhysiDcdocitemsheetDict[@(2)];
                NSMutableArray *strArray3 = self.myPhysiDcdocitemsheetDict[@(3)];
                [strArray addObjectsFromArray:strArray3];
                NSString *str = [strArray componentsJoinedByString:@"、"];
                [cell renderMedicalRecordCommonCellWithTitle:@"筋骨、关窍小结" content:str];
            }
                
                break;
            case 3:
            {
                NSMutableArray *strArray = self.myPhysiDcdocitemsheetDict[@(7)];
                NSString *str = [strArray componentsJoinedByString:@"、"];
                [cell renderMedicalRecordCommonCellWithTitle:@"气机体查小结" content:str];
            }
                
                break;
            case 4:
            {
                NSMutableArray *strArray = self.myPhysiDcdocitemsheetDict[@(8)];
                NSString *str = [strArray componentsJoinedByString:@"、"];
                [cell renderMedicalRecordCommonCellWithTitle:@"皮肤体查小结" content:str];
            }
                
                break;
            case 5:
                [cell renderMedicalRecordCommonCellWithTitle:@"望" content:self.myPhysiotherapy.ptmsCdbasicsick.expression];
                break;
            case 6:
                [cell renderMedicalRecordCommonCellWithTitle:@"闻" content:self.myPhysiotherapy.ptmsCdbasicsick.tzmc];
                break;
            case 7:
                [cell renderMedicalRecordCommonCellWithTitle:@"问" content:self.myPhysiotherapy.ptmsCdbasicsick.mxmc];
                break;
            case 8:
                [cell renderMedicalRecordCommonCellWithTitle:@"切" content:self.myPhysiotherapy.ptmsCdbasicsick.xianbs];
                break;
            case 9:
                [cell renderMedicalRecordCommonCellWithTitle:@"专家辩证" content:self.myPhysiotherapy.ptmsCdbasicsick.hunyins];
                break;
            case 10:
                [cell renderMedicalRecordCommonCellWithTitle:@"专家方案" content:self.myPhysiotherapy.ptmsCdbasicsick.blNote1];
                break;
            case 11:
                [cell renderMedicalRecordCommonCellWithTitle:@"注意事项" content:self.myPhysiotherapy.ptmsCdbasicsick.blNote2];
                break;
            case 12:
                [cell renderMedicalRecordCommonCellWithTitle:@"调理频次" content:self.myPhysiotherapy.ptmsCdbasicsick.blNote3];
                break;
            default:
                break;
        }
        return cell;
    
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    // 文字的最大尺寸
    CGSize maxSize = CGSizeMake(screen_width - 30, MAXFLOAT);
    // 计算文字的高度
    CGFloat textH;
    
    switch (indexPath.row) {
        case 0:
        {
            NSMutableArray *strArray = self.myPhysiDcdocitemsheetDict[@(4)];
            NSString *str = [strArray componentsJoinedByString:@"、"];
            textH = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size.height;
            return textH+25+10+1;
        }
            break;
        case 1:
        {
            NSMutableArray *strArray = self.myPhysiDcdocitemsheetDict[@(5)];
            NSString *str = [strArray componentsJoinedByString:@"、"];
            textH = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size.height;
            return textH+25+10+1;
        }
           
            break;
        case 2:
        {
            NSMutableArray *strArray = self.myPhysiDcdocitemsheetDict[@(2)];
            NSMutableArray *strArray3 = self.myPhysiDcdocitemsheetDict[@(3)];
            [strArray addObjectsFromArray:strArray3];
            NSString *str = [strArray componentsJoinedByString:@"、"];
            textH = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size.height;
            return textH+25+10+1;
        }
            
            break;
        case 3:
        {
            NSMutableArray *strArray = self.myPhysiDcdocitemsheetDict[@(7)];
            NSString *str = [strArray componentsJoinedByString:@"、"];
            textH = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size.height;
            return textH+25+10+1;
        }
            
            break;
        case 4:
        {
            NSMutableArray *strArray = self.myPhysiDcdocitemsheetDict[@(8)];
            NSString *str = [strArray componentsJoinedByString:@"、"];
            textH = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size.height;
            return textH+25+10+1;
        }
           
            break;
        case 5:
        {
            textH = [self.myPhysiotherapy.ptmsCdbasicsick.expression boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size.height;
            return textH+25+10+1;
        }
            
            break;
        case 6:
        {
            textH = [self.myPhysiotherapy.ptmsCdbasicsick.tzmc boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size.height;
            return textH+25+10+1;
        
        }
            
            break;
        case 7:
        {
            textH = [self.myPhysiotherapy.ptmsCdbasicsick.mxmc boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size.height;
            return textH+25+10+1;
        
        }
           
            break;
        case 8:
        {
            textH = [self.myPhysiotherapy.ptmsCdbasicsick.xianbs boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size.height;
            return textH+25+10+1;
        }
            
            break;
        case 9:
        {
            textH = [self.myPhysiotherapy.ptmsCdbasicsick.hunyins boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size.height;
            return textH+25+10+1;
        }
           
            break;
        case 10:
        {
            textH = [self.myPhysiotherapy.ptmsCdbasicsick.blNote1 boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size.height;
            return textH+25+10+1;
        
        }
            
            break;
        case 11:
        {
            textH = [self.myPhysiotherapy.ptmsCdbasicsick.blNote2 boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size.height;
            return textH+25+10+1;
        }
            
            break;
        case 12:
        {
            textH = [self.myPhysiotherapy.ptmsCdbasicsick.blNote3 boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size.height;
            return textH+25+10+1;
        }
            
            break;
            
        default:
            break;
    }
        return 0;
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
