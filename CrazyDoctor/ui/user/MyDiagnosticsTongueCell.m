//
//  MyDiagnosticsTongueCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/11.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "MyDiagnosticsTongueCell.h"
#import "MyDiagnosticsTongueTagCollectionCell.h"
static NSString *myDiagnosticsTongueTagCollectionCellId = @"myDiagnosticsTongueTagCollectionCell";
@implementation MyDiagnosticsTongueCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
    self.dateLabel.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
    // 推荐专家
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 9.0;//item间距(最小值)
    flowLayout.minimumLineSpacing = 0.0;//行间距(最小值)
    //    float width = (46*self.classifyArray.count)+((self.classifyArray.count-1)*9);
    self.myDiagnosticsTongueCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(150,77, screen_width-150-15-35, 25)
                                                                collectionViewLayout:flowLayout];
    self.myDiagnosticsTongueCollectionView.delegate = self;
    self.myDiagnosticsTongueCollectionView.dataSource = self;
    self.myDiagnosticsTongueCollectionView.showsHorizontalScrollIndicator = NO;
    
    self.myDiagnosticsTongueCollectionView.backgroundColor = [UIColor clearColor];
    
    UINib *nib = [UINib nibWithNibName:@"MyDiagnosticsTongueTagCollectionCell" bundle: nil];
    [self.myDiagnosticsTongueCollectionView registerNib:nib
                             forCellWithReuseIdentifier:myDiagnosticsTongueTagCollectionCellId];
    
    [self.contentView addSubview:self.myDiagnosticsTongueCollectionView];
}

- (void)renderMyDiagnosticsTongueCellWithDiagnoseLog:(DiagnoseLog *)diagnoseLog{
    self.dateLabel.text = [DateUtils dateWithStringFromLongLongInt:diagnoseLog.createTime];
    self.tagsArray = [NSMutableArray new];
    self.diagnoseLog = diagnoseLog;
    [self.tongueIMgView sd_setImageWithURL:[NSURL URLWithString:diagnoseLog.tongueUrl] placeholderImage:[UIImage imageNamed:@"bg_default_she_picture"]];
    
    if ([NSStringUtils isNotBlank:diagnoseLog.bodyTagNames]) {
        NSArray *array = [diagnoseLog.bodyTagNames componentsSeparatedByString:@","];
        for (NSString *tagStr in array) {
            if ([NSStringUtils isNotBlank:tagStr]) {
                [self.tagsArray addObject:tagStr];
            }
        }
    }
    NSLog(@">>>>>>>>>>>>biaoqian>>>>>>%@",self.tagsArray);
    [self.myDiagnosticsTongueCollectionView reloadData];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.tagsArray.count;
}


-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyDiagnosticsTongueTagCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:myDiagnosticsTongueTagCollectionCellId
                                                                             forIndexPath:indexPath];
    if (self.tagsArray.count > 0) {
        NSString *tagStr = self.tagsArray[indexPath.item];
        [cell renderMyDiagnosticsTongueTagCollectionCellWithTagName:tagStr];
    }
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(55, 25);
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>%ld",(long)indexPath.item);
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
