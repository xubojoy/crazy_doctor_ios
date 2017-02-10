//
//  Acupoint.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/4.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol Acupoint
@end
@interface Acupoint : JSONModel
@property (nonatomic ,assign) int id;
@property (nonatomic ,strong) NSString<Optional> *name;//穴位名称
@property (nonatomic ,assign) int meridianId;//对应的经络id
@property (nonatomic ,strong) NSString<Optional> *imageUrl;//穴位的图片
@property (nonatomic ,strong) NSString<Optional> *remark;//穴位的描述
@property (nonatomic ,assign) long long int lastUpdateTime;
@property (nonatomic ,assign) long long int createTime;
@property (nonatomic ,strong) NSString<Optional> *title;
//
@end
