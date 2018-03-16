//
//  Dialog.m
//  Kuaifu
//
//  Created by ND on 12-12-27.
//  Copyright (c) 2012年 ND. All rights reserved.
//

#import "Dialog.h"

@interface Dialog()

+ (void)runBlock:(void (^)())block;
+ (void)runAfterDelay:(CGFloat)delay block:(void (^)())block;

@end

@implementation Dialog


@synthesize callback;
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    callback(buttonIndex);
}

+ (void)showAlertView:(UIAlertView *)alertView
         withCallback:(AlertViewCompletionBlock)callback {
    __block Dialog *delegate = [[Dialog alloc] init];
    alertView.delegate = delegate;
    delegate.callback = ^(NSInteger buttonIndex) {
        alertView.delegate = nil;
        delegate = nil;
        callback(buttonIndex);
    };
    [alertView show];
}

+ (void)showMsg:(NSString*)msg
{    
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] autorelease];
    
    [alert show];
}

+ (void)showModalMsg:(NSString*)msg
{    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] ;
    
    __block CFRunLoopRef currentLoop = CFRunLoopGetCurrent();
    [Dialog showAlertView:alert
             withCallback:^(NSInteger buttonIndex) {
                 [alert release];
                 CFRunLoopStop(currentLoop);
             }];

    CFRunLoopRun();
}

+ (void)runBlock:(void (^)())block
{
    block();
}

+ (void)runAfterDelay:(CGFloat)delay block:(void (^)())block
{
    void (^block_)() = [[block copy] autorelease];
    [self performSelector:@selector(runBlock:) withObject:block_ afterDelay:delay];
}

+ (void)tipMsg: (NSString*)msg
{
    [Dialog tipMsg:msg block:nil];
}

+ (void)tipMsg: (NSString*)msg block:(void (^)())block
{
    UILabel* lb = [[[UILabel alloc]initWithFrame:CGRectMake(50, 150, 200, 100)] autorelease];
    UIWindow *frontWindow = [[UIApplication sharedApplication] keyWindow];
    [frontWindow addSubview:lb];
    [lb setText:msg];
    [lb setTextColor:[UIColor whiteColor]];
    [frontWindow bringSubviewToFront:lb];
    [lb setBackgroundColor:[UIColor blackColor]];
    [lb setNumberOfLines:0];
    lb.textAlignment = NSTextAlignmentCenter;
    //文本阴影颜色
    lb.shadowColor = [UIColor grayColor];
    //阴影大小
    lb.shadowOffset = CGSizeMake(1.0, 1.0);
    
    //时间
    double delaytime = 1;
    delaytime += msg.length / 8;
    if (delaytime>2.5f)
        delaytime = 2.5f;
    [Dialog runAfterDelay:delaytime block:^{
        // some code
        [lb removeFromSuperview];
        if (block)
            block();
    }];
    [[NSRunLoop currentRunLoop] limitDateForMode:NSDefaultRunLoopMode];
}

@end
