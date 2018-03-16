//
//  UIView+FormScroll.h
//  MyFina
//
//  Created by yangmx on 13-4-26.
//  Copyright (c) 2013年 Ymx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FormScroll)

-(void)scrollToY:(float)y;
-(void)scrollToView:(UIView *)view;
-(void)scrollElement:(UIView *)view toPoint:(float)y;

@end
