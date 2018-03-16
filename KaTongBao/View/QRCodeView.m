//
//  QRCodeView.m
//  JingXuan
//
//  Created by wj on 16/5/17.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "QRCodeView.h"
#import "UIView+SDAutoLayout.h"
#import "macro.h"
@implementation QRCodeView
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
    backView.sd_layout.topSpaceToView(self,20).leftSpaceToView(self,0).widthIs(KscreenWidth).heightIs(120);
    
    UILabel *reasonLabel = [[UILabel alloc] init];
    reasonLabel.text = @"收款理由：";
    [backView addSubview:reasonLabel];
    reasonLabel.sd_layout.topSpaceToView(backView,10).leftSpaceToView(backView,10).widthIs(120).heightIs(40);
    
    UITextField *_primevalPswTF = [[UITextField alloc] init];
    _primevalPswTF.placeholder = @"请输入原始登录密码";
    [backView addSubview:_primevalPswTF];
    _primevalPswTF.sd_layout.topSpaceToView(backView,10).leftSpaceToView(reasonLabel,0).widthIs(200).heightIs(40);
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:view];
    view.sd_layout.topSpaceToView(reasonLabel,10).leftSpaceToView(self,0).rightSpaceToView(self,0).widthIs(KscreenWidth).heightIs(1);
    
    UILabel*_moneyLabel = [[UILabel alloc] init];
    _moneyLabel.text = @"收款金额：";
    [backView addSubview:_moneyLabel];
    _moneyLabel.sd_layout.topSpaceToView(reasonLabel,20).leftSpaceToView(backView,10).widthIs(120).heightIs(40);
    
    UITextField*_moneyTF = [[UITextField alloc] init];
    _moneyTF.placeholder = @"请输入实际交易金额";
    [backView addSubview:_moneyTF];
    _moneyTF.sd_layout.topSpaceToView(_primevalPswTF,20).leftSpaceToView(_moneyLabel,0).widthIs(180).heightIs(40);
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.backgroundColor = NavBack;
    confirmBtn.tintColor = [UIColor whiteColor];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmBtn];
    confirmBtn.sd_layout.topSpaceToView(backView,140).leftSpaceToView(self,20).widthIs(KscreenWidth-40).heightRatioToView(self,0.08);
    
    UILabel *notarizePswLabel = [[UILabel alloc] init];
    notarizePswLabel.text = @"支付说明：\n1.单笔交易最高2万，且不能为整数，单卡交易最高金 额为5万，累积不限，普 通和快捷收款合计日结算限额10万。 \n2.所有交易按工作日T+1结算； \n3.法定假日期间交易，工作日第一天结算。";
    notarizePswLabel.font = [UIFont systemFontOfSize:14];
    notarizePswLabel.textColor = [UIColor lightGrayColor];
    notarizePswLabel.numberOfLines = 0;
    [self addSubview:notarizePswLabel];
    notarizePswLabel.sd_layout.topSpaceToView(confirmBtn,0).leftSpaceToView(self,20).rightEqualToView(confirmBtn).heightIs(120);
}
- (void)confirmClick:(UIButton *)sender {
    
    NSLog(@"*----*");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
