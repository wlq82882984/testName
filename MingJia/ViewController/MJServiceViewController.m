//
//  MJServiceViewController.m
//  MingJia
//
//  Created by admin on 15/12/26.
//  Copyright © 2015年 BCKJ. All rights reserved.
//

#import "MJServiceViewController.h"

@interface MJServiceViewController ()

@end

@implementation MJServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"平台介绍";
    [self drawView];
}

- (void)drawView{
    UILabel *title1 = [UILabel createLabelWithFrame:CGRectMake(0, 0, ScreenWidth - 10, 0) backgroundColor:CLEAN_COLOR textColor:[UIColor orangeColor] font:SYSTEM_FONT_(20) textalignment:NSTextAlignmentLeft text:@"1.《明佳信用平台》开发明佳专线软件，推出免费安装使用明佳软件并常年享受明佳公司提供的单车200万保险，免费广告宣传等。我要安装"];
    title1.numberOfLines = 0;
    
    UILabel *title2 = [UILabel createLabelWithFrame:CGRectMake(0, 0, ScreenWidth - 10, 0) backgroundColor:CLEAN_COLOR textColor:TABBAR_TEXT_COLOR_SEL font:SYSTEM_FONT_(20) textalignment:NSTextAlignmentLeft text:@"2.微信，APP，发货方在线下单，在线办单，在线查询，在线跟踪，在线评价等，整车入单按照提示录入数据可免费享受明佳提供的单车200万保险。我要了解"];
    title2.numberOfLines = 0;
    
    UILabel *title3 = [UILabel createLabelWithFrame:CGRectMake(0, 0, ScreenWidth - 10, 0) backgroundColor:CLEAN_COLOR textColor:[UIColor greenColor] font:SYSTEM_FONT_(20) textalignment:NSTextAlignmentLeft text:@"3.微信、APP专线可在线接货，在线报价，在线跟踪，在线上传回单等，增加发货量。我要了解"];
    title3.numberOfLines = 0;

    CGSize size1 = [self getLabelsize:title1.text andTextsize:20 andLabwidth:ScreenWidth-10];
    CGSize size2 = [self getLabelsize:title2.text andTextsize:20 andLabwidth:ScreenWidth-10];
    CGSize size3 = [self getLabelsize:title3.text andTextsize:20 andLabwidth:ScreenWidth-10];
    
    int offset = 10;
    title1.frame = CGRectMake(5, offset, ScreenWidth - 10, size1.height);
    
    offset += size1.height +10;
    title2.frame = CGRectMake(5, offset, ScreenWidth - 10, size2.height);
    
    offset += size2.height +10;
    title3.frame = CGRectMake(5, offset, ScreenWidth - 10, size3.height);
    
    [self.view addSubview:title1];
    [self.view addSubview:title2];
    [self.view addSubview:title3];
}

@end
