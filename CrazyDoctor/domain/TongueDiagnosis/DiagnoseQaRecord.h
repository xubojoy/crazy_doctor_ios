//
//  DiagnoseQaRecord.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/28.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol DiagnoseQaRecord
@end
@interface DiagnoseQaRecord : JSONModel

@property (nonatomic ,assign) int bodyTagId;
@property (nonatomic ,strong) NSString<Optional> *logoUrl;// 体质logo
@property (nonatomic ,strong) NSString<Optional> *name;//name 体质名称
@property (nonatomic ,strong) NSString<Optional> *nameUrl;// 体质名称图片url
@property (nonatomic ,strong) NSString<Optional> *remark;// 面熟
@property (nonatomic ,strong) NSString<Optional> *bodyTagQuestions;// 体质的所有问题
@property (nonatomic ,strong) NSString<Optional> *tongueImageUrl;// 舌头照片
@property (nonatomic ,strong) NSString<Optional> *detailImageUrl;// 体质描述照片
@property (nonatomic ,strong) NSString<Optional> *userSelectQuestions;// 用户选择的是的题

@property (nonatomic ,assign) int userSelectQuestionsCount;// 用户选择是的题的个数

@end
