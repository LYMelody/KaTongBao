//
//  ValidInput.h
//  Kuaifu
//
//  Created by yangmx on 13-1-28.
//  Copyright (c) 2013年 ND. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidInput : NSObject


+ (BOOL)isMobileNumber:(NSString*)mobileNum;
+ (BOOL)isIDCardNumber:(NSString*)idCardNum;

+ (BOOL)isMoneyNumber:(NSString*)money;

@end

