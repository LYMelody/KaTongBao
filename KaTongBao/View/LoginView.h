//
//  LoginView.h
//  JingXuan
//
//  Created by wj on 16/5/17.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView

@property (strong, nonatomic) UIImageView *phoneImage;
@property (strong, nonatomic) UIImageView *phoneImageView;
@property (strong, nonatomic) UIView *phoneView;
@property (strong, nonatomic) UITextField *phoneTF;


@property (strong, nonatomic) UIView *pwdView;
@property (strong, nonatomic) UIImageView *pwdImageView;
@property (strong, nonatomic) UITextField *pwdTF;


@property (strong, nonatomic) UIButton *reservePwd;
@property (strong, nonatomic) UIButton *forgetPwdBtn;
@property (strong, nonatomic) UIButton *loginBtn;
@property (strong, nonatomic) UIButton *registBtn;
@property (strong, nonatomic) UIButton *showPwd;
@property (strong, nonatomic) UIView *bottomView;


@property (nonatomic, copy) void (^__loginBlock )(NSString *phone,NSString *pwd);
@property (nonatomic, copy) void (^registBlock )(NSString *str);
@property (nonatomic, copy) void (^forgetPwdBlock )(NSString *str);
@end
