//
//  OtherHospitalDetailController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/16.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "OtherHospitalDetailController.h"
#import "OtherHospitalDetailCell.h"
@interface OtherHospitalDetailController ()

@end

@implementation OtherHospitalDetailController
- (instancetype)initWithUserUploadRecord:(UserUploadRecord *)userUploadRecord{
    self = [super init];
    if (self) {
        self.userUploadRecord = userUploadRecord;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    self.view.autoresizesSubviews = NO;
    [self initHeadView];
    [self initTableView];
    
    NSLog(@">>>>>>self.userUploadRecord>>>>>>%@",self.userUploadRecord);
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"病历详情" navigationController:self.navigationController];
    [self.view addSubview:self.headerView];
}

- (void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width,screen_height-self.headerView.frame.size.height) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark - tableViewDelegate and datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *nameCellIdentifier = @"nameCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nameCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nameCellIdentifier];
            UILabel *sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(general_margin, 0, 130, 49)];
            sexLabel.text = @"姓       名";
            sexLabel.font = [UIFont systemFontOfSize:default_1_font_size];
            [cell.contentView addSubview:sexLabel];
            
            self.nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(general_margin, 0, screen_width-30, 49)];
            self.nameTextField.backgroundColor = [UIColor clearColor];
            self.nameTextField.enabled = NO;
            self.nameTextField.text = self.userUploadRecord.userName;
            self.nameTextField.textAlignment = NSTextAlignmentRight;
            self.nameTextField.font = [UIFont systemFontOfSize:default_1_font_size];
            [cell.contentView addSubview:self.nameTextField];
            
            UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(general_margin, 48, screen_width-general_margin, splite_line_height)];
            downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
            [cell.contentView addSubview:downLine];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.row == 1){
        static NSString *hospitalCellIdentifier = @"hospitalCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:hospitalCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hospitalCellIdentifier];
            UILabel *sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(general_margin, 0, 130, 49)];
            sexLabel.text = @"就诊医院";
            sexLabel.font = [UIFont systemFontOfSize:default_1_font_size];
            [cell.contentView addSubview:sexLabel];
            
            self.hospitalNameField = [[UITextField alloc] initWithFrame:CGRectMake(general_margin, 0, screen_width-30, 49)];
            self.hospitalNameField.backgroundColor = [UIColor clearColor];
            self.hospitalNameField.enabled = NO;
            self.hospitalNameField.text = self.userUploadRecord.hospital;
            self.hospitalNameField.textAlignment = NSTextAlignmentRight;
            self.hospitalNameField.font = [UIFont systemFontOfSize:default_1_font_size];
            [cell.contentView addSubview:self.hospitalNameField];
            
            UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(general_margin, 48, screen_width-general_margin, splite_line_height)];
            downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
            [cell.contentView addSubview:downLine];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 2){
        static NSString *dateCellIdentifier = @"dateCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dateCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dateCellIdentifier];
            UILabel *sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(general_margin, 0, 100, 49)];
            sexLabel.text = @"日       期";
            sexLabel.font = [UIFont systemFontOfSize:default_1_font_size];
            [cell.contentView addSubview:sexLabel];
            
            self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width-30-200, 0, 200, 49)];
            self.dateLabel.font = [UIFont systemFontOfSize:default_1_font_size];
            self.dateLabel.backgroundColor = [UIColor whiteColor];
            self.dateLabel.textAlignment = NSTextAlignmentRight;
            NSString *dateStr = [DateUtils stringFromLongLongIntDate:self.userUploadRecord.diagnoseTime];
            NSArray *array = [dateStr componentsSeparatedByString:@" "];
            NSString *date = array[0];
            self.dateLabel.text = date;
            [cell.contentView addSubview:self.dateLabel];
            
            UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(screen_width-30, (49-20)/2, general_space, general_space)];
            arrowImgView.image = [UIImage imageNamed:@"icon_arrow"];
            [cell.contentView addSubview:arrowImgView];
            
            UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(general_margin, 48, screen_width-general_margin, splite_line_height)];
            downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
            [cell.contentView addSubview:downLine];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if(indexPath.row == 3){
        static NSString *otherHospitalDetailCellIdentifier = @"otherHospitalDetailCell";
        UINib *nib = [UINib nibWithNibName:@"OtherHospitalDetailCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:otherHospitalDetailCellIdentifier];
        OtherHospitalDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:otherHospitalDetailCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell renderOtherHospitalDetailCellWithTitle:@"就诊病历" imageUrlsStr:self.userUploadRecord.medicalRecordImageUrls showLine:YES nav:self.navigationController];
        return cell;
    }else if(indexPath.row == 4){
        static NSString *otherHospitalDetailCellIdentifier = @"otherHospitalDetailCell1";
        UINib *nib = [UINib nibWithNibName:@"OtherHospitalDetailCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:otherHospitalDetailCellIdentifier];
        OtherHospitalDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:otherHospitalDetailCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell renderOtherHospitalDetailCellWithTitle:@"就诊药方" imageUrlsStr:self.userUploadRecord.prescriptionImageUrls showLine:YES nav:self.navigationController];
        return cell;
    }else if(indexPath.row == 5){
        static NSString *otherHospitalDetailCellIdentifier = @"otherHospitalDetailCell2";
        UINib *nib = [UINib nibWithNibName:@"OtherHospitalDetailCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:otherHospitalDetailCellIdentifier];
        OtherHospitalDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:otherHospitalDetailCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell renderOtherHospitalDetailCellWithTitle:@"医生结论" imageUrlsStr:self.userUploadRecord.conclusionImageUrls showLine:YES nav:self.navigationController];
        return cell;
    }else if(indexPath.row == 6){
        static NSString *otherHospitalDetailCellIdentifier = @"otherHospitalDetailCell3";
        UINib *nib = [UINib nibWithNibName:@"OtherHospitalDetailCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:otherHospitalDetailCellIdentifier];
        OtherHospitalDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:otherHospitalDetailCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell renderOtherHospitalDetailCellWithTitle:@"其他" imageUrlsStr:self.userUploadRecord.otherImageUrls showLine:NO nav:self.navigationController];
        return cell;
    }else if (indexPath.row == 7){
        UITableViewCell *cell = [UITableViewCell new];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(general_space, 0, screen_width-general_space, 49)];
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"补充说明";
        [cell.contentView addSubview:label];
        
        cell.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
        UITableViewCell *cell = [UITableViewCell new];
        cell.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
        if ([NSStringUtils isNotBlank:self.userUploadRecord.remark]) {
            UIView *bgView = [[UIView alloc] init];
            bgView.layer.borderColor = [ColorUtils colorWithHexString:@"#dddddd"].CGColor;
            bgView.layer.borderWidth = 0.5;
            bgView.backgroundColor = [UIColor whiteColor];
            [cell.contentView addSubview:bgView];
            
            self.remarkLabel = [[UILabel alloc] init];
            self.remarkLabel.backgroundColor = [UIColor whiteColor];
            self.remarkLabel.font = [UIFont systemFontOfSize:12.f];
            self.remarkLabel.textColor = [UIColor blackColor];
            self.remarkLabel.textAlignment = NSTextAlignmentLeft;
            self.remarkLabel.text = self.userUploadRecord.remark;
            self.remarkLabel.numberOfLines = 0;
            
            // 文字的最大尺寸
            CGSize maxSize = CGSizeMake(screen_width - 50, MAXFLOAT);
            // 计算文字的高度
            CGFloat textH = [self.userUploadRecord.remark boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil].size.height;
            self.remarkLabel.frame = CGRectMake(general_padding, 20, screen_width - 50, textH);
            
            bgView.frame = CGRectMake(general_margin, 0, screen_width-30, textH+40);
            
            [bgView addSubview:self.remarkLabel];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 7) {
        return 49;
    }else if (indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6){
        return 80;
        
    }else if(indexPath.row == 8){
        if ([NSStringUtils isNotBlank:self.userUploadRecord.remark]) {
            // 文字的最大尺寸
            CGSize maxSize = CGSizeMake(screen_width - 30, MAXFLOAT);
            CGFloat textH = [self.userUploadRecord.remark boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil].size.height;
            return textH+40;
        }else{
            return 0;
        }
    }else{
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
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
