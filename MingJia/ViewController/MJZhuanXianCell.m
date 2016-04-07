//
//  MJZhuanXianCell.m
//  MingJia
//
//  Created by admin on 16/1/4.
//  Copyright © 2016年 BCKJ. All rights reserved.
//

#import "MJZhuanXianCell.h"
@interface MJZhuanXianCell(){
    UIImageView     *imgstar1;
    UIImageView     *imgstar2;
    UIImageView     *imgstar3;
    UIImageView     *imgstar4;
    UIImageView     *imgstar5;
    
    UIImageView *phoneimg;
    UILabel *phone;
    UIImageView *teleimg;
    UILabel *tele;
}

@end
@implementation MJZhuanXianCell
- (void)setRankStar:(int)rankStar{
    // 设置信用星级别，可以绘画星星 ,下同
    _rankStar = rankStar;
    switch (rankStar) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            imgstar1.image = [UIImage imageNamed:@"实心评价"];
        }
            break;
        case 2:
        {
            imgstar1.image = [UIImage imageNamed:@"实心评价"];
            imgstar2.image = [UIImage imageNamed:@"实心评价"];
        }
            break;
        case 3:
        {
            imgstar1.image = [UIImage imageNamed:@"实心评价"];
            imgstar2.image = [UIImage imageNamed:@"实心评价"];
            imgstar3.image = [UIImage imageNamed:@"实心评价"];
        }
            break;
        case 4:
        {
            imgstar1.image = [UIImage imageNamed:@"实心评价"];
            imgstar2.image = [UIImage imageNamed:@"实心评价"];
            imgstar3.image = [UIImage imageNamed:@"实心评价"];
            imgstar4.image = [UIImage imageNamed:@"实心评价"];
        }
            break;
        case 5:
        {
            imgstar1.image = [UIImage imageNamed:@"实心评价"];
            imgstar2.image = [UIImage imageNamed:@"实心评价"];
            imgstar3.image = [UIImage imageNamed:@"实心评价"];
            imgstar4.image = [UIImage imageNamed:@"实心评价"];
            imgstar5.image = [UIImage imageNamed:@"实心评价"];
        }
        default:
            break;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setPhoneLab:(NSString *)phoneLab{
    _phoneLab = phoneLab;
    [phoneimg removeFromSuperview];
    [phone removeFromSuperview];
    phoneimg = [UIImageView createImageViewWithFrame:CGRectMake( 50, 53, 10, 13) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_手机"]];
    [self addSubview:phoneimg];
    
    phone = [UILabel createLabelWithFrame:CGRectMake(65, 53, 100, 12) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(12) textalignment:NSTextAlignmentLeft text:phoneLab];
    [self addSubview:phone];
    
    UIButton *phoneBtn = [UIButton createButtonwithFrame:CGRectMake(60, 53, 90, 30) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@""]];
    [self addSubview:phoneBtn];
    [phoneBtn addTarget:self action:@selector(phon) forControlEvents:UIControlEventTouchUpInside];
}

- (void)phon{
    if ([_delegate respondsToSelector:@selector(daphone:)]) {
        [_delegate daphone:_indexRow];
    }
}

- (void)setTeleLab:(NSString *)teleLab{
    _teleLab = teleLab;
    [teleimg removeFromSuperview];
    [tele removeFromSuperview];
    teleimg = [UIImageView createImageViewWithFrame:CGRectMake( 145, 53, 13, 13) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_电话"]];
    [self addSubview:teleimg];
    
    tele = [UILabel createLabelWithFrame:CGRectMake(160, 53, 120, 12) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(12) textalignment:NSTextAlignmentLeft text:teleLab];
    [self addSubview:tele];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self) {
        _comNameLab = [UILabel createLabelWithFrame:CGRectMake(10, 10, ScreenWidth - 50, 16) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft text:@"无锡市鸿辉运输有限公司"];
        [self addSubview:_comNameLab];
        
        _rankLab = [UILabel createLabelWithFrame:CGRectMake(10, 36, 60, 12) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(12) textalignment:NSTextAlignmentLeft text:@"明佳信用："];
        [self addSubview:_rankLab];
        
        imgstar1 = [UIImageView createImageViewWithFrame:CGRectMake(70, 34, 15, 15) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
        [self addSubview:imgstar1];
        imgstar2 = [UIImageView createImageViewWithFrame:CGRectMake(85, 34, 15, 15) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
        [self addSubview:imgstar2];
        imgstar3 = [UIImageView createImageViewWithFrame:CGRectMake(100, 34, 15, 15) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
        [self addSubview:imgstar3];
        imgstar4 = [UIImageView createImageViewWithFrame:CGRectMake(115, 34, 15, 15) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
        [self addSubview:imgstar4];
        imgstar5 = [UIImageView createImageViewWithFrame:CGRectMake(130, 34, 15, 15) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
        [self addSubview:imgstar5];
        
        _nameLab = [UILabel createLabelWithFrame:CGRectMake(10, 53, 40, 12) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(12) textalignment:NSTextAlignmentLeft text:@""];
        [self addSubview:_nameLab];
        
        _lineLab = [UILabel createLabelWithFrame:CGRectMake(10, 70, 150, 14) backgroundColor:CLEAN_COLOR textColor:Color_font_light font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"无锡 --> 广州"];
        [self addSubview:_lineLab];
        
        _addressLab = [UILabel createLabelWithFrame:CGRectMake(10, 95, ScreenWidth - 20, 12) backgroundColor:CLEAN_COLOR textColor:Color_font_light font:SYSTEM_FONT_(12) textalignment:NSTextAlignmentLeft text:@"友谊路320号53可是空间分布适度腐败是东风"];
        [self addSubview:_addressLab];
        
        _orderBtn = [UIButton createButtonwithFrame:CGRectMake(ScreenWidth - 47, 20, 20, 20) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_下单"]];
        [_orderBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_orderBtn];
        UILabel *lab1 = [UILabel createLabelWithFrame:CGRectMake(ScreenWidth - 61, 40, 60, 12) backgroundColor:CLEAN_COLOR textColor:Color_font_light font:SYSTEM_FONT_(12) textalignment:NSTextAlignmentLeft text:@"立即下单"];
        [self addSubview:lab1];
        
        _tapLine = [UILabel createLabelWithFrame:CGRectMake(0, 129, ScreenWidth, 1) backgroundColor:COLOR_line textColor:Color_font_dark font:SYSTEM_FONT_(12) textalignment:NSTextAlignmentLeft text:@""];
        [self addSubview:_tapLine];
        
    }
    return self;
}

- (void)btnAction:(id)sender{
    UIButton *btn = (UIButton *)sender;
    if ([btn isEqual:_orderBtn]) {
        if (_delegate && [_delegate respondsToSelector:@selector(order:)]) {
            [_delegate order:_indexRow];
        }
    }
}

@end
