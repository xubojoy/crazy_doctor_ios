//
//  MyDoctor.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/12.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cdbasicsick.h"
#import "Dcdocitemsheet.h"
@protocol MyDoctor
@end
@interface MyDoctor : JSONModel

@property (nonatomic ,strong) NSString<Optional> *reid;
@property (nonatomic ,strong) NSString<Optional> *orderno;
@property (nonatomic ,strong) NSString<Optional> *userid;
@property (nonatomic ,assign) int refee;
@property (nonatomic ,assign) int dtfee;
@property (nonatomic ,assign) int scfee;
@property (nonatomic ,assign) long long int modifydate;
@property (nonatomic ,strong) Cdbasicsick<Optional> *cdbasicsick;
@property (nonatomic ,strong) NSArray<Dcdocitemsheet *><Optional> *dcdocitemsheet;

@end
