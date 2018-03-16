//
//  LoginView.m
//  JingXuan
//
//  Created by wj on 16/5/17.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "LoginView.h"
#import "UIView+SDAutoLayout.h"
#import "macro.h"
#import "HomePageViewController.h"
#import "ForgetPwdViewController.h"
#import "BusiIntf.h"
@implementation LoginView
{
    
    BOOL isR;
    BOOL _isSelected;
    UIButton *remenberBtn;
    
    
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self init_UI];
    }
    return self;
}
- (void)init_UI {
    isR = YES;
    UIImageView *headImage = [[UIImageView alloc] init];
    headImage.image = [UIImage imageNamed:@"JX.png"];
    [self addSubview:headImage];
    //headImage.sd_layout.topSpaceToView(self,40).centerXIs(KscreenWidth/3.5).widthRatioToView(self,0.4).heightRatioToView(self,0.13);
    headImage.sd_layout.leftSpaceToView(self,122.5).topSpaceToView(self,69.5).widthIs(85.5).heightIs(47.5).centerXIs(self.center.x);
    
    _phoneView = [[UIView alloc] init];
    _phoneView.backgroundColor = [UIColor whiteColor];
    _phoneView.clipsToBounds = YES;
    _phoneView.layer.cornerRadius = 3;
    _phoneView.layer.borderWidth = 1;
    _phoneView.layer.borderColor = [[UIColor colorWithRed:239.0/255.0 green:95.0/255.0 blue:7.0/255.0 alpha:1]CGColor];
    [self addSubview:_phoneView];
    _phoneView.sd_layout.topSpaceToView(headImage,44).leftSpaceToView(self,18.5).widthIs(283).heightIs(52);
    
    _phoneImageView = [[UIImageView alloc] init];
    _phoneImageView.image = [UIImage imageNamed:@"用户名"];
    [_phoneView addSubview:_phoneImageView];
    _phoneImageView.sd_layout.topSpaceToView(_phoneView,8).leftSpaceToView(_phoneView,5.5).heightIs(38).widthIs(38);
    
    _phoneTF = [[UITextField alloc] init];
    _phoneTF.borderStyle = UITextBorderStyleNone;
    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTF.placeholder = @"请输入用户名";
    _phoneTF.font = [UIFont systemFontOfSize:15];
    [_phoneView addSubview:_phoneTF];
    _phoneTF.sd_layout.topSpaceToView(_phoneView,8).leftSpaceToView(_phoneView,52).heightIs(40).widthIs(160);
    
    _pwdView = [[UIView alloc] init];
    _pwdView.backgroundColor = [UIColor whiteColor];
    _pwdView.clipsToBounds = YES;
    _pwdView.layer.cornerRadius = 3;
    _pwdView.layer.borderWidth = 1;
    _pwdView.layer.borderColor = [[UIColor colorWithRed:239.0/255.0 green:95.0/255.0 blue:7.0/255.0 alpha:1]CGColor];
    [self addSubview:_pwdView];
    _pwdView.sd_layout.topSpaceToView(_phoneView,26).leftSpaceToView(self,18.5).widthIs(283).heightIs(52);
    
    _pwdImageView = [[UIImageView alloc] init];
    _pwdImageView.image = [UIImage imageNamed:@"密码"];
    [_pwdView addSubview:_pwdImageView];
    _pwdImageView.sd_layout.topSpaceToView(_pwdView,8).leftSpaceToView(_pwdView,5.5).heightIs(38).widthIs(38);
    
    _pwdTF = [[UITextField alloc] init];
    _pwdTF.borderStyle = UITextBorderStyleNone;
    _pwdTF.placeholder = @"请输入密码";
    _pwdTF.secureTextEntry = YES;
    _pwdTF.font = [UIFont systemFontOfSize:15];
    [_pwdView addSubview:_pwdTF];
    _pwdTF.sd_layout.topSpaceToView(_pwdView,10).leftSpaceToView(_pwdView,50).heightIs(40).widthIs(140);
    
    _showPwd = [UIButton buttonWithType:UIButtonTypeCustom];
    [_showPwd setImage:[UIImage imageNamed:@"密码可见"] forState:UIControlStateNormal];
    [_showPwd addTarget:self action:@selector(showPwdClick:) forControlEvents:UIControlEventTouchUpInside];
    [_pwdView addSubview:_showPwd];
    _showPwd.sd_layout.centerYEqualToView(_pwdView).rightSpaceToView(_pwdView,20).widthIs(35).heightIs(20);
    
//    _reservePwd = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_reservePwd setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
//    [_reservePwd setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    _reservePwd.titleLabel.font = [UIFont systemFontOfSize:15.0f];
//    [_reservePwd setTitle:@"记住密码" forState:UIControlStateNormal];
//    [_reservePwd addTarget:self action:@selector(resevePwd:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:_reservePwd];
//    _reservePwd.sd_layout.topSpaceToView(_pwdView,10).leftSpaceToView(self,40).widthIs(80).heightIs(40);
    
    //记住密码
    remenberBtn = [[UIButton alloc] init];
    if (_isSelected) {
        [remenberBtn setImage:[UIImage imageNamed:@"记住.png"] forState:UIControlStateNormal];
    }else {
        [remenberBtn setImage:[UIImage imageNamed:@"正常.png"] forState:UIControlStateNormal];
    }
    [remenberBtn addTarget:self action:@selector(remenber:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:remenberBtn];
    remenberBtn.sd_layout.leftSpaceToView(self,19).topSpaceToView(_pwdView,15.5).widthIs(32).heightIs(32);
    UILabel *lab = [[UILabel alloc] init];
    lab.text = @"记住密码";
    lab.font = [UIFont systemFontOfSize:13];
    lab.textColor = [UIColor grayColor];
    [self addSubview:lab];
    lab.sd_layout.leftSpaceToView(remenberBtn,6).topSpaceToView(_pwdView,20).widthIs(60).heightIs(17.5);

    _forgetPwdBtn = [[UIButton alloc] init];
    _forgetPwdBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_forgetPwdBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [_forgetPwdBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_forgetPwdBtn addTarget:self action:@selector(forgetPwdClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_forgetPwdBtn];
    _forgetPwdBtn.sd_layout.topSpaceToView(_pwdView,10).rightEqualToView(_pwdView).widthIs(80).heightIs(40);
    
    _loginBtn = [[UIButton alloc] init];
    _loginBtn.layer.cornerRadius = 4.0;
    _loginBtn.layer.masksToBounds = YES;
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    _loginBtn.backgroundColor = NavBack;
    [self addSubview:_loginBtn];
    _loginBtn.sd_layout.topSpaceToView(_pwdView,80).rightEqualToView(_pwdView).leftEqualToView(_pwdView).heightIs(45);
    
    _bottomView = [[UIView alloc] init];
    _bottomView.backgroundColor = [UIColor grayColor];
    [self addSubview:_bottomView];
    _bottomView.sd_layout.topSpaceToView(_loginBtn,60).leftSpaceToView(self,0).widthIs(KscreenWidth).heightIs(1);
    
    _registBtn = [[UIButton alloc] init];
    [_registBtn setTitleColor:[UIColor colorWithRed:118.0/255.0 green:118.0/255.0 blue:118.0/255.0 alpha:1] forState:UIControlStateNormal];
    _registBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    _registBtn.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:243.0/255.0 blue:246.0/255.0 alpha:1];
    [_registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registBtn addTarget:self action:@selector(registClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_registBtn];
    _registBtn.sd_layout.topSpaceToView(_bottomView,-20).centerXEqualToView(_bottomView).widthIs(80).heightIs(40);
    //记住密码
    _phoneTF.text = [BusiIntf getUserInfo].UserName;
    if ([BusiIntf getUserInfo].RemPwd) {
        _pwdTF.text = [BusiIntf getUserInfo].Pwd;
        [self setCheckSel:remenberBtn isChecked:YES];
    }
    else {
        [self setCheckSel:remenberBtn isChecked:NO];
    }
}

//设置用户密码的显示情况
- (void)setCheckSel: (UIButton*)btn isChecked: (BOOL)isChecked
{
    btn.selected = isChecked;
    if (btn.selected)
        [btn setImage:[UIImage imageNamed:@"记住.png"] forState:UIControlStateNormal];
    else
        [btn setImage:[UIImage imageNamed:@"正常.png"] forState:UIControlStateNormal];
}
//显示密码
- (void)showPwdClick:(UIButton *)sender {
    
    if (isR) {
        _pwdTF.secureTextEntry = NO;
        [_showPwd setImage:[UIImage imageNamed:@"密码不可见"] forState:UIControlStateNormal];
    } else {
        _pwdTF.secureTextEntry = YES;
        [_showPwd setImage:[UIImage imageNamed:@"密码可见"] forState:UIControlStateNormal];
    }
    isR = !isR;
}
//记住密码
- (void)resevePwd:(UIButton *)sender {
    NSLog(@"------");
    
}
- (void)remenber:(UIButton *)btn {
    [self setCheckSel:btn isChecked:!btn.selected];
    NSLog(@"remenber");
}
//登录
- (void)loginClick:(UIButton *)sender {
    self.__loginBlock(_phoneTF.text,_pwdTF.text);
}
//注册
- (void)registClicked:(UIButton *)sender {
    
    self.registBlock(@"注册");
    
}
//忘记密码
- (void)forgetPwdClicked:(UIButton *)sender {
    
    
    self.forgetPwdBlock(@"忘记密码");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
