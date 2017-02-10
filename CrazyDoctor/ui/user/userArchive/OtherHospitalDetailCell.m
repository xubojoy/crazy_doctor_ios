//
//  OtherHospitalDetailCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/17.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "OtherHospitalDetailCell.h"
@implementation OtherHospitalDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
    self.imageBgView = [[UIView alloc] init];
    self.imageBgView.backgroundColor = [UIColor whiteColor];
    self.imageBgView.userInteractionEnabled = YES;
    [self.contentView addSubview:self.imageBgView];
}

- (void)renderOtherHospitalDetailCellWithTitle:(NSString *)title imageUrlsStr:(NSString *)imageUrls showLine:(BOOL)show nav:(UINavigationController *)nav{
    self.titleLabel.text = title;
    if (show) {
        self.downLine.hidden = NO;
    }else{
        self.downLine.hidden = YES;
    }
    
    if ([NSStringUtils isNotBlank:imageUrls]) {
        NSLog(@">>>>图片>>>>>>>%@",imageUrls);
        self.photoArray = [NSMutableArray new];
        NSArray *array = [imageUrls componentsSeparatedByString:@","];
        float x = screen_width-15-(array.count)*70-(array.count-1)*5;
        self.imageBgView.frame = CGRectMake(x, 10, screen_width-x-15, 60);
        for (NSInteger i = 0; i < array.count; i ++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(70*i+i*5, 0, 70, 60)];
            imageView.userInteractionEnabled = YES;
            NSString *imgStr = array[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"bg_default_she_picture"]];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.clipsToBounds = YES;
            imageView.tag = i;
            [self.imageBgView addSubview:imageView];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
            [imageView addGestureRecognizer:tap];
        }
        [self.photoArray addObjectsFromArray:array];
    }
}

#pragma mark - private actions

- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    NSLog(@">>>>>>>>>%d",(int)self.photoArray.count);
    UIView *imageView = tap.view;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = imageView.tag;
    browser.sourceImagesContainerView = self.controller.view;
    browser.imageCount = self.photoArray.count;
    browser.delegate = self;
    [browser show];
}


#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *imageName = self.photoArray[index];
    NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.imageBgView.subviews[index];
    return imageView.image;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
