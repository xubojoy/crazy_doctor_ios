//
//  BAddressPickerController.m
//  Bee
//
//  Created by 林洁 on 16/1/12.
//  Copyright © 2016年 Lin. All rights reserved.
//

#import "BAddressPickerController.h"
#import "ChineseToPinyin.h"
#import "BAddressHeader.h"
#import "BCurrentCityCell.h"
#import "BRecentCityCell.h"
#import "BHotCityCell.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
#import "CityStore.h"
#import "ChineseString.h"
@interface BAddressPickerController (){
    NSArray *titleArray;
    NSMutableArray *resultArray;
}

@end

@implementation BAddressPickerController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    debugMethod();
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.autoresizesSubviews = NO;
    self.view.backgroundColor = [ColorUtils colorWithHexString:@"#fafafa"];
    self.navigationController.navigationBarHidden = YES;
    [self setRightSwipeGestureAndAdaptive];
    [self initHeadView];
    if ([[AppStatus sharedInstance] isConnetInternet]) {
        NSLog(@">>>>>>>>>>>>联网成功");
        titleArray = [self getSectionTitles];
        resultArray = [[NSMutableArray alloc] init];
        self.citiesArray = [NSMutableArray new];
        self.sortCityDict = [NSMutableDictionary new];
        self.hotCitiesArray = [NSMutableArray new];
        self.recentVisitCityArray = [NSMutableArray new];
        self.recentCitesDict = [NSMutableDictionary new];
        [self loadRecentVisitCitiesArrayData];
        [self loadHotCitiesData];
        [self loadCityData];
        
    }else{
        NSLog(@">>>>>>>>>>>>联网失败");
        [self initRefreshUIBtn];
    }
    
}

#pragma mark - 数据加载

- (void)loadRecentVisitCitiesArrayData{
    for (NSString *city in [AppStatus sharedInstance].recentCityArray) {
        NSLog(@">>>>>>>>>>最近访问city的城市3333333>>>>>>>>>>>>%@",city);
        [self.recentVisitCityArray addObject:city];
    }
    [self.tableView reloadData];
}

- (void)loadHotCitiesData{
    [SVProgressHUD showWithStatus:@"加载数据..." maskType:SVProgressHUDMaskTypeBlack];
    [CityStore getAllHotCitys:^(NSArray *hotCitiesArr, NSError *err) {
        [SVProgressHUD dismiss];
        if (hotCitiesArr != nil) {
            for (NSDictionary *hotCityDic in hotCitiesArr) {
//                NSLog(@">>>>>>返回的数据hotCityDic>>>>>>%@",hotCityDic);
                self.hotCity = [[City alloc] initWithDictionary:hotCityDic error:nil];
//                NSLog(@">>>>>>返回的数据self.hotCity>>>>>>%@",self.hotCity);
                if (self.hotCity != nil) {
                    [self.hotCitiesArray addObject:self.hotCity];
//                    NSLog(@">>>>>>返回的数据self.hotCitiesArray>>>>>>%@",self.hotCitiesArray);
                }
            }
            [self initUI];
        }else{
            ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
            [self.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
            [self initRefreshUIBtn];
        }
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:2];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    }];
}

