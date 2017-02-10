//
//  MeridianRecord.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/5.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol MeridianRecord
@end
@interface MeridianRecord : NSObject
@property (nonatomic ,assign) int id;
@property (nonatomic ,assign) int userId;// 用户id
@property (nonatomic ,assign) int meridianId;// 经络id
@property (nonatomic ,assign) int acupointId;// 穴位id
@property (nonatomic ,strong) NSString<Optional> *level;// 疼痛登记

@end
