//
//  SharkeyLocal.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/22.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WCDSharkeyFunction.h"
#import "JSONSerializable.h"
@interface SharkeyLocal : NSObject<JSONSerializable, NSCopying, NSCoding>
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *serialNumber; // 序列号
//@property (nonatomic, strong) NSString *firmwareVersion;// 固件版本
@property (nonatomic, strong) NSString *macAddress;   // mac地址
@property (nonatomic, strong) NSString *modelName;   // 产品Name
@property (nonatomic, strong) NSString *name;
@end
