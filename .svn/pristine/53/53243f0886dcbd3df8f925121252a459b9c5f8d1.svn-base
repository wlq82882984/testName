//
//  MJMyComplaintViewController.m
//  MingJia
//
//  Created by admin on 16/1/6.
//  Copyright © 2016年 BCKJ. All rights reserved.
//  http://app.mjxypt.com/api/complaint/getlist?id=

#import "MJMyComplaintViewController.h"
#import "MJComplainViewController.h"
#import "MycomplaintCell.h"

@interface MJMyComplaintViewController ()<UITableViewDelegate,UITableViewDataSource>{
NSMutableArray    *arrList;
}
@property(nonatomic,strong)UITableView *mainTab;

@end

@implementation MJMyComplaintViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestgetlist];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的投诉列表";
    arrList = [NSMutableArray array];
    [self drawTabV];
}

- (void)drawTabV{
    _mainTab = [UITableView createTableViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain backgroundColor:CLEAN_COLOR delegate:self dataSource:self];
    _mainTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mainTab];
}

- (void)requestgetlist{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *urlStr = [NSString stringWithFormat:@"http://app.mjxypt.com/api/complaint/getlist?id=%@",[[user objectForKey:@"UserLogin"] objectForKey:@"userId"]];
    [Request getRequestWithUrl:urlStr params:nil showTips:@"获取列表" tipsType:SVProgressHUDMaskTypeClear sucessBlock:^(id responseObject) {
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
    MycomplaintCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[MycomplaintCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.timeLab.text =[NSString stringWithFormat:@"%@ %@",[[model objectForKey:@"CreateTime"] substringToIndex:16],[model objectForKey:@"CargoName"]];
    cell.nameLab.text = [NSString stringWithFormat:@"%@ 投诉 %@",[model objectForKey:@"ShipperContact"],[model objectForKey:@"ConsigneeContact"]];
    cell.reasonLab.text = @"";
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *model = arrList[indexPath.row];
    MJComplainViewController *vc = [[MJComplainViewController alloc]init];
    vc.complaintId = [model objectForKey:@"ComplaintId"];
    [self.navigationController pushViewController:vc animated:NO];
}


@end
