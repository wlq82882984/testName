//
//  MJOrderCell.h
//  MingJia
//
//  Created by admin on 16/1/3.
//  Copyright © 2016年 BCKJ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    DAISHOULITYPE,
    YISHOULITYPE,
    WEIFUKUANTYPE,
    DAIYUNSHUTYPE,
    YUNSHUWANCHENTYPE
} orderType;

@class MJOrderCell;
@protocol OrderChooseDelegate<NSObject>

- (void)orderWithIndex:(int)indexRow andType:(orderType)type;

@end

@interface MJOrderCell : UITableViewCell

@property(nonatomic,weak)id<OrderChooseDelegate> delegate;
@property(nonatomic,strong)UILabel     *orderIdLab;
@property(nonatomic,strong)UILabel     *nameLab;
@property(nonatomic,strong)UILabel     *lineLab;
@property(nonatomic,strong)UILabel     *productLab;
@property(nonatomic,strong)UIButton    *typeBtn;
@property(nonatomic,strong)UILabel     *typeLab;

@property(nonatomic,assign)int          indexRow;
@property(nonatomic,assign)orderType    type;

@end
