//
//  MJContactViewController.m
//  MingJia
//
//  Created by admin on 15/12/31.
//  Copyright © 2015年 BCKJ. All rights reserved.
//

#import "MJContactViewController.h"

@interface MJContactViewController ()

@end

@implementation MJContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"客服服务";
    [self drawView];
}

- (void)drawView{
    UIImageView *headImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    headImg.image = [UIImage imageNamed:@"headBackg"];
    [self.view addSubview:headImg];
    UIImageView *headImg2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    headImg2.image = [UIImage imageNamed:@"BUTATAhead"];
    headImg2.center = CGPointMake(ScreenWidth/2, 50);
    [self.view addSubview:headImg2];
    
    UILabel *tit = [UILabel createLabelWithFrame:CGRectMake(20, 110, 190, 14) backgroundColor:CLEAN_COLOR textColor:TABBAR_TEXT_COLOR_SEL font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"客服电话   18961872005"];
    tit.attributedText = [self changeAttr:tit.text];
    [self.view addSubview:tit];
    
    UILabel *tit2 = [UILabel createLabelWithFrame:CGRectMake(20, 140, 190, 14) backgroundColor:CLEAN_COLOR textColor:[UIColor blackColor] font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"微信公众号 明佳信用平台"];
    [self.view addSubview:tit2];
    
    UIImageView *headImg5 = [[UIImageView alloc]initWithFrame:CGRectMake(190, 110, 15, 15)];
    headImg5.image = [UIImage imageNamed:@"电话y"];
    [self.view addSubview:headImg5];
    
    UIButton *teleBtn = [UIButton createButtonwithFrame:CGRectMake(190, 110, 100, 14) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@""]];
    [teleBtn setTitle:@"一键拨号" forState:UIControlStateNormal];
    [teleBtn setTitleColor:TABBAR_TEXT_COLOR_NOR forState:UIControlStateNormal];
    teleBtn.titleLabel.font = SYSTEM_FONT_(14);
    [teleBtn addTarget:self action:@selector(teleAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:teleBtn];

    UIImageView *headImg4 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
    headImg4.image = [UIImage imageNamed:@"qrcode"];
    headImg4.center = CGPointMake(ScreenWidth/2, 300);
    [self.view addSubview:headImg4];
    
}

- (void)teleAction{
    [self tele:@"18961872005"];
}

- (NSMutableAttributedString *)changeAttr:(NSString *)str{
    NSString *attrStr= str;
    NSRange range = [attrStr rangeOfString:@"客服电话"];
    NSMutableAttributedString *attRemain = [[NSMutableAttributedString alloc] initWithString:attrStr];
    [attRemain setAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],   NSFontAttributeName : SYSTEM_FONT_(14)} range:range];
    return attRemain;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end