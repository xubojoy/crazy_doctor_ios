//
//  UploadPictureCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/14.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoBrowserCell.h"
#import "PictureModel.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

@protocol UploadPictureCellDelegate <NSObject>

- (void)selcetCollectionView:(UICollectionView *)collectionView imgStr:(NSString *)imgStr;

@end

@interface UploadPictureCell : UITableViewCell<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate,PhotoBrowserCellDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, weak)IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIView *downLine;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *remindLabel;

@property (nonatomic, strong)NSMutableArray *mPhotoArray;

@property (nonatomic ,strong) UIViewController *controller;

@property (nonatomic ,assign) id<UploadPictureCellDelegate> delegate;

- (void)renderUploadPictureCellWithController:(UIViewController *)controller title:(NSString *)title remind:(NSString *)remind;

- (NSString *)upLoadImg:(NSString *)str;


@end
