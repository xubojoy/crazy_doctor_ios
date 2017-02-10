//
//  BodyTag.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/28.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol BodyTag
@end
@interface BodyTag : JSONModel
@property (nonatomic ,assign) int id;
@property (nonatomic ,strong) NSString<Optional> *logoUrl;//  logo图片
@property (nonatomic ,strong) NSString<Optional> *name;//name  名称
@property (nonatomic ,strong) NSString<Optional> *remark;// 标书
@property (nonatomic ,strong) NSString<Optional> *nameUrl;
@property (nonatomic ,strong) NSString<Optional> *bodyTagQuestions;// 所有问题“,”分割
@property (nonatomic ,strong) NSString<Optional> *tongueImageUrl;// 舌头照片
@property (nonatomic ,strong) NSString<Optional> *detailImageUrl;// 体质描述照片

@end
