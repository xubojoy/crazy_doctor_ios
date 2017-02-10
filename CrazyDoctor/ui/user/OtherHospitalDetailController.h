//
//  OtherHospitalDetailController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/16.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UploadPictureCell.h"
#import "UserUploadRecord.h"
@interface OtherHospitalDetailController : BaseViewController<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) HeaderView *headerView;

@property (nonatomic ,strong) UserUploadRecord *userUploadRecord;

@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic ,strong) UITextField *nameTextField;
@property (nonatomic ,strong) UITextField *hospitalNameField;
@property (nonatomic ,strong) UILabel *dateLabel;
@property (nonatomic ,strong) UILabel *remarkLabel;

- (instancetype)initWithUserUploadRecord:(UserUploadRecord *)userUploadRecord;

@end
