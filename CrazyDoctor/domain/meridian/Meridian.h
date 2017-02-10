//
//  Meridian.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/4.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Acupoint.h"
@protocol Meridian
@end
@interface Meridian : JSONModel
@property (nonatomic ,assign) int id;

@property (nonatomic ,strong) NSString<Optional> *name;//时辰名称
@property (nonatomic ,strong) NSString<Optional> *jingLuoName;// 经络名称
@property (nonatomic ,strong) NSString<Optional> *remark;//经络描述
@property (nonatomic ,strong) NSString<Optional> *meridianImageUrl;//子午时钟图片
@property (nonatomic ,strong) NSString<Optional> *bodyImageUrl;//经络身体图片
@property (nonatomic ,strong) NSArray<Acupoint *><Optional> *acupoints;//经络对应的穴位

@property (nonatomic ,assign) int beginTime;
@property (nonatomic ,assign) int endTime;

@end
