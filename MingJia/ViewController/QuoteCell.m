//
//  QuoteCell.m
//  MingJia
//
//  Created by admin on 16/1/3.
//  Copyright © 2016年 BCKJ. All rights reserved.
//

#import "QuoteCell.h"

@implementation QuoteCell{
    UIImageView     *imgstar1;
    UIImageView     *imgstar2;
    UIImageView     *imgstar3;
    UIImageView     *imgstar4;
    UIImageView     *imgstar5;
}

- (void)awakeFromNib {
}

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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setIndexRow:(int)indexRow{
    _indexRow = indexRow;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self) {
        _nameLab = [UILabel createLabelWithFrame:CGRectMake(10, 10, ScreenWidth -50, 16)  backgroundColor:CLEAN_COLOR textColor:Color_font_light font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft text:@""];
        [self addSubview:_nameLab];
        
        _phoneLab = [UILabel createLabelWithFrame:CGRectMake(10, 50, ScreenWidth -50, 14) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"奥斯卡 28172386826"];
        [self addSubview:_phoneLab];
        
        _detailLab = [UILabel createLabelWithFrame:CGRectMake(10, 78, ScreenWidth -50, 14) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"出价：10w"];
        [self addSubview:_detailLab];
        
        _addLab = [UILabel createLabelWithFrame:CGRectMake(10, 100, ScreenWidth -50, 14) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@""];
        [self addSubview:_addLab];
        
        imgstar1 = [UIImageView createImageViewWithFrame:CGRectMake(10, 28, 15, 15) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
        [self addSubview:imgstar1];
        imgstar2 = [UIImageView createImageViewWithFrame:CGRectMake(25, 28, 15, 15) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
        [self addSubview:imgstar2];
        imgstar3 = [UIImageView createImageViewWithFrame:CGRectMake(40, 28, 15, 15) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
        [self addSubview:imgstar3];
        imgstar4 = [UIImageView createImageViewWithFrame:CGRectMake(55, 28, 15, 15) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
        [self addSubview:imgstar4];
        imgstar5 = [UIImageView createImageViewWithFrame:CGRectMake(70, 28, 15, 15) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
        [self addSubview:imgstar5];
        
        _commitbtn = [UIButton createButtonwithFrame:CGRectMake(ScreenWidth - 57, 45, 30, 30) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@""]];
        [_commitbtn setBackgroundImage:[UIImage imageNamed:@"修改"] forState:UIControlStateNormal];
        [_commitbtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_commitbtn];
        
        _typeLab = [UILabel createLabelWithFrame:CGRectMake(ScreenWidth - 55, 80, 30, 14) backgroundColor:CLEAN_COLOR textColor:Color_font_light font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"确认"];
        [self addSubview:_typeLab];
        
        UILabel *tapLine = [UILabel createLabelWithFrame:CGRectMake(0, 129, ScreenWidth, 1) backgroundColor:COLOR_line textColor:Color_font_dark font:SYSTEM_FONT_(12) textalignment:NSTextAlignmentLeft text:@""];
        [self addSubview:tapLine];
        
    }
    return self;
}

- (void)btnAction:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(commitWithIndex:)]) {
        [_delegate commitWithIndex:_indexRow];
    }
}

@end
