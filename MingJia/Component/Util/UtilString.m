//
//  UtilString.m
//  hysj
//
//  Created by baichun on 15-9-16.
//  Copyright (c) 2015年 BBKJ. All rights reserved.
//

#import "UtilString.h"
#import "BaseSetting.h"

@implementation UtilString
+(NSString *)getNoNilString:(NSString *)str{
    if (!str||[str isEqualToString:@""]||[str isEqualToString:@"null"]) {
        return @"";
    }else{
        return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
}

+(NSString *)getPriceWithProduct:(NSInteger)priceNum{
    return [NSString stringWithFormat:@"¥ %.2f",((float)priceNum)*0.01f];
}

+(CGSize)getLabelsize:(NSString *)text andTextsize:(int)textsize andLabwidth:(int)width{
    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    label.numberOfLines = 1000;
    CGSize size = CGSizeMake(width, 9999);
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:textsize]};
    CGSize labelSize = [text boundingRectWithSize:size options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return labelSize;
}


/*获取yyyy.MM.dd hh:mm:ss格式的时间*/
+(NSString *)getTimeFormmatterHMS:(NSNumber *)time formatStr:(NSString *)timeFormatStr{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    if (timeFormatStr &&![timeFormatStr isEqualToString:@""]) {
        [formatter setDateFormat:timeFormatStr];
    }else{
        [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    }
    NSTimeInterval orderTime=[time doubleValue];
    NSDate *orderTimedate=[NSDate dateWithTimeIntervalSince1970:orderTime];
    return [NSString stringWithFormat:@"%@",[formatter stringFromDate:orderTimedate]];
}

+ (NSString *)getOSSPictureWithUrlString:(NSString *)urlstr
{
    if (!urlstr||[urlstr isEqualToString:@""]||[urlstr isEqualToString:@"null"])
    {
        return @"";
    }
    else
    {
        return [NSString stringWithFormat:@"%@%@",IMAGES_OSS_PIC,urlstr];
    }
}

/**
 *  大图路径
 */
+ (NSString *)getBigPictureWithUrlString:(NSString *)urlstr
{
    if (!urlstr||[urlstr isEqualToString:@""]||[urlstr isEqualToString:@"null"])
    {
        return @"";
    }
    else
    {
        return [NSString stringWithFormat:@"%@%@",IMAGES_ICON_BIG,urlstr];
    }
}



/**
 *  小图路劲
 */
+ (NSString *)getSamllPictureWithUrlString:(NSString *)urlstr
{
    if (!urlstr||[urlstr isEqualToString:@""]||[urlstr isEqualToString:@"null"])
    {
        return @"";
    }
    else
    {
        return [NSString stringWithFormat:@"%@%@",IMAGES_ICON_SAMLL,urlstr];
    }
}


+(NSURL *)getSmallImageUrlWithString:(NSString *)string
{
    //    if ([[self getNoNilString:string] isEqualToString:@""]) {
    //        return nil;
    //    }
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGES_ICON_SAMLL,[self getNoNilString:string]]];
}

+(NSURL *)getBigImageUrlWithString:(NSString *)string
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGES_ICON_BIG,[self getNoNilString:string]]];
    
}


+(NSURL *)getOSSImageUrlWithString:(NSString *)string
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGES_OSS_PIC,[self getNoNilString:string]]];
    
}

+ (NSString *)documentsPath:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

+ (NSString *)documentsGroupDataPath:(NSString *)fileName
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *groupDataPath = [NSString stringWithFormat:@"%@/GroupData", pathDocuments];
    
    // 判断文件夹是否存在，如果不存在，则创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:groupDataPath]) {
        [fileManager createDirectoryAtPath:groupDataPath withIntermediateDirectories:YES attributes:nil error:nil];
    } else {
        NSLog(@"FileDir is exists.");
    }
    
    NSString *filePath = [groupDataPath stringByAppendingPathComponent:fileName];
    
    return filePath;
}

+ (NSString *)documentFriendAndGroupChatDataPlistPath
{
    NSString *filePath = [UtilString documentsPath:@"FriendAndGroupChatData.plist"];
    
    return filePath;
}

+ (NSString *)documentGroupImageFilesPlistPath
{
    NSString *filePath = [UtilString documentsPath:@"GroupImagePaths.plist"];
    
    return filePath;
}

+ (NSString *)documentPersonalImageFilesPlistPath
{
    NSString *filePath = [UtilString documentsPath:@"PersonalImagePaths.plist"];
    
    return filePath;
}

+ (NSString *)documentTemporaryChatFriendsPlistPath
{
    NSString *filePath = [UtilString documentsPath:@"TemporaryChatFriends.plist"];
    
    return filePath;
}

@end
