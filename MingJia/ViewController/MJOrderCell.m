//
//  MJOrderCell.m
//  MingJia
//
//  Created by admin on 16/1/3.
//  Copyright © 2016年 BCKJ. All rights reserved.
//

#import "MJOrderCell.h"

@implementation MJOrderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setType:(orderType)type{
    _type = type;
    switch (type) {
        case DAISHOULITYPE:
        {
        _typeLab.text = @"修改订单";
        }
            break;
        case YISHOULITYPE:
        {
        _typeLab.text = @"选择报价";
        }
            break;
        case WEIFUKUANTYPE:
        {
            _typeLab.text = @"查看运单";
        }
            break;
        case DAIYUNSHUTYPE:
        {
            _typeLab.text = @"查看运单";
        }
            break;
        case YUNSHUWANCHENTYPE:
        {
            _typeLab.text = @"查看运单";
        }
            break;
        default:
            break;
    }
}

- (void)setIndexRow:(int)indexRow{
    _indexRow = indexRow;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self) {
        _orderIdLab = [UILabel createLabelWithFrame:CGRectMake(10, 15, 180, 16) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft text:@"88273668183726"];
        [self addSubview:_orderIdLab];
        
        _nameLab = [UILabel createLabelWithFrame:CGRectMake(10, 45, 180, 12)  backgroundColor:CLEAN_COLOR textColor:Color_font_light font:SYSTEM_FONT_(12) textalignment:NSTextAlignmentLeft text:@""];
        [self addSubview:_nameLab];
        
        _lineLab = [UILabel createLabelWithFrame:CGRectMake(10, 70, ScreenWidth -80, 14) backgroundColor:CLEAN_COLOR textColor:Color_font_light font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"无锡 --> 广州"];
        [self addSubview:_lineLab];
        
        _productLab = [UILabel createLabelWithFrame:CGRectMake(10, 100, 150, 14) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@""];
        [self addSubview:_productLab];

        _typeBtn = [UIButton createButtonwithFrame:CGRectMake(ScreenWidth - 90, 00, 90, 120) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@""]];
//        [_typeBtn setBackgroundImage:[UIImage imageNamed:@"修改"] forState:UIControlStateNormal];
        [_typeBtn setImage:[UIImage imageNamed:@"修改b"] forState:UIControlStateNormal];
        [_typeBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_typeBtn];

        _typeLab = [UILabel createLabelWithFrame:CGRectMake(ScreenWidth - 77, 90, 90, 16) backgroundColor:CLEAN_COLOR textColor:Color_font_light font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft text:@"修改订单"];
        [self addSubview:_typeLab];
        
        UILabel *tapLine = [UILabel createLabelWithFrame:CGRectMake(0, 129, ScreenWidth, 1) backgroundColor:COLOR_line textColor:Color_font_dark font:SYSTEM_FONT_(12) textalignment:NSTextAlignmentLeft text:@""];
        [self addSubview:tapLine];
        
    }
    return self;
}

- (void)btnAction:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(orderWithIndex:andType:)]) {
        [_delegate orderWithIndex:_indexRow andType:_type];
    }
}

@end
