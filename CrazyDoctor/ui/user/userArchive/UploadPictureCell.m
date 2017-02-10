//
//  UploadPictureCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/14.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "UploadPictureCell.h"
#import "TongueDiagnosisStore.h"
static NSString *cellIdentifier = @"PhotoBrowserCell";
@implementation UploadPictureCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
    self.remindLabel.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"PhotoBrowserCell" bundle: nil];
    [self.collectionView registerNib:nib
                             forCellWithReuseIdentifier:cellIdentifier];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.scrollEnabled = NO;
    _mPhotoArray = [NSMutableArray new];
    // 在最后加上添加照片的 item
    PictureModel *photo = [[PictureModel alloc]init];
//    photo.image = [UIImage imageNamed:@"icon_add_case"];
    photo.type = PhotoTypeOfAdd;
    [_mPhotoArray addObject:photo];
}

- (void)renderUploadPictureCellWithController:(UIViewController *)controller title:(NSString *)title remind:(NSString *)remind{
    self.controller = controller;
    self.titleLabel.text = title;
    self.remindLabel.text = remind;
}

#pragma mark - UICollectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor purpleColor];
    PictureModel *photo = _mPhotoArray[indexPath.item];
    cell.photo = photo;
    cell.delegate = self;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _mPhotoArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_mPhotoArray.count <= 3) {
        if (indexPath.row == _mPhotoArray.count-1) {
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
            [actionSheet showInView:self.contentView];
            return;
        }
    }else{
        return;
    }
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath didMoveToIndexPath:(NSIndexPath *)toIndexPath{
    PictureModel *fromPicture = [_mPhotoArray objectAtIndex:fromIndexPath.item];
    [_mPhotoArray removeObjectAtIndex:fromIndexPath.item];
    [_mPhotoArray insertObject:fromPicture atIndex:toIndexPath.item];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(70, 60);
}


#pragma mark - UIImagePickerViewControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    PictureModel *photo = [PictureModel new];
    photo.image = image;
    [_mPhotoArray insertObject:photo atIndex:_mPhotoArray.count-1];
    [_collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:_mPhotoArray.count-2 inSection:0]]];
//    image = [ImageUtils imageWithImageSimple:image scaledToSize:CGSizeMake(screen_width, screen_height)];
    [SVProgressHUD showWithStatus:@"图片上传中..." maskType:SVProgressHUDMaskTypeBlack];
    [TongueDiagnosisStore upLoadTongueDiagnosisImg:^(NSString *imgUrl, NSError *err) {
        [SVProgressHUD dismiss];
        if (imgUrl != nil) {
            NSLog(@">>>>>>>>>>>>>>>>>>上传的舌头照片-%@---%@",_mPhotoArray,imgUrl);

            if ([self.delegate respondsToSelector:@selector(selcetCollectionView:imgStr:)]) {
                [self.delegate selcetCollectionView:self.collectionView imgStr:imgUrl];
            }
            [self upLoadImg:imgUrl];
           
        }else{
            ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
            [self.controller.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.controller.view.center]];
        }
    } tongueImage:image];

    // TODO: 这里选中照片之后可以进行图片的上传操作
}


- (NSString *)upLoadImg:(NSString *)str{
    return str;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    
    switch (buttonIndex) {
        case 0:{
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if(authStatus == ALAuthorizationStatusRestricted || authStatus == ALAuthorizationStatusDenied){
                NSLog(@"没有访问相机的权限");
                return;
            }
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        }
        case 1:{
            ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
            if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied){
                NSLog(@"没有访问相册的权限");
                return;
            }
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        }
        default:
            return;
    }
    [self.controller presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - PhotoBrowserCellDelegate
- (void)PhotoBrowserCellDelete:(PhotoBrowserCell *)cell{
    NSIndexPath *indexpath = [_collectionView indexPathForCell:cell];
    [_mPhotoArray removeObjectAtIndex:indexpath.item];
    [_collectionView deleteItemsAtIndexPaths:@[indexpath]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
