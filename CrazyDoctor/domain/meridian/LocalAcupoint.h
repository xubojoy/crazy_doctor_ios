//
//  LocalAcupoint.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/24.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalAcupoint : NSObject
@property (nonatomic ,assign) int id;
@property (nonatomic ,strong) NSString *name;//穴位名称
@property (nonatomic ,assign) int meridianId;//对应的经络id
@property (nonatomic ,strong) NSString *imageUrl;//穴位的图片
@property (nonatomic ,strong) NSString *remark;//穴位的描述
@property (nonatomic ,assign) long long int lastUpdateTime;
@property (nonatomic ,assign) long long int createTime;
@end
