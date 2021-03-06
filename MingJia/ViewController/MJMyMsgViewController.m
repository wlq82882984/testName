//
//  MJMyMsgViewController.m
//  MingJia
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 BCKJ. All rights reserved.
//

#import "MJMyMsgViewController.h"
#import "MJQuoteViewController.h"
#import "MJBJViewController.h"
#import "MJmyMsgCell.h"


@interface MJMyMsgViewController ()<UITableViewDataSource,UITableViewDelegate,MsgChooseDelegate>{
    UITableView *mainTab;
    NSMutableArray     *arrlist;
    
    UIImageView        *headTitleView; // 仿 seg
    UIControl          *ctrlStay;
    UIControl          *ctrlAlready;
    int                 typeSelected;
    int                 ordertype;
}

@end

@implementation MJMyMsgViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (typeSelected == 0) {
        [self freshSegment:1];
    }
    else{
        [self freshSegment:typeSelected];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的消息";
    
    arrlist = [NSMutableArray array];
    headTitleView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth-300)/2, 5, 300, 35)];
    headTitleView.backgroundColor = [UIColor clearColor];
    headTitleView.image = [UIImage imageNamed:@"2栏左"];
    headTitleView.userInteractionEnabled = YES;
    [self.view addSubview:headTitleView];
    
    [self setUpSegment];
    mainTab = [UITableView createTableViewWithFrame:CGRectMake(0, 46, ScreenWidth, ScreenHeight - 110) style:UITableViewStylePlain backgroundColor:WHITE_COLOR delegate:self dataSource:self];
    [mainTab setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:mainTab];
}

#pragma mark - headView segment
- (void)setUpSegment{
    //seg1
    ctrlStay = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, headTitleView.frame.size.width / 2, headTitleView.frame.size.height)];
    ctrlStay.backgroundColor = [UIColor clearColor];
    [ctrlStay addTarget:self action:@selector(ctlStayClick) forControlEvents:UIControlEventTouchUpInside];
    [headTitleView addSubview:ctrlStay];
    UILabel *lbStay = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ctrlStay.frame.size.width, ctrlStay.frame.size.height)];
    lbStay.backgroundColor = [UIColor clearColor];
    lbStay.text = @"待报价";
    lbStay.textAlignment = NSTextAlignmentCenter;
    lbStay.font = [UIFont systemFontOfSize:15.0];
    lbStay.tag = 100;
    lbStay.textColor = [UIColor whiteColor];
    [ctrlStay addSubview:lbStay];
    
    //seg2
    ctrlAlready = [[UIControl alloc] initWithFrame:CGRectMake(headTitleView.frame.size.width / 2, 0, headTitleView.frame.size.width / 2, headTitleView.frame.size.height)];
    ctrlAlready.backgroundColor = [UIColor clearColor];
    [ctrlAlready addTarget:self action:@selector(ctlAlreadyClick) forControlEvents:UIControlEventTouchUpInside];
    [headTitleView addSubview:ctrlAlready];
    UILabel *lbAlready = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ctrlAlready.frame.size.width, ctrlAlready.frame.size.height)];
    lbAlready.backgroundColor = [UIColor clearColor];
    lbAlready.text = @"待确认";
    lbAlready.textAlignment = NSTextAlignmentCenter;
    lbAlready.font = [UIFont systemFontOfSize:15.0];
    lbAlready.tag = 101;
    lbAlready.textColor = [UIColor colorWithHex:0xf26e2c alpha:1.0];
    [ctrlAlready addSubview:lbAlready];
    
    [self freshSegment:1];
}

- (void)ctlStayClick{
    NSLog(@"1");
    [self freshSegment:1];
}

- (void)ctlAlreadyClick{
    NSLog(@"2");
    [self freshSegment:2];
}

