//
//  MedicalRecordModel.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/16.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MedicalRecordModel : NSObject
@property (nonatomic ,strong) NSString<Optional> *name;
/**
 *  记录这行是否被打开
 */
@property (nonatomic, getter=isOpen) BOOL isOpen;

-(instancetype)initWithDict:(NSDictionary *)dict;
@end
