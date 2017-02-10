//
//  TongueDiagnosisCompareController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/25.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "TongueDiagnosisCompareController.h"
#import "TongueDiagnosisStore.h"
#import "ShowIMGCollectionCell.h"
#import "ShowIMGModel.h"
#import "PreShowBigPicView.h"
#import "TongueDiagnosisTestController.h"
static NSString *tonguePictureCollectionCellId = @"tonguePictureCollectionCell";
@interface TongueDiagnosisCompareController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *selectedArray;

@property (nonatomic,assign)CGFloat collectionCellWidth;

@end

@implementation TongueDiagnosisCompareController
-(instancetype)initWithImage:(NSString *)sheImageUrl{
    self = [super init];
    if (self) {
        self.sheImageUrl = sheImageUrl;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorUtils colorWithHexString:white_text_color];
//    [self setRightSwipeGestureAndAdaptive];
    self.tongueListArray = [NSMutableArray new];
    self.selectedArray = [NSMutableArray new];
    self.dataArray = [NSMutableArray new];
    self.row = 0;
    [self initUI];
    [self loadData];
    
}

- (void)loadData{
    [TongueDiagnosisStore getAllBodyTags:^(NSArray *tags, NSError *err) {
        if (tags != nil) {
            for (NSDictionary *dict in tags) {
                self.tongueList = [[TongueList alloc] initWithDictionary:dict error:nil];
//                NSLog(@">>>>>>>>%@",self.tongueList);
                if (self.tongueList != nil) {
                    [self.tongueListArray addObject:self.tongueList];
                }
            }
            int integerNum = ((int)self.tongueListArray.count)/3;
            int remandNum = ((int)self.tongueListArray.count)%3;
            if (remandNum == 0) {
                self.row = integerNum;
            }else{
                self.row = integerNum + 1;
            }

        }
        [self loadModelData];
        [self initCountPhotosLibraryView];
        [self initTonguePicturesView];
        [self initBottomMarkView];
    }];
}
- (void)initUI{
    [self initHeadView];
    [self initBgScrollView];
    [self initTopRemindView];
    [self initBottomView];
}

- (void)loadModelData{
    if (self.tongueListArray.count > 0) {
        for (TongueList *tongue in self.tongueListArray) {
            NSMutableDictionary *infoDict = [[NSMutableDictionary alloc]init];
            [infoDict setValue:[NSNumber numberWithBool:NO] forKey:@"selectState"];
            [infoDict setValue:tongue.bodyTagQuestions forKey:@"bodyTagQuestions"];
            [infoDict setValue:tongue.detailImageUrl forKey:@"detailImageUrl"];
            [infoDict setValue:tongue.logoUrl forKey:@"logoUrl"];
            [infoDict setValue:tongue.name forKey:@"name"];
            [infoDict setValue:tongue.nameUrl forKey:@"nameUrl"];
            [infoDict setValue:tongue.remark forKey:@"remark"];
            [infoDict setValue:tongue.tongueImageUrl forKey:@"tongueImageUrl"];
            [infoDict setValue:@(tongue.id) forKey:@"id"];
            //封装数据模型
            ShowIMGModel *model = [[ShowIMGModel alloc] initWithDict:infoDict];
            [self.dataArray addObject:model];
        }
        
        [self.collectionView reloadData];
    }
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"舌诊对比" navigationController:self.navigationController];
    [self.view addSubview:self.headerView];
    
    self.rightReTakePhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightReTakePhotoBtn.frame = CGRectMake(screen_width-25-17, 20, 44, 44);
    [self.rightReTakePhotoBtn setImage:[UIImage imageNamed:@"icon_homepage_abandon_photograph_nor"] forState:UIControlStateNormal];
    [self.rightReTakePhotoBtn setImage:[UIImage imageNamed:@"icon_homepage_abandon_photograph_pre"] forState:UIControlStateHighlighted];
    [self.rightReTakePhotoBtn addTarget:self action:@selector(rightReTakePhotoBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.rightReTakePhotoBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.rightReTakePhotoBtn];
}

- (void)initBgScrollView{
    self.bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width, screen_height-self.headerView.frame.size.height-tabbar_height)];
    self.bgScrollView.backgroundColor = [ColorUtils colorWithHexString:white_text_color];
    self.bgScrollView.showsVerticalScrollIndicator = NO;
    self.bgScrollView.delegate =self;
    [self.view addSubview:self.bgScrollView];
}

