//
//  AddMedicalRecordController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/14.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceholderTextView.h"
#import "UploadPictureCell.h"
@interface AddMedicalRecordController : BaseViewController<UITextViewDelegate,UploadPictureCellDelegate,UITextFieldDelegate>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) UITextField *nameTextField;
@property (nonatomic ,strong) UITextField *hospitalNameField;
@property (nonatomic ,strong) UILabel *dateLabel;

@property (nonatomic ,strong) PlaceholderTextView *placeholderTextView;
@property (nonatomic ,strong) UIButton *completeBtn;

@property (nonatomic ,strong) NSMutableArray *uploadArray3;
@property (nonatomic ,strong) NSMutableArray *uploadArray4;
@property (nonatomic ,strong) NSMutableArray *uploadArray5;
@property (nonatomic ,strong) NSMutableArray *uploadArray6;


@property (nonatomic ,assign) long long int diagnoseTime;



//时间选择器

@property (strong, nonatomic) IBOutlet UIView *maskView;

@property (strong, nonatomic) IBOutlet UIView *chooseDateModalView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelDateBtn;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *confirmDateBtn;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;

- (IBAction)cancelDatePickerClick:(UIBarButtonItem *)sender;


- (IBAction)confirmDatePickerClick:(UIBarButtonItem *)sender;


@end
