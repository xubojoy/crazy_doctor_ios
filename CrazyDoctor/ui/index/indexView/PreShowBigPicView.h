//
//  PreShowBigPicView.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/26.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowIMGModel.h"

typedef void(^SelectBlock)(NSMutableArray*array,ShowIMGModel *model,BOOL selected);

typedef void(^ReturnArrayBlock)(NSArray *array);

@interface PreShowBigPicView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UIButton *rightItemBtn;
@property (nonatomic,assign)NSInteger  nowNum;

@property (nonatomic ,strong) UIImageView *myTongueImgView;

@property (nonatomic,strong)UIView *toolBarBGView;
@property (nonatomic,strong)UIButton *toolBarRightBtn;
@property (nonatomic,strong)NSMutableArray *imgModelArray;

@property (nonatomic,strong)NSMutableArray *selectedArray;

@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,copy)SelectBlock selectBlock;

@property (nonatomic,copy)ReturnArrayBlock returnArrayBlock;

@property (nonatomic ,strong) UIPageControl *pageCtrl;
@property (nonatomic ,strong) UILabel *countLabel;

@property (nonatomic ,strong) UINavigationController *navigationController;
- (id)initWithFrame:(CGRect)frame nav:(UINavigationController *)nav pageCount:(int)pageCount pageNum:(NSInteger)pageNum selectedCount:(int)selectedCount myTongueUrl:(NSString *)tongueUrl;

@end
