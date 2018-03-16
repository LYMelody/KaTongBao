//
//  PubFunc.m
//  Kuaifu
//
//  Created by yangmx on 13-1-13.
//  Copyright (c) 2013年 ND. All rights reserved.
//

#import "PubFunc.h"
#import "UIDevice+IdentifierAddition.h"
#import "pinyin.h"

@implementation PubFunc

+ (NSString*)getToday
{
    NSDate *today = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString* dateString = [df stringFromDate:today];
    [df release];
    return dateString;
}
+ (NSString*)getNow
{
    NSDate *today = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* dateString = [df stringFromDate:today];
    [df release];
    return dateString;
}


+ (NSString*)DateToStr:(NSDate*)date
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString* dateString = [df stringFromDate:date];
    [df release];
    return dateString;
}

+ (NSDate*)StrToDate:(NSString*)str
{    
    if ([str isEqualToString:@""])
        return [NSDate date];
        
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateFromString = [dateFormatter dateFromString:str];
    [dateFormatter release];
    return dateFromString;
}

+(float)currentSize:(BOOL)h{
    CGRect screen_rect=[[UIScreen mainScreen] bounds];
    CGSize screen_size=screen_rect.size;
    
    CGFloat screen_scale=[[UIScreen mainScreen]scale];//一般屏幕为1,Retina为2
    float baseResolution_h=480*screen_scale;
    float baseResolution_w=320*screen_scale;
    
    float currentResolution_h;
    float currentResolution_w;
    
    currentResolution_h=screen_size.height*screen_scale;//当前设备的分辨率
    currentResolution_w=screen_size.width*screen_scale;
    
    if (h) {
        return (float)currentResolution_h/baseResolution_h;
    }else {
        return (float)currentResolution_w/baseResolution_w;
    }
    
}

//返回合适的坐标
+(CGRect)fitCGRect:(CGRect)rect{
    float x=rect.origin.x;
    float y=rect.origin.y;
    float width=rect.size.width;
    float height=rect.size.height;
    float currentSize_h=[self currentSize:YES];
    float currentSize_w=[self currentSize:NO];
    CGRect frame=CGRectMake(x*currentSize_w, y*currentSize_h, width*currentSize_w, height*currentSize_h);
    return frame;
    
}

+ (void)resetFrame:(CGRect*)pframe
{
//    *pframe = [PubFunc fitCGRect:*pframe];
//    return;
    
//    // 上和下空白
//    if (!iPhone5)
//        return;
//    CGRect rect = *pframe;
//    rect.origin.y += 30;
//    *pframe = rect;
//  
////     等比例拉伸
//    CGRect rect = *pframe;
//    float rate = 568 / 480.0;
//    rect.origin.y = rate * rect.origin.y;
//    rect.size.height = rate * rect.size.height;
//    *pframe = rect;
}

NSString * gen_uuid()
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(NSString*)uuid_string_ref];
    CFRelease(uuid_string_ref);
    return uuid;
}


NSString * deviceID()
{
    return [[UIDevice currentDevice] uniqueGlobalDeviceIdentifier];
}

NSString * deviceName()
{
    return [[UIDevice currentDevice] name];
}
NSString * sysver()
{
    return [[UIDevice currentDevice] systemVersion];
}


NSString* getPY(NSString* words)
{
    char result[128];
    memset(result, 0x00, sizeof(result));
    for (int i = 0; i < [words length]; i++)
    {
        sprintf(&result[i], "%c", pinyinFirstLetter([words characterAtIndex:i]));
    }
    return [NSString stringWithUTF8String:result];
    
}

@end

@implementation NSString (util)

- (int) indexOf:(NSString *)text {
    NSRange range = [self rangeOfString:text];
    if ( range.length > 0 ) {
        return range.location;
    } else {
        return -1;
    }
}

@end

@implementation NSObject (PerformBlockAfterDelay)

- (void)performBlock:(void (^)(void))block
          afterDelay:(NSTimeInterval)delay
{
    block = [[block copy] autorelease];
    [self performSelector:@selector(fireBlockAfterDelay:)
               withObject:block
               afterDelay:delay];
}

- (void)fireBlockAfterDelay:(void (^)(void))block {
    block();
}

@end

@implementation UIScrollView(TouchEvent)



//- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
//{
//    [super touchesBegan:touches withEvent:event];
//    if ( !self.dragging )
//    {
//        [[self nextResponder] touchesBegan:touches withEvent:event];
//    }
//}
//- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
//{
//    [super touchesMoved:touches withEvent:event];
//    if ( !self.dragging )
//    {
//        [[self nextResponder] touchesMoved:touches withEvent:event];
//    }
//}
//- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
//{
//    [super touchesEnded:touches withEvent:event];
//    if ( !self.dragging )
//    {
//        [[self nextResponder] touchesEnded:touches withEvent:event];
//    }
//}

@end