-(void)initTopRemindView{
    self.topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 55)];
    self.topBgView.backgroundColor = [ColorUtils colorWithHexString:white_text_color];
    [self.bgScrollView addSubview:self.topBgView];

    self.topLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 13, screen_width-15, 20)];
    self.topLabel.backgroundColor = [ColorUtils colorWithHexString:white_text_color];
    self.topLabel.text = @"第一步：您的舌象";
    self.topLabel.font = [UIFont boldSystemFontOfSize:default_font_size];
    self.topLabel.textColor = [ColorUtils colorWithHexString:gray_text_color];
    self.topLabel.textAlignment = NSTextAlignmentLeft;
    [self.topBgView addSubview:self.topLabel];
    
    self.remarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.topLabel.bottomY, screen_width, 20)];
    self.remarkLabel.backgroundColor = [ColorUtils colorWithHexString:white_text_color];
    self.remarkLabel.text = @"如果您的舌象不清晰，可点击右上角的舌拍图标重新拍照";
    self.remarkLabel.font = [UIFont systemFontOfSize:smallest_font_size];
    self.remarkLabel.textColor = [ColorUtils colorWithHexString:@"#f45f41"];
    self.remarkLabel.textAlignment = NSTextAlignmentLeft;
    [self.topBgView addSubview:self.remarkLabel];

    float height = ((screen_width-30)*42)/69;
    self.myTonguePictureImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, self.topBgView.bottomY, screen_width-30, height)];
    
    [self.myTonguePictureImgView sd_setImageWithURL:[NSURL URLWithString:self.sheImageUrl] placeholderImage:[UIImage imageNamed:@"bg_default_she_picture"]];

    self.myTonguePictureImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.myTonguePictureImgView.clipsToBounds = YES;

    [self.bgScrollView addSubview:self.myTonguePictureImgView];
    
    self.secondMarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(general_margin, self.myTonguePictureImgView.bottomY+18, screen_width-30, 40)];
    self.secondMarkLabel.text = @"第二步：找出与自己相似的舌象，并选择下方问题进行回答，最多可选3套";
    self.secondMarkLabel.font = [UIFont boldSystemFontOfSize:default_font_size];
    self.secondMarkLabel.textColor = [ColorUtils colorWithHexString:gray_text_color];
    self.secondMarkLabel.numberOfLines = 0;
    self.secondMarkLabel.textAlignment = NSTextAlignmentLeft;
    [self.bgScrollView addSubview:self.secondMarkLabel];

}

 -(UIImage *)getImageFromImage:(UIImage*)superImage subImageSize:(CGSize)subImageSize subImageRect:(CGRect)subImageRect {
//     定义裁剪的区域相对于原图片的位置
     CGImageRef imageRef = superImage.CGImage;
     CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, subImageRect);
    UIGraphicsBeginImageContext(subImageSize);
     CGContextRef context = UIGraphicsGetCurrentContext();
     CGContextDrawImage(context, subImageRect, subImageRef);
     UIImage* returnImage = [UIImage imageWithCGImage:subImageRef];
     return returnImage;
 }

- (void)initCountPhotosLibraryView{
    self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(general_margin, self.secondMarkLabel.bottomY, screen_width-30, 20)];
    self.countLabel.textAlignment = NSTextAlignmentRight;
    self.countLabel.text = @"0/3";
    self.countLabel.textColor = [ColorUtils colorWithHexString:@"#f56d53"];
    self.countLabel.font = [UIFont boldSystemFontOfSize:default_1_font_size];
    [self.bgScrollView addSubview:self.countLabel];
}

