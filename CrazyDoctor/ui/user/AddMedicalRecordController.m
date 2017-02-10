//
//  AddMedicalRecordController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/14.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "AddMedicalRecordController.h"
#import "NewUserUploadRecord.h"
#import "UserStore.h"
@interface AddMedicalRecordController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation AddMedicalRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.autoresizesSubviews = NO;
    self.uploadArray3 = [NSMutableArray new];
    self.uploadArray4 = [NSMutableArray new];
    self.uploadArray5 = [NSMutableArray new];
    self.uploadArray6 = [NSMutableArray new];
    
    [self initHeadView];
    [self initTableView];
    [self initBottomBtnView];
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"添加病历" navigationController:self.navigationController];
    [self.view addSubview:self.headerView];
}

- (void)initTableView{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyBoard)];
    tapGesture.cancelsTouchesInView = NO;
    
    [self.tableView addGestureRecognizer:tapGesture];
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
            self.nameTextField.placeholder = @"输入姓名";
            self.nameTextField.textAlignment = NSTextAlignmentRight;
            self.nameTextField.returnKeyType = UIReturnKeyDone;
            self.nameTextField.delegate = self;
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
            self.hospitalNameField.placeholder = @"输入就诊医院";
            self.hospitalNameField.textAlignment = NSTextAlignmentRight;
            self.hospitalNameField.returnKeyType = UIReturnKeyDone;
            self.hospitalNameField.delegate = self;
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
        static NSString *uploadPictureCellIdentifier = @"uploadPictureCell";
        UINib *nib = [UINib nibWithNibName:@"UploadPictureCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:uploadPictureCellIdentifier];
        UploadPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:uploadPictureCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        [cell renderUploadPictureCellWithController:self title:@"就诊病历" remind:@"最多上传3张图片"];
        return cell;
    }else if(indexPath.row == 4){
        static NSString *uploadPictureCellIdentifier = @"uploadPictureCell1";
        UINib *nib = [UINib nibWithNibName:@"UploadPictureCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:uploadPictureCellIdentifier];
        UploadPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:uploadPictureCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        [cell renderUploadPictureCellWithController:self title:@"就诊药方" remind:@"最多上传3张图片"];
        return cell;
    }else if(indexPath.row == 5){
        static NSString *uploadPictureCellIdentifier = @"uploadPictureCell2";
        UINib *nib = [UINib nibWithNibName:@"UploadPictureCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:uploadPictureCellIdentifier];
        UploadPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:uploadPictureCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        [cell renderUploadPictureCellWithController:self title:@"医生结论" remind:@"最多上传3张图片"];
        return cell;
    }else if(indexPath.row == 6){
        static NSString *uploadPictureCellIdentifier = @"uploadPictureCell3";
        UINib *nib = [UINib nibWithNibName:@"UploadPictureCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:uploadPictureCellIdentifier];
        UploadPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:uploadPictureCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        [cell renderUploadPictureCellWithController:self title:@"其他" remind:@"最多上传3张图片"];
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
        static NSString *remarkCellIdentifier = @"remarkCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:remarkCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:remarkCellIdentifier];
        cell.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
        self.placeholderTextView = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(general_margin, 0, screen_width - 30, 80)];
        self.placeholderTextView.backgroundColor = [UIColor whiteColor];
        self.placeholderTextView.delegate = self;
        self.placeholderTextView.font = [UIFont systemFontOfSize:14.f];
        self.placeholderTextView.textColor = [UIColor blackColor];
        self.placeholderTextView.textAlignment = NSTextAlignmentLeft;
        self.placeholderTextView.editable = YES;
        self.placeholderTextView.layer.borderColor = [ColorUtils colorWithHexString:@"#dddddd"].CGColor;
        self.placeholderTextView.layer.borderWidth = 0.5;
        self.placeholderTextView.placeholderColor = [ColorUtils colorWithHexString:@"#bbbbbb"];
        self.placeholderTextView.placeholder = @"请输入您要补充的内容";
        [cell.contentView addSubview:self.placeholderTextView];
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
    
    }else{
        return 80;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2) {
        [self.nameTextField resignFirstResponder];
        [self.hospitalNameField resignFirstResponder];
        [self tapDatePickerView:UIDatePickerModeDate];
    }
}

/**
 *  时间选择器
 *
 *  @return
 */
//弹出-------datePickerView
#pragma mark - datePickerView   处理Date
-(void)tapDatePickerView:(UIDatePickerMode)model{
    CGRect maskFrame = self.maskView.frame;
    maskFrame.size.height = screen_height;
    maskFrame.size.width = screen_width;
    self.maskView.frame = maskFrame;
    self.maskView.alpha = 0.5;
    self.maskView.backgroundColor = [UIColor blackColor];
    [self.cancelDateBtn setTintColor:[UIColor blackColor]];
    [self.confirmDateBtn setTintColor:[ColorUtils colorWithHexString:common_app_text_color]];
    [self.view addSubview:self.maskView];
    self.datePickerView.datePickerMode = model;
//    NSDate *date = [NSDate date];
//    self.datePickerView.minimumDate = date;
    NSLocale *chineseLocale = [NSLocale currentLocale]; //创建一个中文的地区对象
    [self.datePickerView setLocale:chineseLocale]; //将这个地区对象给UIDatePicker设置上
    CGRect frame = self.chooseDateModalView.frame;
    frame.origin.y = self.view.frame.size.height;
    frame.size.width = screen_width;
    self.chooseDateModalView.frame = frame;
    [self.view addSubview:self.chooseDateModalView];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.chooseDateModalView.frame;
        frame.origin.y = self.view.frame.size.height - frame.size.height;
        self.chooseDateModalView.frame = frame;
    }];
}

