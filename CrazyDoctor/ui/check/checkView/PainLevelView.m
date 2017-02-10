//
//  PainLevelView.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/5.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "PainLevelView.h"

static NSString *painLevelCollectionCellId = @"painLevelCollectionCell";
@implementation PainLevelView

- (id)initWithFrame:(CGRect)frame meridian:(Meridian *)meridian
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"PainLevelView" owner:self options:nil] objectAtIndex:0];
        self.frame = frame;
        self.meridian = meridian;
        self.modelArray = [NSMutableArray new];
        self.leftLine.backgroundColor = [ColorUtils colorWithHexString:common_app_text_color];
        self.rightLine.backgroundColor = [ColorUtils colorWithHexString:common_app_text_color];
        self.downLine.backgroundColor = [ColorUtils colorWithHexString:common_app_text_color];
        
        for (NSInteger i = 0; i < 4; i ++) {
            PainLevelModel *model = [[PainLevelModel alloc] init];
            [self.modelArray addObject:model];
        }
        
        [self initPainLevelCollectionView];
        
        [self bringSubviewToFront:self.leftLine];
        [self bringSubviewToFront:self.downLine];
    }
    return self;
}

- (void)initPainLevelCollectionView{
    // 推荐专家
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0.0;//item间距(最小值)
    flowLayout.minimumLineSpacing = 0.0;//行间距(最小值)
    self.painLevelCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(1,0, screen_width-30-2, 160)
                                                   collectionViewLayout:flowLayout];
    self.painLevelCollectionView.delegate = self;
    self.painLevelCollectionView.dataSource = self;
    self.painLevelCollectionView.showsHorizontalScrollIndicator = NO;
    
    self.painLevelCollectionView.backgroundColor = [UIColor whiteColor];
    
    UINib *nib = [UINib nibWithNibName:@"PainLevelCollectionCell" bundle: nil];
    [self.painLevelCollectionView registerNib:nib
                forCellWithReuseIdentifier:painLevelCollectionCellId];
    
    [self addSubview:self.painLevelCollectionView];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}


-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PainLevelCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:painLevelCollectionCellId forIndexPath:indexPath];
    
    if (indexPath.item == 0) {
        [cell renderPainLevelCollectionCellWithTitle:@"不        痛" meridian:[NSString stringWithFormat:@"请注意%@调养",self.meridian.jingLuoName] brownStr:@"注意"];
    }else if (indexPath.item == 1){
        [cell renderPainLevelCollectionCellWithTitle:@"微痛喜按" meridian:[NSString stringWithFormat:@"请重视%@调养",self.meridian.jingLuoName] brownStr:@"重视"];
    }else if (indexPath.item == 2){
        [cell renderPainLevelCollectionCellWithTitle:@"中痛喜按" meridian:[NSString stringWithFormat:@"请多重视%@调养",self.meridian.jingLuoName] brownStr:@"多重视"];
    }else{
        [cell renderPainLevelCollectionCellWithTitle:@"剧痛拒按" meridian:[NSString stringWithFormat:@"请时刻重视%@调养",self.meridian.jingLuoName] brownStr:@"时刻重视"];
    }
    PainLevelModel *model =self.modelArray[indexPath.item];
    [cell cellWithData:model];
    cell.painLevelSelectBtn.tag = indexPath.item;
    cell.remindLabel.tag = indexPath.item;
    cell.delegate = self;
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((screen_width-30-2)/2, 80);
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>%ld",(long)indexPath.item);
    
}

- (void)didPainLevelBtnClick:(UIButton *)sender{
    NSLog(@">>>>>>>>>>>>>>>>>点击了痛感>>>>>>>>>>>%ld",(long)sender.tag);
    if ([self.delegate respondsToSelector:@selector(didainLevelViewPainLevelBtnClick:)]) {
        [self.delegate didainLevelViewPainLevelBtnClick:sender];
    }
    
    if (self.painLevelModel) {
        self.painLevelModel.isSelected = !self.painLevelModel.isSelected;
    }
    PainLevelModel *model = self.modelArray[sender.tag];
    if (!model.isSelected) {
        model.isSelected = !model.isSelected;
        self.painLevelModel = model;
    }
    [self.painLevelCollectionView reloadData];
}

@end
