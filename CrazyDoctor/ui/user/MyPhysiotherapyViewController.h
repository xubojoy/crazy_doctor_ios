//
//  MyPhysiotherapyViewController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/11.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPhysiotherapy.h"

@protocol MyPhysiotherapyViewControllerDelegate <NSObject>

- (void)didMyPhysiotherapyViewControllerIndexPathRow:(NSInteger)row myPhysiotherapy:(MyPhysiotherapy *)myPhysiotherapy;

@end
@interface MyPhysiotherapyViewController : BaseViewController
@property (nonatomic ,strong) MyPhysiotherapy *myPhysiotherapy;
@property (nonatomic ,strong) NSMutableArray *myPhysiotherapyArray;
@property (nonatomic ,assign) id<MyPhysiotherapyViewControllerDelegate> delegate;
@end
