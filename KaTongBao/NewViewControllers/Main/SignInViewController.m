//
//  SignInViewController.m
//  wujieNew
//
//  Created by rongfeng on 15/12/18.
//  Copyright © 2015年 rongfeng. All rights reserved.
//

#import "SignInViewController.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "IBHttpTool.h"
#import "SBJSON.h"
#import "LoginViewController.h"
#import "RestPwdVC.h"
#import "AboutTextViewController.h"
#import "macro.h"
#import "JXPayProtrolViewController.h"
#import <CommonCrypto/CommonDigest.h>
@implementation SignInViewController {
    NSTimer *timer;
    UIButton *btn;
    NSInteger index;
    UIButton *nextBtn;
    UITextField *phoneFld;
    UITextField *codeFld;
    UITextField *pwdfld;
    UITextField *EnSurefld;
    BOOL IsSignIn;
    UISwitch *protrolSwitch;
    UITextField *OrgIdFld;
    NSString *version;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    if (self.tag == 100) {
        self.title = @"忘记密码";
        IsSignIn = NO;
    }else {
        self.title = @"注册";
        IsSignIn = YES;
    }
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = NavBack;
}

- (void)viewDidAppear:(BOOL)animated {
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    //自定义返回按钮
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    right.title = @"返回";
    self.navigationItem.backBarButtonItem = right;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [self CreatView];
    
}