- (void)freshSegment:(int)i{
//    if ( typeSelected == i){
//        return;
//    }

    typeSelected = i;
    switch (typeSelected)
    {
        case 1:
        {
            UILabel *lbStay = (UILabel *)[ctrlStay viewWithTag:100];
            lbStay.textColor = [UIColor whiteColor];
            
            UILabel *lbAlready = (UILabel *)[ctrlAlready viewWithTag:101];
            lbAlready.textColor = BLACK_COLOR;
            
            headTitleView.image = [UIImage imageNamed:@"2栏左"];
            
            [self requestMyOrder];
        }
            break;
        case 2:
        {
            UILabel *lbStay = (UILabel *)[ctrlStay viewWithTag:100];
            lbStay.textColor = BLACK_COLOR;
            
            UILabel *lbAlready = (UILabel *)[ctrlAlready viewWithTag:101];
            lbAlready.textColor = [UIColor whiteColor];
            
            headTitleView.image = [UIImage imageNamed:@"2栏右"];
            
            [self requestMyOrder];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark  ---请求数据
- (void)requestMyOrder{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *urlStr = [NSString stringWithFormat:@"http://app.mjxypt.com/api/order/GetMsgList?companyId=%@&type=%i",[[user objectForKey:@"UserLogin"] objectForKey:@"userId"],typeSelected];
    
    [Request getRequestWithUrl:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] params:nil showTips:@"查询" tipsType:SVProgressHUDMaskTypeClear sucessBlock:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSArray *arrTempResult = (NSArray *)responseObject;
        NSLog(@"MJOrder-----%@",arrTempResult);
        [arrlist removeAllObjects];
        arrlist = [arrTempResult mutableCopy];
        [mainTab reloadData];
//        if ([arrTempResult count] > 0){
//            for (NSDictionary *dicResult in arrTempResult){
//                [arrOrder addObject:dicResult];
//            }
//        }
//        
//        if (tbOrder){
//            [tbOrder reloadData];
//            [tbOrder.mj_header endRefreshing];
//            [tbOrder.mj_footer endRefreshing];
//            
//            if ([arrTempResult count] == 0)
//            {
//                [tbOrder.mj_footer endRefreshingWithNoMoreData];
//            }
//        }   
    } failBlock:^(NSError *error) {
        
    } successBackFailedBlock:^(id responseObject) {
        
    }];
    
}

#pragma mark Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrlist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *model = arrlist[indexPath.row];
    MJmyMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[MJmyMsgCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.delegate = self;
    if (typeSelected == 1) {
        cell.typeLab.text = @"报价";
        cell.type = DAIBAOJIATYPE;
        [cell.typeBtn setBackgroundImage:[UIImage imageNamed:@"已邀"] forState:UIControlStateNormal];
    }
    
    else if (typeSelected == 2){
        cell.typeLab.text = @"确认";
        cell.type = DAIQUERENTYPE;
        [cell.typeBtn setBackgroundImage:[UIImage imageNamed:@"修改"] forState:UIControlStateNormal];
    }

    cell.indexRow = (int)indexPath.row;
    cell.orderIdLab.text = [NSString stringWithFormat:@"%@(%@)",[model objectForKey:@"OrderNo"],[model objectForKey:@"State"]];
    cell.lineLab.text = [NSString stringWithFormat:@"%@-->%@ 运费：%@",[model objectForKey:@"StartCity"],[model objectForKey:@"ArrivalCity"],[model objectForKey:@"Freight"]];
    
    if ([[model objectForKey:@"Weight"]floatValue]>0) {
        cell.productLab.text = [NSString stringWithFormat:@"%@ %@吨",[model objectForKey:@"CargoName"],[model objectForKey:@"Weight"]];
    }
    if ([[model objectForKey:@"Volume"]floatValue]>0) {
        cell.productLab.text = [NSString stringWithFormat:@"%@ %@方",[model objectForKey:@"CargoName"],[model objectForKey:@"Volume"]];
    }
    
    return cell;
}

#pragma mark Datasouce
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

- (void)orderWithIndex:(int)indexRow andType:(msgType)type{
    NSDictionary *model = arrlist[indexRow];
    if (typeSelected == 1) {
        // 报价界面
        MJBJViewController *vc = [[MJBJViewController alloc]init];
        vc.orderId = [model objectForKey:@"OrderId"];
        [self.navigationController pushViewController:vc animated:NO];
    }
    else if(typeSelected == 2){
        MJQuoteViewController *vc = [[MJQuoteViewController alloc]init];
        vc.orderId = [model objectForKey:@"OrderId"];
        [self.navigationController pushViewController:vc animated:NO];
    }
}



@end