- (void)initTonguePicturesView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumInteritemSpacing = 10.0;
    flowLayout.minimumLineSpacing      = 10.0;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(general_margin, self.countLabel.bottomY, screen_width-30, self.row*80+(self.row-1)*10) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    UINib *nib = [UINib nibWithNibName:@"TonguePictureCollectionCell" bundle: nil];
    [self.collectionView registerNib:nib
                        forCellWithReuseIdentifier:tonguePictureCollectionCellId];
    [self.bgScrollView addSubview:self.collectionView];
    self.bgScrollView.contentSize = CGSizeMake(screen_width, self.countLabel.bottomY+60);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

   __weak TonguePictureCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:tonguePictureCollectionCellId forIndexPath:indexPath];
    ShowIMGModel *model =self.dataArray[indexPath.row];
    __weak TongueDiagnosisCompareController *WeakSelf = self;
    cell.selectedBlock = ^(BOOL select){
        model.selected = select;
        if (select) {
            if (WeakSelf.selectedArray.count < 3) {
                NSLog(@">>>>>>>>>>>>小于3");
                [WeakSelf.selectedArray addObject:model];
            }else{
                NSLog(@">>>>>>>>>>>>大于3了");
                [cell.selectedBtn setImage:[UIImage imageNamed:@"icon_abandon_picture_select_nor"] forState:UIControlStateSelected];
                model.selected = NO;
                [WeakSelf.selectedArray removeObject:model];
                [self.view makeToast:@"最多选择3个！" duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
//                return;
            }
        }else{
            [cell.selectedBtn setImage:[UIImage imageNamed:@"icon_abandon_picture_select"] forState:UIControlStateSelected];
            [WeakSelf.selectedArray removeObject:model];
        }
        self.countLabel.text = [NSString stringWithFormat:@"%ld/3",(long)WeakSelf.selectedArray.count];
    };
    
    cell.previewBlock = ^(){
        
        WeakSelf.pre = [[PreShowBigPicView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height) nav:self.navigationController pageCount:(int)(self.dataArray.count) pageNum:indexPath.row selectedCount:(int)self.selectedArray.count myTongueUrl:self.sheImageUrl];
        WeakSelf.pre.backgroundColor = [UIColor blackColor];
        WeakSelf.pre.alpha = 0.8;
        WeakSelf.pre.imgModelArray = [NSMutableArray arrayWithArray:self.dataArray];
        WeakSelf.pre.pageNum       = indexPath.row;
        WeakSelf.pre.selectedArray = [NSMutableArray arrayWithArray:self.selectedArray];
        WeakSelf.pre.selectBlock = ^(NSMutableArray *array,ShowIMGModel *model,BOOL selected){
            WeakSelf.selectedArray = [NSMutableArray arrayWithArray:array];
            model.selected = selected;
            [WeakSelf.collectionView reloadData];
            self.countLabel.text = [NSString stringWithFormat:@"%ld/3",(long)WeakSelf.selectedArray.count];
        };
        [WeakSelf.pre.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
        [WeakSelf.pre.collectionView reloadData];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddePreShowBigPicView)];
        [WeakSelf.pre addGestureRecognizer:tap];
        
        [self.view addSubview:WeakSelf.pre];
    };
    [cell configWithModel:model];
    
    return cell;
}

- (void)hiddePreShowBigPicView{
    NSLog(@">>>>>>>>>>>>>溢出视图");
    [self.pre removeFromSuperview];
    [self.pre.collectionView removeFromSuperview];
    [self.pre.rightItemBtn removeFromSuperview];
    [self.pre.myTongueImgView removeFromSuperview];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGSize collectionSize = {(screen_width-30-20)/3,80};
    return collectionSize;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
}


- (void)initBottomMarkView{

    UILabel *healthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.collectionView.bottomY+20, screen_width, 20)];
    healthLabel.text = @"(健康舌象：淡红舌，薄白苔)";
    healthLabel.font = [UIFont boldSystemFontOfSize:default_2_font_size];
    healthLabel.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
    healthLabel.textAlignment = NSTextAlignmentCenter;
    [self.bgScrollView addSubview:healthLabel];
    self.bgScrollView.contentSize = CGSizeMake(screen_width, healthLabel.bottomY+60);
}

- (void)initBottomView{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, screen_height-51, screen_width, splite_line_height)];
    lineView.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
    [self.view addSubview:lineView];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(general_margin, lineView.bottomY+((51-40)/2), screen_width-30, 40);

    UIImage *hightLightImage = [UIImage imageNamed:@"btn_login_pre"];
    [nextBtn setBackgroundImage:[ImageUtils resizableBgImage:hightLightImage] forState:UIControlStateNormal];
    [nextBtn setBackgroundImage:[ImageUtils resizableBgImage:hightLightImage] forState:UIControlStateHighlighted];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn.titleLabel setFont:[UIFont systemFontOfSize:bigger_font_size]];
    [nextBtn addTarget:self action:@selector(nextBtn) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nextBtn];
}

