//
//  CardInformationView.m
//  JingXuan
//
//  Created by jinke on 16/5/18.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "CardInformationView.h"
#import "macro.h"

@implementation CardInformationView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    if (self) {
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, KscreenWidth/4, 40)];
        self.label.textColor = [UIColor darkGrayColor];
        self.label.font = [UIFont systemFontOfSize:15.0f];
        [self addSubview:self.label];
        
        self.textField = [[UITextField alloc]initWithFrame:CGRectMake(KscreenWidth/4, 0, KscreenWidth/4*3, 40)];
        self.textField.borderStyle = UITextBorderStyleNone;
        self.textField.font = [UIFont systemFontOfSize:15.0f];
        [self addSubview:self.textField];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 39, KscreenWidth, 1)];
        lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
        [self addSubview:lineView];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
