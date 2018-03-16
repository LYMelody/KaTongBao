//
//  AgreementView.m
//  JingXuan
//
//  Created by jinke on 16/5/18.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "AgreementView.h"
#import "macro.h"

@implementation AgreementView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    if (self) {
        self.checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.checkButton.frame = CGRectMake(10, 12, 15, 15);
        [self.checkButton setBackgroundImage:[UIImage imageNamed:@"矩形 18.png"] forState:UIControlStateNormal];
        [self addSubview:self.checkButton];
        
        UILabel *agreeLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 30, 20)];
        agreeLabel.text = @"同意";
        agreeLabel.textColor = [UIColor darkGrayColor];
        agreeLabel.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:agreeLabel];
        
        self.agreementButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.agreementButton.frame = CGRectMake(60, 10, 150, 20);
        [self.agreementButton setTitle:@"《一键支付服务协议》" forState:UIControlStateNormal];
        self.agreementButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [self.agreementButton setTitleColor:[UIColor colorWithRed:94/255.0 green:193/255.0 blue:239/255.0 alpha:1] forState:UIControlStateNormal];
        [self addSubview:self.agreementButton];
        
        UILabel *promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, KscreenWidth-20, 70)];
        promptLabel.text = @"小提示：\n每笔限额：无；每日限额：20，000，000.00元；\n每月限额：600，000，000.00元；具体限额以银行设置为标准";
        promptLabel.font = [UIFont systemFontOfSize:12.0f];
        promptLabel.numberOfLines = 0;
        promptLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:promptLabel];
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
