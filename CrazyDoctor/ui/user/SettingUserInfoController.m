//
//  SettingUserInfoController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/6.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "SettingUserInfoController.h"
#import "UserStore.h"
#import "UserNew.h"
@interface SettingUserInfoController ()

@end

@implementation SettingUserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    [self setRightSwipeGestureAndAdaptive];
    [self initHeadView];
    [self initTableView];
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"个人信息" navigationController:self.navigationController];
    [self.view addSubview:self.headerView];
    
    self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveBtn.frame = CGRectMake(screen_width-60, 20, 60, 44);
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    self.saveBtn.titleLabel.font = [UIFont systemFontOfSize:default_font_size];
    [self.saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.saveBtn.backgroundColor = [UIColor clearColor];
    [self.saveBtn addTarget:self action:@selector(saveUserInfoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.saveBtn];
}

//初始化tableview
-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height+general_padding, screen_width,195) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark - tableViewDelegate and datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [UITableViewCell new];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(general_space, (95-20)/2, 100, 20)];
        titleLabel.text = @"头像";
        titleLabel.font = [UIFont systemFontOfSize:default_1_font_size];
        titleLabel.textColor = [ColorUtils colorWithHexString:gray_text_color];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:titleLabel];
        
        UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(screen_width-7-14, (95-14)/2, 14, 14)];
        arrowImgView.image = [UIImage imageNamed:@"icon_arrow"];
        [cell.contentView addSubview:arrowImgView];
        
        self.avaterImgView = [[UIImageView alloc] initWithFrame:CGRectMake(screen_width-7-14-11-53, (95-53)/2, 53, 53)];
        self.avaterImgView.layer.cornerRadius = 53/2;
        self.avaterImgView.layer.masksToBounds = YES;
        [self.avaterImgView sd_setImageWithURL:[NSURL URLWithString:[AppStatus sharedInstance].user.avatarUrl] placeholderImage:[UIImage imageNamed:@"icon_head_nor"]];
        [cell.contentView addSubview:self.avaterImgView];
        
        UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(0, 95, screen_width, splite_line_height)];
        downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
        [cell.contentView addSubview:downLine];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1){
        UITableViewCell *cell = [UITableViewCell new];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(general_space, (50-20)/2, 100, 20)];
        titleLabel.text = @"昵称";
        titleLabel.font = [UIFont systemFontOfSize:default_1_font_size];
        titleLabel.textColor = [ColorUtils colorWithHexString:gray_text_color];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:titleLabel];
        
        self.nickNameField = [[UITextField alloc] initWithFrame:CGRectMake(screen_width-28-200, 0, 200, 50)];
        self.nickNameField.textAlignment = NSTextAlignmentRight;
        self.nickNameField.font = [UIFont systemFontOfSize:default_1_font_size];
        self.nickNameField.textColor = [ColorUtils colorWithHexString:black_text_color];
        self.nickNameField.text = [AppStatus sharedInstance].user.name;
        [self.nickNameField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:self.nickNameField];
        
        UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(0, 50, screen_width, splite_line_height)];
        downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
        [cell.contentView addSubview:downLine];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        UITableViewCell *cell = [UITableViewCell new];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(general_space, (50-20)/2, 100, 20)];
        titleLabel.text = @"手机号";
        titleLabel.font = [UIFont systemFontOfSize:default_1_font_size];
        titleLabel.textColor = [ColorUtils colorWithHexString:gray_text_color];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:titleLabel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.phoneNoField = [[UITextField alloc] initWithFrame:CGRectMake(screen_width-28-200, 0, 200, 50)];
        self.phoneNoField.textAlignment = NSTextAlignmentRight;
        self.phoneNoField.font = [UIFont systemFontOfSize:default_1_font_size];
        self.phoneNoField.textColor = [ColorUtils colorWithHexString:black_text_color];
        self.phoneNoField.text = [AppStatus sharedInstance].user.mobileNo;
        self.phoneNoField.enabled = NO;
        [cell.contentView addSubview:self.phoneNoField];
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 95;
    }
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self changeAvatar];
    }
}

-(void)textFieldDidChanged:(UITextField *)textField{

    if (![self.nickNameField.text isEqualToString:[AppStatus sharedInstance].user.name]) {
        [self.saveBtn setTitleColor:[ColorUtils colorWithHexString:@"#66ad1b"] forState:UIControlStateNormal];
    }else{
        [self.saveBtn setTitleColor:[ColorUtils colorWithHexString:black_common_color] forState:UIControlStateNormal];
    }
}

