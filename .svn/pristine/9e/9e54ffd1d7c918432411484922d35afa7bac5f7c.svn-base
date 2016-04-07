//
//  MJMySettingViewController.m
//  MingJia
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 BCKJ. All rights reserved.
//

#import "MJMySettingViewController.h"
#import "MJChangePwdViewController.h"

@interface MJMySettingViewController ()

@end

@implementation MJMySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self drawView];
    self.view.backgroundColor = [UIColor colorWithHex:0xebebec alpha:1.0];
    
}

- (void)drawView{
    UIView *titView = [UIView createViewWithFrame:CGRectMake(0, 20, ScreenWidth, 40) backgroundColor:WHITE_COLOR];
    [self.view addSubview:titView];
    UILabel *titLab = [UILabel createLabelWithFrame:CGRectMake(10, 0, 80, 40) backgroundColor:CLEAN_COLOR textColor:BLACK_COLOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft text:@"修改密码"];
    titLab.textColor = BLACK_COLOR;
    titLab.font = SYSTEM_FONT_(16);
    [titView addSubview:titLab];
    UILabel *tapline2 = [UILabel createLabelWithFrame:CGRectMake(0, 0, ScreenWidth, 1) backgroundColor:[UIColor lightGrayColor] textColor:BLACK_COLOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft text:@""];
//    [titView addSubview:tapline2];
    UILabel *tapline = [UILabel createLabelWithFrame:CGRectMake(0, 39, ScreenWidth, 1) backgroundColor:[UIColor lightGrayColor] textColor:BLACK_COLOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft text:@""];
//    [titView addSubview:tapline];
    
    UIButton *btn = [UIButton createButtonwithFrame:CGRectMake(0, 0, ScreenWidth, 40) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@""]];
    [btn addTarget:self action:@selector(changePwd) forControlEvents:UIControlEventTouchUpInside];
    [titView addSubview:btn];
}

- (void)changePwd{
    MJChangePwdViewController *vc = [[MJChangePwdViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}



@end
