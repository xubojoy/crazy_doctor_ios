/**
 !! 随便弄了一下，只是为了 目前项目的使用.过几天会 完善
 !! 加入单例等
 
 有问题可以联系 邮箱 906037367@qq.com
 QQ               906037367
 

 */

#import "PellTableViewSelect.h"
#import "PellTableViewCell.h"
#define  LeftView 10.0f
#define  TopToView 10.0f
@interface  PellTableViewSelect()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,copy) NSArray *selectData;
@property (nonatomic,copy) void(^action)(NSInteger index);
@property (nonatomic,copy) NSArray * imagesData;
@end



PellTableViewSelect * backgroundView;
UITableView * tableView;

@implementation PellTableViewSelect


- (instancetype)init{
    if (self = [super init]) {
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

+ (void)addPellTableViewSelectWithWindowFrame:(CGRect)frame
                                   selectData:(NSArray *)selectData
                                       images:(NSArray *)images
                                       action:(void(^)(NSInteger index))action animated:(BOOL)animate
                                        navController:(UINavigationController *)nav
{
    if (backgroundView != nil) {
        [PellTableViewSelect hiden];
    }
//    UIWindow *win = [[[UIApplication sharedApplication] windows] firstObject];
    
    backgroundView = [[PellTableViewSelect alloc] initWithFrame:nav.view.bounds];
    backgroundView.action = action;
    backgroundView.imagesData = images ;
    backgroundView.selectData = selectData;
    backgroundView.backgroundColor = [UIColor colorWithHue:0
                                                saturation:0
                                                brightness:0 alpha:0];
    [nav.view addSubview:backgroundView];
    
    // TAB
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(screen_width - 80 , 70.0 -  20.0 * selectData.count+9.0 , frame.size.width, 40 * selectData.count) style:0];
    tableView.dataSource = backgroundView;
    tableView.delegate = backgroundView;
    tableView.layer.cornerRadius = 3.0f;
    // 定点
    tableView.layer.anchorPoint = CGPointMake(1.0, 0);
    tableView.transform =CGAffineTransformMakeScale(0.0001, 0.0001);
    
    tableView.rowHeight = 40;
    tableView.backgroundColor = [ColorUtils colorWithHexString:common_app_text_color];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [nav.view addSubview:tableView];
    [nav.view bringSubviewToFront:backgroundView];
    [nav.view bringSubviewToFront:tableView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgroundClick)];
    [backgroundView addGestureRecognizer:tap];
    backgroundView.action = action;
    backgroundView.selectData = selectData;
//    tableView.layer.anchorPoint = CGPointMake(100, 64);


    if (animate == YES) {
//        backgroundView.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            backgroundView.alpha = 1;
           tableView.transform = CGAffineTransformMakeScale(1.0, 1.0);
           
        }];
    }
}
+ (void)tapBackgroundClick
{
    [PellTableViewSelect hiden];
}
+ (void)hiden
{
    if (backgroundView != nil) {
        
        [UIView animateWithDuration:0.3 animations:^{
            tableView.transform = CGAffineTransformMakeScale(0.000001, 0.0001);
        } completion:^(BOOL finished) {
            [backgroundView removeFromSuperview];
            [tableView removeFromSuperview];
            tableView = nil;
            backgroundView = nil;
        }];
    }
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _selectData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *pellTableViewCellIdentifier = @"pellTableViewCell";
    UINib *nib = [UINib nibWithNibName:@"PellTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:pellTableViewCellIdentifier];
    PellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pellTableViewCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [ColorUtils colorWithHexString:common_app_text_color];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, general_cell_height)];
    view.backgroundColor = [ColorUtils colorWithHexString:@"#532c0d"];
    cell.selectedBackgroundView = view;
    cell.iconImgView.image = [UIImage imageNamed:self.imagesData[indexPath.row]];
    cell.titleLabel.text = _selectData[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.action) {
        self.action(indexPath.row);
    }
    [PellTableViewSelect hiden];
}

#pragma mark 绘制三角形
- (void)drawRect:(CGRect)rect

{
    // 设置背景色
    [[ColorUtils colorWithHexString:common_app_text_color] set];
    //拿到当前视图准备好的画板
    
    CGContextRef  context = UIGraphicsGetCurrentContext();
    
    //利用path进行绘制三角形
    
    CGContextBeginPath(context);//标记
    CGFloat location = screen_width;
    CGContextMoveToPoint(context,
                         location -  LeftView - 10, 69);//设置起点
    
    CGContextAddLineToPoint(context,
                             location - 10-5 ,  79);
    
    CGContextAddLineToPoint(context,
                            location - TopToView * 3+5, 79);
    
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    
    [[ColorUtils colorWithHexString:common_app_text_color] setFill];  //设置填充色
    
    [[ColorUtils colorWithHexString:common_app_text_color] setStroke]; //设置边框颜色
    
    CGContextDrawPath(context,
                      kCGPathFillStroke);//绘制路径path
    
//    [self setNeedsDisplay];
}

@end
