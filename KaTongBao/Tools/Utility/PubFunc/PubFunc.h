//
//  PubFunc.h
//  Kuaifu
//
//  Created by yangmx on 13-1-13.
//  Copyright (c) 2013年 ND. All rights reserved.
//

#import <Foundation/Foundation.h>
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@interface PubFunc : NSObject


+ (NSString*)getToday;
+ (NSString*)getNow;
+ (NSString*)DateToStr:(NSDate*)date;
+ (NSDate*)StrToDate:(NSString*)str;
+ (void)resetFrame:(CGRect*)pframe;
NSString * gen_uuid();
NSString * deviceID();
NSString * deviceName();
NSString * sysver();
NSString* getPY(NSString* words);

@end


@interface NSString (util)

- (int) indexOf:(NSString *)text;

@end

@interface NSObject (PerformBlockAfterDelay)

- (void)performBlock:(void (^)(void))block
          afterDelay:(NSTimeInterval)delay;

@end

@interface UIScrollView(TouchEvent)

//- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event;
//- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event;
//- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event;
@end