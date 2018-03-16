//
//  Dialog.h
//  Kuaifu
//
//  Created by ND on 12-12-27.
//  Copyright (c) 2012年 ND. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dialog : NSObject<UIAlertViewDelegate>

typedef void (^AlertViewCompletionBlock)(NSInteger buttonIndex);
@property (strong,nonatomic) AlertViewCompletionBlock callback;

+ (void)showAlertView:(UIAlertView *)alertView withCallback:(AlertViewCompletionBlock)callback;
+ (void)showMsg:(NSString*)msg;
+ (void)showModalMsg:(NSString*)msg;
+ (void)tipMsg: (NSString*)msg;
+ (void)tipMsg: (NSString*)msg block:(void (^)())block;


@end
