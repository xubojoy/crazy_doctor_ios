//
//  NewProjectOrder.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/10.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol NewProjectOrder
@end
@interface NewProjectOrder : JSONModel
@property (nonatomic ,assign) int userId;
@property (nonatomic ,assign) int projectId;
@property (nonatomic ,assign) int organizationId;
@property (nonatomic ,strong) NSString<Optional> *orderName;// 预约人姓名
@property (nonatomic ,strong) NSString<Optional> *orderMobileNo;// 预约人手机号
@property (nonatomic ,assign) int orderAge;// 预约人年龄
@property (nonatomic ,assign) int orderGender;// 预约人性别
@property (nonatomic ,assign) long long int orderTime;
@property (nonatomic ,assign) float price;
@property (nonatomic ,assign) float specialOfferPrice;
@property (nonatomic ,assign) int redEnvelopeAmount;
@property (nonatomic ,assign) float orderPrice;
@property (nonatomic ,strong) NSString<Optional> *orderAddress;
@end
