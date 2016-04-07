//
//  MycomplaintCell.m
//  MingJia
//
//  Created by admin on 16/1/6.
//  Copyright © 2016年 BCKJ. All rights reserved.
//

#import "MycomplaintCell.h"

@implementation MycomplaintCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    UILabel *tapline  = [[UILabel alloc]init];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _nameLab = [UILabel createLabelWithFrame:CGRectMake(10, 10, 200, 14) backgroundColor:[UIColor clearColor] textColor:TABBAR_TEXT_COLOR_SEL font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"A投诉B"];
        [self addSubview:_nameLab];
        
        _timeLab = [UILabel createLabelWithFrame:CGRectMake(10, 35, ScreenWidth - 70, 14) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"15-12-16 21:56"];
        [self addSubview:_timeLab];
        
        _reasonLab = [UILabel createLabelWithFrame:CGRectMake(10, 65, ScreenWidth - 20, 12) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(12) textalignment:NSTextAlignmentLeft text:@"原因：没有在规定的时间送到"];
        [self addSubview:_reasonLab];
        
        tapline.text = @"";
        tapline.frame = CGRectMake( 0, 99, ScreenWidth, 1);
        tapline.backgroundColor=[UIColor colorWithHex:0xe2e2e2 alpha:1.0];
        [self addSubview:tapline];
    }
    return self;
}


@end
