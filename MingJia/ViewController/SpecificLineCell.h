//
//  SpecificLineCell.h
//  MingJia
//
//  Created by admin on 15/12/31.
//  Copyright © 2015年 BCKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SpecificLineCell;
@protocol SpecificChooseDelegate<NSObject>

- (void)order:(NSInteger)indexRow;
- (void)deCollect:(NSInteger)indexRow;
- (void)daphone:(NSInteger)indexRow;

@end

@interface SpecificLineCell : UITableViewCell

@property(nonatomic,weak)id<SpecificChooseDelegate> delegate;
@property(nonatomic,strong)UILabel     *comNameLab;
@property(nonatomic,strong)UILabel     *rankLab;
@property(nonatomic,strong)UILabel     *nameLab;
@property(nonatomic,strong)UILabel     *lineLab;
@property(nonatomic,strong)UILabel     *addressLab;
@property(nonatomic,strong)UILabel     *tapLine;
@property(nonatomic,strong)UIButton    *orderBtn;
@property(nonatomic,strong)UIButton    *collBtn;
@property(nonatomic,strong)UILabel     *lab2;

@property(nonatomic,copy)NSString       *phoneLab;
@property(nonatomic,copy)NSString       *teleLab;
@property(nonatomic,assign)int          rankStar;
@property(nonatomic,assign)NSInteger    indexRow;

@end
