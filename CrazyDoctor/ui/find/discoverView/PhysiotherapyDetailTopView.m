//
//  PhysiotherapyDetailTopView.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/9.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "PhysiotherapyDetailTopView.h"

@implementation PhysiotherapyDetailTopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"PhysiotherapyDetailTopView" owner:self options:nil] objectAtIndex:0];
        self.frame = frame;
        self.layer.borderWidth = splite_line_height;
        self.layer.borderColor = [ColorUtils colorWithHexString:@"#b9976c"].CGColor;
        self.layer.masksToBounds = YES;
        self.projectPriceLabel.textColor = [ColorUtils colorWithHexString:common_app_text_color];
    }
    return self;
}

- (void)renderPhysiotherapyDetailTopViewWithProject:(Project *)project{
    NSLog(@">>>>>渲染>>>>>>%@",project);
    
    self.firstLabel.text = @"理疗项目";
    self.secondLabel.text = @"理疗院名";
    self.thirdLabel.text = @"理疗店地址";
    self.forthLabel.text = @"理疗店电话";
    self.fifthLabel.text = @"价格";
    
    self.projectName.text = project.name;
    self.organizationName.text = project.organization.name;
    
    self.organizationAddressLabel.text = project.organization.address;
    self.organizationAddressLabel.numberOfLines = 0;
    self.organizationPhoneLabel.text = project.organization.phone;
    NSString *priceStr= [NSString stringWithFormat:@"¥%.2f",project.specialPrice];
    int start = (int)[priceStr rangeOfString:[NSString stringWithFormat:@"%@",@"¥"]].location;
    int length = (int)[priceStr rangeOfString:[NSString stringWithFormat:@"%@",@"¥"]].length;
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:priceStr];
    [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(start,length)];
    self.projectPriceLabel.attributedText = attributedText;
}

- (void)renderPhysiotherapyDetailTopViewWithDoctor:(Doctor *)doctor{
    self.firstLabel.text = @"医生姓名";
    self.secondLabel.text = @"医院名称";
    self.thirdLabel.text = @"医院地址";
    self.forthLabel.text = @"医院电话";
    self.fifthLabel.text = @"价格";
    
    NSString *nameStr = [NSString stringWithFormat:@"%@   %@",doctor.name,doctor.level];
    
    int start = (int)[nameStr rangeOfString:[NSString stringWithFormat:@"%@",doctor.level]].location;
    NSLog(@">>>>>>>>>>开始位置>>>>>>>>>%d",start);
    int length = (int)[nameStr rangeOfString:[NSString stringWithFormat:@"%@",doctor.level]].length;
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:nameStr];
    [attributedText addAttribute:NSForegroundColorAttributeName value:[ColorUtils colorWithHexString:common_app_text_color] range:NSMakeRange(start,length)];
    [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:default_2_font_size] range:NSMakeRange(start,length)];
    self.projectName.attributedText = attributedText;
    self.organizationName.text = doctor.hospital.name;
    
    self.organizationAddressLabel.text = doctor.hospital.address;
    self.organizationAddressLabel.numberOfLines = 0;
    self.organizationPhoneLabel.text = doctor.hospital.tel;
    
    NSString *priceStr= [NSString stringWithFormat:@"¥%.2f",doctor.price];
    int start1 = (int)[priceStr rangeOfString:[NSString stringWithFormat:@"%@",@"¥"]].location;
    int length1 = (int)[priceStr rangeOfString:[NSString stringWithFormat:@"%@",@"¥"]].length;
    NSMutableAttributedString *attributedText1 = [[NSMutableAttributedString alloc] initWithString:priceStr];
    [attributedText1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(start1,length1)];
    self.projectPriceLabel.attributedText = attributedText1;
}

@end
