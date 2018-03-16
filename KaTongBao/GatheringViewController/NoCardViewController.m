//
//  NoCardViewController.m
//  JingXuan
//
//  Created by wj on 16/5/12.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "NoCardViewController.h"
#import "macro.h"
#import "NoCardView.h"
#import "GatheringViewController.h"
#import "ShortcutViewController.h"
#import "UIView+SDAutoLayout.h"
#import "HttpRequest.h"
#import "NoCardModel.h"
#import "NSObject+SBJSON.h"
#import "IBHttpTool.h"
#import <CommonCrypto/CommonDigest.h>

@interface NoCardViewController ()
@property (nonatomic, strong) ShortcutViewController *shortcutVC;

@end

@implementation NoCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBaseVCAttributes:@"无卡收款" withLeftName:@"返回" withRightName:nil withColor:NavBack];
    
    NoCardView *noCard = [[NoCardView alloc] initWithFrame:CGRectMake(0, 64, KscreenWidth, KscreenHeight)];
    noCard.block = ^(NSString *str) {
        _shortcutVC = [[ShortcutViewController alloc] init];
//        shortcutVC.money = str;
        
        [self noCardRequestOrderType:@"10" amount:str];
        
        [self.navigationController pushViewController:_shortcutVC animated:YES];
        _shortcutVC.amount = @"123";
    };
    if (self.dataBlock) {
        self.dataBlock(_amount,_orderNo,_orderTime);
        NSLog(@"--------%@",_amount);
    }
    [self.view addSubview:noCard];
}
//无卡收款
- (void)noCardRequestOrderType:(NSString *)orderType amount:(NSString *)amount {
    
    //获取版本号
    //    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    NSString *sign = [NSString stringWithFormat:@"%@%@%@%@",orderType,amount,@"2702546835",token(@"key")];
    NSString *SIGN = [self md5:sign];
    
    NSDictionary *dic1 = @{@"orderType":orderType,
                           @"amount":amount,
                           @"version":@"2702546835",
                           @"token":token(@"auth"),
                           @"sign":SIGN,
                           };
    NSDictionary *dicc = @{@"action":@"OrderCreate",
                           @"data":dic1};
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:HOST params:params success:^(id result) {
        NSDictionary *dic = [result JSONValue];
        //        NoCardModel *noCard = [[NoCardModel alloc] init];
        //        [noCard initWithDic:dic];
//        _amount = dic[@"amount"];
//        _orderNo = dic [@"orderNo"];
//        _orderTime = dic[@"orderTime	"];
//        _shortcutVC.amount = _amount;
//        _shortcutVC.orderNo = _orderNo;
//        _shortcutVC.orderTime = _orderTime;
        NSLog(@"%@",result);
        
        
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
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//键盘下落
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event  {
//    [self. view endEditing:NO];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
