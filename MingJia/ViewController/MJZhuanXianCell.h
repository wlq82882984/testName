//
//  MJZhuanXianCell.h
//  MingJia
//
//  Created by admin on 16/1/4.
//  Copyright © 2016年 BCKJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MJZhuanXianCell;
@protocol ZhuanxianChooseDelegate<NSObject>

- (void)order:(NSInteger)indexRow;
- (void)daphone:(NSInteger)indexRow;

@end
@interface MJZhuanXianCell : UITableViewCell
@property(nonatomic,weak)id<ZhuanxianChooseDelegate> delegate;
@property(nonatomic,strong)UILabel     *comNameLab;
@property(nonatomic,strong)UILabel     *rankLab;
@property(nonatomic,strong)UILabel     *nameLab;
@property(nonatomic,strong)UILabel     *lineLab;
@property(nonatomic,strong)UILabel     *addressLab;
@property(nonatomic,strong)UILabel     *tapLine;
@property(nonatomic,strong)UIButton    *orderBtn;

@property(nonatomic,copy)NSString       *phoneLab;
@property(nonatomic,copy)NSString       *teleLab;
@property(nonatomic,assign)int          rankStar;
@property(nonatomic,assign)NSInteger    indexRow;
@end
