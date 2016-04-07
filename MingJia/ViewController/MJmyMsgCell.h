//
//  MJmyMsgCell.h
//  MingJia
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 BCKJ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    DAIBAOJIATYPE,
    DAIQUERENTYPE,
} msgType;
@class MJmyMsgCell;
@protocol MsgChooseDelegate<NSObject>

- (void)orderWithIndex:(int)indexRow andType:(msgType)type;

@end

@interface MJmyMsgCell : UITableViewCell
@property(nonatomic,weak)id<MsgChooseDelegate> delegate;
@property(nonatomic,strong)UILabel     *orderIdLab;
@property(nonatomic,strong)UILabel     *nameLab;
@property(nonatomic,strong)UILabel     *lineLab;
@property(nonatomic,strong)UILabel     *productLab;
@property(nonatomic,strong)UIButton    *typeBtn;
@property(nonatomic,strong)UILabel     *typeLab;

@property(nonatomic,assign)int          indexRow;
@property(nonatomic,assign)msgType    type;
@end
