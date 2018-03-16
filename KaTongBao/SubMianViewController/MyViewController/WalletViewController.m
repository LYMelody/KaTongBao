//
//  WalletViewController.m
//  JingXuan
//
//  Created by wj on 16/5/16.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "WalletViewController.h"
#import "macro.h"
#import "WalletView.h"
#import "NSObject+SBJSON.h"
#import "IBHttpTool.h"
#import <CommonCrypto/CommonDigest.h>
#import "HttpRequest.h"
@interface WalletViewController ()
@property (nonatomic, strong) NSUserDefaults *user;
@property (nonatomic, assign) NSString *account;
@property (nonatomic, assign) NSString *settle;
@property (nonatomic, strong) WalletView *wallet;
@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBaseVCAttributes:@"钱包" withLeftName:@"返回" withRightName:nil withColor:NavBack];
    
    _wallet = [[WalletView alloc] initWithFrame:CGRectMake(0, 64, KscreenWidth, KscreenHeight)];
    
    [self walletCommonRequestType];
    [self walletShortcutRequestType];
    [self.view addSubview:_wallet];

}
- (void)walletCommonRequestType {
    _user = [NSUserDefaults standardUserDefaults];
    NSString *auth = [_user objectForKey:@"auth"];
    NSString *key = [_user objectForKey:@"key"];
    NSString *sign = [NSString stringWithFormat:@"%@%@",@"10",key];
    NSLog(@"%@",sign);
    NSString *SIGN = [self md5:sign];
    NSDictionary *dic1 = @{@"type":@"10",
                           @"token":auth,
                           @"sign":SIGN,
                           };
    NSDictionary *dicc = @{@"action":@"SettleBalanceQuery",
                           @"data":dic1};
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:HOST params:params success:^(id result) {
        NSLog(@"数据:%@",result);
        NSDictionary *dic = [result JSONValue];
        _account = dic[@"accountBalance"];
        _settle = dic[@"settleBalance"];
        _wallet.moneyLabel.text = [NSString stringWithFormat:@"账户金额：%@",_account];
        _wallet.clearingLabel.text = [NSString stringWithFormat:@"可结算金额：%@",_settle];
        [self.view addSubview:_wallet];
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
    }];
    
    
}
- (void)walletShortcutRequestType {
    _user = [NSUserDefaults standardUserDefaults];
    NSString *auth = [_user objectForKey:@"auth"];
    NSString *key = [_user objectForKey:@"key"];
    NSString *sign = [NSString stringWithFormat:@"%@%@",@"11",key];
    NSLog(@"%@",sign);
    NSString *SIGN = [self md5:sign];
    NSDictionary *dic1 = @{@"type":@"11",
                           @"token":auth,
                           @"sign":SIGN,
                           };
    NSDictionary *dicc = @{@"action":@"SettleBalanceQuery",
                           @"data":dic1};
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:HOST params:params success:^(id result) {
        NSLog(@"数据:%@",result);
        NSDictionary *dic = [result JSONValue];
        _account = dic[@"accountBalance"];
        _settle = dic[@"settleBalance"];
        _wallet.moneyLabel1.text = [NSString stringWithFormat:@"账户金额：%@",_account];
        _wallet.clearingLabel1.text = [NSString stringWithFormat:@"可结算金额：%@",_settle];
        [self.view addSubview:_wallet];
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
    }];
    
    
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
