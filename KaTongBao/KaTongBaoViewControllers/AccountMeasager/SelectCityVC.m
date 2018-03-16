//
//  SelectCityVC.m
//  wujieNew
//
//  Created by rongfeng on 16/1/12.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "SelectCityVC.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "BaseMsgVC.h"
#import "BusiIntf.h"
#import "macro.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import <CommonCrypto/CommonDigest.h>
#import "KTBSubBankViewController.h"
#import "GiFHUD.h"
@implementation SelectCityVC

-(void)viewWillAppear:(BOOL)animated
{
    //不隐藏导航栏
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.hidden = NO;
    //隐藏工具栏
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = NavBack;
    self.view.backgroundColor = [UIColor whiteColor];
    //去掉tabbar
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"选择支行所在市";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] init];
    left.title = @"返回";
    self.navigationItem.backBarButtonItem = left;
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 64) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    [self.view addSubview:table];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.CityArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        NSString *cityName = self.CityArray[indexPath.row];
        cell.textLabel.text = cityName;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *cityName = self.CityArray[indexPath.row];
    [BusiIntf curPayOrder].cityName = cityName;
    NSLog(@"%@,%@",[BusiIntf curPayOrder].ProName,[BusiIntf curPayOrder].cityName);
    [self RequestForSubBankInfo];

}

//获取支行信息
- (void)RequestForSubBankInfo {
    
    NSString *url = JXUrl;
  
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    
    NSString *md5 = [NSString stringWithFormat:@"%@%@%@%@%@",[BusiIntf curPayOrder].AddBankName,[BusiIntf curPayOrder].BankCardType,[BusiIntf curPayOrder].cityName,[BusiIntf curPayOrder].ProName,key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                           @"bankType":[BusiIntf curPayOrder].BankCardType,
                           @"bankName":[BusiIntf curPayOrder].AddBankName,
                           @"province":[BusiIntf curPayOrder].ProName,
                           @"city":[BusiIntf curPayOrder].cityName,
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"bankInfoCnaps",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSLog(@"数据:%@",result);
        NSDictionary *dic = [result JSONValue];
        NSString *code = dic[@"code"];
        NSArray *ListAtr = dic[@"cnapsList"];
       
        if ([code isEqualToString:@"000000"]) {
            //注册成功 2 登陆页面
            //LoginViewController *Login = [[LoginViewController alloc] init];
            //[self performSelector:@selector(backToRootView) withObject:nil afterDelay:2];
            KTBSubBankViewController *ktbsunbank = [[KTBSubBankViewController alloc] init];
            ktbsunbank.hidesBottomBarWhenPushed = YES;
            ktbsunbank.SubBankArray = ListAtr;
            [self.navigationController pushViewController:ktbsunbank animated:YES];
            ktbsunbank.hidesBottomBarWhenPushed = NO;
            
        } else {
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
       
    }];
}

//MD5加密
- (NSString *)md5HexDigest:(NSString*)password
{
    const char *original_str = [password UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    NSString *mdfiveString = [hash lowercaseString];
    return mdfiveString;
}

- (void)alert:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
}
@end