- (void)loadCityData{
    [SVProgressHUD showWithStatus:@"加载数据..." maskType:SVProgressHUDMaskTypeBlack];
    [CityStore getAllCitys:^(NSDictionary *dict, NSError *err) {
        [SVProgressHUD dismiss];
//        NSLog(@">>>>>>返回的数据>>>>>>%@",dict);
        if (dict != nil) {
            for (NSDictionary *areaTmpDic in dict) {
                self.area = [[Area alloc] initWithDictionary:areaTmpDic error:nil];
//                NSLog(@">>>>>>返回的数据self.area>>>>>>%@",self.area);
                for (NSDictionary *provinceDic in self.area.provinces) {
                    self.province = [[Province alloc] initWithDictionary:provinceDic error:nil];
//                    NSLog(@">>>>>>返回的数据self.area>>>>>>%@",self.province);
                    for (NSDictionary *citysDict in self.province.cities) {
                        self.city = [[City alloc] initWithDictionary:citysDict error:nil];
                        if (self.city != nil) {
                            [self.citiesArray addObject:self.city.name];
                            //                        NSLog(@">>>>>>返回的数据self.citiesArray>>>>>>%@",self.citiesArray);
                        }
                    }
                }
            }
            self.sortCityArray = [ChineseString LetterSortArray:self.citiesArray];
//            NSLog(@">>>>>>返回的数据self.sortUserArray>>>>>>%@",self.sortCityArray);
            for (NSInteger i = 0; i < self.sortCityArray.count; i ++) {
                [self.sortCityDict setValue:self.sortCityArray[i] forKey:self.getSectionTitles[i]];
            }
            [self initUI];
//            NSLog(@">>>>>>返回的数据self.sortCityDict>>>>>>%@",self.sortCityDict);
        }else{
            ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
            [self.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
            [self initRefreshUIBtn];
        }
        [self.tableView reloadData];
    }];
}

- (NSArray *) getSectionTitles {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 26; i++) {
        if (i == 8 || i == 14 || i == 20 || i== 21) {
            continue;
        }
        NSString *cityKey = [NSString stringWithFormat:@"%c",i+65];
        [arr addObject:cityKey];
    }
    return arr;
}



#pragma mark - 初始化自定义View
- (void)initUI{
    [self initMysearchBarAndMysearchDisPlay];
    [self initTableView];
    [self initRightIndexView];
}

//初始化自定义导航
-(void)initHeadView{
    NSString *currentCity = [NSString stringWithFormat:@"当前城市-%@",[AppStatus sharedInstance].cityName];
    self.headerView = [[HeaderView alloc] initWithTitle:currentCity navigationController:self.navigationController];
    [self.view addSubview:self.headerView];
}


- (void)initRefreshUIBtn{
    self.refreshUIView = [[RefreshUIView alloc] initWithFrame:CGRectMake(0, (screen_height-50)/2, screen_width, 50)];
    self.refreshUIView.backgroundColor = [ColorUtils colorWithHexString:@"#fafafa"];
    self.refreshUIView.delegate = self;
    [self.view addSubview:self.refreshUIView];
}

- (void)initRightIndexView{
    self.customIndexView = [YXDCustomIndexView customIndexViewWithWidth:30
                                                                 center:CGPointMake(screen_width-15, ([UIScreen mainScreen].bounds.size.height/2)+64)
                                                      sectionTitleArray:titleArray
                                                               delegate:self
                                                              superView:self.view];
    
}

-(void)initMysearchBarAndMysearchDisPlay
{
    self.mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width, 100)];
    self.mySearchBar.delegate = self;
    //设置选项
//    [self.mySearchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self.mySearchBar sizeToFit];
    
    self.mySearchBar.placeholder = @"城市/行政区/拼音";
    NSArray *subViews;
    if (IOS7) {
        subViews = [(self.mySearchBar.subviews[0]) subviews];
    }
    else {
        subViews = self.mySearchBar.subviews;
    }
    for (id view in subViews) {
        if ([view isKindOfClass:[UITextField class]]){
            UITextField *textField = (UITextField *)view;
            //            textField.backgroundColor = [ColorUtils colorWithHexString:searchBar_textField_background_color];
            textField.textColor = [UIColor blackColor];
            NSUInteger length = [self.mySearchBar.placeholder length];
            // 创建可变属性化字符串
            NSMutableAttributedString *attrString =
            [[NSMutableAttributedString alloc] initWithString:self.mySearchBar.placeholder];
            // 设置颜色
            UIColor *color = [ColorUtils colorWithHexString:placeholer_color];
            [attrString addAttribute:NSForegroundColorAttributeName
                               value:color
                               range:NSMakeRange(0, length)];
            [textField.layer setBorderWidth:0.5];
            [textField.layer setBorderColor:[ColorUtils colorWithHexString:splite_line_color].CGColor];
            [textField.layer setCornerRadius:5];
            
            textField.attributedPlaceholder = attrString;
            
        }
    }
    
    [self.mySearchBar setSearchFieldBackgroundImage:nil forState:UIControlStateNormal];
    self.mySearchBar.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    self.mySearchBar.backgroundImage = [self imageWithColor:[ColorUtils colorWithHexString:gray_common_color] size:self.mySearchBar.bounds.size];
    [self.view addSubview:self.mySearchBar];
    
    self.mySearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.mySearchBar contentsController:self];
    self.mySearchDisplayController.delegate = self;
    self.mySearchDisplayController.searchResultsDataSource = self;
    self.mySearchDisplayController.searchResultsDelegate = self;
}

