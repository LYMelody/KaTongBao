//
//  MyDateField.m
//  CustTextField
//
//  Created by yangmx on 13-4-20.
//  Copyright (c) 2013年 Ymx. All rights reserved.
//

#import "MyDateField.h"

@implementation MyDateField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        TdCalendarView* vc = [[[TdCalendarView alloc] initWithFrame:CGRectMake(0, 0, 320, 270)] autorelease];
        vc.calendarViewDelegate = self;
        self.inputView = vc;
        //self.textAlignment = NSTextAlignmentCenter;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.adjustsFontSizeToFitWidth = YES;
        //self.delegate = self;
        CFAbsoluteTime	currentTime;
        currentTime=CFAbsoluteTimeGetCurrent();
        CFGregorianDate today=CFAbsoluteTimeGetGregorianDate(currentTime, CFTimeZoneCopyDefault());
        self.text = [NSString stringWithFormat:@"%04ld-%02d-%02d", today.year, today.month, today.day];
        vc.currentMonthDate = today;
        vc.currentSelectDate = today;
    }
    return self;
}

- (void) selectDateChanged:(CFGregorianDate) selectDate
{
    self.text = [NSString stringWithFormat:@"%04ld-%02d-%02d", selectDate.year, selectDate.month, selectDate.day];
    [self endEditing:YES];
    
}
- (void) monthChanged:(CFGregorianDate) currentMonth viewLeftTop:(CGPoint)viewLeftTop height:(float)height
{
    
}
- (void) beforeMonthChange:(TdCalendarView*) calendarView willto:(CFGregorianDate) currentMonth
{
    
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
        CFAbsoluteTime	currentTime;
        currentTime=CFAbsoluteTimeGetCurrent();
        CFGregorianDate today=CFAbsoluteTimeGetGregorianDate(currentTime, CFTimeZoneCopyDefault());
        if (![self.text isEqualToString:@""])
        {
            sscanf([self.text UTF8String], "%ld-%d-%d", &today.year, (int*)&today.month, (int*)&today.day);
        }
        TdCalendarView* vc = (TdCalendarView*)self.inputView;
        vc.currentMonthDate = today;
        vc.currentSelectDate = today;
        [vc initCalView];
     
    }
    return outcome;
}

- (CGRect)caretRectForPosition:(UITextPosition *)position
{
    return CGRectZero;
}

@end