- (IBAction)cancelDatePickerClick:(UIBarButtonItem *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.chooseDateModalView.frame;
        frame.origin.y = self.view.frame.size.height;
        self.chooseDateModalView.frame = frame;
    } completion:^(BOOL finished) {
        [self.chooseDateModalView removeFromSuperview];
        [self.maskView removeFromSuperview];
    }];
    
}

- (IBAction)confirmDatePickerClick:(UIBarButtonItem *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.chooseDateModalView.frame;
        frame.origin.y = self.view.frame.size.height;
        self.chooseDateModalView.frame = frame;
    } completion:^(BOOL finished) {
        NSDate *select = [self.datePickerView date]; // 获取被选中的时间
        self.diagnoseTime = [DateUtils longlongintFromDate:select];
        NSString *dateString = [DateUtils getDateByDate:select];
        NSArray *array = [dateString componentsSeparatedByString:@" "];
        NSString *dateStr = array[0];
        self.dateLabel.text = dateStr;
        [self.chooseDateModalView removeFromSuperview];
        [self.maskView removeFromSuperview];
    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([@"\n" isEqualToString:text] == YES)
    {
        [textView resignFirstResponder];
        
        
        return NO;
    }
    
    return YES;
}


- (void)selcetCollectionView:(UICollectionView *)collectionView imgStr:(NSString *)imgStr{
    NSLog(@">>>>>>>>点击>>>>>>>>%@",NSStringFromClass(collectionView.superview.superview.class));
    UploadPictureCell *cell = (UploadPictureCell *)collectionView.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSLog(@">>>>>indexPath.row>>>%@>>>%d",imgStr,(int)indexPath.row);
    if (indexPath.row == 3) {
        [self.uploadArray3 addObject:imgStr];
    }else if (indexPath.row == 4){
        [self.uploadArray4 addObject:imgStr];
    }else if (indexPath.row == 5){
        [self.uploadArray5 addObject:imgStr];
    }else{
        [self.uploadArray6 addObject:imgStr];
    }
}

- (void)initBottomBtnView{
    UIView *upLine = [[UIView alloc] initWithFrame:CGRectMake(0, screen_height-59, screen_width, splite_line_height)];
    upLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
    [self.view addSubview:upLine];
    
    self.completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.completeBtn.frame = CGRectMake(general_margin, screen_height-7-45, screen_width-2*general_margin, 45);
    //    UIImage *norImage = [UIImage imageNamed:@"btn_login_nor"];
    UIImage *hightLightImage = [UIImage imageNamed:@"btn_login_pre"];
    [self.completeBtn setBackgroundImage:[ImageUtils resizableBgImage:hightLightImage] forState:UIControlStateNormal];
    [self.completeBtn setBackgroundImage:[ImageUtils resizableBgImage:hightLightImage] forState:UIControlStateHighlighted];
    [self.completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.completeBtn.titleLabel setFont:[UIFont systemFontOfSize:bigger_font_size]];
    [self.completeBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.completeBtn];
}

- (void)completeBtnClick{
    NSLog(@">>>>>>>>>>>%@---%@----%@>>>>>>>>>%@------%@-----%@---%@---%@",self.nameTextField.text,self.hospitalNameField.text,self.dateLabel.text,[self.uploadArray3 componentsJoinedByString:@","],self.uploadArray4,self.uploadArray5,self.uploadArray6,self.placeholderTextView.text);
    if (self.nameTextField.text == nil || self.nameTextField.text.length == 0) {
        [self.view makeToast:@"姓名不能为空" duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        return;
    }
    
    if (self.hospitalNameField.text == nil || self.hospitalNameField.text.length == 0) {
        [self.view makeToast:@"就诊医院不能为空" duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        return;
    }
    if (self.dateLabel.text == nil || self.dateLabel.text.length == 0) {
        [self.view makeToast:@"日期不能为空" duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        return;
    }
    
    NewUserUploadRecord *newUserUploadRecord = [[NewUserUploadRecord alloc] init];
    newUserUploadRecord.userId = [AppStatus sharedInstance].user.id;
    newUserUploadRecord.userName = self.nameTextField.text;
    newUserUploadRecord.hospital = self.hospitalNameField.text;
    newUserUploadRecord.diagnoseTime = self.diagnoseTime;
    newUserUploadRecord.medicalRecordImageUrls = [self.uploadArray3 componentsJoinedByString:@","];
    newUserUploadRecord.prescriptionImageUrls = [self.uploadArray4 componentsJoinedByString:@","];
    newUserUploadRecord.conclusionImageUrls = [self.uploadArray5 componentsJoinedByString:@","];
    newUserUploadRecord.otherImageUrls = [self.uploadArray6 componentsJoinedByString:@","];
    newUserUploadRecord.remark = self.placeholderTextView.text;
    [UserStore confirmUserUploadRecord:^(UserUploadRecord *userUploadRecord, NSError *err) {
        if (userUploadRecord != nil) {
            NSLog(@">>>>>userUploadRecord>>>>>>%@",userUploadRecord);
            NSArray *array = @[@"其他医院"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"添加病历完成" object:array];

            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
            [self.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        }
    } newUserUploadRecord:newUserUploadRecord];
    
}

-(void)dismissKeyBoard{
    [self.nameTextField resignFirstResponder];
    [self.hospitalNameField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.nameTextField resignFirstResponder];
    [self.hospitalNameField resignFirstResponder];
    return YES;
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