#pragma mark - 修改头像手势的处理点击事件
//修改头像
- (void)changeAvatar {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选择", nil];
    [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheet代理方法
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setDelegate:self];
    [imagePicker setAllowsEditing:YES];
    
    if(buttonIndex == 0){
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self.view.window.rootViewController presentViewController:imagePicker animated:YES completion:nil];
    }else if(buttonIndex == 1){
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self.view.window.rootViewController presentViewController:imagePicker animated:YES completion:nil];
    }
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    //    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [SVProgressHUD showWithStatus:@"正在处理，请稍等..."  maskType:SVProgressHUDMaskTypeGradient];
    image = [ImageUtils imageWithImageSimple:image scaledToSize:CGSizeMake(220, 220)];
    self.avaterImgView.image = image;
    [[UserStore sharedStore] upLoadImg:^(NSString *imgUrl, NSError *err) {
        if (err == nil) {
            [SVProgressHUD showSuccessWithStatus:@"头像更新成功" maskType:SVProgressHUDMaskTypeBlack];
//            NSLog(@">>>>>>>>>>>更新成功地URLIMg>>>>>>>>>%@",[AppStatus sharedInstance].user.avatarUrl);
            [[UserStore sharedStore] updateUserInfo:^(User *user, NSError *err) {
                [SVProgressHUD dismiss];
                if (user != nil) {
                    NSLog(@">>>>>>>user.avatarUrl>>>>>>>>>%@",user.avatarUrl);
                    [[NSNotificationCenter defaultCenter] postNotificationName:notification_name_update_user_avatar object:nil];
                }else{
                    
                }
            } userId:[AppStatus sharedInstance].user.id
                                               name:self.nickNameField.text
                                          avatarUrl:imgUrl
                                         userGender:[AppStatus sharedInstance].user.userGender
                                        userSetCity:[AppStatus sharedInstance].user.userSetCity
                                         userRoleId:[AppStatus sharedInstance].user.userRoleId
                                        receivePush:[AppStatus sharedInstance].user.receivePush
                                          pushTimes:[AppStatus sharedInstance].user.pushTimes
                                            userJob:[AppStatus sharedInstance].user.userJob
                                           userType:[AppStatus sharedInstance].user.userType
                                           realName:[AppStatus sharedInstance].user.realName
                                          birthCity:[AppStatus sharedInstance].user.birthCity
                                          userMarry:[AppStatus sharedInstance].user.userMarry
                                           birthday:[AppStatus sharedInstance].user.birthday
                                         userHeight:[AppStatus sharedInstance].user.userHeight
                                         userWeight:[AppStatus sharedInstance].user.userWeight
                                           userIDNo:[AppStatus sharedInstance].user.userIDNo
                                 pastMedicalHistory:[AppStatus sharedInstance].user.pastMedicalHistory];
        }else{
            [SVProgressHUD showErrorWithStatus:@"更新头像失败！" maskType:SVProgressHUDMaskTypeBlack];
        }
        
    } tongueImage:image];
}

- (void)saveUserInfoBtnClick{    
    [SVProgressHUD showWithStatus:@"保存中..." maskType:SVProgressHUDMaskTypeBlack];
    [[UserStore sharedStore] updateUserInfo:^(User *user, NSError *err) {
        [SVProgressHUD dismiss];
        if (user != nil) {
            NSLog(@">>>>>>>user.avatarUrl>>>>>>>>>%@",user.avatarUrl);
            [[NSNotificationCenter defaultCenter] postNotificationName:notification_name_update_user_avatar object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
        }
    } userId:[AppStatus sharedInstance].user.id
                                       name:self.nickNameField.text
                                  avatarUrl:[AppStatus sharedInstance].user.avatarUrl
                                 userGender:[AppStatus sharedInstance].user.userGender
                                userSetCity:[AppStatus sharedInstance].user.userSetCity
                                 userRoleId:[AppStatus sharedInstance].user.userRoleId
                                receivePush:[AppStatus sharedInstance].user.receivePush
                                  pushTimes:[AppStatus sharedInstance].user.pushTimes
                                    userJob:[AppStatus sharedInstance].user.userJob
                                   userType:[AppStatus sharedInstance].user.userType
                                   realName:[AppStatus sharedInstance].user.realName
                                  birthCity:[AppStatus sharedInstance].user.birthCity
                                  userMarry:[AppStatus sharedInstance].user.userMarry
                                   birthday:[AppStatus sharedInstance].user.birthday
                                 userHeight:[AppStatus sharedInstance].user.userHeight
                                 userWeight:[AppStatus sharedInstance].user.userWeight
                                   userIDNo:[AppStatus sharedInstance].user.userIDNo
                         pastMedicalHistory:[AppStatus sharedInstance].user.pastMedicalHistory];
}

#pragma mark -  UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.nickNameField resignFirstResponder];
    return YES;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
