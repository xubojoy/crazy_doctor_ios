//
//  MyDiagnosticsTongueCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/11.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiagnoseLog.h"
@interface MyDiagnosticsTongueCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UIView *downLine;

@property (weak, nonatomic) IBOutlet UIImageView *tongueIMgView;



@property (strong, nonatomic) UICollectionView *myDiagnosticsTongueCollectionView;

@property (nonatomic ,strong) DiagnoseLog *diagnoseLog;
@property (nonatomic ,strong) NSMutableArray *tagsArray;

- (void)renderMyDiagnosticsTongueCellWithDiagnoseLog:(DiagnoseLog *)diagnoseLog;

@end
