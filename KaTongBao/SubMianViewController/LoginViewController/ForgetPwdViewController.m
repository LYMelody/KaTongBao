//
//  ForgetPwdViewController.m
//  JingXuan
//
//  Created by wj on 16/5/12.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "macro.h"
#import "UIView+SDAutoLayout.h"
#import "ForgetPwdView.h"
#import "RegistViewController.h"
#import "NSObject+SBJSON.h"
#import "IBHttpTool.h"
@interface ForgetPwdViewController () 
@property (nonatomic, strong) ForgetPwdView *forgetPwd;
@end

@implementation ForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBaseVCAttributes:@"忘记密码" withLeftName:@"返回" withRightName:nil withColor:NavBack];
    self.view.backgroundColor = LightGrayColor;
    
    _forgetPwd = [[ForgetPwdView alloc] initWithFrame:CGRectMake(0, 64, KscreenWidth, KscreenHeight)];
    [self.view addSubview:_forgetPwd];
    [self getVerificationCodeRequest];
    [self ForgetPwdRequest];
    
}
//获取验证码
- (void) getVerificationCodeRequest{
    _forgetPwd.captchaBlock = ^(NSString *str) {
        
        NSDictionary *dic1 = @{@"phone":str};
        
        NSDictionary *dicc = @{@"action":@"ShopForgetPassGainSms",
                               @"data":dic1};
        
        NSString *params = [dicc JSONFragment];
        [IBHttpTool postWithURL:HOST params:params success:^(id result) {
            NSLog(@"数据:%@",result);
            NSDictionary *dic = [result JSONValue];
            NSString *msg = dic[@"msg"];
            [AlertView(msg, @"确定") show];
            
        } failure:^(NSError *error) {
            NSLog(@"网络请求失败:%@",error);
        }];
        
    };
    
}
//忘记密码
- (void) ForgetPwdRequest {
    _forgetPwd.ForgetPwdBlock = ^(NSString *phone, NSString *sms, NSString *pass1, NSString *pass2) {
        NSLog(@"%@%@%@%@",phone,sms,pass1,pass2);
        NSDictionary *dic1 = @{@"phone":phone,
                               @"code":sms,
                               @"pass1":pass1,
                               @"pass2":pass2
                               };
        NSDictionary *dicc = @{@"action":@"ShopForgetPassReset",
                               @"data":dic1};
        NSString *params = [dicc JSONFragment];
        [IBHttpTool postWithURL:HOST params:params success:^(id result) {
            NSLog(@"数据:%@",result);
            NSDictionary *dic = [result JSONValue];
            NSString *msg = dic[@"msg"];
            [AlertView(msg, @"确定") show];
        } failure:^(NSError *error) {
            NSLog(@"网络请求失败:%@",error);
        }];
        
    };
}
- (void)leftEvent:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

//键盘下落
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event  {
//    [self. view endEditing:NO];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
