//
//  MyDiagnosticsEyeCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/11.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "MyDiagnosticsEyeCell.h"
typedef void(^ISLimitWidth)(BOOL yesORNo,id data);

static NSString *kCellIdentifier   = @"CellIdentifier";
@implementation MyDiagnosticsEyeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
    self.dateLabel.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
    self.remindLabel.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
    
    CGRect collectionViewFrame = CGRectMake(150, (155-20)/2+51, screen_width-150-15-10, 2000);
    UICollectionViewLeftAlignedLayout * layout = [[UICollectionViewLeftAlignedLayout alloc] init];
    layout.minimumLineSpacing = 5;
    self.myDiagnosticsEyeCollectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:layout];
    self.myDiagnosticsEyeCollectionView.delegate = self;
    self.myDiagnosticsEyeCollectionView.dataSource = self;
    
    self.myDiagnosticsEyeCollectionView.backgroundColor = [UIColor clearColor];
    
    [self.myDiagnosticsEyeCollectionView registerClass:[SectionHeaderViewCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
    self.myDiagnosticsEyeCollectionView.bounces = NO;
    
    [self.myDiagnosticsEyeCollectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
    self.myDiagnosticsEyeCollectionView.allowsMultipleSelection = YES;
    
    self.myDiagnosticsEyeCollectionView.showsHorizontalScrollIndicator = NO;
    self.myDiagnosticsEyeCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.myDiagnosticsEyeCollectionView.scrollsToTop = YES;
    
    [self.contentView addSubview:self.myDiagnosticsEyeCollectionView];
}


- (void)renderMyDiagnosticsEyeCellWithDiagnoseLog:(DiagnoseLog *)diagnoseLog{
    
    self.dateLabel.text = [DateUtils dateWithStringFromLongLongInt:diagnoseLog.createTime];
    self.tagsArray = [NSMutableArray new];
    self.diagnoseLog = diagnoseLog;
    if ([NSStringUtils isNotBlank:diagnoseLog.visceras]) {
        NSArray *array = [diagnoseLog.visceras componentsSeparatedByString:@","];
        for (NSString *tagStr in array) {
            if ([NSStringUtils isNotBlank:tagStr]) {
               [self.tagsArray addObject:tagStr];
            }
        }
    }
//    NSLog(@">>>>>>>>>>>>biaoqian>>>>>>%@",self.tagsArray);
    [self.myDiagnosticsEyeCollectionView reloadData];
    
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
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.titleLabel.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    cell.sepImageView.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    if (self.tagsArray.count > 0) {
        NSString *tagName = self.tagsArray[indexPath.item];
        cell.titleLabel.text = tagName;
        int num = (cell.frame.origin.y+25)/25;
//        NSLog(@">>>>>>>>行数>>>>>>>>>>%d",num);
        if (num == 0) {
           self.myDiagnosticsEyeCollectionView.frame = CGRectMake(150, 51+(155-20)/2, screen_width-150-15-10,20);
        }else if (num == 1) {
            self.myDiagnosticsEyeCollectionView.frame = CGRectMake(150, 51+(155-20-25)/2, screen_width-150-15-10, 25+20);
        }else{
            float H = (num)*25+(num-1)*5;
            self.myDiagnosticsEyeCollectionView.frame = CGRectMake(150, 51+(155-H)/2, screen_width-150-15-10, H);
        }
    }else{
        self.myDiagnosticsEyeCollectionView.frame = CGRectMake(150, 51+(155-20)/2, screen_width-150-15-10,20);
    }
    return cell;
}

#pragma mark 头视图size
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = {screen_width-150-15-10, 20.0};
    return size;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            SectionHeaderViewCollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"head" forIndexPath:indexPath];
            headView.titleLabel.text = @"请注意以下脏腑问题的防范";
            return headView;
        }
    }
    return nil;
}

- (float)getCollectionCellWidthText:(NSString *)text{
    float cellWidth;
    CGSize size = [text sizeWithAttributes:
                   @{NSFontAttributeName:
                         [UIFont boldSystemFontOfSize:big_font_size]}];
    
    cellWidth = ceilf(size.width) + kCellBtnCenterToBorderMargin;
    cellWidth = [self checkCellLimitWidth:cellWidth isLimitWidth:nil];
    return cellWidth;
}


- (float)checkCellLimitWidth:(float)cellWidth isLimitWidth:(ISLimitWidth)isLimitWidth {
    float limitWidth = (CGRectGetWidth(self.myDiagnosticsEyeCollectionView.frame)-kCollectionViewToLeftMargin-kCollectionViewToRightMargin);
    if (cellWidth >= limitWidth) {
        cellWidth = limitWidth;
        isLimitWidth?isLimitWidth(YES,@(cellWidth)):nil;
        return cellWidth;
    }
    isLimitWidth?isLimitWidth(NO,@(cellWidth)):nil;
    return cellWidth;
}

#pragma mark - UICollectionViewDelegateLeftAlignedLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // cell 的宽
    NSString *text = self.tagsArray[indexPath.row];
    float cellWidth = [self getCollectionCellWidthText:text];
    return CGSizeMake(cellWidth, kCollectionViewCellHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return kCollectionViewCellsHorizonMargin;//cell之间的间隔
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
