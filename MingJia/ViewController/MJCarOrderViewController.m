//
//  MJCarOrderViewController.m
//  MingJia
//
//  Created by admin on 15/12/30.
//  Copyright © 2015年 BCKJ. All rights reserved.
//http://app.mjxypt.com/api/through/getbycompanyid?companyId= 

#import "MJCarOrderViewController.h"
#import "MJCarChangeViewController.h"
#import "MainTabBarController.h"
#import "MJCarOrderCell.h"

@interface MJCarOrderViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray    *arrList;
}

@property(nonatomic,strong)UITableView *mainTab;

@end

@implementation MJCarOrderViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestgetlist];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"整车订单的的的的";
    arrList = [NSMutableArray array];
    [self drawTabV];
    
    UIButton *btnBackCustom = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBackCustom.frame = CGRectMake(0, 0, 40, 35);
    [btnBackCustom setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    btnBackCustom.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [btnBackCustom addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:btnBackCustom];
}

- (void)backAction{
    if (self.navigationController.viewControllers.count == 2) {
        [self.navigationController popViewControllerAnimated:NO];
    }
    else{
        [self.navigationController popToRootViewControllerAnimated:NO];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"pushtoshopCar" object:nil];
    }
//    MainTabBarController *main = [[MainTabBarController alloc]init];
//    [main selectedTabAtIndex:3];
//    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
//    mainWindow.rootViewController = main;
}

- (void)drawTabV{
    _mainTab = [UITableView createTableViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain backgroundColor:CLEAN_COLOR delegate:self dataSource:self];
    _mainTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mainTab];
}

- (void)requestgetlist{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *urlStr = [NSString stringWithFormat:@"http://app.mjxypt.com/api/through/getbycompanyid?companyId=%@",[[user objectForKey:@"UserLogin"] objectForKey:@"userId"]];
    [Request getRequestWithUrl:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] params:nil showTips:@"查询" tipsType:SVProgressHUDMaskTypeClear sucessBlock:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSArray *resparr = (NSArray *)responseObject;
        arrList = [resparr mutableCopy];
        [_mainTab reloadData];
    } failBlock:^(NSError *error) {
        
    } successBackFailedBlock:^(id responseObject) {
        
    }];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *model = arrList[indexPath.row];
    MJCarOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[MJCarOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.orderLab.text = [model objectForKey:@"ThroughOrderNo"];
    cell.timeLab.text =[NSString stringWithFormat:@"%@ %@",[[model objectForKey:@"CreateTime"] substringToIndex:16],[model objectForKey:@"CargoName"]];
    cell.nameLab.text = [NSString stringWithFormat:@"%@-->%@",[model objectForKey:@"ShipperContact"],[model objectForKey:@"ConsigneeContact"]];
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *model = arrList[indexPath.row];
    MJCarChangeViewController *vc = [[MJCarChangeViewController alloc]init];
    vc.orderId =[model objectForKey:@"ThroughOrderId"];
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
