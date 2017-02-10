//
//  IndexTopView.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/12.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "IndexTopView.h"
static NSString *physiqueClassifyViewCellId = @"physiqueCollectionCell";
@implementation IndexTopView
- (id)initWithFrame:(CGRect)frame classifyArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"IndexTopView" owner:self options:nil] objectAtIndex:0];
        self.frame = frame;
        self.classifyArray = array;
        self.userInteractionEnabled = YES;
        [self initPhysiqueClassifyView];
        [self.tongueDiagnosisReadyBtn setTitleColor:[ColorUtils colorWithHexString:brown_common_color] forState:UIControlStateNormal];
        
    }
    return self;
}

- (void)initPhysiqueClassifyView{
    // 推荐专家
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 9.0;//item间距(最小值)
    flowLayout.minimumLineSpacing = 0.0;//行间距(最小值)
    float width = (46*self.classifyArray.count)+((self.classifyArray.count-1)*9);
    self.physiqueClassifyView = [[UICollectionView alloc] initWithFrame:CGRectMake(58+(screen_width-58-105-width)/2,18, width, 35)
                                                   collectionViewLayout:flowLayout];
    self.physiqueClassifyView.delegate = self;
    self.physiqueClassifyView.dataSource = self;
    self.physiqueClassifyView.showsHorizontalScrollIndicator = NO;
    
    self.physiqueClassifyView.backgroundColor = [UIColor whiteColor];
    
    UINib *nib = [UINib nibWithNibName:@"PhysiqueCollectionCell" bundle: nil];
    [self.physiqueClassifyView registerNib:nib
                forCellWithReuseIdentifier:physiqueClassifyViewCellId];
    
    [self addSubview:self.physiqueClassifyView];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.classifyArray.count;
}


-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhysiqueCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:physiqueClassifyViewCellId
                                                                             forIndexPath:indexPath];
    [cell renderPhysiqueCollectionCellWithTitle:self.classifyArray[indexPath.item] item:indexPath.item];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(46, 35);
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>%ld",(long)indexPath.item);
    
}


- (IBAction)tongueDiagnosisReadyBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didTongueDiagnosisReadyBtnClick:)]) {
        [self.delegate didTongueDiagnosisReadyBtnClick:sender];
    }
}



@end