- (void)rightReTakePhotoBtn:(UIButton *)sender{
    self.homevc = [[HomeViewController alloc] init];
    self.homevc.delegate = self;
    [self presentViewController:self.homevc animated:YES completion:nil];
    
    self.remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, screen_width, 40)];
    self.remindLabel.backgroundColor = [UIColor clearColor];
    self.remindLabel.text = @"请伸出舌头并放在下方拍照框";
    self.remindLabel.textColor = [UIColor whiteColor];
    self.remindLabel.font = [UIFont systemFontOfSize:default_font_size];
    self.remindLabel.textAlignment = NSTextAlignmentCenter;
    [self.homevc.view addSubview:self.remindLabel];
    
//    float y = ((screen_width-40)*198)/750;
//    float h = screen_height-y-(((screen_width-40)*274)/750)-85-20;
//    
//    self.markImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, y, screen_width-40, h)];
//    //    markImgView.backgroundColor = [UIColor purpleColor];
//    self.markImgView.image = [UIImage imageNamed:@"bg_abandon_photograph_wireframe"];
//    self.markImgView.backgroundColor = [UIColor clearColor];
//    [self.homevc.view addSubview:self.markImgView];
//    
//    float tongueImgViewW = ((h-80)*384)/628;
//    UIImageView *tongueImgView = [[UIImageView alloc] initWithFrame:CGRectMake((screen_width-40-tongueImgViewW)/2, 40, tongueImgViewW, h-80)];
//    tongueImgView.image = [UIImage imageNamed:@"bg_abandon_photograph"];
//    tongueImgView.backgroundColor = [UIColor clearColor];
//    [self.markImgView addSubview:tongueImgView];
    
    self.contentCameraLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, screen_height-60-10-85, screen_width-65, 85)];
    self.contentCameraLabel.backgroundColor = [UIColor clearColor];
    NSString *contentStr = @"1.请在充足光线在拍照。\n2.刷牙及饭后不要立即做舌像自诊，会有误差。\n3.不要在吃进色素等人为染苔行为下做自诊。";
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:contentStr];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [contentStr length])];
    [self.contentCameraLabel setAttributedText:attributedString];
    self.contentCameraLabel.numberOfLines = 0;
    self.contentCameraLabel.textColor = [ColorUtils colorWithHexString:white_text_color];
    self.contentCameraLabel.font = [UIFont systemFontOfSize:small_font_size];
    self.contentCameraLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentCameraLabel sizeToFit];
    [self.homevc.view addSubview:self.contentCameraLabel];
}

-(void) homeViewController:(HomeViewController *)picker didFinishPickingMediaWithImage:(UIImage *)image{
    [picker dismissViewControllerAnimated:NO completion:nil];
//    image = [ImageUtils imageWithImageSimple:image scaledToSize:CGSizeMake(220, 220)];
    self.myTonguePictureImgView.image = image;
    [SVProgressHUD showWithStatus:@"图片上传中..." maskType:SVProgressHUDMaskTypeBlack];
    [TongueDiagnosisStore upLoadTongueDiagnosisImg:^(NSString *imgUrl, NSError *err) {
        [SVProgressHUD dismiss];
        if (imgUrl != nil) {
            NSLog(@">>>>>>>>>>>>>>>>>>上传的舌头照片----%@",imgUrl);
            self.sheImageUrl = imgUrl;
            [self.myTonguePictureImgView sd_setImageWithURL:[NSURL URLWithString:self.sheImageUrl] placeholderImage:[UIImage imageNamed:@"bg_default_she_picture"]];
            
            self.myTonguePictureImgView.contentMode = UIViewContentModeScaleAspectFill;
            self.myTonguePictureImgView.clipsToBounds = YES;

        }else{
            ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
            [self.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        }
    } tongueImage:image];
}

- (void)nextBtn{
    if (self.selectedArray.count > 0) {
//        for (ShowIMGModel *model in self.selectedArray) {
//            NSLog(@">>>>>>>>>>>>>>>>%@",self.selectedArray);
//        }
        TongueDiagnosisTestController *tdtvc = [[TongueDiagnosisTestController alloc] initWithModelArray:self.selectedArray tongueImgUrl:self.sheImageUrl];
        [self.navigationController pushViewController:tdtvc animated:YES];
  
    }else{
        [self.view makeToast:@"您还未选择符合自己的舌象" duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
