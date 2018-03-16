//
//  RegistView.m
//  JingXuan
//
//  Created by wj on 16/5/19.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "RegistView.h"
#import "UIView+SDAutoLayout.h"
#import "macro.h"
@implementation RegistView

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
    backView.sd_layout.topSpaceToView(self,20).leftSpaceToView(self,0).widthIs(KscreenWidth).heightIs(240);
    
    _phoneLabel = [[UILabel alloc] init];
    _phoneLabel.text = @"手机号码:";
    [backView addSubview:_phoneLabel];
    _phoneLabel.sd_layout.topSpaceToView(backView,10).leftSpaceToView(backView,10).widthIs(75).heightIs(40);
    
    _phoneTextField = [[UITextField alloc] init];
    _phoneTextField.placeholder = @"请输入您的手机号码";
    [backView addSubview:_phoneTextField];
    _phoneTextField.sd_layout.topSpaceToView(backView,10).leftSpaceToView(_phoneLabel,10).widthIs(200).heightIs(40);
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:view];
    view.sd_layout.topSpaceToView(_phoneLabel,10).leftSpaceToView(self,0).rightSpaceToView(self,0).widthIs(KscreenWidth).heightIs(1);
    
    _verifyLabel = [[UILabel alloc] init];
    _verifyLabel.text = @"验证码:";
    [backView addSubview:_verifyLabel];
    _verifyLabel.sd_layout.topSpaceToView(_phoneLabel,20).leftSpaceToView(backView,10).widthIs(75).heightIs(40);
    
    _verifyTextField = [[UITextField alloc] init];
    _verifyTextField.placeholder = @"请输入您收到的验证码";
    [backView addSubview:_verifyTextField];
    _verifyTextField.sd_layout.topSpaceToView(_phoneTextField,20).leftSpaceToView(_verifyLabel,10).widthIs(180).heightIs(40);
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:view1];
    view1.sd_layout.topSpaceToView(_verifyLabel,10).leftSpaceToView(self,0).rightSpaceToView(self,0).widthIs(KscreenWidth).heightIs(1);
    
    UILabel *pswLabel = [[UILabel alloc] init];
    pswLabel.text = @"密码:";
    [backView addSubview:pswLabel];
    pswLabel.sd_layout.topSpaceToView(_verifyLabel,20).leftSpaceToView(backView,10).widthIs(75).heightIs(40);
    
    _pswTextField = [[UITextField alloc] init];
    _pswTextField.placeholder = @"请输入您的密码";
    [backView addSubview:_pswTextField];
    _pswTextField.sd_layout.topSpaceToView(_verifyTextField,20).leftSpaceToView(pswLabel,10).widthIs(180).heightIs(40);
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:view2];
    view2.sd_layout.topSpaceToView(pswLabel,10).leftSpaceToView(self,0).rightSpaceToView(self,0).widthIs(KscreenWidth).heightIs(1);
    
    UILabel *notarizePswLabel = [[UILabel alloc] init];
    notarizePswLabel.text = @"确认密码:";
    [backView addSubview:notarizePswLabel];
    notarizePswLabel.sd_layout.topSpaceToView(pswLabel,20).leftSpaceToView(backView,10).widthIs(75).heightIs(40);
    
    UILabel *reminderLabel = [[UILabel alloc] init];
    reminderLabel.text = @"密码由6-20位英文字母，数字，或符号组成";
    reminderLabel.font = [UIFont systemFontOfSize:14];
    reminderLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:reminderLabel];
    reminderLabel.sd_layout.topSpaceToView(backView,0).leftSpaceToView(self,10).rightSpaceToView(self,10).heightIs(40);
    
    _notarizePswTF = [[UITextField alloc] init];
    _notarizePswTF.placeholder = @"请输入您的密码";
    [backView addSubview:_notarizePswTF];
    _notarizePswTF.sd_layout.topSpaceToView(_pswTextField,20).leftSpaceToView(notarizePswLabel,10).widthIs(180).heightIs(40);
    
    UIButton *verifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [verifyBtn setTitle:@"获取" forState:UIControlStateNormal];
    [verifyBtn setTintColor:[UIColor whiteColor]];
    [verifyBtn setBackgroundColor:NavBack];
    [verifyBtn addTarget:self action:@selector(captchaClick:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:verifyBtn];
    verifyBtn.sd_layout.topEqualToView(view).rightEqualToView(view).widthIs(55).heightIs(60);
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.backgroundColor = NavBack;
    confirmButton.tintColor = [UIColor whiteColor];
    confirmButton.clipsToBounds = YES;
    confirmButton.layer.cornerRadius = 3;
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmButton];
    confirmButton.sd_layout.topSpaceToView(backView,100).leftSpaceToView(self,20).rightSpaceToView(self,20).heightRatioToView(self,0.1);
    
    UIButton *agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [agreeBtn setTitle:@"同意" forState:UIControlStateNormal];
    [agreeBtn setTintColor:[UIColor blackColor]];
    [agreeBtn setImage:[UIImage imageNamed:@"矩形 17"] forState:UIControlStateNormal];
    [agreeBtn addTarget:self action:@selector(agreeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:agreeBtn];
    agreeBtn.sd_layout.topSpaceToView(backView,50).leftSpaceToView(self,10).widthIs(30).heightIs(30);
}
//确认注册button
- (void)confirmClick:(UIButton *)sender {
    self.confirmBlock(_phoneTextField.text,_verifyTextField.text,_notarizePswTF.text,_pswTextField.text);
    
}
//获取验证码
- (void)captchaClick:(UIButton *)sender {
    
    self.captchaBlock(_phoneTextField.text);
    
}

- (void)agreeClick:(UIButton *)sender {
    NSLog(@"同意");
}
//键盘下落
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event  {
//    [self endEditing:NO];
//}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
