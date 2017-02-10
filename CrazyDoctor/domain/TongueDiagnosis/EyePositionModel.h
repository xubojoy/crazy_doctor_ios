//
//  EyePositionModel.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/3.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EyePositionModel : NSObject
@property (nonatomic ,assign) int positionId;// 位置
@property (nonatomic ,strong) NSString<Optional> *organ;//  器官
@property (nonatomic ,strong) NSString<Optional> *imgUrl;// 器官图片
@property (nonatomic ,strong) NSString<Optional> *remark;
@property (assign,nonatomic) BOOL selectState;//是否选中状态

-(instancetype)initWithDict:(NSDictionary *)dict;

@end
