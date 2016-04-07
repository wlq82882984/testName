//
//  MJMyInfoViewController.m
//  MingJia
//
//  Created by admin on 15/12/25.
//  Copyright © 2015年 BCKJ. All rights reserved.
//   http://app.mjxypt.com/api/account/getcompany?companyid=

#import "MJMyInfoViewController.h"
#import "MJContactViewController.h"
#import "MJCarOrderViewController.h"
#import "MJSpecificLineViewController.h"
#import "MJFindFriendViewController.h"
#import "MJMyOrderListViewController.h"
#import "MJMyComplaintViewController.h"
#import "MJMyMsgViewController.h"   // 我的消息
#import "MJLoginViewController.h"
#import "MJMySettingViewController.h"
#import "MJMyinfoCell.h"

@interface MJMyInfoViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UIScrollView      *mainScroll;
    NSArray           *titArr;
    NSArray           *iconArr;
    
    UILabel           *teleLab;
    UILabel           *nameLab;
}

@property(nonatomic,strong)UITableView *myTabV;

@end

@implementation MJMyInfoViewController

- (void)requestMyInfo{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://app.mjxypt.com/api/account/getcompany?companyid=%@",[[user objectForKey:@"UserLogin"] objectForKey:@"userId"]];
    
    [Request getRequestWithUrl:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] params:nil showTips:@"查询" tipsType:SVProgressHUDMaskTypeClear sucessBlock:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = responseObject;
        NSLog(@"%@",dict);
        if(mainScroll){
            nameLab.text = [dict objectForKey:@"CompanyName"];
            teleLab.text = [dict objectForKey:@"Mobile"];
        }
        
    } failBlock:^(NSError *error) {
        
    } successBackFailedBlock:^(id responseObject) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];

    if ([[user objectForKey:@"UserLogin"] objectForKey:@"userId"]) {    // 登录
        [self requestMyInfo];
    }
    else {   // 未登录
        nameLab.text = @"未知";
        teleLab.text = @"请登录";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    titArr = @[@[@"我的订单",@"整车订单"],@[@"我的专线",@"我的消息",@"我的好友"],@[@"会员投诉",@"联系客服"]];
    iconArr = @[@[@"我的订单",@"整车订单"],@[@"专线",@"我的订单",@"已邀"],@[@"投诉",@"联系客服"]];
    self.title = @"用户中心";
    [self drawView];
}

- (void)drawView{
    mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenHeight, ScreenHeight - 64 - 48)];
    mainScroll.backgroundColor = CLEAN_COLOR;
    [self.view addSubview:mainScroll];
    
    UIView *headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    UIImageView *bg = [[UIImageView alloc]init];
    bg.frame = headV.bounds;
    bg.image = [UIImage imageNamed:@"bg"];
    [headV addSubview:bg];
    [mainScroll addSubview:headV];
    
    UIImageView *moreImg = [UIImageView createImageViewWithFrame: CGRectMake(ScreenWidth - 30, 40, 20, 20) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"更多"]];
    [headV addSubview:moreImg];
    
    nameLab = [UILabel createLabelWithFrame:CGRectMake(0, 0, 90, 14) backgroundColor:CLEAN_COLOR textColor:WHITE_COLOR font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@""];
    teleLab = [UILabel createLabelWithFrame:CGRectMake(0, 0, 150, 14) backgroundColor:CLEAN_COLOR textColor:WHITE_COLOR font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@""];
    
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    if ([userInfo objectForKey:@"userInfo"]) { // 无登陆
        nameLab.frame = CGRectMake(10, 43, 90, 14);
        nameLab.text = @"立刻绑定";
        [headV addSubview:nameLab];
    }
    else {
        nameLab.frame = CGRectMake(10, 33, 90, 14);
        [headV addSubview:nameLab];
        teleLab.frame = CGRectMake(10, 53, 150, 14);
        [headV addSubview:teleLab];
    }
    
    UIButton *registBtn = [UIButton createButtonwithFrame:headV.bounds backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@""]];
    [registBtn addTarget:self action:@selector(loginto) forControlEvents:UIControlEventTouchUpInside];
    [headV addSubview:registBtn];
    
    _myTabV = [UITableView createTableViewWithFrame:CGRectMake(0, 106, ScreenWidth, 370) style:UITableViewStylePlain backgroundColor:CLEAN_COLOR delegate:self dataSource:self];
    [mainScroll addSubview:_myTabV];
    _myTabV.scrollEnabled = NO;
    [_myTabV registerClass:[MJMyinfoCell class] forCellReuseIdentifier:@"cell"];
    
    UIButton *outBtn = [UIButton createButtonwithFrame:CGRectMake(6, CGRectGetMaxY(_myTabV.frame) + 15, ScreenWidth - 12, 40) backgroundColor:TABBAR_TEXT_COLOR_SEL titleColor:WHITE_COLOR title:@"退出"];
    [outBtn addTarget:self action:@selector(outlet) forControlEvents:UIControlEventTouchUpInside];
    outBtn.layer.cornerRadius = 5;
    [mainScroll addSubview:outBtn];
    
    mainScroll.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(outBtn.frame)+10);

}

