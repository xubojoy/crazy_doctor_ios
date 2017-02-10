//
//  SettingUserInfoController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/6.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingUserInfoController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIAlertViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) UIImageView *avaterImgView;

@property (nonatomic ,strong) UITextField *nickNameField;
@property (nonatomic ,strong) UITextField *phoneNoField;
@property (nonatomic ,strong) UIButton *saveBtn;

@end
