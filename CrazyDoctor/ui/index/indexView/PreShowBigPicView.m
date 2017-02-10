//
//  PreShowBigPicView.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/26.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "PreShowBigPicView.h"
#import "PreViewCell.h"
@implementation PreShowBigPicView

- (id)initWithFrame:(CGRect)frame nav:(UINavigationController *)nav pageCount:(int)pageCount pageNum:(NSInteger)pageNum selectedCount:(int)selectedCount myTongueUrl:(NSString *)tongueUrl
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"PreShowBigPicView" owner:self options:nil] objectAtIndex:0];
        self.frame = frame;
        self.navigationController = nav;
        self.nowNum = 0;
        self.pageNum = pageNum;
        
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.delegate = self;
        }
    
        
        self.myTongueImgView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 64, screen_width-100, (screen_height-91-64-10)/2)];
        [self.myTongueImgView sd_setImageWithURL:[NSURL URLWithString:tongueUrl] placeholderImage:[UIImage imageNamed:@"icon_default_homepage_picture"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image != nil) {
                if (image.size.height>image.size.width) {//图片的高要大于与宽
                    CGRect rect = CGRectMake(0, image.size.height/2-image.size.width/2, image.size.width, image.size.width);//创建矩形框
                    CGImageRef cgimg = CGImageCreateWithImageInRect([image CGImage], rect);
                    UIImage *finalImaage = [UIImage imageWithCGImage:cgimg scale:1.0 orientation:UIImageOrientationUp];
                    self.myTongueImgView.image = finalImaage;
                    CGImageRelease(cgimg);
                }else{
                    CGRect rect = CGRectMake(image.size.width/2-image.size.height/2, 0, image.size.height, image.size.height);//创建矩形框
                    CGImageRef cgimg = CGImageCreateWithImageInRect([image CGImage], rect);
                    UIImage *finalImaage = [UIImage imageWithCGImage:cgimg scale:1.0 orientation:UIImageOrientationUp];
                    self.myTongueImgView.image = finalImaage;
                    CGImageRelease(cgimg);
                }
            }
        }];
        self.myTongueImgView.contentMode = UIViewContentModeScaleAspectFill;
        self.myTongueImgView.clipsToBounds = YES;
        [self.navigationController.view addSubview:self.myTongueImgView];
        
        [self.navigationController.view bringSubviewToFront:self.myTongueImgView];
        
        NSLog(@">>>>>self.pageNum>>>>>>%d",(int)self.pageNum);
        [self createCollectionView];
        
        self.rightItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightItemBtn.frame = CGRectMake(screen_width-26-15-50, (screen_height-91-64-10)/2+20+64, 26, 26);
        self.rightItemBtn.backgroundColor = [UIColor clearColor];
        [self.rightItemBtn setImage:[UIImage imageNamed:@"icon_abandon_picture_big_select"] forState:UIControlStateSelected];
        [self.rightItemBtn setImage:[UIImage imageNamed:@"icon_abandon_picture_big_select_nor"] forState:UIControlStateNormal];
        [self.rightItemBtn addTarget:self action:@selector(rightItemBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController.view addSubview:self.rightItemBtn];
        [self.navigationController.view bringSubviewToFront:self.rightItemBtn];
        
        ShowIMGModel *model = self.imgModelArray[pageNum];
        if (model.selected) {
            self.rightItemBtn.selected = YES;
        }
        self.pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, screen_height-51-10-20, screen_width, 20)];
        self.pageCtrl.backgroundColor = [UIColor blackColor];
        self.pageCtrl.alpha = 0.8;
        self.pageCtrl.numberOfPages = pageCount;
        self.pageCtrl.currentPage = 0;
        self.pageCtrl.userInteractionEnabled = NO;
        [self addSubview:self.pageCtrl];
        
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, screen_width-15, 20)];
        self.countLabel.backgroundColor = [UIColor clearColor];
        self.countLabel.text = [NSString stringWithFormat:@"%d/3",selectedCount];
        self.countLabel.font = [UIFont boldSystemFontOfSize:default_font_size];
        self.countLabel.textColor = [ColorUtils colorWithHexString:@"#f45f41"];
        self.countLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.countLabel];
        
    }
    return self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"------%@",NSStringFromClass(gestureRecognizer.view.class));
    if ([NSStringFromClass([gestureRecognizer.view class]) isEqualToString:@"PreShowBigPicView"]) {
        return YES;
    }else{
        return NO;
    }
}


#pragma mark --选择照片
- (void)rightItemBtnClick{
    if (self.rightItemBtn.selected) {
         [self.rightItemBtn setImage:[UIImage imageNamed:@"icon_abandon_picture_big_select"] forState:UIControlStateSelected];
        self.rightItemBtn.selected = NO;
        ShowIMGModel *model = self.imgModelArray[self.nowNum];
        model.selected = NO;
        [self.selectedArray removeObject:model];
        self.selectBlock(self.selectedArray,model,NO);
    }else{
        ShowIMGModel *model = self.imgModelArray[self.nowNum];
        if (self.selectedArray.count < 3) {
            NSLog(@">>>>>>>小小小小小于3时>>>>>>>>>>>>>>>");
            [self.selectedArray addObject:model];
            model.selected = YES;
            self.rightItemBtn.selected = YES;
            self.selectBlock(self.selectedArray,model,YES);
        }else{
            [self.navigationController.view makeToast:@"最多选择3个！" duration:2.0 position:[NSValue valueWithCGPoint:self.navigationController.view.center]];
        }
    }
    self.countLabel.text = [NSString stringWithFormat:@"%d/3",(int)self.selectedArray.count];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    self.nowNum =scrollView.contentOffset.x/self.bounds.size.width;
    
    ShowIMGModel *model = self.imgModelArray[self.nowNum];
    
    if (model.selected) {
        [self.rightItemBtn setImage:[UIImage imageNamed:@"icon_abandon_picture_big_select"] forState:UIControlStateSelected];
        self.rightItemBtn.selected = YES;
    }else{
        [self.rightItemBtn setImage:[UIImage imageNamed:@"icon_abandon_picture_big_select_nor"] forState:UIControlStateNormal];
        self.rightItemBtn.selected = NO;
    }
    self.pageCtrl.currentPage = scrollView.contentOffset.x/self.bounds.size.width;
}

- (void)createCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing      = 0;
//(screen_width*716)/750
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, (screen_height-91-64-10)/2+64+10, screen_width, (screen_height-91-64-10)/2) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:[PreViewCell class] forCellWithReuseIdentifier:@"preView"];
    NSLog(@">>>>>>>>>>俯视图>>>>>>>>%@",NSStringFromClass(self.navigationController.class));
    
    [self.navigationController.view addSubview:self.collectionView];
    [self.navigationController.view bringSubviewToFront:self.collectionView];
    [self refreshIndex];
}
- (void)refreshIndex{
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imgModelArray.count;
}


- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PreViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"preView" forIndexPath:indexPath];
    __weak  PreShowBigPicView *WeakSelf = self;
    cell.hiddenNAVBlock = ^(){
        if (WeakSelf.toolBarBGView.hidden) {
            WeakSelf.toolBarBGView.hidden = NO;
            
        }else{
            WeakSelf.toolBarBGView.hidden = YES;
            
        }
    };
    
    ShowIMGModel *model =self.imgModelArray[indexPath.row];
    
    [cell configWith:model];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGSize collectionSize = {screen_width,(screen_width*716)/750};
    return collectionSize;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    
}




@end
