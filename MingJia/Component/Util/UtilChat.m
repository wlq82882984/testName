//
//  UtilChat.m
//  WaterMan
//
//  Created by baichun on 15/12/9.
//  Copyright © 2015年 baichun. All rights reserved.
//

#import "UtilChat.h"

@implementation UtilChat

//判断会话有没有置顶
+(BOOL)conversationIsTop:(NSString *)chatter
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *array = [defaults valueForKey:TopChatArray];
    
    if (array == nil)
    {
        return NO;
    }
    
    for (NSDictionary *dic in array)
    {
        if ([dic[@"imID"] isEqualToString:chatter])
        {
            return YES;
        }
    }
    
    return NO;
}

/**
 *  设置置顶聊天
 */
+ (void)conversationSetTopState:(NSString *)chatter changedToState:(BOOL)isTop conversationType:(EMMessageType)msgType
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *array = [NSMutableArray arrayWithArray:[defaults valueForKey:TopChatArray]];
    if (isTop)
    {
        if (array == nil)
        {
            array = [NSMutableArray array];
        }
        
        NSDictionary *dic = @{@"imID":[UtilString getNoNilString:chatter],@"conversationType":[NSNumber numberWithInteger:msgType]};
        
        [array insertObject:dic atIndex:0];
        [defaults setValue:array forKey:TopChatArray];
        [defaults synchronize];
    }
    else
    {
        for (NSDictionary *dic in array)
        {
            if ([dic[@"imID"] isEqualToString:chatter])
            {
                [array removeObject:dic];
                [defaults setValue:array forKey:TopChatArray];
                [defaults synchronize];
            }
        }
    }
}



@end
