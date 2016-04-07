//
//  MJmyMsgCell.m
//  MingJia
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 BCKJ. All rights reserved.
//

#import "MJmyMsgCell.h"

@implementation MJmyMsgCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setType:(msgType)type{
    _type = type;
    switch (type) {
        case DAIBAOJIATYPE:
        {
            _typeLab.text = @"报价";
        }
            break;
        case DAIQUERENTYPE:
        {
            _typeLab.text = @"确认";
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
        _orderIdLab = [UILabel createLabelWithFrame:CGRectMake(10, 15, 180, 16) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft text:@""];
        [self addSubview:_orderIdLab];
        
        _lineLab = [UILabel createLabelWithFrame:CGRectMake(10, 40, 150, 14) backgroundColor:CLEAN_COLOR textColor:Color_font_light font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@""];
        [self addSubview:_lineLab];
        
        _productLab = [UILabel createLabelWithFrame:CGRectMake(10, 70, 150, 14) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@""];
        [self addSubview:_productLab];
        
        _typeBtn = [UIButton createButtonwithFrame:CGRectMake(ScreenWidth - 57, 30, 25, 25) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@""]];
        [_typeBtn setBackgroundImage:[UIImage imageNamed:@"已邀"] forState:UIControlStateNormal];
        [_typeBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_typeBtn];
        
        _typeLab = [UILabel createLabelWithFrame:CGRectMake(ScreenWidth - 57, 60, 90, 12) backgroundColor:CLEAN_COLOR textColor:Color_font_light font:SYSTEM_FONT_(12) textalignment:NSTextAlignmentLeft text:@"报价"];
        [self addSubview:_typeLab];
        
        UILabel *tapLine = [UILabel createLabelWithFrame:CGRectMake(0, 109, ScreenWidth, 1) backgroundColor:COLOR_line textColor:Color_font_dark font:SYSTEM_FONT_(12) textalignment:NSTextAlignmentLeft text:@""];
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
