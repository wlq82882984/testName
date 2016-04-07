//
//  MJComplainViewController.m
//  MingJia
//
//  Created by admin on 15/12/28.
//  Copyright © 2015年 BCKJ. All rights reserved.
//

#import "MJComplainViewController.h"
#import "ComplainCell.h"

@interface MJComplainViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIGestureRecognizerDelegate>{
    UIScrollView      *mainScroll;
    NSArray           *typeArr;
    UITableView       *typeTabV;
    UIButton          *typebtn;
    UILabel           *typeLab;
    UIImageView       *iconImg;
    UIView            *bodyView;
    UILabel           *downLabel;
    
    UITextField       *complainName;
    UITextField       *complainTele;
    UITextField       *complainedName;
    UITextField       *complainedTele;
    UITextView        *evalTextV;
    
    UIButton          *photoBtn;    // 拍照上传
    UIButton          *commitBtn;   // 提交
    
}

@end

@implementation MJComplainViewController

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 输出点击的view的类名
    
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self resignFirst];
    return YES;
}

- (void)resignFirst{
    [complainName resignFirstResponder];
    [complainTele resignFirstResponder];
    [complainedName resignFirstResponder];
    [complainedTele resignFirstResponder];
    [evalTextV resignFirstResponder];
}

- (void)changeicon:(id)sender{
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self showtypeView];
    }
    else {
        [self hidetypeView];
    }
}

- (void)showtypeView{
    bodyView.frame = CGRectMake(0, 300, bodyView.frame.size.width, bodyView.frame.size.height);
    mainScroll.contentSize = CGSizeMake(ScreenWidth, 680);
    [UIView animateWithDuration:0 animations:^{
        typeTabV.frame = CGRectMake(0, 40, ScreenWidth, 240);
    }];
}

- (void)hidetypeView{
    bodyView.frame = CGRectMake(0, 60, bodyView.frame.size.width, bodyView.frame.size.height);
    mainScroll.contentSize = CGSizeMake(ScreenWidth, 450);
    [UIView animateWithDuration:0 animations:^{
        typeTabV.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, 240);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"投诉";
    typeArr = @[@"运输时效",@"运费问题",@"货损问题",@"服务问题",@"软件问题",@"其他"];
    
    mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    mainScroll.backgroundColor = WHITE_COLOR;
    UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignFirst)];
    Tap.delegate = self;
    mainScroll.userInteractionEnabled=YES;
    [mainScroll addGestureRecognizer:Tap];
    [self.view addSubview:mainScroll];
    bodyView = [UIView createViewWithFrame:CGRectMake(0, 60, ScreenWidth, 350) backgroundColor:WHITE_COLOR];
    [mainScroll addSubview:bodyView];
    
    [self drawView];
    typeTabV = [UITableView createTableViewWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, 240) style:UITableViewStylePlain backgroundColor:CLEAN_COLOR delegate:self dataSource:self];
    typeTabV.scrollEnabled = NO;
    [mainScroll addSubview:typeTabV];
    //键盘frame变化的时候会调用该通知的方法
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

//当键盘位置发生改变的时候会调用该方法
-(void)keyboardWillChangeFrame:(NSNotification *)notification{
    //键盘弹出的时间
    CGFloat duration=[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //键盘自己的frame
    CGRect keyBoardFrame=[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //计算当前view的y方向的偏移量
    CGFloat transfomY=keyBoardFrame.origin.y-self.view.frame.size.height;
    //UIView动画
    [UIView animateWithDuration:duration animations:^{
        //        self.view.transform=CGAffineTransformMakeTranslation(0, transfomY);
        if (transfomY>=0) {
            mainScroll.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64);
        }
        else{
            mainScroll.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 -254);
        }
        //        NSLog(@"keyboard   %@",NSStringFromCGRect(keyBoardFrame));
        //        NSLog(@"view  %@",NSStringFromCGRect(self.view.frame));
        //        NSLog(@"table %@",NSStringFromCGRect(self.tableView.frame));
    }];
}

