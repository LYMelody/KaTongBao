//
//  MyMoneyField.m
//  CustTextField
//
//  Created by yangmx on 13-4-20.
//  Copyright (c) 2013年 Ymx. All rights reserved.
//

#import "MyMoneyField.h"


@implementation MyMoneyField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CalculatorView* vc = [[[CalculatorView alloc] initWithFrame:CGRectMake(0, 0, 320, 270)] autorelease];
        vc.delegate = self;
        self.inputView = vc;
        //self.textAlignment = NSTextAlignmentCenter;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.adjustsFontSizeToFitWidth = YES;
        //self.delegate = self;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
 */
- (BOOL)becomeFirstResponder {
    BOOL outcome = [super becomeFirstResponder];
    if (outcome) {
        CalculatorView* vc = (CalculatorView*)self.inputView;
        vc.mainLabelText = self.text;
    }
    return outcome;
}

- (void)valueChanged:(NSString *)value
{
    self.text = value;
}

@end
