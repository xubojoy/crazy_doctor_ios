//
//  MyDoctorViewController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/11.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDoctor.h"
@protocol MyDoctorViewControllerDelegate <NSObject>

- (void)didMyDoctorViewControllerIndexPathRow:(NSInteger)row myDoctor:(MyDoctor *)myDoctor;

@end
@interface MyDoctorViewController : BaseViewController
@property (nonatomic ,strong) MyDoctor *myDoctor;

@property (nonatomic ,strong) NSMutableArray *myDoctorArray;
@property (nonatomic ,assign) id<MyDoctorViewControllerDelegate> delegate;


@end
