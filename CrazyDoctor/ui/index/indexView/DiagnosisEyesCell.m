//
//  DiagnosisEyesCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/17.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "DiagnosisEyesCell.h"
static NSString *diagnosisEyesCollectionCellId = @"DiagnosisEyesCollectionCell";
@implementation DiagnosisEyesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectModelArray = [NSMutableArray new];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"DiagnosisEyesCollectionCell" bundle: nil];
    [self.collectionView registerNib:nib
                forCellWithReuseIdentifier:diagnosisEyesCollectionCellId];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.layer.borderWidth = splite_line_height;
    self.collectionView.layer.borderColor = [ColorUtils colorWithHexString:common_app_text_color].CGColor;
}

- (void)renderDiagnosisEyesCell:(NSMutableArray *)modelArray{
    self.modelArray = modelArray;
    [self.collectionView reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelArray.count;
}


-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DiagnosisEyesCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:diagnosisEyesCollectionCellId forIndexPath:indexPath];
    EyePositionModel *model = self.modelArray[indexPath.item];
    [cell renderDiagnosisOnEyesCell:model row:(int)indexPath.item+1];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((screen_width-30)/4, 34);
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>%ld",(long)indexPath.item);
    EyePositionModel *model = self.modelArray[indexPath.item];
    if (model.selectState) {
        model.selectState = NO;
        [self.selectModelArray removeObject:model];
    }else{
        model.selectState = YES;
        [self.selectModelArray addObject:model];
    }
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    if ([self.delegate respondsToSelector:@selector(didDiagnosisEyesCellBtnClick:)]) {
        [self.delegate didDiagnosisEyesCellBtnClick:self.selectModelArray];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
