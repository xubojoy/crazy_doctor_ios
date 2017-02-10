//
//  MedicalRecordController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/12.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDoctor.h"
#import "Dcdocitemsheet.h"
#import "Detailid.h"
#import "XBHeaderView.h"
@interface MedicalRecordController : BaseViewController<XBHeaderViewDelegate>

@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) MyDoctor *myDoctor;
@property (nonatomic ,strong) Dcdocitemsheet *dcdocitemsheet;
@property (nonatomic ,strong) Detailid *detailid;


@property (nonatomic ,strong) NSMutableArray *itemType2Array;
@property (nonatomic ,strong) NSMutableArray *itemType3Array;
@property (nonatomic ,strong) NSMutableArray *itemType7Array;

@property (nonatomic, strong) NSArray *listArray;

@property (nonatomic ,strong) NSMutableDictionary *itemTypeDict;

- (instancetype)initWithMyDoctor:(MyDoctor *)myDoctor;
@end
