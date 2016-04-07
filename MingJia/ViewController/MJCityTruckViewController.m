//
//  MJCityTruckViewController.m
//  MingJia
//
//  Created by admin on 15/12/30.
//  Copyright © 2015年 BCKJ. All rights reserved.
//

#import "MJCityTruckViewController.h"

@interface MJCityTruckViewController ()

@end

@implementation MJCityTruckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"同城货的";
    
    UIView *headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    headV.backgroundColor = TABBAR_TEXT_COLOR_SEL;
    [self.view addSubview:headV];
    UILabel *lab = [UILabel createLabelWithFrame:CGRectMake(0, 0, ScreenWidth, 50) backgroundColor:CLEAN_COLOR textColor:WHITE_COLOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentCenter text:@"暂无数据"];
    [headV addSubview:lab];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
