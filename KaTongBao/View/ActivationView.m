//
//  ActivationView.m
//  JingXuan
//
//  Created by wj on 16/5/18.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "ActivationView.h"
#import "UIView+SDAutoLayout.h"
#import "macro.h"
@implementation ActivationView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self init_UI];
    }
    return self;
}
- (void)init_UI {
    
    UIView *blackView = [[UIView alloc] init];
    blackView.backgroundColor = [UIColor colorWithRed:63.0/255.0 green:69.0/255.0 blue:79.0/255.0 alpha:1];
    blackView.clipsToBounds = YES;
    blackView.layer.cornerRadius = 3;
    [self addSubview:blackView];
    blackView.sd_layout.topSpaceToView(self,0).leftSpaceToView(self,0).widthIs(KscreenWidth).heightRatioToView(self,0.25);
    
    UILabel *paymentLabel = [[UILabel alloc] init];
    paymentLabel.text = @"付款";
    paymentLabel.textColor = [UIColor whiteColor];
    [blackView addSubview:paymentLabel];
    paymentLabel.sd_layout.topSpaceToView(blackView,20).centerXEqualToView(blackView).widthIs(60).heightIs(60);
    
    UILabel *moneyLabel = [[UILabel alloc] init];
    moneyLabel.text = @"¥1.00元";
    moneyLabel.font = [UIFont systemFontOfSize:35];
    moneyLabel.textColor = [UIColor whiteColor];
    [blackView addSubview:moneyLabel];
    moneyLabel.sd_layout.topSpaceToView(blackView,70).centerXEqualToView(blackView).widthIs(160).heightIs(60);
    
    UILabel *cardNumberLabel = [[UILabel alloc] init];
    cardNumberLabel.text = @"卡号";
    cardNumberLabel.font = [UIFont systemFontOfSize:23];
    [self addSubview:cardNumberLabel];
    cardNumberLabel.sd_layout.topSpaceToView(blackView,40).leftSpaceToView(self,20).widthIs(60).heightIs(40);
    
    UITextField *cardNumberTF = [[UITextField alloc] init];
    cardNumberTF.placeholder = @"      请输入卡号";
    cardNumberTF.backgroundColor= [UIColor whiteColor];
    cardNumberTF.clipsToBounds = YES;
    cardNumberTF.layer.cornerRadius = 3;
    [self addSubview:cardNumberTF];
    cardNumberTF.sd_layout.topSpaceToView(blackView,22).leftSpaceToView(cardNumberLabel,10).rightSpaceToView(self,20).heightIs(60);
    
    self.paymentBtn = [[UIButton alloc] init];
    self.paymentBtn.backgroundColor = NavBack;
    self.paymentBtn.clipsToBounds = YES;
    self.paymentBtn.layer.cornerRadius = 3;
    self.paymentBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.paymentBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [self.paymentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.paymentBtn addTarget:self action:@selector(paymentClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.paymentBtn];
    self.paymentBtn.sd_layout.topSpaceToView(cardNumberTF,50).leftSpaceToView(self,20).rightSpaceToView(self,20).heightRatioToView(self,0.08);
    
    UILabel *reminderLabel = [[UILabel alloc] init];
    reminderLabel.text = @"使用本人信用卡完成一笔交易，交易完成后，完成账户激活";
    reminderLabel.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1];
    reminderLabel.numberOfLines = 0;
    [self addSubview:reminderLabel];
    reminderLabel.sd_layout.topSpaceToView(self.paymentBtn,10).leftEqualToView(self.paymentBtn).rightEqualToView(self.paymentBtn).heightIs(80);
}
//- (void)paymentClick:(UIButton *)sender {
//    
//    NSLog(@"----*----");
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
