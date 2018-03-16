//
//  BusiIntf.m
//  Kuaifu
//
//  Created by ND on 12-12-27.
//  Copyright (c) 2012年 ND. All rights reserved.
//

#import "BusiIntf.h"
#import "Base64.h"
#import "NSString+MD5Addition.h"

@implementation BusiIntf

static OrderInfo *payOrder;

+ (void)baseImageToStr:(UIImage*)img str:(NSString**)str
{
    NSData* data = UIImageJPEGRepresentation(img, 0.5f);
    //NSData* data = UIImagePNGRepresentation(img);
    [Base64 initialize];
    *str = [Base64 encode:data];
}

+ (void)baseStrToImage:(NSString*)str img:(UIImage**)img
{
    [Base64 initialize];
    NSData* data = [Base64 decode:str ];
    *img = [UIImage imageWithData:data];
}

+ (NSString*)baseEncode: (NSString*)str
{
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];    
    [Base64 initialize];
    NSString* result = [Base64 encode:data];
    return result;
}

+ (OrderInfo*)curPayOrder
{
    if (payOrder == nil)
        payOrder = [[OrderInfo alloc]init];
    return  payOrder;
}

+ (void)setCurPayOrder:(OrderInfo*)order
{
    if (payOrder == nil)
        payOrder = [[OrderInfo alloc]init];
    [OrderInfo copy: order to:payOrder];
    
}

+ (BOOL)checkBaseFile:(NSString*)srcfile base64file:(NSString*)base64file
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:srcfile ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
//    NSString *str1 = [ASIHTTPRequest base64forData:data];
    [Base64 initialize];
    NSString* str1 = [Base64 encode:data];
    
    filePath = [[NSBundle mainBundle] pathForResource:base64file ofType:nil];
    NSData *data2 = [NSData dataWithContentsOfFile:filePath];
    NSString *str2 = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
    str2 = [str2 stringByReplacingOccurrencesOfString: @"\n" withString:@""];
    
    NSLog(@"src:%@\n", str1);
    NSLog(@"dest:%@\n", str2);
    BOOL result = [str1 isEqualToString:str2];
    NSLog(@"result:%d\n",result);
    return result;
    
}



+ (BOOL)checkMd5File:(NSString*)srcfile md5file:(NSString*)md5file
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:srcfile ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSString *str1 = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    str1 = [str1 stringFromMD5];
    
    filePath = [[NSBundle mainBundle] pathForResource:md5file ofType:nil];
    NSData *data2 = [NSData dataWithContentsOfFile:filePath];
    NSString *str2 = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
    str2 = [str2 stringByReplacingOccurrencesOfString: @"\n" withString:@""];
    
    NSLog(@"src:%@\n", str1);
    NSLog(@"dest:%@\n", str2);
    BOOL result = [str1 isEqualToString:str2];
    NSLog(@"result:%d\n",result);
    return result;
    
}


@end
