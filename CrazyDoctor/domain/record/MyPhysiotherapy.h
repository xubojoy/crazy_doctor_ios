//
//  MyPhysiotherapy.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/12.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PtmsCdbasicsick.h"
#import "MyPhysiDcdocitemsheet.h"
@protocol MyPhysiotherapy
@end
@interface MyPhysiotherapy : JSONModel
@property (nonatomic ,assign) long long int sheetPsdate;
@property (nonatomic ,assign) int sheetStatus;
@property (nonatomic ,strong) NSString<Optional> *sheetPsid;
@property (nonatomic ,assign) int sickTime;
@property (nonatomic ,strong) NSString<Optional> *paName;
@property (nonatomic ,assign) int ifTh;
@property (nonatomic ,strong) PtmsCdbasicsick<Optional> *ptmsCdbasicsick;
@property (nonatomic ,strong) NSArray<MyPhysiDcdocitemsheet *><Optional> *dcdocitemsheet;

@end
