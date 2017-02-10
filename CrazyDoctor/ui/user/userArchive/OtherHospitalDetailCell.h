//
//  OtherHospitalDetailCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/17.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDPhotoBrowser.h"
@interface OtherHospitalDetailCell : UITableViewCell<SDPhotoBrowserDelegate>



@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *downLine;

@property (nonatomic ,strong) UIView *imageBgView;
@property (nonatomic ,strong) NSMutableArray *photoArray;
@property (nonatomic ,strong) UINavigationController *controller;

- (void)renderOtherHospitalDetailCellWithTitle:(NSString *)title imageUrlsStr:(NSString *)imageUrls showLine:(BOOL)show nav:(UINavigationController *)nav;

@end
