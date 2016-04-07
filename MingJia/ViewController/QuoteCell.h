//
//  QuoteCell.h
//  MingJia
//
//  Created by admin on 16/1/3.
//  Copyright © 2016年 BCKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuoteCell;
@protocol OrderChooseDelegate<NSObject>

- (void)commitWithIndex:(int)indexRow;

@end

@interface QuoteCell : UITableViewCell

@property(nonatomic,weak)id<OrderChooseDelegate> delegate;
@property(nonatomic,strong)UILabel     *nameLab;
@property(nonatomic,strong)UILabel     *phoneLab;
@property(nonatomic,strong)UILabel     *detailLab;
@property(nonatomic,strong)UILabel     *addLab;
@property(nonatomic,strong)UIButton    *commitbtn;
@property(nonatomic,strong)UILabel     *typeLab;

@property(nonatomic,assign)int          indexRow;
@property(nonatomic,assign)int          rankStar;

@end
