//
//  LoginViewController.m
//  JingXuan
//
//  Created by wj on 16/5/11.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "LoginViewController.h"
#import "RootView.h"
#import "UIView+SDAutoLayout.h"
#import "macro.h"
#import "LoginView.h"
#import "HomePageViewController.h"
#import "ForgetPwdViewController.h"
#import "RegistViewController.h"
#import "NSObject+SBJSON.h"
#import "IBHttpTool.h"
#import <CommonCrypto/CommonDigest.h>
#import "BusiIntf.h"
@interface LoginViewController ()

@property (nonatomic, strong) LoginView *login;
@property (nonatomic, strong) LoginViewController *loginVC;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:243.0/255.0 blue:246.0/255.0 alpha:1];
    _login.phoneTF.text = token(@"phone");
    __block LoginViewController *loginVC = self;
    
    _login = [[LoginView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_login];
    [self loginRequest];
    //注册block
    _login.registBlock = ^(NSString *str) {
        RegistViewController *registVC = [[RegistViewController alloc] init];
        [loginVC.navigationController pushViewController:registVC animated:YES];
    };
    //忘记密码
    _login.forgetPwdBlock = ^(NSString *str) {
        ForgetPwdViewController *forgetVC = [[ForgetPwdViewController alloc] init];
        [loginVC.navigationController pushViewController:forgetVC animated:YES];
        
    };
    
}
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
//登录
- (void)loginRequest {
     __weak typeof(self)weakSelf = self;
    //获取版本号
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    //获取UUID
    NSString *imsi = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *UUID = [self md5:imsi];
    NSString *UUID16 = [[UUID substringFromIndex:8] substringToIndex:16];

    //登录block
    _login.__loginBlock = ^(NSString *phone, NSString *pwd) {
            NSDictionary *dic1 = @{@"name":phone,
                                   @"pass":pwd,
                                   @"os":@"IOS",
                                   @"soft":@"JXPAY",
                                   @"imsi":UUID16,
                                   @"version":appCurVersion
                                   };
            NSDictionary *dicc = @{@"action":@"ShopLogin",
                                   @"data":dic1};
            NSString *params = [dicc JSONFragment];
            [IBHttpTool postWithURL:HOST params:params success:^(id result) {
                NSLog(@"返回数据:%@",result);
                NSDictionary *dic = [result JSONValue];
                NSString *msg = dic[@"msg"];
                NSString *auth = dic[@"auth"];
                NSString *key = dic[@"key"];
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:auth forKey:@"auth"];
                [userDefaults setObject:key forKey:@"key"];
                [userDefaults setObject:phone forKey:phone];
                [userDefaults synchronize];
 
                if ([msg isEqualToString:@"Success"]) {
                    HomePageViewController *homePageVC = [[HomePageViewController alloc] init];
                    [RootView rootView];
                    [weakSelf.navigationController pushViewController:homePageVC animated:YES];
                } else {
                    [AlertView(msg,@"确定") show];
                    
                }
                
            } failure:^(NSError *error) {
                NSLog(@"网络请求失败:%@",error);
                HomePageViewController *homePageVC = [[HomePageViewController alloc] init];
                [RootView rootView];
                [weakSelf.navigationController pushViewController:homePageVC animated:YES];
            }];
        };
    
//[RootView rootView];
};
- (void)viewDidAppear:(BOOL)animated{
    //隐藏导航栏
    self.navigationController.navigationBarHidden = YES;
}
//键盘下落
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event  {
    [self.view endEditing:NO];
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