- (void)CreatView {
   
//    UITableView *table = [[UITableView alloc] init];
//    table.dataSource = self;
//    table.delegate = self;
    UIImageView *backImg = [[UIImageView alloc] init];
    backImg.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    backImg.backgroundColor = LightGrayColor;
    backImg.userInteractionEnabled =  YES;
    [self.view addSubview:backImg];
    
    UITapGestureRecognizer *TapToHideenKeyBoard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HideKeyBoayd)];
    TapToHideenKeyBoard.numberOfTouchesRequired = 1;
    [backImg addGestureRecognizer:TapToHideenKeyBoard];
    
    
    UIImageView *Img = [[UIImageView alloc] init];
    Img.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:Img];
    //手机号
    UILabel *phoneLab = [[UILabel alloc] init];
    phoneLab.text = @"手机号";
    phoneLab.font = [UIFont systemFontOfSize:15];
    phoneLab.textColor = Gray100;
    [self.view addSubview:phoneLab];
    
    phoneFld = [[UITextField alloc] init];
    phoneFld.placeholder = @"请输入您的手机号码";
    phoneFld.font = [UIFont systemFontOfSize:14];
    phoneFld.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:phoneFld];
    
    Img.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,78.5 - 64).heightIs(134.5 + 46);
    phoneLab.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,89.5 - 64).widthIs(45 + 8).heightIs(20);
    phoneFld.sd_layout.leftSpaceToView(self.view,79).topSpaceToView(self.view,90 - 64).widthIs(226).heightIs(20);
    //中间的横线
    UIImageView *lineImg = [[UIImageView alloc] init];
    lineImg.backgroundColor = Gray229;
    [self.view addSubview:lineImg];
    lineImg.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,0).topSpaceToView(self.view,122.5 -64).heightIs(0.5);
    UIImageView *lineImgS = [[UIImageView alloc] init];
    lineImgS.backgroundColor = Gray229;
    [self.view addSubview:lineImgS];
    lineImgS.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,0).topSpaceToView(self.view,167.5 - 64).heightIs(0.5);
    UIImageView *LineImgT = [[UIImageView alloc] init];
    LineImgT.backgroundColor = Gray229;
    [self.view addSubview:LineImgT];
    LineImgT.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,0).topSpaceToView(self.view,213.5 - 64).heightIs(0.5);
    //验证码
    UILabel *codeLab = [[UILabel alloc] init];
    codeLab.text = @"验证码";
    codeLab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:codeLab];
    
    codeFld = [[UITextField alloc] init];
    codeFld.placeholder = @"请输入您的验证码";
    codeFld.font = [UIFont systemFontOfSize:14];
    codeFld.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:codeFld];
    
    codeLab.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,137 - 64).widthIs(45 + 15).heightIs(20);
    codeFld.sd_layout.leftSpaceToView(self.view,79).topSpaceToView(self.view,137.5 - 64).widthIs(140).heightIs(20);
    //获取验证码
    btn = [[UIButton alloc] init];
    [btn setTitle:@"获取" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.backgroundColor = NavBack;
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.sd_layout.leftSpaceToView(self.view,232).topSpaceToView(self.view,132.5 - 64).widthIs(83.5).heightIs(24);
    //密码
    UILabel *pwdLab = [[UILabel alloc] init];
    pwdLab.text = @"登录密码";
    pwdLab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:pwdLab];
    pwdfld = [[UITextField alloc] init];
    pwdfld.placeholder = @"请输入您的密码";
    pwdfld.secureTextEntry = YES;
    pwdfld.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:pwdfld];
    //确认密码
    UILabel *EnSurepwdLab = [[UILabel alloc] init];
    EnSurepwdLab.text = @"确认密码";
    EnSurepwdLab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:EnSurepwdLab];
    EnSurefld = [[UITextField alloc] init];
    EnSurefld.placeholder = @"请再次输入您的密码";
    EnSurefld.font = [UIFont systemFontOfSize:14];
    EnSurefld.secureTextEntry = YES;
    [self.view addSubview:EnSurefld];
    
    
    //上级推荐码
    UIImageView *OrgBackImg = [[UIImageView alloc] init];
    OrgBackImg.backgroundColor = [UIColor whiteColor];
    OrgBackImg.userInteractionEnabled = YES;
    [self.view addSubview:OrgBackImg];
    
    UILabel *OrgIdLab = [[UILabel alloc] init];
    OrgIdLab.text = @"上级推荐码";
    OrgIdLab.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:OrgIdLab];
    OrgIdFld = [[UITextField alloc] init];
    OrgIdFld.placeholder = @"上级手机号";
    OrgIdFld.font = [UIFont systemFontOfSize:14];
    OrgIdFld.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:OrgIdFld];
    
    
    UILabel *TipsLab = [[UILabel alloc] init];
    TipsLab.text = @"密码由6-20位英文字母,数字,或符号组成";
    TipsLab.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:TipsLab];
    
    pwdLab.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,183 - 64).widthIs(45 + 15).heightIs(20);
    pwdfld.sd_layout.leftSpaceToView(self.view,79).topSpaceToView(self.view,183.5 - 64).widthIs(98+100).heightIs(20);
    EnSurepwdLab.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,229 - 64).widthIs(45 + 15).heightIs(20);
    EnSurefld.sd_layout.leftSpaceToView(self.view,79).topSpaceToView(self.view,229.5 - 64).widthIs(98+100).heightIs(20);
    TipsLab.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,222 - 64 + 46).widthIs(228).heightIs(12.5);
    OrgBackImg.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(self.view,229 - 64 + 86).widthIs(KscreenWidth).heightIs(46);
    OrgIdLab.sd_layout.leftSpaceToView(self.view,15).topSpaceToView(self.view,229 - 64 + 86 + 12).widthIs(100).heightIs(20);
    OrgIdFld.sd_layout.leftSpaceToView(self.view,92).topSpaceToView(self.view,229.5 - 64 + 86 + 12).widthIs(189).heightIs(20);
    if (self.tag != 100) {
        //注册协议
        protrolSwitch = [[UISwitch alloc] init];
        protrolSwitch.on = YES;
        [self.view addSubview:protrolSwitch];
        protrolSwitch.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,238 - 64 + 46 + 86).widthIs(40).heightIs(20);
        UILabel *agreeLab = [[UILabel alloc] init];
        agreeLab.text = @"同意";
        agreeLab.font = [UIFont systemFontOfSize:16];
        [self.view addSubview:agreeLab];
        agreeLab.sd_layout.leftSpaceToView(self.view,80).topSpaceToView(self.view,240 - 64 + 46 + 86).widthIs(40).heightIs(25);
        UIButton *ProtrolBtn = [[UIButton alloc] init];
        [ProtrolBtn setTitle:@"《注册协议》" forState:UIControlStateNormal];
        ProtrolBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [ProtrolBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [ProtrolBtn addTarget:self action:@selector(SignProtrol) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:ProtrolBtn];
        ProtrolBtn.sd_layout.leftSpaceToView(self.view,126).topSpaceToView(self.view,240 - 64 + 46 + 86).widthIs(100).heightIs(25);
    }
    //下一步
    nextBtn = [[UIButton alloc] init];
    nextBtn.backgroundColor = RedColor;
    [nextBtn setTitle:@"提交" forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [nextBtn setBackgroundColor:NavBack];
    nextBtn.layer.cornerRadius = 3.5;
    nextBtn.layer.masksToBounds = YES;
    [nextBtn addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    nextBtn.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,16).topSpaceToView(self.view,280 - 64 + 46 + 86).heightIs(45);
    //隐藏
    UIImageView *ImageView = [[UIImageView alloc] init];
    ImageView.backgroundColor = LightGrayColor;
    [self.view addSubview:ImageView];
    ImageView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,229 - 64 + 86).heightIs(46 );
    ImageView.hidden = YES;
    if (self.tag == 100) {
        pwdLab.hidden = NO;
        pwdfld.hidden = NO;
        TipsLab.hidden = NO;
        [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        
        OrgBackImg.hidden = YES;
        OrgIdLab.hidden = YES;
        OrgIdFld.hidden = YES;
    }
    
    timer = [[NSTimer alloc] init];
}
//PUSH到注册协议
- (void)SignProtrol {
    
    JXPayProtrolViewController *AboutTextView = [[JXPayProtrolViewController alloc] init];
    [self.navigationController pushViewController:AboutTextView animated:YES];
    
}
//注册
- (void)nextStep {
    
    NSLog(@"下一步!");
    nextBtn.backgroundColor = NavBack;
    nextBtn.enabled = NO;
    
    if (self.tag == 100) {
        
        NSLog(@"忘记密码!");
        //忘记密码
        if ([phoneFld.text isEqualToString:@""] || [codeFld.text isEqualToString:@""]) {
            
            NSLog(@"请填写完整信息!");
            [self alert:@"请填写完整信息!"];
            nextBtn.backgroundColor = NavBack;
            nextBtn.enabled = YES;
            return;
        }else if (![EnSurefld.text isEqualToString:pwdfld.text]) {
            [self alert:@"您两次输入的密码不一致，请重新输入!"];
            nextBtn.backgroundColor = NavBack;
            nextBtn.enabled = YES;
            return;
        }
        
        NSString *url = JXUrl;
        NSDictionary *dic1 = @{
                               @"phone":phoneFld.text,
                               @"code":codeFld.text,
                               @"pass":pwdfld.text
                               };
        NSDictionary *dicc = @{
                               @"action":@"shopFindPassState",
                               @"data":dic1
                               };
        NSString *params = [dicc JSONFragment];
        [IBHttpTool postWithURL:url params:params success:^(id result) {
            NSLog(@"数据:%@",result);
            NSDictionary *dic = [result JSONValue];
            NSString *code = dic[@"code"];
            NSString *content = dic[@"msg"];
            //NSString *cert = dic[@"cert"];
            //[self alert:content];
            if ([code isEqualToString:@"000000"]) {
                //注册成功 2 登陆页面
                NSLog(@"验证成功!");
                content = @"恭喜您！修改密码成功!";
                [self alert:content];
                [self.navigationController popViewControllerAnimated:YES];
                
            } else {
                
            }
            
            NSLog(@"返回的数据:%@",dic);
        } failure:^(NSError *error) {
            NSLog(@"网络请求失败:%@",error);
            nextBtn.enabled = YES;
        }];

    }else {
        //注册
        if (!protrolSwitch.on) {
            
            [self alert:@"您尚未同意注册协议!"];
            nextBtn.backgroundColor = NavBack;
            nextBtn.enabled = YES;
            return;
        }
        if ([phoneFld.text isEqualToString:@""] || [codeFld.text isEqualToString:@""]  || [pwdfld.text isEqualToString:@""]) {
            
            NSLog(@"请填写完整信息!");
            [self alert:@"请填写完整信息!"];
            nextBtn.backgroundColor = NavBack;
            nextBtn.enabled = YES ;
            return;
        }else if (![EnSurefld.text isEqualToString:pwdfld.text]) {
            [self alert:@"您两次输入的密码不一致，请重新输入!"];
            nextBtn.backgroundColor = NavBack;
            nextBtn.enabled = YES;
            return;
        }
        else if ([OrgIdFld.text isEqualToString:@""]) {
            [self alert:@"请填写上级推荐码!"];
            nextBtn.backgroundColor = NavBack;
            nextBtn.enabled = YES;
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
                               @"phone":phoneFld.text,
                               @"code":codeFld.text,
                               @"pass":pwdfld.text,
                               @"orgId":OrgIdFld.text,
                               @"os":@"IOS",
                               @"soft":@"KTB",
                               @"version":version,
                               @"imsi":@"",
                               @"imei":UUID16
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
//                LoginViewController *login = [[LoginViewController alloc] init];
//                [self.navigationController pushViewController:login animated:YES];
                content = @"恭喜您!注册成功!";
                [self.navigationController popViewControllerAnimated:YES];
                
            } else {
                
            }
            [self alert:content];
            nextBtn.backgroundColor = NavBack;
            nextBtn.enabled = YES ;
            NSLog(@"返回的数据:%@",dic);
        } failure:^(NSError *error) {
            NSLog(@"网络请求失败:%@",error);
            nextBtn.backgroundColor = NavBack;
            nextBtn.enabled = YES ;
        }];
    }
}

