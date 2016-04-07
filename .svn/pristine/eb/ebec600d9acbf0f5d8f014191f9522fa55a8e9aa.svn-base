//
//  UIColor+Hex.m
//  Yiqiba
//
//  Created by jacob on 15/9/6.
//  Copyright (c) 2015年 hualei. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue
{
    
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
    
}

+ (UIColor *)colorMainBg
{
    return [UIColor colorWithHex:0xeeeeee alpha:1.0];
}

+ (UIColor *)colorSeparateLine
{
    return [UIColor colorWithHex:0xe7e7e7 alpha:1.0];
}

+ (UIColor *)colorCompSeparateLine
{
    return [UIColor colorWithHex:0xe8e8e8 alpha:1.0];
}

+ (UIColor *)colorNaviLine
{
    return [UIColor colorWithHex:0xdddddd alpha:1.0];
}

+ (UIColor *)colorNaviBg
{
    return [UIColor colorWithHex:0xf8f8f8 alpha:1.0];
}

+ (UIColor *)colorFontDark
{
    return [UIColor colorWithHex:0x333333 alpha:1.0];
}

+ (UIColor *)colorFontMiddle
{
    return [UIColor colorWithHex:0x666666 alpha:1.0];
}

+ (UIColor *)colorFontLight
{
    return [UIColor colorWithHex:0xa2a2a2 alpha:1.0];

//    return [UIColor colorWithHex:0xa5a5a5 alpha:1.0];
}

+ (UIColor *)colorFontOrange
{
    return [UIColor colorWithHex:0xe86c57 alpha:1.0];
    
    //    return [UIColor colorWithHex:0xa5a5a5 alpha:1.0];
}

@end
