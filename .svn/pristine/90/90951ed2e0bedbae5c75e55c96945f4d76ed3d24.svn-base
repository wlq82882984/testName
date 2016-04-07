//
//  NSDictionary+safeObjectForKeyValue.m
//  hysj
//
//  Created by admin on 15/9/15.
//  Copyright (c) 2015年 BBKJ. All rights reserved.
//

#import "NSDictionary+safeObjectForKeyValue.h"
#define checkNull(__X__)      (__X__) == [NSNull null] || (__X__) == nil ? @"" : [NSString stringWithFormat:@"%@", (__X__)]

@implementation NSDictionary (safeObjectForKeyValue)

- (NSString *)safeObjectForKey:(id)key
{
    return checkNull([self objectForKey:key]);
}

@end
