//
//  PhysiotherapyRecordController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/13.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPhysiotherapy.h"
#import "MyPhysiDcdocitemsheet.h"
@interface PhysiotherapyRecordController : BaseViewController
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) MyPhysiotherapy *myPhysiotherapy;
@property (nonatomic ,strong) MyPhysiDcdocitemsheet *myPhysiDcdocitemsheet;
@property (nonatomic ,strong) NSMutableArray *myPhysiDcdocitemsheetArray;
@property (nonatomic ,strong) NSMutableDictionary *myPhysiDcdocitemsheetDict;

- (instancetype)initWithMyPhysiotherapy:(MyPhysiotherapy *)myPhysiotherapy;

@end
