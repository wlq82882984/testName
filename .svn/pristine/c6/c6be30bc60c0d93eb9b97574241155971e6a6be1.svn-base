//
//  UtilAddressPerson.h
//  WaterMan
//
//  Created by baichun on 15-11-19.
//  Copyright (c) 2015年 baichun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import "ModelMemberPhoneContact.h"
@interface UtilAddressPerson : NSObject

@property(nonatomic,strong)NSMutableArray *arrAddressPersons; //手机通讯录的朋友
@property(nonatomic,strong)NSMutableString *jsonTextAddressPersons;

+ (UtilAddressPerson *)sharedMemberMySelf;
//、、手机通讯录  get list address persons
-(void)permissionAndPersonsArr;
//手机通讯录 所有用户的json字符串 get list address persons
-(void)addressPersonsJson;
// 手机通讯录  get list address persons
//+(NSMutableArray *)permissionAndPersonsArr;
// 手机通讯录 所有用户的json字符串 get list address persons
//+(NSMutableString *)addressPersonsJson:(NSMutableArray *)arrPersons;
@end