- (void)drawView{
    UILabel *titLab = [UILabel createLabelWithFrame:CGRectMake(0, 0, 80, 40) backgroundColor:CLEAN_COLOR textColor:[UIColor blackColor] font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"投诉类型："];
    [mainScroll addSubview:titLab];
    typeLab = [UILabel createLabelWithFrame:CGRectMake(ScreenWidth - 120, 0, 100, 40) backgroundColor:CLEAN_COLOR textColor:[UIColor blackColor] font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentRight text:@""];
    [mainScroll addSubview:typeLab];
    typebtn = [UIButton createButtonwithFrame:CGRectMake(90, 0, 250, 40) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@""]];
    [typebtn addTarget:self action:@selector(changeicon:) forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:typebtn];
    iconImg = [UIImageView createImageViewWithFrame:CGRectMake(ScreenWidth - 30, 13, 15, 15) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"展开"]];
    [mainScroll addSubview:iconImg];
    
    UILabel *titLab1 = [UILabel createLabelWithFrame:CGRectMake(0, 0, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"投诉人："];
    [bodyView addSubview:titLab1];
    complainName = [UITextField createTextFieldWithFrame:CGRectMake(90, 0, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:[UIColor blackColor] font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft];
    complainName.delegate = self;
    [bodyView addSubview:complainName];
    UILabel *tapline = [UILabel createLabelWithFrame:CGRectMake(0, 39, ScreenWidth, 1) backgroundColor:BACK_COLL_HEAD textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@""];
    [bodyView addSubview:tapline];
    
    UILabel *titLab2 = [UILabel createLabelWithFrame:CGRectMake(0, 40, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"电话："];
    [bodyView addSubview:titLab2];
    complainTele = [UITextField createTextFieldWithFrame:CGRectMake(90, 40, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:[UIColor blackColor] font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft];
    complainTele.delegate = self;
    [bodyView addSubview:complainTele];
    UILabel *tapline1 = [UILabel createLabelWithFrame:CGRectMake(0, 79, ScreenWidth, 1) backgroundColor:BACK_COLL_HEAD textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@""];
    [bodyView addSubview:tapline1];
    
    UILabel *titLab3 = [UILabel createLabelWithFrame:CGRectMake(0, 80, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"被投诉人："];
    [bodyView addSubview:titLab3];
    complainedName = [UITextField createTextFieldWithFrame:CGRectMake(90, 80, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:[UIColor blackColor] font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft];
    complainedName.delegate = self;
    [bodyView addSubview:complainedName];
    UILabel *tapline2 = [UILabel createLabelWithFrame:CGRectMake(0, 119, ScreenWidth, 1) backgroundColor:BACK_COLL_HEAD textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@""];
    [bodyView addSubview:tapline2];
    
    UILabel *titLab4 = [UILabel createLabelWithFrame:CGRectMake(0, 120, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"电话："];
    [bodyView addSubview:titLab4];
    complainedTele = [UITextField createTextFieldWithFrame:CGRectMake(90, 120, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:[UIColor blackColor] font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft];
    complainedTele.delegate = self;
    [bodyView addSubview:complainedTele];
    UILabel *tapline3 = [UILabel createLabelWithFrame:CGRectMake(0, 159, ScreenWidth, 1) backgroundColor:BACK_COLL_HEAD textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@""];
    [bodyView addSubview:tapline3];
    
    UILabel *titLab5 = [UILabel createLabelWithFrame:CGRectMake(0, 160, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"投诉原因："];
    [bodyView addSubview:titLab5];
    evalTextV = [[UITextView alloc]init];
    evalTextV.frame = CGRectMake(90, 160, ScreenWidth - 100, 80);
    evalTextV.font = SYSTEM_FONT_(14);
    evalTextV.delegate = self;
    [bodyView addSubview:evalTextV];
    UILabel *tapline4 = [UILabel createLabelWithFrame:CGRectMake(0, 239, ScreenWidth, 1) backgroundColor:BACK_COLL_HEAD textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@""];
    [bodyView addSubview:tapline4];
    
    downLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tapline4.frame),  ScreenWidth - 20, 11)];
    downLabel.backgroundColor = [UIColor clearColor];
    downLabel.font = SYSTEM_FONT_(11);
    downLabel.textAlignment = NSTextAlignmentRight;
    downLabel.textColor = [UIColor colorWithHex:0xbebebe alpha:1.0];
    downLabel.text = @"还能输入300字";
    [bodyView addSubview:downLabel];
    
    photoBtn = [UIButton createButtonwithFrame:CGRectMake(10, CGRectGetMaxY(tapline4.frame)+15, ScreenWidth-20, 35) backgroundColor:TABBAR_TEXT_COLOR_SEL image:[UIImage imageNamed:@""]];
    photoBtn.titleLabel.font = SYSTEM_FONT_(14);
    photoBtn.layer.cornerRadius = 5;
    [photoBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [photoBtn setTitle:@"拍照上传" forState:UIControlStateNormal];
//    [bodyView addSubview:btn];
    commitBtn = [UIButton createButtonwithFrame:CGRectMake(10, CGRectGetMaxY(photoBtn.frame)+15, ScreenWidth-20, 40) backgroundColor:TABBAR_TEXT_COLOR_SEL image:[UIImage imageNamed:@""]];
    commitBtn.titleLabel.font = SYSTEM_FONT_(14);
    commitBtn.layer.cornerRadius = 5;
    [commitBtn addTarget:self action:@selector(complaint) forControlEvents:UIControlEventTouchUpInside];
    [commitBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [bodyView addSubview:commitBtn];
}

- (void)complaint{
    if (complainName.text.length == 0) {
        [SVProgressHUD showSuccessWithStatus:@"请填写投诉人姓名" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    
    if (complainTele.text.length > 0) {
        if (![CheckMethod validateMobile:complainTele.text]) {
            [SVProgressHUD showSuccessWithStatus:@"请填写正确的手机格式" maskType:SVProgressHUDMaskTypeClear];
            return;
        }
    }
    else{
        [SVProgressHUD showSuccessWithStatus:@"请填写投诉人手机" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    
    if (complainedName.text.length == 0) {
        [SVProgressHUD showSuccessWithStatus:@"请填写被投诉人姓名" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    
    if (complainedTele.text.length > 0) {
        if (![CheckMethod validateMobile:complainedTele.text]) {
            [SVProgressHUD showSuccessWithStatus:@"请填写正确的手机格式" maskType:SVProgressHUDMaskTypeClear];
            return;
        }
    }
    else{
        [SVProgressHUD showSuccessWithStatus:@"请填写投诉人手机" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    
    if (evalTextV.text.length == 0) {
        [SVProgressHUD showSuccessWithStatus:@"请填写投诉原因" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    
    [self requestTousu];
    
}

- (void)requestTousu{
    NSString *urlStr = [Request getUrlStringWithRequestStr:@"complaint/create"];
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    if (_complaintId) {
        [dict setObject:_complaintId forKey:@"ComplaintId"];
    }
    else {
        [dict setObject:@"00000000-0000-0000-0000-000000000000" forKey:@"ComplaintId"];
    }
    [dict setObject:@"其他" forKey:@"ComplaintType"];
    if (typeLab.text.length > 0) {
        [dict setObject:typeLab.text forKey:@"ComplaintType"];
    }
    [dict setObject:complainName.text forKey:@"Complainant"];
    [dict setObject:complainTele.text forKey:@"ComplainantTel"];
    [dict setObject:complainedName.text forKey:@"Defendant"];
    [dict setObject:complainedTele.text forKey:@"DefendantTel"];
    [dict setObject:evalTextV.text forKey:@"Remark"];
    
    [Request postRequestWithUrl:urlStr params:dict showTips:@"正在提交...." tipsType:SVProgressHUDMaskTypeBlack sucessBlock:^(id responseObject) {
        NSDictionary *dict = responseObject;
        if ([[dict objectForKey:@"Code"]integerValue] == 0) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Message"]] maskType:SVProgressHUDMaskTypeClear];
        }
        if ([[dict objectForKey:@"Code"]integerValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Message"]] maskType:SVProgressHUDMaskTypeClear];
        }
    } failBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"服务器未知异常"];
    } successBackFailedBlock:^(id responseObject) {
        
    }];




}

- (void)textViewDidChange:(UITextView *)textView
{
    NSString  *nsTextContent= textView.text;
    
    if ([nsTextContent length] > 300)
    {
        nsTextContent = [nsTextContent substringToIndex:300];
    }
    
    int remainTextNum_ =  300;
    remainTextNum_ -= [nsTextContent length];
    
    textView.text = nsTextContent;
    downLabel.text = [NSString stringWithFormat:@"还能输入%d字",remainTextNum_];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [typeArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ComplainCell * cell = [[ComplainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.titLab.text = [NSString stringWithFormat:@"%@",typeArr[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    ComplainCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.titLab.textColor = [UIColor blackColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ComplainCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.titLab.textColor = TABBAR_TEXT_COLOR_SEL;
    typebtn.selected = NO;
    typeLab.text = [NSString stringWithFormat:@"%@",typeArr[indexPath.row]];
    [self hidetypeView];
}




@end
