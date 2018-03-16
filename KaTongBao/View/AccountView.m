//
//  AccountView.m
//  JingXuan
//
//  Created by jinke on 16/5/18.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "AccountView.h"
#import "macro.h"

@implementation AccountView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    if (self) {
        UIView *BGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, 70)];
        BGView.backgroundColor = [UIColor colorWithRed:56/255.0 green:64/255.0 blue:73/255.0 alpha:1];
        [self addSubview:BGView];
        
        
        self.vacanciesLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, KscreenWidth, 50)];
        self.vacanciesLabel.text = @"￥1.00元";
        self.vacanciesLabel.textColor = [UIColor colorWithRed:212/255.0 green:106/255.0 blue:45/255.0 alpha:1];
        self.vacanciesLabel.textAlignment = NSTextAlignmentCenter;
        self.vacanciesLabel.font = [UIFont systemFontOfSize:25.0f];
        [BGView addSubview:self.vacanciesLabel];
        
        UILabel *cardInformationLablel = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, KscreenWidth, 40)];
        cardInformationLablel.text = @"填写银行卡信息";
        cardInformationLablel.textColor = [UIColor darkGrayColor];
        [self addSubview:cardInformationLablel];
        
        UIView *cardBGView = [[UIView alloc]initWithFrame:CGRectMake(0, 110, KscreenWidth, 70)];
        cardBGView.backgroundColor = [UIColor whiteColor];
        [self addSubview:cardBGView];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(KscreenWidth - 40, 25, 15, 20)];
        imageView.image = [UIImage imageNamed:@"arrow1.png"];
        [cardBGView addSubview:imageView];

        
        self.bankCardLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, KscreenWidth/3, 30)];
        self.bankCardLabel.text = @"招商银行";
        self.bankCardLabel.textColor = [UIColor darkGrayColor];
        [cardBGView addSubview:self.bankCardLabel];
        
        self.numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, KscreenWidth/3, 20)];
        self.numberLabel.text = @"尾号6415";
        self.numberLabel.textColor = [UIColor lightGrayColor];
        self.numberLabel.font = [UIFont systemFontOfSize:15.0f];
        [cardBGView addSubview:self.numberLabel];
        
        self.cardTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(KscreenWidth/3, 40, KscreenWidth/3, 20)];
        self.cardTypeLabel.textColor = [UIColor lightGrayColor];
        self.cardTypeLabel.font = [UIFont systemFontOfSize:15.0f];
        self.cardTypeLabel.text = @"信用卡";
        [cardBGView addSubview:self.cardTypeLabel];
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
