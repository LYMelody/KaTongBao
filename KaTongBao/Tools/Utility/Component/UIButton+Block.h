//
//  UIButton+Block.h
//  Kuaifu
//
//  Created by chenyuanxin on 14-3-29.
//  Copyright (c) 2014年 ND. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


typedef void (^ActionBlock)();

@interface UIButton(Block)

@property (readonly) NSMutableDictionary *event;

- (void) handleControlEvent:(UIControlEvents)controlEvent withBlock:(ActionBlock)action;

@end