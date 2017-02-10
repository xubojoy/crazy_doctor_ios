//
//  MyDiagnosticsTongueTagCollectionCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/11.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBorderView.h"
@interface MyDiagnosticsTongueTagCollectionCell : UICollectionViewCell

@property (nonatomic ,strong) LBorderView *sepImageView;
@property (nonatomic ,strong) UILabel *tagLabel;

- (void)renderMyDiagnosticsTongueTagCollectionCellWithTagName:(NSString *)tagName;

@end
