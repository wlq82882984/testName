//
//  UtilAddressPerson.m
//  WaterMan
//
//  Created by baichun on 15-11-19.
//  Copyright (c) 2015年 baichun. All rights reserved.
//

#import "UtilAddressPerson.h"
#import <UIKit/UIKit.h>
#import "CheckMethod.h"
#import "PrintObject.h"
#import "ModelMember.h"

static UtilAddressPerson *instanceModel = nil;


@implementation UtilAddressPerson


//用户登录系统的单例用的，只在登录和获取用户信息的时候用
+ (UtilAddressPerson *)sharedMemberMySelf
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instanceModel = [[UtilAddressPerson alloc] init];
        instanceModel.arrAddressPersons=[NSMutableArray array];
        instanceModel.jsonTextAddressPersons=[NSMutableString string];
    });
    return instanceModel;
    
}


//限制当前对象创建多实例
#pragma mark - sengleton setting
+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (instanceModel == nil) {
            instanceModel = [super allocWithZone:zone];
            instanceModel.arrAddressPersons=[NSMutableArray array];
            instanceModel.jsonTextAddressPersons=[NSMutableString string];

        }
    }
    return instanceModel;
}

+ (id)copyWithZone:(NSZone *)zone {
    return self;
}



#pragma mark  手机通讯录  get list address persons
#pragma =====================================================
//+(NSMutableArray *)permissionAndPersonsArr{
-(void)permissionAndPersonsArr{

    ModelMember *model=[ModelMember sharedMemberMySelf];
    if (!model || !model.memberId) {
//        return nil;
        self.arrAddressPersons=[NSMutableArray array];
    }
    ABAddressBookRef addressBooks = nil;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
    
    {
        addressBooks =  ABAddressBookCreateWithOptions(NULL, NULL);
        
        //获取通讯录权限
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error){dispatch_semaphore_signal(sema);});
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
        //        dispatch_release(sema);
        
    }
    
    else
    
    {
        addressBooks = ABAddressBookCreate();
        
    }
    
    //获取通讯录中的所有人
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
  NSMutableArray  *arrAddressPersons=[NSMutableArray array];
    
    
    //通讯录中人数
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);
    
    //循环，获取每个人的个人信息
    for (NSInteger i = 0; i < nPeople; i++)
    {
        //新建一个addressBook model类
        ModelMemberPhoneContact *addressBook = [[ModelMemberPhoneContact alloc] init];
        //获取个人
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
        //获取个人名字
        CFTypeRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFTypeRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(person);
        NSString *nameString = (__bridge NSString *)abName;
        NSString *lastNameString = (__bridge NSString *)abLastName;
        
        if ((__bridge id)abFullName != nil) {
            nameString = (__bridge NSString *)abFullName;
        } else {
            if ((__bridge id)abLastName != nil)
            {
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }
        addressBook.contactName = nameString;
        //        addressBook.recordID = (int)ABRecordGetRecordID(person);;
        
        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty,
            kABPersonEmailProperty
        };
        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
            NSInteger valuesCount = 0;
            if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
            
            if (valuesCount == 0) {
                CFRelease(valuesRef);
                continue;
            }
            //获取电话号码和email
            for (NSInteger k = 0; k < valuesCount; k++) {
                CFTypeRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                switch (j) {
                    case 0: {// Phone number
                        NSString *phone=[(__bridge NSString*)value stringByReplacingOccurrencesOfString:@"-" withString:@""];
                        addressBook.contactPhone = phone;
                        
                        //                        addressBook.contactPhone = (__bridge NSString*)value;
                        break;
                    }
                    case 1: {// Email
                        //                        addressBook.email = (__bridge NSString*)value;
                        break;
                    }
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
        
        if ([CheckMethod validateMobile:addressBook.contactPhone]) {
            addressBook.memberId=model.memberId;
            [arrAddressPersons addObject:addressBook];
//            NSLog(@"address person:%@,%@",addressBook.contactPhone,addressBook.contactName);
        }
        //将个人信息添加到数组中，循环完成后addressBookTemp中包含所有联系人的信息
        if (abName) CFRelease(abName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);
    }
    NSLog(@"address persons:%@",arrAddressPersons);

//    return arrAddressPersons;
    self.arrAddressPersons=arrAddressPersons;
}

#pragma mark  手机通讯录 所有用户的json字符串 get list address persons
#pragma =====================================================
-(void)addressPersonsJson{
    NSMutableString *jsonText=[NSMutableString stringWithString:@"["];
    
    if (!self.arrAddressPersons ||[self.arrAddressPersons count]==0) {
        [jsonText appendString:@"]"];
        self.jsonTextAddressPersons= jsonText;
        return;
    }
    
    for (int i=0; i<[self.arrAddressPersons count]; i++) {
        NSData *josnStr=[PrintObject getJSON:self.arrAddressPersons[i] options:NSJSONWritingPrettyPrinted error:nil];
        NSString  *jsonTextTemp = [[NSString alloc] initWithData:josnStr encoding:NSUTF8StringEncoding];
        [jsonText appendString:jsonTextTemp];
        if (i==[self.arrAddressPersons count]-1) {
            [jsonText appendString:@"]"];
            
        }else{
            [jsonText appendString:@","];
        }
    }
    
    self.jsonTextAddressPersons= jsonText;

}
+(NSMutableString *)addressPersonsJson:(NSMutableArray *)arrPersons{
    NSMutableString *jsonText=[NSMutableString stringWithString:@"["];
    
    if ([arrPersons count]==0) {
        [jsonText appendString:@"]"];
        return jsonText;
    }
    
    for (int i=0; i<[arrPersons count]; i++) {
        NSData *josnStr=[PrintObject getJSON:arrPersons[i] options:NSJSONWritingPrettyPrinted error:nil];
        NSString  *jsonTextTemp = [[NSString alloc] initWithData:josnStr encoding:NSUTF8StringEncoding];
        [jsonText appendString:jsonTextTemp];
        if (i==[arrPersons count]-1) {
            [jsonText appendString:@"]"];
            
        }else{
            [jsonText appendString:@","];
        }
    }
    
    return jsonText;

}
@end
