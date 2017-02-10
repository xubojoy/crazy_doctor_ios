//
//  EyeDiagnoseRecord.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/3.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EyePosition.h"
@protocol EyeDiagnoseRecord
@end

@interface EyeDiagnoseRecord : JSONModel
@property (nonatomic ,assign) int id;
@property (nonatomic ,assign) int userId;//用户id
@property (nonatomic ,strong) NSString<Optional> *userLeftEyeImageUrl;//左眼图片
@property (nonatomic ,strong) NSString<Optional> *userRightEyeImageUrl;//右眼图片
@property (nonatomic ,strong) NSString<Optional> *userLeftSelectPositions;// 左眼选择的位置
@property (nonatomic ,strong) NSString<Optional> *userRightSelectPositions;// 右眼选择的位置
@property (nonatomic ,strong) NSString<Optional> *result;// 结果
@property (nonatomic ,strong) NSArray<EyePosition *><Optional> *eyePositions;//  眼诊位置器官
@property (nonatomic ,assign) long long int createTime;

@end
