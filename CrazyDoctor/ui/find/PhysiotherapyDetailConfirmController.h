//
//  PhysiotherapyDetailConfirmController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/9.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"
#import "Organization.h"
#import "PhysiotherapyDetailTopView.h"
#import "ProjectOrder.h"
#define date_type 0
#define time_type 1
#import "PopUpView.h"
#import "XbPopView.h"
#import "RedEnvelope.h"
#import "UserAccount.h"
@interface PhysiotherapyDetailConfirmController :  BaseViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,XbPopViewDelegate>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,assign) int projectId;
@property (nonatomic ,strong) Project *project;
@property (nonatomic ,strong) ProjectOrder *projectOrder;
@property (nonatomic ,strong) NSMutableArray *projectArray;
@property (nonatomic ,strong) RedEnvelope *redEnvelope;
@property (nonatomic ,strong) Organization *organization;
@property (nonatomic ,strong) NSMutableArray *organizationArray;
@property (nonatomic ,strong) PhysiotherapyDetailTopView *physiotherapyDetailTopView;

@property (nonatomic ,strong) UIButton *confirmBtn;

@property (nonatomic ,strong) UILabel *nameLabel;
@property (nonatomic ,strong) UITextField *nameTextField;
@property (nonatomic ,strong) UILabel *phoneLabel;
@property (nonatomic ,strong) UITextField *phoneTextField;
@property (nonatomic ,strong) UILabel *ageLabel;
@property (nonatomic ,strong) UITextField *ageTextField;
@property (nonatomic ,strong) UILabel *sexLabel;
@property (nonatomic ,strong) UILabel *sexTitleLabel;
@property (nonatomic ,strong) UILabel *dateTitleLabel;
@property (nonatomic ,strong) UILabel *dateLabel;
@property (nonatomic ,strong) UILabel *timeTitleLabel;
@property (nonatomic ,strong) UILabel *timeLabel;
@property (nonatomic ,strong) UILabel *payTypeTitleLabel;
@property (nonatomic ,strong) UILabel *payTypeLabel;
@property (nonatomic ,strong) UILabel *youhuiTitleLabel;
@property (nonatomic ,strong) UILabel *youhuiquanLabel;
@property (nonatomic ,strong) UILabel *addressTitleLabel;
@property (nonatomic ,strong) UITextField *addressField;
@property (nonatomic ,strong) UILabel *priceLabel;
@property (nonatomic ,strong) UILabel *orginPriceLabel;
@property (nonatomic ,strong) UILabel *discountPriceLabel;

@property (nonatomic ,strong) PopUpView *popUpView;
@property (nonatomic ,strong) XbPopView *xbPopView;

@property (nonatomic ,assign) int pickerType;

@property (nonatomic ,assign) BOOL isClick;

@property (nonatomic ,strong) NSString *selectedPayTypeStr;
@property (nonatomic ,assign) int tmpRedCouponId;
@property (nonatomic ,strong) UserAccount *userAccount;


//时间选择器

@property (strong, nonatomic) IBOutlet UIView *maskView;

@property (strong, nonatomic) IBOutlet UIView *chooseDateModalView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelDateBtn;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *confirmDateBtn;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;

- (IBAction)cancelDatePickerClick:(UIBarButtonItem *)sender;


- (IBAction)confirmDatePickerClick:(UIBarButtonItem *)sender;

- (instancetype)initWithProjectId:(int)projectId;


@end
