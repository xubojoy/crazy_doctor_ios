//
//  UserNew.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/9.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserNew : NSObject
@property (nonatomic ,assign) int id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *userCode;
//默认为女的即0 男 1
@property (nonatomic, assign) int userGender;
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *mobileNo;
@property (nonatomic ,assign) int userRoleId;
@property (nonatomic ,strong) NSString *userSetCity;
@property (nonatomic ,strong) NSString *devices;//用户所使用的设备ID集合
@property (nonatomic ,assign) BOOL receivePush;//用户是否接收PUSH
@property (nonatomic ,strong) NSString *pushTimes;// 用户接收PUSH的时间点，多个时间点用逗号隔开
@property (nonatomic ,strong) NSString *bodyTagNames;//用户的体质
@property (nonatomic ,strong) NSString *userJob;//用户职业

@end
