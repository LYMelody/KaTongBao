//
//  RestPwdVC.m
//  wujieNew
//
//  Created by rongfeng on 16/1/4.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "RestPwdVC.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "IBHttpTool.h"
#import "SBJSON.h"
#import "LoginViewController.h"
@implementation RestPwdVC {
    
    NSTimer *timer;
    UIButton *btn;
    NSInteger index;
    UIButton *nextBtn;
    UITextField *phoneFld;
    UITextField *codeFld;
    UITextField *pwdfld;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"修改密码";
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = DrackBlue;

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // create UI
    UIImageView *backImg = [[UIImageView alloc] init];
    backImg.frame = CGRectMake(0, 0 , KscreenWidth, KscreenHeight);
    backImg.backgroundColor = LightGrayColor;
    [self.view addSubview:backImg];
    UIImageView *Img = [[UIImageView alloc] init];
    Img.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:Img];
    //身份证
    UILabel *phoneLab = [[UILabel alloc] init];
    phoneLab.text = @"身  份 证";
    phoneLab.font = [UIFont systemFontOfSize:15];
    //phoneLab.textColor = Gray100;
    [self.view addSubview:phoneLab];
    
    phoneFld = [[UITextField alloc] init];
    phoneFld.placeholder = @"请输入您的身份证号码";
    phoneFld.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:phoneFld];
    
    Img.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,78.5 - 60).heightIs(134.5);
    phoneLab.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,89.5 - 60).widthIs(60).heightIs(20);
    phoneFld.sd_layout.leftSpaceToView(self.view,79).topSpaceToView(self.view,90 - 60).widthIs(226).heightIs(20);
    //中间的横线
    UIImageView *lineImg = [[UIImageView alloc] init];
    lineImg.backgroundColor = Gray229;
    [self.view addSubview:lineImg];
    lineImg.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,0).topSpaceToView(self.view,122.5 - 60).heightIs(0.5);
    UIImageView *lineImgS = [[UIImageView alloc] init];
    lineImgS.backgroundColor = Gray229;
    [self.view addSubview:lineImgS];
    lineImgS.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,0).topSpaceToView(self.view,167.5 - 60).heightIs(0.5);
    //密码
    UILabel *codeLab = [[UILabel alloc] init];
    codeLab.text = @"密        码";
    codeLab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:codeLab];
    
    codeFld = [[UITextField alloc] init];
    codeFld.placeholder = @"请输入您的密码";
    codeFld.font = [UIFont systemFontOfSize:14];
    codeFld.secureTextEntry = YES;
    [self.view addSubview:codeFld];
    
    codeLab.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,137 - 60).widthIs(60).heightIs(20);
    codeFld.sd_layout.leftSpaceToView(self.view,79).topSpaceToView(self.view,137.5 - 60).widthIs(140).heightIs(20);
    //确认密码
    UILabel *pwdLab = [[UILabel alloc] init];
    pwdLab.text = @"确认密码";
    pwdLab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:pwdLab];
    pwdfld = [[UITextField alloc] init];
    pwdfld.placeholder = @"请再次输入您的密码";
    pwdfld.font = [UIFont systemFontOfSize:14];
    pwdfld.secureTextEntry = YES;
    [self.view addSubview:pwdfld];
    UILabel *TipsLab = [[UILabel alloc] init];
    TipsLab.text = @"密码由6-20位英文字母,数字,或符号组成";
    TipsLab.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:TipsLab];
    pwdLab.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,183 - 60).widthIs(60).heightIs(20);
    pwdfld.sd_layout.leftSpaceToView(self.view,79).topSpaceToView(self.view,183.5 - 60).widthIs(226).heightIs(20);
    TipsLab.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,222 - 60).widthIs(228).heightIs(12.5);
    //下一步
    nextBtn = [[UIButton alloc] init];
    nextBtn.backgroundColor = RedColor;
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    nextBtn.layer.cornerRadius = 3.5;
    nextBtn.layer.masksToBounds = YES;
    [nextBtn addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    nextBtn.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,16).topSpaceToView(self.view,276 - 60).heightIs(45);
    //index = 1;
    if (!self.cert) {
        phoneLab.hidden = YES;
        phoneFld.hidden = YES;
        Img.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,78.5 - 60).heightIs(80.5);
        codeLab.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,89.5 - 60).widthIs(60).heightIs(20);
        codeFld.sd_layout.leftSpaceToView(self.view,79).topSpaceToView(self.view,90 - 60).widthIs(140).heightIs(20);
        pwdLab.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,127 - 60).widthIs(60).heightIs(20);
        pwdfld.sd_layout.leftSpaceToView(self.view,79).topSpaceToView(self.view,127.5 - 60).widthIs(226).heightIs(20);
        TipsLab.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,165 - 60).widthIs(228).heightIs(12.5);
        lineImg.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,0).topSpaceToView(self.view,30 - 60).heightIs(0.5);
        lineImgS.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,0).topSpaceToView(self.view,117.5 - 60).heightIs(0.5);
    }
    
}
//下一步
- (void)nextStep {
    if (self.cert) {
        if ([codeFld.text isEqualToString:@""] || [pwdfld.text isEqualToString:@""]) {
            [self alert:@"请填写完整信息"];
            return;
        }
    }else {
        
        if ([phoneFld.text isEqualToString:@""] || [codeFld.text isEqualToString:@""] || [pwdfld.text isEqualToString:@""]) {
            [self alert:@"请填写完整信息!"];
            return;
        }
    }
    //
    NSString *url = BaseUrl;
    NSDictionary *dic1 = @{
                           @"pass1":codeFld.text,
                           @"pass2":pwdfld.text,
                           @"sms":self.Sms,
                           @"phone":self.phone,
                           @"cert":phoneFld.text
                           };
    NSDictionary *dicc = @{
                           @"action":@"ShopFindPassModify",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSLog(@"数据:%@",result);
        NSDictionary *dic = [result JSONValue];
        NSString *code = dic[@"code"];
        NSString *content = dic[@"content"];
        if ([content isEqualToString:@"正常"]) {
            content = @"密码修改成功！";
        }
        [self alert:content];
        if ([code isEqualToString:@"000000"]) {
            //注册成功 2 登陆页面
            //LoginViewController *Login = [[LoginViewController alloc] init];
            [self performSelector:@selector(backToRootView) withObject:nil afterDelay:2];
        } else {
            
        }
        NSLog(@"返回的数据:%@",dic);
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
        nextBtn.enabled = YES;
    }];
}
- (void)backToRootView {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)alert:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    [self.view endEditing:YES];
//}
@end
