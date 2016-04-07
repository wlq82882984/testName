//
//  MJCarOrderCell.m
//  MingJia
//
//  Created by admin on 15/12/30.
//  Copyright © 2015年 BCKJ. All rights reserved.
//

#import "MJCarOrderCell.h"

@implementation MJCarOrderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    _tapline  = [[UILabel alloc]init];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *titLab = [UILabel createLabelWithFrame:CGRectMake(10, 10, 40, 14) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"单号"];
        [self addSubview:titLab];
        
        _orderLab = [UILabel createLabelWithFrame:CGRectMake(50, 10, 200, 14) backgroundColor:[UIColor clearColor] textColor:TABBAR_TEXT_COLOR_SEL font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"2324234235435234"];
        [self addSubview:_orderLab];
        
        _iconImg = [UIImageView createImageViewWithFrame:CGRectMake(10, 50, 30, 30) backgroundColor:[UIColor clearColor] image:[UIImage imageNamed:@"整车"]];
        [self addSubview:_iconImg];

        _timeLab = [UILabel createLabelWithFrame:CGRectMake(60, 45, ScreenWidth - 70, 12) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(12) textalignment:NSTextAlignmentLeft text:@"15-12-16 21:56 米"];
        [self addSubview:_timeLab];
        
        _nameLab = [UILabel createLabelWithFrame:CGRectMake(60, 65, ScreenWidth - 70, 12) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(12) textalignment:NSTextAlignmentLeft text:@"美美--->"];
        [self addSubview:_nameLab];
        
        _tapline.text = @"";
        _tapline.frame = CGRectMake( 0, 99, ScreenWidth, 1);
        _tapline.backgroundColor=[UIColor colorWithHex:0xe2e2e2 alpha:1.0];
        [self addSubview:_tapline];
    }
    return self;
}

@end
