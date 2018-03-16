//
//  RegistViewController.m
//  JingXuan
//
//  Created by wj on 16/5/13.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "RegistViewController.h"
#import "LoginViewController.h"
#import "macro.h"
#import "RegistView.h"
#import "NSObject+SBJSON.h"
#import "IBHttpTool.h"
#import <CommonCrypto/CommonDigest.h>

@interface RegistViewController ()
@property (nonatomic, strong) RegistView *regist;
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBaseVCAttributes:@"注册" withLeftName:@"返回" withRightName:nil withColor:NavBack];
    self.view.backgroundColor = LightGrayColor;

    _regist = [[RegistView alloc] initWithFrame:CGRectMake(0, 64, KscreenWidth, KscreenHeight)];
    [self.view addSubview:_regist];
    [self getVerificationCodeRequest];
    [self registRequest];
    
}
//获取验证码
- (void) getVerificationCodeRequest{
    _regist.captchaBlock = ^(NSString *str) {
        NSDictionary *dic1 = @{@"phone":str};
        NSDictionary *dicc = @{@"action":@"ShopRegisterGainSms",
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
//注册
- (void)registRequest {
    __weak typeof(self)weakSelf = self;
    //获取版本号
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    //获取UUID
    NSString *imsi = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *UUID = [self md5:imsi];
    NSString *UUID16 = [[UUID substringFromIndex:8] substringToIndex:16];
    _regist.confirmBlock = ^(NSString *phone, NSString *verify, NSString *psw, NSString *psw1) {
        NSDictionary *dic1 = @{@"phone":phone,
                               @"code":verify,
                               @"pass":psw,
                               @"confirmation":psw1,
                               @"os":@"IOS",
                               @"soft":@"JXPAY",
                               @"version":appCurVersion,
                               @"imsi":UUID16
                               };
        NSDictionary *dicc = @{@"action":@"ShopRegisterGainSms",
                               @"data":dic1};
        NSString *params = [dicc JSONFragment];
        [IBHttpTool postWithURL:HOST params:params success:^(id result) {
            NSLog(@"数据:%@",result);
            NSDictionary *dic = [result JSONValue];
            NSString *msg = dic[@"msg"];
            [AlertView(msg, @"确定") show];
//            LoginViewController *loginVC = [[LoginViewController alloc] init];
//            [weakSelf.navigationController pushViewController:loginVC animated:YES];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            NSLog(@"网络请求失败:%@",error);
        }];
    };

}
- (void)leftEvent:(UIButton *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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