- (void)loginto{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if (![user objectForKey:@"UserLogin"]) {
        BaseNavigationController *vc = [[BaseNavigationController alloc]initWithRootViewController:[[MJLoginViewController alloc]init]];
        [self presentViewController:vc animated:NO completion:^{
            
        }];
        return;
    }
    else{
        MJMySettingViewController *vc = [[MJMySettingViewController alloc]init];
        [self.navigationController pushViewController:vc animated:NO];
    }
}

- (void)outlet{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user removeObjectForKey:@"UserLogin"];
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];   // 退出时关闭推送 尝试
    nameLab.text = @"未知";
    teleLab.text = @"请登录";
    [SVProgressHUD showSuccessWithStatus:@"退出成功" maskType:SVProgressHUDMaskTypeClear];
}

#pragma mark  delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [titArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MJMyinfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[MJMyinfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSString *titName = [NSString stringWithFormat:@"%@",titArr[indexPath.section][indexPath.row]];
    NSString *iconName = [NSString stringWithFormat:@"%@",iconArr[indexPath.section][indexPath.row]];
    cell.titleLab.text = titName;
    cell.iconImg.image = [UIImage imageNamed:iconName];
    
    return cell;
}

#pragma mark  datasouce
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    else {
        return 10;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return titArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                MJMyOrderListViewController *vc = [[MJMyOrderListViewController alloc]init];
                [self.navigationController pushViewController:vc animated:NO];
            }
            else if (indexPath.row == 1){
                MJCarOrderViewController *vc = [[MJCarOrderViewController alloc]init];
                [self.navigationController pushViewController:vc animated:NO];
            }
        }
            break;
            
        case 1:
        {
            if (indexPath.row == 0) {
                MJSpecificLineViewController *vc = [[MJSpecificLineViewController alloc]init];
                [self.navigationController pushViewController:vc animated:NO];
            }
            else if (indexPath.row == 1) {
                // 我的消息
                MJMyMsgViewController *vc = [[MJMyMsgViewController alloc]init];
                [self.navigationController pushViewController:vc animated:NO];
                
            }
            else{
                MJFindFriendViewController *vc = [[MJFindFriendViewController alloc]init];
                [self.navigationController pushViewController:vc animated:NO];
            }
        }
            break;
            
        case 2:
        {
            if (indexPath.row == 0) {
                MJMyComplaintViewController *vc = [[MJMyComplaintViewController alloc]init];
                [self.navigationController pushViewController:vc animated:NO];
            }
            if (indexPath.row == 1) {
                MJContactViewController *vc = [[MJContactViewController alloc]init];
                [self.navigationController pushViewController:vc animated:NO];
            }
        }
            break;
            
        default:
            break;
    }
}


@end