- (void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.mySearchBar.frame.size.height+self.headerView.frame.size.height+splite_line_height, ScreenWidth-30, ScreenHeight-44-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
}

#pragma mark UISearchBar and UISearchDisplayController Delegate Methods
//searchBar开始编辑时改变取消按钮的文字
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.mySearchBar.showsCancelButton = YES;
    
    NSArray *subViews;
    
    if (IOS7) {
        subViews = [(self.mySearchBar.subviews[0]) subviews];
    }
    else {
        subViews = self.mySearchBar.subviews;
    }
    
    for (id view in subViews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton* cancelbutton = (UIButton* )view;
            NSString *title = @"取消";
            NSUInteger length = [title length];
            // 创建可变属性化字符串
            NSMutableAttributedString *attrString =
            [[NSMutableAttributedString alloc] initWithString:title];
            // 设置颜色
            UIColor *color = [UIColor blackColor];
            [attrString addAttribute:NSForegroundColorAttributeName
                               value:color
                               range:NSMakeRange(0, length)];
            [cancelbutton setAttributedTitle:attrString forState:UIControlStateNormal];
            
            break;
        }else if ([view isKindOfClass:[UITextField class]]){
            //            NSLog(@">>>>>>>>>>>>>>>>>>%@",view);
            //            UITextField *textField = (UITextField *)view;
            
            //            textField.backgroundColor = [ColorUtils colorWithHexString:searchBar_textField_background_color];
        }
    }
}

#pragma mark - UISearchBar Delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"开始搜索22222");
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    NSLog(@"开始搜索searchBarShouldEndEditing");

    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@">>>>>>>>>>>点击搜索");
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString

