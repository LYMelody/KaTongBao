//
//  JXRegistViewController.m
//  JingXuan
//
//  Created by rongfeng on 16/6/2.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "JXRegistViewController.h"
#import "macro.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "SBJSON.h"
#import <CommonCrypto/CommonDigest.h>
#import "IBHttpTool.h"
#import "JXLoginViewController.h"
#import "JXPayProtrolViewController.h"
@interface JXRegistViewController ()

@end

@implementation JXRegistViewController {
    
    BOOL IsSelect;
    BOOL CanIseeFirst;
    BOOL CanIseeSecond;
    UIButton *agreeBtn;
    UIButton *PwdBtnOne;
    UIButton *PwdBtnTwo;
    UIButton *verifyBtn;
    NSInteger index;
    NSTimer *timer;
    UIButton *confirmButton;
    NSString *version;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:19],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = NavBack;
    //自定义返回按钮
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    right.title = @"返回";
    self.navigationItem.backBarButtonItem = right;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    backView.layer.borderWidth = 1;
    [self.view addSubview:backView];
    backView.sd_layout.topSpaceToView(self.view,78 - 64).leftSpaceToView(self.view,0).widthIs(KscreenWidth).heightIs(240);
    
    _phoneLabel = [[UILabel alloc] init];
    _phoneLabel.text = @"手机号码:";
    _phoneLabel.font = [UIFont systemFontOfSize:17];
    [backView addSubview:_phoneLabel];
    _phoneLabel.sd_layout.topSpaceToView(backView,10).leftSpaceToView(backView,10).widthIs(75).heightIs(40);
    
    _phoneTextField = [[UITextField alloc] init];
    _phoneTextField.placeholder = @"请输入您的手机号码";
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTextField.font = [UIFont systemFontOfSize:15];
    [backView addSubview:_phoneTextField];
    _phoneTextField.sd_layout.topSpaceToView(backView,10).leftSpaceToView(_phoneLabel,10).widthIs(200).heightIs(40);
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:view];
    view.sd_layout.topSpaceToView(_phoneLabel,10).leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).widthIs(KscreenWidth).heightIs(1);
    
    _verifyLabel = [[UILabel alloc] init];
    _verifyLabel.text = @"验证码:";
    _verifyLabel.font = [UIFont systemFontOfSize:17];
    [backView addSubview:_verifyLabel];
    _verifyLabel.sd_layout.topSpaceToView(_phoneLabel,20).leftSpaceToView(backView,10).widthIs(75).heightIs(40);
    
    _verifyTextField = [[UITextField alloc] init];
    _verifyTextField.placeholder = @"请输入验证码";
    _verifyTextField.keyboardType = UIKeyboardTypeNumberPad;
    _verifyTextField.font = [UIFont systemFontOfSize:15];
    [backView addSubview:_verifyTextField];
    _verifyTextField.sd_layout.topSpaceToView(_phoneTextField,20).leftSpaceToView(_verifyLabel,10).widthIs(180).heightIs(40);
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:view1];
    view1.sd_layout.topSpaceToView(_verifyLabel,10).leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).widthIs(KscreenWidth).heightIs(1);
    
    UILabel *pswLabel = [[UILabel alloc] init];
    pswLabel.text = @"密码:";
    pswLabel.font = [UIFont systemFontOfSize:17];
    [backView addSubview:pswLabel];
    pswLabel.sd_layout.topSpaceToView(_verifyLabel,20).leftSpaceToView(backView,10).widthIs(75).heightIs(40);
    
    _pswTextField = [[UITextField alloc] init];
    _pswTextField.placeholder = @"请输入密码";
    _pswTextField.secureTextEntry = YES;
    _pswTextField.font = [UIFont systemFontOfSize:15];
    [backView addSubview:_pswTextField];
    _pswTextField.sd_layout.topSpaceToView(_verifyTextField,20).leftSpaceToView(pswLabel,10).widthIs(180).heightIs(40);
    
    PwdBtnOne = [[UIButton alloc] init];
    [PwdBtnOne setImage:[UIImage imageNamed:@"密码可见"] forState:UIControlStateNormal];
    [PwdBtnOne addTarget:self action:@selector(SelectToSeePwd:) forControlEvents:UIControlEventTouchUpInside];
    PwdBtnOne.tag = 100;
    CanIseeFirst = NO;
    [backView addSubview:PwdBtnOne];
    PwdBtnOne.sd_layout.rightSpaceToView(backView,22.5).topSpaceToView(view1,15).widthIs(35).heightIs(20);
    

    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:view2];
    view2.sd_layout.topSpaceToView(pswLabel,10).leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).widthIs(KscreenWidth).heightIs(1);
    
    UILabel *notarizePswLabel = [[UILabel alloc] init];
    notarizePswLabel.text = @"确认密码:";
    notarizePswLabel.font = [UIFont systemFontOfSize:17];
    [backView addSubview:notarizePswLabel];
    notarizePswLabel.sd_layout.topSpaceToView(pswLabel,20).leftSpaceToView(backView,10).widthIs(75).heightIs(40);
    
    UILabel *reminderLabel = [[UILabel alloc] init];
    reminderLabel.text = @"密码由6-20位英文字母，数字，或符号组成";
    reminderLabel.font = [UIFont systemFontOfSize:12];
    reminderLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:reminderLabel];
    reminderLabel.sd_layout.topSpaceToView(backView,0).leftSpaceToView(self.view,10).rightSpaceToView(self.view,10).heightIs(40);
    
    _notarizePswTF = [[UITextField alloc] init];
    _notarizePswTF.placeholder = @"请再次输入密码";
    _notarizePswTF.font = [UIFont systemFontOfSize:15];
    _notarizePswTF.secureTextEntry = YES;
    [backView addSubview:_notarizePswTF];
    _notarizePswTF.sd_layout.topSpaceToView(_pswTextField,20).leftSpaceToView(notarizePswLabel,10).widthIs(180).heightIs(40);
    
    PwdBtnTwo = [[UIButton alloc] init];
    [PwdBtnTwo setImage:[UIImage imageNamed:@"密码可见"] forState:UIControlStateNormal];
    [PwdBtnTwo addTarget:self action:@selector(SelectToSeePwdTwo:) forControlEvents:UIControlEventTouchUpInside];
    PwdBtnTwo.tag = 101;
    CanIseeSecond = NO;
    [backView addSubview:PwdBtnTwo];
    PwdBtnTwo.sd_layout.rightSpaceToView(backView,22.5).topSpaceToView(view2,15).widthIs(35).heightIs(20);
    
    verifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [verifyBtn setTitle:@"获取" forState:UIControlStateNormal];
    [verifyBtn setTintColor:[UIColor whiteColor]];
    [verifyBtn setBackgroundColor:NavBack];
    [verifyBtn addTarget:self action:@selector(captchaClick:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:verifyBtn];
    verifyBtn.sd_layout.topEqualToView(view).rightEqualToView(view).widthIs(78).heightIs(60);
    
    confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.backgroundColor = NavBack;
    confirmButton.tintColor = [UIColor whiteColor];
    confirmButton.clipsToBounds = YES;
    confirmButton.layer.cornerRadius = 3;
    [confirmButton setTitle:@"提交" forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmButton];
    confirmButton.sd_layout.topSpaceToView(backView,104.5).leftSpaceToView(self.view,10).rightSpaceToView(self.view,10).heightIs(45);
    
    agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [agreeBtn setImage:[UIImage imageNamed:@"矩形 18"] forState:UIControlStateNormal];
    [agreeBtn addTarget:self action:@selector(agreeClick:) forControlEvents:UIControlEventTouchUpInside];
    IsSelect = YES;
    [self.view addSubview:agreeBtn];
    agreeBtn.sd_layout.topSpaceToView(backView,40.5).leftSpaceToView(self.view,10).widthIs(20).heightIs(20);
    UILabel *agreeLab = [[UILabel alloc] init];
    agreeLab.text = @"同意";
    agreeLab.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:agreeLab];
    agreeLab.sd_layout.leftSpaceToView(agreeBtn,10).topSpaceToView(backView,41).widthIs(30).heightIs(16);
    UIButton *TiPsBtn = [[UIButton alloc] init];
    [TiPsBtn setTitle:@"《镜炫支付服务协议》" forState:UIControlStateNormal];
    TiPsBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [TiPsBtn setTitleColor:LightBlue forState:UIControlStateNormal];
    [TiPsBtn addTarget:self action:@selector(ToProtocolView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:TiPsBtn];
    TiPsBtn.sd_layout.leftSpaceToView(agreeLab,10).topSpaceToView(backView,41).widthIs(160).heightIs(15);
    
}
//获取验证码
- (void)captchaClick:(UIButton *)btn {
    
    //点击后设置不能点击
    btn.enabled = NO;
    if ([_phoneTextField.text isEqualToString:@""]) {
        [self alert:@"请输入手机号!"];
        return;
    }
    index += 120;
    [btn setTitle:[NSString stringWithFormat:@"(120s)后重发"] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.backgroundColor = Gray151;
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(TimerAction) userInfo:nil repeats:YES];
   
        //获取注册验证码
        NSString *url = JXUrl;
        NSDictionary *dic1 = @{
                               @"phone":_phoneTextField.text,
                               
                               };
        NSDictionary *dicc = @{
                               @"action":@"shopRegisterStateSms",
                               @"data":dic1
                               };
        NSString *params = [dicc JSONFragment];
        [IBHttpTool postWithURL:url params:params success:^(id result) {
            NSLog(@"数据:%@",result);
            NSDictionary *dic = [result JSONValue];
            NSString *code = dic[@"code"];
            NSString *content = dic[@"msg"];
            //改一下提示文字
            if ([content isEqualToString:@"Success"]) {
                content = @"短信已下发至您的手机，请注意查收!";
            }
            if ([code isEqualToString:@"130019"])
            {
                index = 1;
            }
            [self alert:content];
            NSLog(@"返回的数据:%@",dic);
        } failure:^(NSError *error) {
            NSLog(@"网络请求失败:%@",error);
        }];
    
}
- (void)TimerAction {
    
    index --;
    [verifyBtn setTitle:[NSString stringWithFormat:@"(%ds)后重发",index] forState:UIControlStateNormal];
    if (index == 0) {
        [timer invalidate];
        verifyBtn.enabled = YES;
        [verifyBtn setTitle:@"获取" forState:UIControlStateNormal];
        verifyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        verifyBtn.backgroundColor = NavBack;
        confirmButton.enabled = YES;
        confirmButton.backgroundColor = NavBack;
    }
}

