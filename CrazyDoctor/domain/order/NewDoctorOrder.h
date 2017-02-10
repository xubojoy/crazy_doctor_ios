//
//  NewDoctorOrder.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/10.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol NewDoctorOrder
@end
@interface NewDoctorOrder : JSONModel
@property (nonatomic ,assign) int userId;
@property (nonatomic ,assign) int doctorId;
@property (nonatomic ,strong) NSString<Optional> *orderName;// 到诊人姓名
@property (nonatomic ,strong) NSString<Optional> *orderMobileNo;// 到诊人电话
@property (nonatomic ,assign) int orderAge;// 到诊人年龄
@property (nonatomic ,assign) int orderGender;// 到诊人性别
@property (nonatomic ,assign) long long int orderTime;// 到诊时间
@property (nonatomic ,strong) NSString<Optional> *halfDay;// 上午/下午
@property (nonatomic ,assign) float price;// 医生金额
@property (nonatomic ,assign) int redEnvelopeAmount;//  红包扣减金额
@property (nonatomic ,assign) float orderPrice;// 订单金额



@end
