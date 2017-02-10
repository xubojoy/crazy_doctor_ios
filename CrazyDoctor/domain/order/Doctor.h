//
//  Doctor.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/10.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hospital.h"
#import "Department.h"
@protocol Doctor
@end
@interface Doctor : JSONModel
@property (nonatomic ,assign) int id;

@property (nonatomic ,strong) NSString<Optional> *name;
@property (nonatomic ,strong) NSString<Optional> *avatarUrl;// 医生的头像
@property (nonatomic ,assign) int hospitalId;// 医院的ID
@property (nonatomic ,assign) int departmentId;// 科室的ID
@property (nonatomic ,assign) int workAge;// 工作年限

@property (nonatomic ,strong) NSString<Optional> *skills;// 技能 ， 多个技能用逗号隔开
@property (nonatomic ,strong) Hospital<Optional> *hospital;
@property (nonatomic ,strong) NSString<Optional> *level;
@property (nonatomic ,assign) float price;
//@property (nonatomic ,strong) Department<Optional> *department;

//hospital : 医院对象
//department : 科室对象

@end
