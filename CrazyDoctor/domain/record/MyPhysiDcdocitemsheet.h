//
//  MyPhysiDcdocitemsheet.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/13.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PtmsDocitemdetail.h"
@protocol MyPhysiDcdocitemsheet
@end
@interface MyPhysiDcdocitemsheet : JSONModel
@property (nonatomic ,strong) NSString *docitemId;
@property (nonatomic ,strong) NSString<Optional> *reId;
@property (nonatomic ,assign) int itemType;
@property (nonatomic ,strong) NSString<Optional> *dpId;
@property (nonatomic ,strong) NSString<Optional> *sheetPsid;
@property (nonatomic ,assign) long long int sheetPsdate;
@property (nonatomic ,strong) NSArray<PtmsDocitemdetail *><Optional> *ptmsDocitemdetail;

@end
