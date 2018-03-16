//
//  ValidInput.m
//  Kuaifu
//
//  Created by yangmx on 13-1-28.
//  Copyright (c) 2013年 ND. All rights reserved.
//

#import "ValidInput.h"

@implementation ValidInput


+ (BOOL)isMobileNumber:(NSString*)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString* MOBILE= @"^1(3[0-9]|5[0-9]|8[0-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     */
    NSString* CM= @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186
     */
    NSString* CU= @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,1349,153,180,189
     */
    NSString* CT= @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate* regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    NSPredicate* regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CM];
    NSPredicate* regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CU];
    NSPredicate* regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CT];
    
    if(([regextestmobile evaluateWithObject:mobileNum] == YES)
       || ([regextestcm evaluateWithObject:mobileNum] == YES)
       || ([regextestct evaluateWithObject:mobileNum] == YES)
       || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)isIDCardNumber:(NSString*)idCardNum
{
    //身份证正则表达式(15位)
//    NSString* IDCard1 = @"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
    //身份证正则表达式(18位)
    NSString* IDCard2 = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}(\\d|X|x)$";
        
//    NSPredicate* regextestcard1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",IDCard1];
    NSPredicate* regextestcard2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",IDCard2];
    
//    if(([regextestcard1 evaluateWithObject:idCardNum] == YES)
//       || ([regextestcard2 evaluateWithObject:idCardNum] == YES))
    
    if([regextestcard2 evaluateWithObject:idCardNum] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

+ (BOOL)isMoneyNumber:(NSString*)money
{
   
    NSScanner* scan = [NSScanner scannerWithString:money];
    int val;
    //float val1;
    
    if ([scan scanInt:&val] && [scan isAtEnd]) {    //  整形
        return YES;
    }else {
        return NO;
    }
    
}

@end
