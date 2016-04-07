//
//  Parser.h
//  pywiphone
//
//  Created by jacob on 15-7-3.
//  Copyright (c) 2015年 jacob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Parser : NSObject

#pragma mark - json array --> object array
/**
 *  json array --> object array
 *
 *  @param className className
 *  @param array     array
 *
 *  @return objectArray
 */
+(NSMutableArray *)parseToObjectArray:(NSString *)className WithArray:(NSArray*)array;

#pragma mark - json dictionary --> object
/**
 *  json dictionary --> object
 *
 *  @param className  className description
 *  @param dictionary dictionary description
 *
 *  @return nil
 */
+(id)parseToObject:(NSString *)className withDictionary:(NSDictionary *)dictionary;


@end


