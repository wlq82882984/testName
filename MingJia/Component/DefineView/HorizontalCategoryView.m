//
//  ShopProductCategoryView.m
//  hytx
//
//  Created by baichun on 15-10-14.
//  Copyright (c) 2015年 BCKJ. All rights reserved.
//

#import "HorizontalCategoryView.h"

@interface ShopCategoryCell : UITableViewCell{
    NSString * nameCategory;
    BOOL curIsSelect;
}
@property(nonatomic,strong)UILabel *categoryNameLal;
@end

@implementation ShopCategoryCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withName:(NSString *)categoryName isSelected:(BOOL)select{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        self.backgroundColor=[UIColor whiteColor];
        nameCategory=categoryName;
        curIsSelect=select;
    }
    return self;
}

-(void)resetIsSelected:(BOOL)isSelected{
    curIsSelect=isSelected;
    if (isSelected) {
        _categoryNameLal.textColor=[UIColor orangeColor];

    }else{
        _categoryNameLal.textColor=[UIColor colorWithHex:0x333333 alpha:1.0];
    }
}

-(void)drawRect:(CGRect)rect{
    if (_categoryNameLal) {
        [_categoryNameLal removeFromSuperview];
    }
    
    _categoryNameLal=[UILabel createLabelWithFrame:CGRectMake(-SizeScale(31), SizeScale(31),ScreenWidth/3,SizeScale(44)) backgroundColor:[UIColor clearColor] textColor:[UIColor colorWithHex:0x333333 alpha:1.0] font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentCenter text:nameCategory];
    if (curIsSelect) {
        _categoryNameLal.textColor=[UIColor orangeColor];
    }
    _categoryNameLal.transform = CGAffineTransformMakeRotation(M_PI/2);

    [self addSubview:_categoryNameLal];
}
@end

@interface HorizontalCategoryView (){
    NSMutableArray *categoryArr;
    int curShopId;
    UIView *curSuperView;
    NSIndexPath *selectIndex;
}

@end

@implementation HorizontalCategoryView

-(instancetype)initWithFrame:(CGRect)frame shopId:(int)shopId{
    self=[super initWithFrame:frame];
    if (self) {
        categoryArr=[NSMutableArray array];
        self.backgroundColor=[UIColor whiteColor];
        curShopId=shopId;
        selectIndex=[NSIndexPath indexPathForRow:0 inSection:0];
        [self drawView];
    }
    return self;
}

-(void)drawView{
    _categoryTableView= [[UITableView alloc] init];
    _categoryTableView.backgroundColor =[UIColor clearColor];
    [_categoryTableView.layer setAnchorPoint:CGPointMake(0.0, 0.0)];
    _categoryTableView.transform = CGAffineTransformMakeRotation(M_PI/-2);
    _categoryTableView.showsVerticalScrollIndicator = NO;
    _categoryTableView.frame = CGRectMake(SizeScale(0), SizeScale(44), ScreenWidth,SizeScale(44));
    _categoryTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _categoryTableView.delegate = self;
    _categoryTableView.dataSource = self;
    [self addSubview:_categoryTableView];
    [_categoryTableView registerClass:[ShopCategoryCell class] forCellReuseIdentifier:@"ShopCategoryCell"];
    [self sendRecommandList];
}

-(void)sendRecommandList{
    if (!curShopId) {
        [ALToastView  toastInView:curSuperView withText:@"未获取商店信息"];
        return;
    }
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:curShopId] forKey:@"shopId"];
    [Request postRequestWithUrl:[Request getUrlStringWithRequestStr:@"shop/listShopProductCategory"] params:dict sucessBlock:^(id responseObject) {
        NSString *string = [responseObject description];
        NSRange range = [string rangeOfString:@"errorId"];//判断字符串是否包含
        if (range.length >0)//包含
        {
            [self loadDataError];
//            Error *error = [Error objectWithKeyValues:responseObject];
//            if ([error.errorId intValue]==ERROR_VALUE_99) {
//            }
        }else{
            NSArray *array= [ModelShopProductCategory objectArrayWithKeyValuesArray:responseObject];
            
            if(array){
                [categoryArr addObjectsFromArray:array];
            }
            [_categoryTableView reloadData];
        }
        
    } failBlock:^(NSError *error) {
        [self loadDataError];
    }];
}

-(void)loadDataError{
        [_categoryTableView reloadData];
}

#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [categoryArr count]+2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *name=@"";
    if (indexPath.row==0) {
        name=@"热销推荐";
    }
    else if(indexPath.row==1){
        name=@"金币商品";
    }
    else{
        ModelShopProductCategory *category = categoryArr[indexPath.row - 2];
        name=category.categoryName;
    }
    
    ShopCategoryCell *cell=[[ShopCategoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ShopCategoryCell" withName:name isSelected:selectIndex.row==indexPath.row];
    if (indexPath.row==selectIndex.row) {
        cell.categoryNameLal.textColor=[UIColor orangeColor];
    }
    cell.accessoryType=UITableViewCellAccessoryNone;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.categoryNameLal.transform = CGAffineTransformMakeRotation(M_PI/2);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopCategoryCell *beforeCell=(ShopCategoryCell *)[tableView cellForRowAtIndexPath:selectIndex];
    [beforeCell resetIsSelected:NO];
    
    selectIndex=indexPath;
    ShopCategoryCell *curCell=(ShopCategoryCell *)[tableView cellForRowAtIndexPath:selectIndex];
    [curCell resetIsSelected:YES];
    
    if (indexPath.row==0) {
        if (_delegate&&[_delegate respondsToSelector:@selector(categoryRecommendClicked:)]) {
            [_delegate categoryRecommendClicked:YES];
        }
        return;
    }
    if (indexPath.row==1) {
        if (_delegate&&[_delegate respondsToSelector:@selector(categoryRecommendClicked:)]) {
            [_delegate categoryCoinClicked:nil];
        }
        return;
    }
    if (_delegate&&[_delegate respondsToSelector:@selector(categoryProductClicked:)]) {
//        [_delegate categoryProductClicked:categoryArr[indexPath.row - 2]];
        [_delegate categoryProductClicked:categoryArr[indexPath.row - 2] androw:(int)indexPath.row];
    }
}

#pragma UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScreenWidth/3;
}

@end