{
    //一旦SearchBar输入內容有变化，则执行这个方法，询问要不要重裝searchResultTableView的数据
    [self filterContentForSearchText:searchString
                               scope:[self.mySearchBar scopeButtonTitles][self.mySearchBar.selectedScopeButtonIndex]];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption

{
    //如果设置了选项，当Scope Button选项有变化的时候，则执行这个方法，询问要不要重裝searchResultTableView的数据
    [self filterContentForSearchText:self.mySearchBar.text
                               scope:self.mySearchBar.scopeButtonTitles[searchOption]];
    return YES;
}

//源字符串内容是否包含或等于要搜索的字符串内容
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    resultArray = [[NSMutableArray alloc]init];
    if (self.mySearchBar.text.length>0&&![ChineseInclude isIncludeChineseInString:self.mySearchBar.text]) {
        for (int i = 0; i< self.citiesArray.count; i++) {
            if ([ChineseInclude isIncludeChineseInString:self.citiesArray[i]]) {
                NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:self.citiesArray[i]];
                NSRange titleResult=[tempPinYinStr rangeOfString:self.mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [resultArray addObject:self.citiesArray[i]];
                }
                NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:self.citiesArray[i]];
                NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:self.mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleHeadResult.length>0) {
                    [resultArray addObject:self.citiesArray[i]];
                }
            }
            else {
                NSRange titleResult=[self.citiesArray[i] rangeOfString:self.mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [resultArray addObject:self.citiesArray[i]];
                }
            }
        }
    } else if (self.mySearchBar.text.length>0&&[ChineseInclude isIncludeChineseInString:self.mySearchBar.text]) {
        for (NSString *tempStr in self.citiesArray) {
            NSRange titleResult=[tempStr rangeOfString:self.mySearchBar.text options:NSCaseInsensitiveSearch];
            if (titleResult.length>0) {
                [resultArray addObject:tempStr];
            }
        }
    }
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.tableView) {
        return [[self.sortCityDict allKeys] count] + 3;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        if (section > 2) {
            NSString *cityKey = [titleArray objectAtIndex:section - 3];
            NSArray *array = [self.sortCityDict objectForKey:cityKey];
            return [array count];
        }
        return 1;
    }else{
        return [resultArray count];
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        if (indexPath.section == 0) {
            static NSString *currentCityCellIdentifier = @"currentCityCell";
            BCurrentCityCell *currentCityCell = [tableView dequeueReusableCellWithIdentifier:currentCityCellIdentifier];
            if (currentCityCell == nil) {
                currentCityCell = [[BCurrentCityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:currentCityCellIdentifier];
            }
            currentCityCell.selectionStyle = UITableViewCellSelectionStyleNone;
            currentCityCell.backgroundColor = [UIColor whiteColor];
            [currentCityCell buttonWhenClick:^(UIButton *button) {
                [self.navigationController popViewControllerAnimated:YES];
                if ([self.delegate respondsToSelector:@selector(addressPicker:didSelectedCity:)]) {
                    [self.delegate addressPicker:self didSelectedCity:button.titleLabel.text];
                    [[AppStatus sharedInstance] addRecentCity:button.titleLabel.text];
                    [AppStatus saveAppStatus];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"开始改善" object:nil];
                }
            }];
            return currentCityCell;
        }else if (indexPath.section == 1){
            static NSString *recentCityCellIdentifier = @"recentCityCell";
            BRecentCityCell *recentCityCell = [tableView dequeueReusableCellWithIdentifier:recentCityCellIdentifier];
            if (recentCityCell == nil) {
                recentCityCell = [[BRecentCityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:recentCityCellIdentifier cityArray:self.recentVisitCityArray];
            }
            recentCityCell.selectionStyle = UITableViewCellSelectionStyleNone;
            recentCityCell.backgroundColor = [UIColor whiteColor];
            [recentCityCell buttonWhenClick:^(UIButton *button) {
                [self.navigationController popViewControllerAnimated:YES];
                if ([self.delegate respondsToSelector:@selector(addressPicker:didSelectedCity:)]) {
                    [self.delegate addressPicker:self didSelectedCity:button.titleLabel.text];
                    [[AppStatus sharedInstance] addRecentCity:button.titleLabel.text];
                    [AppStatus saveAppStatus];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"开始改善" object:nil];
                }
            }];
            return recentCityCell;
        }else if (indexPath.section == 2){
            static NSString *hotCityCellIdentifier = @"hotCityCell";
            BHotCityCell *hotCell = [tableView dequeueReusableCellWithIdentifier:hotCityCellIdentifier];
            if (hotCell == nil) {
                hotCell = [[BHotCityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hotCityCellIdentifier array:self.hotCitiesArray];
            }
            hotCell.selectionStyle = UITableViewCellSelectionStyleNone;
            hotCell.backgroundColor = [UIColor whiteColor];
            [hotCell buttonWhenClick:^(UIButton *button) {
                [self.navigationController popViewControllerAnimated:YES];
                if ([self.delegate respondsToSelector:@selector(addressPicker:didSelectedCity:)]) {
                    [self.delegate addressPicker:self didSelectedCity:button.titleLabel.text];
                    [[AppStatus sharedInstance] addRecentCity:button.titleLabel.text];
                    [AppStatus saveAppStatus];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"开始改善" object:nil];
                }
            }];
            return hotCell;
        }else{
            static NSString *commonCityCellIdentifier = @"commonCityCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commonCityCellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commonCityCellIdentifier];
            }
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            NSString *cityKey = [titleArray objectAtIndex:indexPath.section - 3];
            NSArray *array = [self.sortCityDict objectForKey:cityKey];
            cell.textLabel.text = [array objectAtIndex:indexPath.row];
            cell.textLabel.font = [UIFont systemFontOfSize:16.0];
            return cell;
        }
    
    }else{
        static NSString *Identifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.text = [resultArray objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:16.0];
        return cell;
    }
}

