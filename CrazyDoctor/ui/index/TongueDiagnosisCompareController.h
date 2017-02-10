//
//  TongueDiagnosisCompareController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/25.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TongueList.h"
#import "TonguePictureCollectionCell.h"
#import "PreShowBigPicView.h"
#import "HomeViewController.h"
@interface TongueDiagnosisCompareController : BaseViewController<UIScrollViewDelegate,HomeViewControllerDelegate>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) UIButton *rightReTakePhotoBtn;

@property (nonatomic ,strong) UIScrollView *bgScrollView;
@property (nonatomic ,strong) UIView *topBgView;
@property (nonatomic ,strong) UILabel *topLabel;
@property (nonatomic ,strong) UILabel *remarkLabel;
@property (nonatomic ,strong) UIImageView *myTonguePictureImgView;

@property (nonatomic ,strong) UILabel *secondMarkLabel;

@property (nonatomic ,strong) UILabel *countLabel;
@property (nonatomic ,strong) TongueList *tongueList;
@property (nonatomic ,strong) NSMutableArray *tongueListArray;


@property (nonatomic ,strong) UILabel *contentLabel;

@property (nonatomic ,strong) NSString *sheImageUrl;

@property (nonatomic,strong)NSArray *selectedModel;

@property (nonatomic ,strong)  PreShowBigPicView *pre;


@property (nonatomic ,assign) int row;

@property (nonatomic ,strong) UILabel *remindLabel;
@property (nonatomic ,strong) UIImageView *markImgView;
@property (nonatomic ,strong) UILabel *contentCameraLabel;


@property (nonatomic ,strong) HomeViewController *homevc;


-(instancetype)initWithImage:(NSString *)sheImageUrl;
@end
