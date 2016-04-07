//
//  ShopProductCategoryView.h
//  hytx
//
//  Created by baichun on 15-10-14.
//  Copyright (c) 2015年 BCKJ. All rights reserved.
//

#import "BaseView.h"
#import "ModelShopProductCategory.h"
@protocol ProductCategoryDelegate <NSObject>
-(void)categoryProductClicked:(ModelShopProductCategory *)category;
-(void)categoryProductClicked:(ModelShopProductCategory *)category androw:(int)selectedRow;
-(void)categoryRecommendClicked:(BOOL)isRecommend;
-(void)categoryCoinClicked:(BOOL)isRecommend;
@end

@interface HorizontalCategoryView : BaseView<UITableViewDelegate,UITableViewDataSource>
-(instancetype)initWithFrame:(CGRect)frame shopId:(int)shopId;
@property(nonatomic,strong)UITableView *categoryTableView;
@property(nonatomic)id<ProductCategoryDelegate>delegate;

@end
