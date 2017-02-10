//
//  LocalMeridian.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/24.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"
#import "LocalAcupoint.h"
@interface LocalMeridian : NSObject<JSONSerializable, NSCopying, NSCoding>
@property (nonatomic ,strong) NSString *jingLuoName;// 经络名称
@property (nonatomic ,strong) LocalAcupoint *localAcupoint;

@end
