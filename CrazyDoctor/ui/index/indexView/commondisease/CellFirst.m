//
//  CellFirst.m
//  豆果美食
//
//  Created by 张琦 on 16/3/31.
//  Copyright © 2016年 张琦. All rights reserved.
//

#import "CellFirst.h"
#import "CollFirst.h"
#import "FirstModel.h"
@interface CellFirst ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flow;
@property (nonatomic, copy) nameBlock nameblock;

@end
@implementation CellFirst

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    // 创建布局对象
    self.flow = [[UICollectionViewFlowLayout alloc] init];
    self.flow.minimumInteritemSpacing = 1;
    self.flow.minimumLineSpacing = 10;
    self.flow.itemSize = CGSizeMake((screen_width-40) / 3, 40);
    /* 创建collectionView对象 */
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 10, screen_width-20, 0) collectionViewLayout:self.flow];
    self.collectionView.scrollEnabled = NO;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.collectionView];
    
    /* 两个协议 */
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[CollFirst class] forCellWithReuseIdentifier:@"2"];
}

- (void)setModel:(FirstModel *)model {
    _model = model;
    NSLog(@">>>>>Pathology>>>>>>>>%@",model.array);
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollFirst *coll = [collectionView dequeueReusableCellWithReuseIdentifier:@"2" forIndexPath:indexPath];
    Pathology *pathology = self.model.array[indexPath.item];
    coll.name = pathology.name;
    [coll renderCollFirst:NO];
    return coll;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_nameblock) {
        self.nameblock(self.model.array[indexPath.item]);
    }
    
    self.previousItem = self.currentItem;
    self.currentItem = (int)indexPath.row;
    if (self.previousItem != self.currentItem) {
        [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    }
    if (self.model.array.count > 0) {
        for (NSInteger i=0; i<self.model.array.count; i++) {
            if (i==self.currentItem) {
                NSIndexPath *indexPath1 = [NSIndexPath indexPathForItem:i inSection:0];
                CollFirst *cell = (CollFirst *)[collectionView cellForItemAtIndexPath:indexPath1];
                [cell renderCollFirst:YES];
            }else{
                NSIndexPath *indexPath1 = [NSIndexPath indexPathForItem:i inSection:0];
                CollFirst *cell = (CollFirst *)[collectionView cellForItemAtIndexPath:indexPath1];
                [cell renderCollFirst:NO];
            }
        }
    }
}

- (void)backNameWithNameBlock:(nameBlock)nameBlok {
    _nameblock = nameBlok;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(10, 10, screen_width-20, self.contentView.frame.size.height);
}

@end
