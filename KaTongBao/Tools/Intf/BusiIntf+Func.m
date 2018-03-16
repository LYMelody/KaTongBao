//
//  BusiIntf+Func.m
//  Kuaifu
//
//  Created by yangmx on 13-1-12.
//  Copyright (c) 2013年 ND. All rights reserved.
//

#import "BusiIntf.h"
#import "Dialog.h"

@implementation BusiIntf(Func)

+(BOOL)confirmOrder
{    
    NSString *OrderID, *errmsg, *merchantID, *params;
    OrderInfo *order = [BusiIntf curPayOrder];
    NSString *amount = [NSString stringWithFormat:@"%g", order.OrderAmt];
    NSString *otheramount = [NSString stringWithFormat:@"%g", order.OrderFee];
    OrderID = [BusiIntf curPayOrder].OrderID;
    BOOL result = [BusiIntf orderpaycheck:[BusiIntf getUserInfo].ShopID ordercode:order.OrderCode userid:order.UserID goodsid:order.GoodsID amount:amount otheramount:otheramount orderdesc:order.OrderDesc orderid:&OrderID merchantid:&merchantID params: &params errmsg:&errmsg];
    
    if (!result)
    {
        [Dialog showMsg: errmsg];
        return NO;
    }
    order.OrderID = OrderID;
    order.merchantid = merchantID;
    
    return YES;
}

+ (NSString*)readConfigString: (NSString*)key
{
    NSString* result = @"";
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"plist"];
    NSMutableDictionary *data = [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath] autorelease];
    id value = [data objectForKey:key];
    if (value)
        result = value;
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    result = [result stringByTrimmingCharactersInSet:whitespace];
    return result;
}

+ (NSString*)readNoticeString: (NSString*)key
{
    NSString* result = @"";
    
    //NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"promptinfo" ofType:@"plist"];
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *plistPath = [documentDir stringByAppendingPathComponent:@"promptinfo.plist"];
    
    NSArray *array = [[[NSArray alloc] initWithContentsOfFile:plistPath] autorelease];
    
    //如果不存在该节点
    if ([array count] < [key intValue]) {
        return @"";
    }
    
    NSDictionary *dic = [array objectAtIndex:([key intValue] - 1)];
    
    id value = [dic objectForKey:key];
    if (value) {
        result = value;
    }
    
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    result = [result stringByTrimmingCharactersInSet:whitespace];
    return result;
}


- (NSString *)applicationDocumentsDirectoryFile {
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *path = [documentDir stringByAppendingPathComponent:@"promptinfo.plist"];
    
    return path;
}

@end
