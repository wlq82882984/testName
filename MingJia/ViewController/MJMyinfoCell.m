//
//  MJMyinfoCell.m
//  MingJia
//
//  Created by admin on 15/12/25.
//  Copyright © 2015年 BCKJ. All rights reserved.
//

#import "MJMyinfoCell.h"

@implementation MJMyinfoCell

- (void)awakeFromNib {
    
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
        _iconImg = [UIImageView createImageViewWithFrame:CGRectMake(10, 15, 20, 20) backgroundColor:[UIColor clearColor] image:[UIImage imageNamed:@""]];
        [self addSubview:_iconImg];
        
        _titleLab = [UILabel createLabelWithFrame:CGRectMake(35, 17, 80, 16) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] font:FONT_TEXTSIZE_Normal textalignment:NSTextAlignmentLeft text:@""];
        [self addSubview:_titleLab];
        
        _tapline.text = @"";
        _tapline.frame = CGRectMake( 0, 49, ScreenWidth, 1);
        _tapline.backgroundColor=[UIColor colorWithHex:0xe2e2e2 alpha:1.0];
        [self addSubview:_tapline];
        
        UIImageView *goImg = [UIImageView createImageViewWithFrame:CGRectMake(ScreenWidth - 30, 15, 15, 15) backgroundColor:[UIColor clearColor] image:[UIImage imageNamed:@"更多"]];
        [self addSubview:goImg];
    }
    return self;
}

@end
