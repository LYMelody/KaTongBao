//
//  MyDotField.m
//  CustTextField
//
//  Created by yangmx on 13-4-20.
//  Copyright (c) 2013年 Ymx. All rights reserved.
//

#import "MyDotField.h"

@implementation MyDotField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _keyboardView = [[[ZenKeyboardView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)] autorelease];
        _keyboardView.delegate = self;        
        self.inputView = _keyboardView;
        //self.textAlignment = NSTextAlignmentRight;
        self.adjustsFontSizeToFitWidth = YES;
    }
    return self;
}

- (void)didNumericKeyPressed:(UIButton *)button {
    NSString *str = button.titleLabel.text;
    if (([str isEqualToString:@"."]) && ([self.text rangeOfString:@"."].location != NSNotFound))
        return;
    
    [self insertText:str];
}

- (void)didBackspaceKeyPressed {
    
    NSInteger length = self.text.length;
    if (length == 0) {
        self.text = @"";
        
        return;
    }
    [self deleteBackward];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
