//
//  OrderDoctorFillController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/10.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Organization.h"
#import "PhysiotherapyDetailTopView.h"
#import "PopUpView.h"
#import "XbPopView.h"
#import "Doctor.h"
#import "RedEnvelope.h"
#import "UserAccount.h"
@interface OrderDoctorFillController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,XbPopViewDelegate>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) PhysiotherapyDetailTopView *physiotherapyDetailTopView;

@property (nonatomic ,strong) Doctor *doctor;
@property (nonatomic ,strong) RedEnvelope *redEnvelope;

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
@property (nonatomic ,strong) UILabel *halfDayLabel;
@property (nonatomic ,strong) UILabel *payTypeTitleLabel;
@property (nonatomic ,strong) UILabel *payTypeLabel;
@property (nonatomic ,strong) UILabel *youhuiquanTitleLabel;
@property (nonatomic ,strong) UILabel *youhuiquanLabel;
@property (nonatomic ,strong) UITextField *addressField;
@property (nonatomic ,strong) UILabel *priceLabel;
@property (nonatomic ,strong) UILabel *orginPriceLabel;
@property (nonatomic ,strong) UILabel *discountPriceLabel;

@property (nonatomic ,assign) BOOL isClick;
@property (nonatomic ,strong) PopUpView *popUpView;
@property (nonatomic ,strong) XbPopView *xbPopView;

@property (nonatomic ,assign) int doctorId;
@property (nonatomic ,strong) NSString *dateStr;
@property (nonatomic ,strong) NSString *halfDayStr;

@property (nonatomic ,strong) NSString *selectedPayTypeStr;
@property (nonatomic ,assign) int tmpRedCouponId;
@property (nonatomic ,strong) UserAccount *userAccount;

- (instancetype)initWithDoctorId:(int)doctorId date:(NSString *)dateStr halfDay:(NSString *)halfDayStr;

@end
