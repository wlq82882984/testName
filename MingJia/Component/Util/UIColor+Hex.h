//
//  UIColor+Hex.h
//  Yiqiba
//
//  Created by jacob on 15/9/6.
//  Copyright (c) 2015年 hualei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor *)colorMainBg;
+ (UIColor *)colorSeparateLine;
+ (UIColor *)colorCompSeparateLine;
+ (UIColor *)colorNaviLine;
+ (UIColor *)colorNaviBg;
+ (UIColor *)colorFontDark;
+ (UIColor *)colorFontMiddle;
+ (UIColor *)colorFontLight;
+ (UIColor *)colorFontOrange;

@end
