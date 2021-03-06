//
//  MLlogdetailCell.m
//  MingJia
//
//  Created by admin on 16/1/6.
//  Copyright © 2016年 BCKJ. All rights reserved.
//

#import "MLlogdetailCell.h"

@implementation MLlogdetailCell

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
        self.backgroundColor = [UIColor colorWithHex:0xe2e2e2 alpha:1.0];
        _timeLab = [UILabel createLabelWithFrame:CGRectMake(0, 15, 70, 14) backgroundColor:[UIColor clearColor] textColor:[UIColor lightGrayColor] font:SYSTEM_FONT_BOLD_(14) textalignment:NSTextAlignmentCenter text:@"14:13"];
        [self addSubview:_timeLab];
        
        _dateLab = [UILabel createLabelWithFrame:CGRectMake(0, 37, 70, 10) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] font:SYSTEM_FONT_(10) textalignment:NSTextAlignmentCenter text:@"2015-12-18"];
        [self addSubview:_dateLab];
        
        UIButton *btn = [UIButton createButtonwithFrame:CGRectMake(0, 0, 20, 20) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@""]];
        btn.center = CGPointMake(80, 30);
        [btn setBackgroundImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        btn.layer.borderWidth = 2;
        btn.layer.cornerRadius = 10;
        [self addSubview:btn];
        
        UILabel *tapline1 = [UILabel createLabelWithFrame:CGRectMake(80, 0, 1, 60) backgroundColor:[UIColor lightGrayColor] textColor:[UIColor blackColor] font:SYSTEM_FONT_BOLD_(14) textalignment:NSTextAlignmentLeft text:@""];
        [self addSubview:tapline1];
        
        _noteLab = [UILabel createLabelWithFrame:CGRectMake(100, 17, ScreenWidth - 110, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] font:SYSTEM_FONT_BOLD_(14) textalignment:NSTextAlignmentLeft text:@"【陈旺】已签收"];
        [self addSubview:_noteLab];
        
        tapline.text = @"";
        tapline.frame = CGRectMake( 0, 59, ScreenWidth, 1);
        tapline.backgroundColor=[UIColor lightGrayColor];
        [self addSubview:tapline];
    }
    return self;
}

@end