-(void)customIndexView:(YXDCustomIndexView *)customView selectedSectionIndex:(int)index {
    NSLog(@">>>>>>>>>>%@",titleArray[index]);
    NSIndexPath *indexpath=[NSIndexPath indexPathForRow:0 inSection:index+3];
    [self.tableView  scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 28)];
        if (section == 0 || section == 1 || section == 2) {
            headerView.backgroundColor = [UIColor whiteColor];
        }else{
            headerView.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
        }
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth - 15, 28)];
        label.font = [UIFont systemFontOfSize:default_font_size];
        [headerView addSubview:label];
        if (section == 0) {
            label.text = @"定位城市";
            label.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
        }else if (section == 1){
            if (self.recentVisitCityArray.count > 0) {
              label.text = @"最近访问城市";
            }else{
                label.text = @"";
            }
            label.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
        }else if (section == 2){
            if (self.hotCitiesArray.count > 0) {
               label.text = @"热门城市";
            }else{
                label.text = @"";
            }
            label.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
        }else{
            label.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
            label.text = [titleArray objectAtIndex:section - 3];
        }
        return headerView;
    }else{
        return nil;
    }
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    if (tableView == self.tableView) {
//        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
//        if (section == 0 || section == 1) {
//            footerView.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
//        }
////        else{
////            footerView.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
////        }
//        return footerView;
//    }else{
//        return nil;
//    }
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        if (section == 1) {
            if (self.recentVisitCityArray.count > 0) {
               return 28;
            }else{
                return 0;
            }
        }else if (section == 2){
            if (self.hotCitiesArray.count > 0) {
                return 28;
            }else{
                return 0;
            }
        }else{
            return 28;
        }
    }else{
        return 0.01;
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (tableView == self.tableView) {
//        if (section == 0) {
//            return splite_line_height;
//        }else if (section == 1){
//            if (self.recentVisitCityArray.count > 0) {
//                return splite_line_height;
//            }
//        }
//    }
//    return 0;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        if (indexPath.section == 1) {
//            return ceil((float)[self.recentVisitCityArray count] / 3) * (BUTTON_HEIGHT + 15) + 15;
            if (self.recentVisitCityArray.count > 0) {
              return 36 + 30;
            }else{
                return 0;
            }
            
        }else if (indexPath.section == 2) {
            if (self.hotCitiesArray.count > 0) {
                return ceil((float)[self.hotCitiesArray count] / 3) * (BUTTON_HEIGHT + 15) + 15;
            }else{
                return 0;
            }
            
        }else if (indexPath.section > 2){
            return 42;
        }else{
            return BUTTON_HEIGHT + 30;
        }
    }else{
        return 42;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        if (indexPath.section > 2) {
            NSString *cityKey = [titleArray objectAtIndex:indexPath.section - 3];
            NSArray *array = [self.sortCityDict objectForKey:cityKey];
            if ([self.delegate respondsToSelector:@selector(addressPicker:didSelectedCity:)]) {
                [self.delegate addressPicker:self didSelectedCity:[array objectAtIndex:indexPath.row]];
                [[AppStatus sharedInstance] addRecentCity:[array objectAtIndex:indexPath.row]];
                [AppStatus saveAppStatus];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"开始改善" object:nil];
            }
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(addressPicker:didSelectedCity:)]) {
            [self.delegate addressPicker:self didSelectedCity:[resultArray objectAtIndex:indexPath.row]];
            [[AppStatus sharedInstance] addRecentCity:[resultArray objectAtIndex:indexPath.row]];
            [AppStatus saveAppStatus];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"开始改善" object:nil];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReLoadDataBtnClick:(UIButton *)sender{
    if ([[AppStatus sharedInstance] isConnetInternet]) {
        NSLog(@">>>>>>>>>>>>联网成功");
        titleArray = [self getSectionTitles];
        resultArray = [[NSMutableArray alloc] init];
        self.citiesArray = [NSMutableArray new];
        self.sortCityDict = [NSMutableDictionary new];
        self.hotCitiesArray = [NSMutableArray new];
        self.recentVisitCityArray = [NSMutableArray new];
        self.recentCitesDict = [NSMutableDictionary new];
        [self loadRecentVisitCitiesArrayData];
        [self loadHotCitiesData];
        [self loadCityData];
        [self initUI];
    }else{
        NSLog(@">>>>>>>>>>>>联网失败");
        
    }
}

//取消searchbar背景色
#pragma mark - 处理searchBar的背景颜色
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


//- (void)dismissCityList:(UIButton *)sender{
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//}


@end
