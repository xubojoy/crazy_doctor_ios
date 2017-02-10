//
//  TonguePictureCollectionCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/25.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TongueList.h"
#import "ShowIMGModel.h"
typedef void(^SelectedBlock)(BOOL select);
typedef void(^PreViewBlock)();
@interface TonguePictureCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic,strong)SelectedBlock selectedBlock;
@property (nonatomic,strong)PreViewBlock previewBlock;

@property (weak, nonatomic) IBOutlet UIButton *showIMGBtn;

@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;

- (void)configWithModel:(ShowIMGModel*)model;

//- (void)renderTonguePictureCollectionCell:(TongueList *)tongueList;


@end
