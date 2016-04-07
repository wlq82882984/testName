//
//  PlistDao.h
//  RomanticAppiontment
//
//  Created by baichun on 15-2-11.
//  Copyright (c) 2015年 baichun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PrintObject.h"


@interface PlistDao : NSObject


//获得plist路径
+(NSString*)getPlistPath:(NSString *)plistName;

//判断沙盒中名为plistname的文件是否存在
+(BOOL) isPlistFileExists:(NSString *)plistName;
//初始化plist文件
+(void)initPlist :(NSString *)plistName;

//判断key的值是否存在
+(BOOL)isExistsForKey:(NSString*)key plistNameStr:(NSString *)plistName;

/*读取指定key的内容*/
+(NSMutableDictionary *)readKeyDictionary:(NSString *)plistName key:(NSString *)key;

//根据key值删除对应书籍
+(void)removeBookWithKey:(NSString *)key plistNameStr:(NSString *)plistName;

//删除plistPath路径对应的文件
+(void)deletePlist:(NSString *)plistName;

//将dictionary写入plist文件，前提：dictionary已经准备好
+(void)writePlist:(NSMutableDictionary*)dictionary forKey:(NSString *)key plistNameStr:(NSString *)plistName;
+(void)writeObjPlist:(id)obj forKey:(NSString *)key plistNameStr:(NSString *)plistName;

//
+(NSMutableDictionary*)readPlist:(NSString *)plistName;

//读取plist文件内容复制给dictionary   备用
+(void)readPlist:(NSMutableDictionary **)dictionary plistNameStr:(NSString *)plistName;
//更改一条数据，就是把dictionary内key重写
+(void)replaceDictionary:(NSMutableDictionary *)newDictionary withDictionaryKey:(NSString *)key plistNameStr:(NSString *)plistName;

+(NSInteger)getCount:(NSString *)plistName;
@end
