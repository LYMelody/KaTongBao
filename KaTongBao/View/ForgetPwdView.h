//
//  ForgetPwdView.h
//  JingXuan
//
//  Created by wj on 16/5/13.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPwdView : UIView
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *verifyLabel;
@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *verifyTextField;
@property (nonatomic, strong) UITextField *pswTextField;
@property (nonatomic, strong) UITextField *notarizePswTF;

@property (nonatomic, copy) void (^captchaBlock)(NSString *str);
@property (nonatomic, copy) void (^ForgetPwdBlock)(NSString *phone, NSString *sms, NSString *pass1, NSString *pass2);
@end
