//
//  PhysiotherapyDetailTopView.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/9.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"
#import "Organization.h"
#import "Doctor.h"
@interface PhysiotherapyDetailTopView : UIView


@property (weak, nonatomic) IBOutlet UILabel *projectName;


@property (weak, nonatomic) IBOutlet UILabel *organizationName;

@property (weak, nonatomic) IBOutlet UILabel *organizationAddressLabel;

@property (weak, nonatomic) IBOutlet UILabel *organizationPhoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *projectPriceLabel;


@property (weak, nonatomic) IBOutlet UILabel *firstLabel;


@property (weak, nonatomic) IBOutlet UILabel *secondLabel;


@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;



@property (weak, nonatomic) IBOutlet UILabel *forthLabel;


@property (weak, nonatomic) IBOutlet UILabel *fifthLabel;


//- (id)initWithFrame:(CGRect)frame Project:(Project *)project;

- (void)renderPhysiotherapyDetailTopViewWithProject:(Project *)project;

- (void)renderPhysiotherapyDetailTopViewWithDoctor:(Doctor *)doctor;

@end
