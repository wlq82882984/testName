//
//  UtilChat.h
//  WaterMan
//
//  Created by baichun on 15/12/9.
//  Copyright © 2015年 baichun. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EaseUI.h"
@interface UtilChat : NSObject

+(BOOL)conversationIsTop:(NSString *)chatter;
+ (void)conversationSetTopState:(NSString *)chatter changedToState:(BOOL)isTop conversationType:(EMMessageType)msgType;
@end