//确认提交
- (void)confirmClick:(UIButton *)btn {
    //注册
    if ([_phoneTextField.text isEqualToString:@""] || [_verifyTextField.text isEqualToString:@""]  || [_pswTextField.text isEqualToString:@""] || [_notarizePswTF.text isEqualToString:@""]) {
        
        NSLog(@"请填写完整信息!");
        [self alert:@"请填写完整信息!"];
        confirmButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:0 blue:0 alpha:1];
        confirmButton.enabled = YES ;
        return;
    }
    NSString *url = JXUrl;
    //版本号
    version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    //获取UUID
    NSString *imsi = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *UUID = [self md5:imsi];
    NSString *UUID16 = [[UUID substringFromIndex:8] substringToIndex:16];
    NSDictionary *dic1 = @{
                           @"phone":_phoneTextField.text,
                           @"code":_verifyTextField.text,
                           @"pass":_pswTextField.text,
                           @"confirmation":_notarizePswTF.text,
                           @"os":@"IOS",
                           @"soft":@"JXPAY",
                           @"imsi":@"",
                           @"imei":UUID16,
                           @"version":version
                           };
    NSDictionary *dicc = @{
                           @"action":@"shopRegisterState",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSLog(@"数据:%@",result);
        NSDictionary *dic = [result JSONValue];
        NSString *code = dic[@"code"];
        NSString *content = dic[@"msg"];
        
        if ([code isEqualToString:@"000000"]) {
            //注册成功 2 登陆页面
            JXLoginViewController *login = [[JXLoginViewController alloc] init];
            [self.navigationController pushViewController:login animated:YES];
            content = @"注册成功！";
        } else {
            
        }
        [self alert:content];
        confirmButton.backgroundColor = NavBack;
        confirmButton.enabled = YES ;
        NSLog(@"返回的数据:%@",dic);
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
        confirmButton.backgroundColor = NavBack;
        confirmButton.enabled = YES ;
    }];
}
//MD5加密
-(NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
}
//是否同意协议
- (void)agreeClick :(UIButton *)btn {
    IsSelect = !IsSelect;
    if (IsSelect) {
        [agreeBtn setImage:[UIImage imageNamed:@"矩形 18"] forState:UIControlStateNormal];
    } else {
        [agreeBtn setImage:[UIImage imageNamed:@"矩形 17"] forState:UIControlStateNormal];
    }
}
//镜炫支付服务协议
-(void)ToProtocolView {
    
    
    JXPayProtrolViewController *JXPayVC = [[JXPayProtrolViewController alloc] init];
    [self.navigationController pushViewController:JXPayVC animated:YES];
    
    
}
//密码是否可见
- (void)SelectToSeePwd:(UIButton *)btn{
    
    
    CanIseeFirst = ! CanIseeFirst;
    
    if (CanIseeFirst ) {
        _pswTextField.secureTextEntry = NO;
        [PwdBtnOne setImage:[UIImage imageNamed:@"密码不可见"] forState:UIControlStateNormal];
    }else if (CanIseeFirst == NO) {
        _pswTextField.secureTextEntry = YES;
        [PwdBtnOne setImage:[UIImage imageNamed:@"密码可见"] forState:UIControlStateNormal];
    }
}
- (void)SelectToSeePwdTwo:(UIButton *)btn {
    
    CanIseeSecond = ! CanIseeSecond;
    
    if (CanIseeSecond ) {
        _notarizePswTF.secureTextEntry = NO;
        [PwdBtnTwo setImage:[UIImage imageNamed:@"密码不可见"] forState:UIControlStateNormal];
    }else if (CanIseeSecond == NO) {
        _notarizePswTF.secureTextEntry = YES;
        [PwdBtnTwo setImage:[UIImage imageNamed:@"密码可见"] forState:UIControlStateNormal];
    }

}
//键盘下落
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    [self.view endEditing:YES];
//    
//}
- (void)alert:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
}
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
