//
//  MainTabBarController.h
//  AudioJack
//
//  Created by Tangwy on 10/18/13.
//  Copyright (c) 2013 Tangwy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabBarController : UITabBarController
@property (nonatomic) NSInteger shouldSelectedIndex;
@property (nonatomic, strong) NSMutableArray *buttons;

@property (nonatomic) BOOL forbidSwitchBar;

@property (nonatomic, strong) UIImageView* recordRoll;
@property (nonatomic, strong) UIImageView* discoverRoll;
@property (nonatomic, strong) UIImageView* shareRoll;

+ (instancetype)sharedMainTb;

- (void)customTabBar;
- (void)hideTabBar;
- (void)selectedTabAtIndex:(NSInteger)index;
- (void)setButtonImageAndText:(NSInteger)index isSelected:(BOOL)select;

-(void)setRoll:(int)_num;
-(void)removeRoll:(int)_num;

-(void)addRecordAnimation:(NSString*)_result;

@end