- (void)getCode {
    //点击后设置不能点击
    btn.enabled = NO;
    if ([phoneFld.text isEqualToString:@""]) {
        [self alert:@"请输入手机号!"];
        return;
    }
    index += 120;
    [btn setTitle:[NSString stringWithFormat:@"(120s)后重发"] forState:UIControlStateNormal];
    btn.backgroundColor = Gray151;
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(TimerAction) userInfo:nil repeats:YES];
    if (self.tag == 101) {
        //获取注册验证码
        NSString *url = JXUrl;
        NSDictionary *dic1 = @{
                               @"phone":phoneFld.text,
                               
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
            if ([code isEqualToString:@"000000"]) {
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
    } else {
        //获取找回密码验证码
        NSLog(@"找回密码!");
        NSString *url = JXUrl;
        NSDictionary *dic1 = @{
                               @"phone":phoneFld.text,
                               };
        NSDictionary *dicc = @{
                               @"action":@"shopFindPassStateSms",
                               @"data":dic1
                               };
        NSString *params = [dicc JSONFragment];
        [IBHttpTool postWithURL:url params:params success:^(id result) {
            NSLog(@"数据:%@",result);
            NSDictionary *dic = [result JSONValue];
            NSString *code = dic[@"code"];
            NSString *content = dic[@"msg"];
            if ([code isEqualToString:@"000000"]) {
                content = @"短信已下发至您的手机，请注意查收!";
            }
            [self alert:content];
            
            NSLog(@"返回的数据:%@",dic);
        } failure:^(NSError *error) {
            NSLog(@"网络请求失败:%@",error);
            
        }];

    }
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

- (void)TimerAction {
    
    index --;
    [btn setTitle:[NSString stringWithFormat:@"(%ds)后重发",index] forState:UIControlStateNormal];
    if (index == 0) {
        [timer invalidate];
        btn.enabled = YES;
        [btn setTitle:@"获取" forState:UIControlStateNormal];
        btn.backgroundColor = NavBack;
        nextBtn.enabled = YES;
        nextBtn.backgroundColor = NavBack;
    }
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//}

- (void)viewWillDisappear:(BOOL)animated {
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }

}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    [self.view endEditing:YES];
//    
//}
//收键盘
- (void)HideKeyBoayd {
    
    [phoneFld resignFirstResponder];
    [codeFld resignFirstResponder];
    [pwdfld resignFirstResponder];
    [EnSurefld resignFirstResponder];
    [OrgIdFld resignFirstResponder];
    
}
- (void)alert:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
}

@end
