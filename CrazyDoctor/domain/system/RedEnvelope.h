//
//  RedEnvelope.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/8/1.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol RedEnvelope
@end
@interface RedEnvelope : JSONModel

@property (nonatomic ,assign) int id;
@property (nonatomic ,assign) int userId;
@property (nonatomic ,assign) int amount;//红包金额
@property (nonatomic ,strong) NSString<Optional> *type;// 类型
@property (nonatomic ,assign) int meetAmount;// 满减金额
@property (nonatomic ,assign) long long int expireTime;
@property (nonatomic ,strong) NSString<Optional> *status;// 状态  ： 未使用：usable，已过期：expired，已使用：used

@end
