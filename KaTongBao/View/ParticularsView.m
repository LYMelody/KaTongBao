//
//  ParticularsView.m
//  JingXuan
//
//  Created by wj on 16/5/18.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "ParticularsView.h"
#import "UIView+SDAutoLayout.h"
#import "macro.h"
@implementation ParticularsView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self init_UI];
    }
    return self;
}
- (void)init_UI {
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    backView.layer.borderWidth = 1;
    [self addSubview:backView];
    backView.sd_layout.topSpaceToView(self,20).leftSpaceToView(self,0).widthIs(KscreenWidth).heightIs(360);
    
    _resultLabel = [[UILabel alloc] init];
    _resultLabel.text = @"支付失败";
    _resultLabel.font = [UIFont systemFontOfSize:20];
    [backView addSubview:_resultLabel];
    _resultLabel.sd_layout.topSpaceToView(backView,10).xIs(KscreenWidth/3).widthIs(200).heightIs(40);
    
    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:view3];
    view3.sd_layout.topSpaceToView(_resultLabel,10).leftSpaceToView(self,0).rightSpaceToView(self,0).widthIs(KscreenWidth).heightIs(1);
    
    UILabel *serialNumberLabel = [[UILabel alloc] init];
    serialNumberLabel.text = @"交易流水：";
    [backView addSubview:serialNumberLabel];
    serialNumberLabel.sd_layout.topSpaceToView(backView,70).leftSpaceToView(backView,10).widthIs(85).heightIs(40);
    
    _numberLabel = [[UILabel alloc] init];
    _numberLabel.text = @"2016051000002846";
    _numberLabel.textColor = [UIColor lightGrayColor];
    [backView addSubview:_numberLabel];
    _numberLabel.sd_layout.topSpaceToView(backView,70).leftSpaceToView(serialNumberLabel,0).widthIs(200).heightIs(40);
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:view];
    view.sd_layout.topSpaceToView(serialNumberLabel,10).leftSpaceToView(self,0).rightSpaceToView(self,0).widthIs(KscreenWidth).heightIs(1);
    
    UILabel*bankLabel = [[UILabel alloc] init];
    bankLabel.text = @"交易银行：";
    [backView addSubview:bankLabel];
    bankLabel.sd_layout.topSpaceToView(serialNumberLabel,20).leftSpaceToView(backView,10).widthIs(85).heightIs(40);
    
    _bankLabel1 = [[UILabel alloc] init];
    _bankLabel1.text = @"招商银行";
    _bankLabel1.textColor = [UIColor lightGrayColor];
    [backView addSubview:_bankLabel1];
    _bankLabel1.sd_layout.topSpaceToView(_numberLabel,20).leftSpaceToView(bankLabel,0).widthIs(180).heightIs(40);
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:view1];
    view1.sd_layout.topSpaceToView(bankLabel,10).leftSpaceToView(self,0).rightSpaceToView(self,0).widthIs(KscreenWidth).heightIs(1);
    
    UILabel *moneyLabel = [[UILabel alloc] init];
    moneyLabel.text = @"交易金额：";
    [backView addSubview:moneyLabel];
    moneyLabel.sd_layout.topSpaceToView(bankLabel,20).leftSpaceToView(backView,10).widthIs(85).heightIs(40);
    
    _moneyLabel1 = [[UILabel alloc] init];
    _moneyLabel1.textColor = [UIColor lightGrayColor];
    _moneyLabel1.text = @"6225";
    [backView addSubview:_moneyLabel1];
    _moneyLabel1.sd_layout.topSpaceToView(_bankLabel1,20).leftSpaceToView(moneyLabel,0).widthIs(180).heightIs(40);
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:view2];
    view2.sd_layout.topSpaceToView(moneyLabel,10).leftSpaceToView(self,0).rightSpaceToView(self,0).widthIs(KscreenWidth).heightIs(1);
    
    UILabel *cardNumberLabel = [[UILabel alloc] init];
    cardNumberLabel.text = @"交易卡号：";
    [backView addSubview:cardNumberLabel];
    cardNumberLabel.sd_layout.topSpaceToView(moneyLabel,20).leftSpaceToView(backView,10).widthIs(85).heightIs(40);
    
    _cardNumberLabel1 = [[UILabel alloc] init];
    _cardNumberLabel1.textColor = [UIColor lightGrayColor];
    _cardNumberLabel1.text = @"6225 **** **** **** 654";
    [backView addSubview:_cardNumberLabel1];
    _cardNumberLabel1.sd_layout.topSpaceToView(_moneyLabel1,20).leftSpaceToView(cardNumberLabel,0).widthIs(180).heightIs(40);
    
    UIView *view4 = [[UIView alloc] init];
    view4.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:view4];
    view4.sd_layout.topSpaceToView(cardNumberLabel,10).leftSpaceToView(self,0).rightSpaceToView(self,0).widthIs(KscreenWidth).heightIs(1);
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.text = @"交易时间：";
    [backView addSubview:timeLabel];
    timeLabel.sd_layout.topSpaceToView(cardNumberLabel,20).leftSpaceToView(backView,10).widthIs(85).heightIs(40);
    
    _timeLabel1 = [[UILabel alloc] init];
    _timeLabel1.textColor = [UIColor lightGrayColor];
    _timeLabel1.text = @"2016-04-18 10:10:10";
    [backView addSubview:_timeLabel1];
    _timeLabel1.sd_layout.topSpaceToView(_cardNumberLabel1,20).leftSpaceToView(moneyLabel,0).widthIs(180).heightIs(40);
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
