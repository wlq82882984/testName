//
//  MJQuoteViewController.m
//  MingJia
//
//  Created by admin on 16/1/3.
//  Copyright © 2016年 BCKJ. All rights reserved.
//    http://app.mjxypt.com/api/order/getline?orderId=

#import "MJQuoteViewController.h"
#import "MJZXQueRenViewController.h"
#import "QuoteCell.h"

@interface MJQuoteViewController ()<UITableViewDataSource,UITableViewDelegate,OrderChooseDelegate>{
    UITableView        *mainTab; // 专线列表
    NSMutableArray     *listarr; // 列表数组
}

@end

@implementation MJQuoteViewController

- (void)requestgetlist{
    NSString *urlStr = [NSString stringWithFormat:@"http://app.mjxypt.com/api/order/getline?orderId=%@",_orderId];
    [Request getRequestWithUrl:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] params:nil showTips:@"查询" tipsType:SVProgressHUDMaskTypeClear sucessBlock:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSArray *dict = (NSArray *)responseObject;
        listarr = [dict mutableCopy];
        [mainTab reloadData];
        
    } failBlock:^(NSError *error) {
        
    } successBackFailedBlock:^(id responseObject) {
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择专线";
    mainTab = [UITableView createTableViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 65) style:UITableViewStylePlain backgroundColor:WHITE_COLOR delegate:self dataSource:self];
    [mainTab setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:mainTab];
    [self requestgetlist];
}

#pragma mark Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return listarr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *model = listarr[indexPath.row];
    QuoteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[QuoteCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.delegate = self;
    cell.indexRow = (int)indexPath.row;
    cell.phoneLab.text = [NSString stringWithFormat:@"%@  %@",[model objectForKey:@"StartContact"],[model objectForKey:@"StartMobile"]];
    cell.rankStar = [[model objectForKey:@"Synthetic"]intValue];
    cell.nameLab.text = [model objectForKey:@"CompanyName"];
    cell.detailLab.text = [NSString stringWithFormat:@"出价:￥%@ 时效:%@ 时间:%@",[model objectForKey:@"Freight"],[model objectForKey:@"Timeliness"],[model objectForKey:@"BidTime"]];
    cell.addLab.text = [model objectForKey:@"StartAddr"];

//    cell.orderIdLab.text = [NSString stringWithFormat:@"%@(%@)",[model objectForKey:@"OrderNo"],[model objectForKey:@"State"]];
//    cell.nameLab.text = [NSString stringWithFormat:@"%@ %@",[model objectForKey:@"ConsigneeContact"],[model objectForKey:@"ConsigneeMobile"]];
//    cell.lineLab.text = [NSString stringWithFormat:@"%@-->%@ 运费：%@",[model objectForKey:@"StartCity"],[model objectForKey:@"ArrivalCity"],[model objectForKey:@"Freight"]];
//    cell.productLab.text = [NSString stringWithFormat:@"%@ %@件",[model objectForKey:@"CargoName"],[model objectForKey:@"Qty"]];
    return cell;
}

#pragma mark Datasouce
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

- (void)commitWithIndex:(int)indexRow{
    NSDictionary *model = listarr[indexRow];
    MJZXQueRenViewController *vc = [[MJZXQueRenViewController alloc]init];
    vc.orderId = _orderId;
    vc.lineId = [model objectForKey:@"LineId"];
    vc.freight = [UtilString getNoNilString:[model objectForKey:@"Freight"]];
    [self.navigationController pushViewController:vc animated:NO];
}

@end
