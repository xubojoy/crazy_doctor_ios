//
//  PhotoBrowserCell.m
//  LewPhotoBrowser
//
//  Created by pljhonglu on 15/6/25.
//  Copyright (c) 2015年 pljhonglu. All rights reserved.
//

#import "PhotoBrowserCell.h"

#define angelToRandian(x)  ((x)/180.0*M_PI)

@interface PhotoBrowserCell ()
@property (nonatomic, weak)IBOutlet UIView *bgView;
@property (nonatomic, weak)IBOutlet UIImageView *imageView;
@property (nonatomic, weak)IBOutlet UIButton *deleteButton;

@end

@implementation PhotoBrowserCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    _deleteButton.hidden = YES;
    self.clipsToBounds = NO;
    self.contentView.clipsToBounds = NO;
    
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.clipsToBounds = YES;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - setter
- (void)setPhoto:(PictureModel *)photo{
    _photo = photo;
    if (photo.image) {
        _imageView.image = photo.image;
    }else if (photo.url){
        [_imageView sd_setImageWithURL:photo.url];
    }
}

- (IBAction)deleteAction:(id)sender{
    NSLog(@"delete photo Action");
    if (_delegate) {
        [_delegate PhotoBrowserCellDelete:self];
    }
}

@end
