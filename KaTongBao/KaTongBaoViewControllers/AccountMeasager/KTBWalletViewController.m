//
//  KTBWalletViewController.m
//  KaTongBao
//
//  Created by rongfeng on 16/6/20.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "KTBWalletViewController.h"
#import "macro.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "JieSuanViewController.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import <CommonCrypto/CommonDigest.h>
#import "JXPayResultViewController.h"
@interface KTBWalletViewController ()

@end

@implementation KTBWalletViewController {
    
    UILabel *TotalAmountLab;
    UIButton *IsICanSeeBtn;
    BOOL isICanSee;
    UILabel *totalCashLab;
    UILabel *PuTongCashLab;
    UILabel *CashLabOne;
    UILabel *KuaiJieCashLab;
    UILabel *CashLabTwo;
    UILabel *WeiXinWalletLab;
    UILabel *WeiXinCashLab;
    UILabel *WeiXinT0WalletLab;
    UILabel *WeiXinT0CashLab;
    
    NSString *allBalance;
    NSString *t0AllBalance;
    NSString *t0EnBalance;
    NSString *t0UnBalance;
    NSString *t1AllBalance;
    NSString *t1EnBalance;
    NSString *t1UnBalance;
    NSString *t1AllBalanceQr;
    NSString *t1EnBalanceQr;
    NSString *t0AllBalanceQr;
    NSString *t0EnBalanceQr;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"钱包";
    self.view.backgroundColor = [UIColor whiteColor];
    //修改返回按钮
    UIBarButtonItem *left = [[UIBarButtonItem alloc] init];
    left.title = @"返回";
    self.navigationItem.backBarButtonItem = left;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    
    
    self.navigationController.navigationBar.barTintColor = NavBack;
    
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBackImg.png"] forBarMetrics:UIBarMetricsDefault];
    
    [self RequestForYuE];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"  返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    //[left setBackgroundImage:[UIImage imageNamed:@"Oval 2"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //UIBarButtonItem *l = [UIBarButtonItem alloc] ini;
    self.navigationItem.leftBarButtonItem = left;
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.barTintColor = NavBack;
    
    
    //
    UIScrollView *Scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    if(KscreenHeight < 568) {
        Scroll.contentSize = CGSizeMake(KscreenWidth, KscreenHeight + 130);
    }else {
        Scroll.contentSize = CGSizeMake(KscreenWidth, KscreenHeight + 70);
    }
    Scroll.showsHorizontalScrollIndicator = NO;
    Scroll.showsVerticalScrollIndicator = NO;
    Scroll.backgroundColor = LightGrayColor;
    [self.view addSubview:Scroll];
    
    UIImageView *BackImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    BackImgView.backgroundColor = LightGrayColor;
    BackImgView.userInteractionEnabled = YES;
    [Scroll addSubview:BackImgView];
    
    //账户总金额
    UIImageView *FirstWhiteBackImgView = [[UIImageView alloc] init];
    FirstWhiteBackImgView.backgroundColor = Color(253, 195, 40);
    [Scroll addSubview:FirstWhiteBackImgView];
    FirstWhiteBackImgView.sd_layout.leftSpaceToView(Scroll,0).topSpaceToView(Scroll,0).widthIs(KscreenWidth).heightIs(120);
    totalCashLab = [[UILabel alloc] init];
    totalCashLab.text = @"账户总金额(元)";
    totalCashLab.font = [UIFont systemFontOfSize:14];
    totalCashLab.textColor = [UIColor whiteColor];
    [Scroll addSubview:totalCashLab];
    totalCashLab.sd_layout.leftSpaceToView(Scroll,16).topSpaceToView(Scroll,15).widthIs(100).heightIs(15);
    TotalAmountLab = [[UILabel alloc] init];
    TotalAmountLab.text = @"0.00";
    TotalAmountLab.font = [UIFont systemFontOfSize:40];
    TotalAmountLab.textAlignment = NSTextAlignmentLeft;
    TotalAmountLab.textColor = [UIColor whiteColor];
    [Scroll addSubview:TotalAmountLab];
    TotalAmountLab.sd_layout.leftSpaceToView(Scroll,16).topSpaceToView(totalCashLab,20).widthIs(200).heightIs(40);
    
//    IsICanSeeBtn = [[UIButton alloc] init];
//    [IsICanSeeBtn setImage:[UIImage imageNamed:@"密码可见"] forState:UIControlStateNormal];
//    [IsICanSeeBtn addTarget:self action:@selector(TouchCanSee) forControlEvents:UIControlEventTouchUpInside];
//    isICanSee = YES;
//    [self.view addSubview:IsICanSeeBtn];
//    IsICanSeeBtn.sd_layout.rightSpaceToView(self.view,16).centerYEqualToView(FirstWhiteBackImgView).widthIs(35).heightIs(20);
    
    //卡通宝普通收款
    UIImageView *SecondWhiteBackView = [[UIImageView alloc] init];
    SecondWhiteBackView.backgroundColor = [UIColor whiteColor];
    SecondWhiteBackView.userInteractionEnabled = YES;
    [Scroll addSubview:SecondWhiteBackView];
    SecondWhiteBackView.sd_layout.leftSpaceToView(Scroll,0).topSpaceToView(FirstWhiteBackImgView,0).widthIs(KscreenWidth).heightIs(100);
    UILabel *PuTongLab = [[UILabel alloc] init];
    PuTongLab.text = @"无卡普通收款";
    PuTongLab.font = [UIFont systemFontOfSize:15];
    PuTongLab.textColor = [UIColor blackColor];
    [SecondWhiteBackView addSubview:PuTongLab];
    PuTongLab.sd_layout.leftSpaceToView(SecondWhiteBackView,16).topSpaceToView(SecondWhiteBackView,13.4).widthIs(200).heightIs(23.5);
    
    UILabel *AbleToCardMoneyLabOne = [[UILabel alloc] init];
    AbleToCardMoneyLabOne.text = @"可结算金额";
    AbleToCardMoneyLabOne.textColor = Color(149, 149, 150);
    AbleToCardMoneyLabOne.textAlignment = NSTextAlignmentRight;
    AbleToCardMoneyLabOne.font = [UIFont systemFontOfSize:14];
    [SecondWhiteBackView addSubview:AbleToCardMoneyLabOne];
   
    PuTongCashLab = [[UILabel alloc] init];
    PuTongCashLab.text = @"0.00";
    PuTongCashLab.textColor = Color(249, 19, 47);
    PuTongCashLab.font = [UIFont systemFontOfSize:14];
    [SecondWhiteBackView addSubview:PuTongCashLab];
    
    PuTongCashLab.sd_layout.rightSpaceToView(SecondWhiteBackView,16).topSpaceToView(SecondWhiteBackView,13.4).widthIs(60).heightIs(20);
    AbleToCardMoneyLabOne.sd_layout.rightSpaceToView(PuTongCashLab,5).topSpaceToView(SecondWhiteBackView,15.4).widthIs(100);
    //账户金额Lab
    UILabel *TipsLabOne = [[UILabel alloc] init];
    TipsLabOne.text = @"账户金额";
    TipsLabOne.font = [UIFont systemFontOfSize:12];
    TipsLabOne.textColor = Color(149, 149, 150);
    [SecondWhiteBackView addSubview:TipsLabOne];
    TipsLabOne.sd_layout.leftSpaceToView(SecondWhiteBackView,16).topSpaceToView(PuTongLab,20).widthIs(60).heightIs(10);
    //账户余额金额
    CashLabOne = [[UILabel alloc] init];
    CashLabOne.text = @"0.00";
    CashLabOne.textColor = Color(249, 19, 47);
    [SecondWhiteBackView addSubview:CashLabOne];
    CashLabOne.sd_layout.leftSpaceToView(SecondWhiteBackView,16).topSpaceToView(TipsLabOne,3).widthIs(60).heightIs(20);
    //结算按钮
    UIButton *PuTongJieSuanBtn = [[UIButton alloc] init];
    PuTongJieSuanBtn.tag = 100;
    PuTongJieSuanBtn.layer.cornerRadius = 3;
    PuTongJieSuanBtn.backgroundColor = [UIColor colorWithRed:53/255.0 green:105/255.0 blue:174/255.0 alpha:1];
    [PuTongJieSuanBtn setTitle:@"结算" forState:UIControlStateNormal];
    //[PuTongJieSuanBtn setTitleColor: forState:UIControlStateNormal];
    [PuTongJieSuanBtn addTarget:self action:@selector(ToJieSuan:) forControlEvents:UIControlEventTouchUpInside];
    [SecondWhiteBackView addSubview:PuTongJieSuanBtn];
    PuTongJieSuanBtn.sd_layout.rightSpaceToView(SecondWhiteBackView,20).bottomEqualToView(CashLabOne).widthIs(70).heightIs(30);
    
    //卡通宝快捷收款
    UIImageView *ThirdWhiteBackView = [[UIImageView alloc] init];
    ThirdWhiteBackView.backgroundColor = [UIColor whiteColor];
    ThirdWhiteBackView.userInteractionEnabled = YES;
    [Scroll addSubview:ThirdWhiteBackView];
    ThirdWhiteBackView.sd_layout.leftSpaceToView(Scroll,0).topSpaceToView(SecondWhiteBackView,5).widthIs(KscreenWidth).heightIs(100);
    
    UILabel *KuaiJieLab = [[UILabel alloc] init];
    KuaiJieLab.text = @"无卡快捷收款";
    KuaiJieLab.font = [UIFont systemFontOfSize:15];
    KuaiJieLab.textColor = [UIColor blackColor];
    [ThirdWhiteBackView addSubview:KuaiJieLab];
    KuaiJieLab.sd_layout.leftSpaceToView(ThirdWhiteBackView,16).topSpaceToView(ThirdWhiteBackView,13.4).widthIs(200).heightIs(23.5);
    
    UILabel *AbleToCardMoneyLabTwo = [[UILabel alloc] init];
    AbleToCardMoneyLabTwo.text = @"可结算金额";
    AbleToCardMoneyLabTwo.textColor = Color(149, 149, 150);
    AbleToCardMoneyLabTwo.textAlignment = NSTextAlignmentRight;
    AbleToCardMoneyLabTwo.font = [UIFont systemFontOfSize:14];
    [ThirdWhiteBackView addSubview:AbleToCardMoneyLabTwo];
    
    KuaiJieCashLab = [[UILabel alloc] init];
    KuaiJieCashLab.text = @"0.00";
    KuaiJieCashLab.textColor = Color(249, 19, 47);
    KuaiJieCashLab.font = [UIFont systemFontOfSize:14];
    [ThirdWhiteBackView addSubview:KuaiJieCashLab];
    
    KuaiJieCashLab.sd_layout.rightSpaceToView(ThirdWhiteBackView,16).topSpaceToView(ThirdWhiteBackView,13.4).widthIs(60).heightIs(20);
    AbleToCardMoneyLabTwo.sd_layout.rightSpaceToView(KuaiJieCashLab,5).topSpaceToView(ThirdWhiteBackView,15.4).widthIs(100);
    
    //账户金额Lab
    UILabel *TipsLabTwo = [[UILabel alloc] init];
    TipsLabTwo.text = @"账户金额";
    TipsLabTwo.textColor = Color(149, 149, 150);
    TipsLabTwo.font = [UIFont systemFontOfSize:12];
    [ThirdWhiteBackView addSubview:TipsLabTwo];
    TipsLabTwo.sd_layout.leftSpaceToView(ThirdWhiteBackView,16).topSpaceToView(KuaiJieLab,20).widthIs(60).heightIs(10);
    //账户余额金额
    CashLabTwo = [[UILabel alloc] init];
    CashLabTwo.text = @"0.00";
    CashLabTwo.textColor = Color(249, 19, 47);
    [ThirdWhiteBackView addSubview:CashLabTwo];
    CashLabTwo.sd_layout.leftSpaceToView(ThirdWhiteBackView,16).topSpaceToView(TipsLabTwo,3).widthIs(60).heightIs(20);
    //结算按钮
    UIButton *KuaiJieJieSuanBtn = [[UIButton alloc] init];
    KuaiJieJieSuanBtn.tag = 101;
    KuaiJieJieSuanBtn.layer.cornerRadius = 3;
    KuaiJieJieSuanBtn.backgroundColor = [UIColor colorWithRed:53/255.0 green:105/255.0 blue:174/255.0 alpha:1];
    [KuaiJieJieSuanBtn setTitle:@"结算" forState:UIControlStateNormal];
    //[PuTongJieSuanBtn setTitleColor: forState:UIControlStateNormal];
    [KuaiJieJieSuanBtn addTarget:self action:@selector(ToJieSuan:) forControlEvents:UIControlEventTouchUpInside];
    [ThirdWhiteBackView addSubview:KuaiJieJieSuanBtn];
    KuaiJieJieSuanBtn.sd_layout.rightSpaceToView(ThirdWhiteBackView,20).bottomEqualToView(CashLabTwo).widthIs(70).heightIs(30);
    
    
    //微信收款
    UIImageView *WeiXinWhiteBackView = [[UIImageView alloc] init];
    WeiXinWhiteBackView.backgroundColor = [UIColor whiteColor];
    WeiXinWhiteBackView.userInteractionEnabled = YES;
    [Scroll addSubview:WeiXinWhiteBackView];
    WeiXinWhiteBackView.sd_layout.leftSpaceToView(Scroll,0).topSpaceToView(ThirdWhiteBackView,5).widthIs(KscreenWidth).heightIs(100);
    
    UILabel *WeiXinLab = [[UILabel alloc] init];
    WeiXinLab.text = @"微信普通收款";
    WeiXinLab.font = [UIFont systemFontOfSize:15];
    WeiXinLab.textColor = [UIColor blackColor];
    [WeiXinWhiteBackView addSubview:WeiXinLab];
    WeiXinLab.sd_layout.leftSpaceToView(WeiXinWhiteBackView,16).topSpaceToView(WeiXinWhiteBackView,13.4).widthIs(200).heightIs(23.5);
    
    UILabel *WeiXinAbleToCardMoneyLabTwo = [[UILabel alloc] init];
    WeiXinAbleToCardMoneyLabTwo.text = @"可结算金额";
    WeiXinAbleToCardMoneyLabTwo.textColor = Color(149, 149, 150);
    WeiXinAbleToCardMoneyLabTwo.textAlignment = NSTextAlignmentRight;
    WeiXinAbleToCardMoneyLabTwo.font = [UIFont systemFontOfSize:14];
    [WeiXinWhiteBackView addSubview:WeiXinAbleToCardMoneyLabTwo];
    
    WeiXinWalletLab = [[UILabel alloc] init];
    WeiXinWalletLab.text = @"0.00";
    WeiXinWalletLab.textColor = Color(249, 19, 47);
    WeiXinWalletLab.font = [UIFont systemFontOfSize:14];
    [WeiXinWhiteBackView addSubview:WeiXinWalletLab];
    
    WeiXinWalletLab.sd_layout.rightSpaceToView(WeiXinWhiteBackView,16).topSpaceToView(WeiXinWhiteBackView,13.4).widthIs(60).heightIs(20);
    WeiXinAbleToCardMoneyLabTwo.sd_layout.rightSpaceToView(WeiXinWalletLab,5).topSpaceToView(WeiXinWhiteBackView,15.4).widthIs(100);
    
    //账户金额Lab
    UILabel *WeiXinTipsLabTwo = [[UILabel alloc] init];
    WeiXinTipsLabTwo.text = @"账户金额";
    WeiXinTipsLabTwo.textColor = Color(149, 149, 150);
    WeiXinTipsLabTwo.font = [UIFont systemFontOfSize:12];
    [WeiXinWhiteBackView addSubview:WeiXinTipsLabTwo];
    WeiXinTipsLabTwo.sd_layout.leftSpaceToView(WeiXinWhiteBackView,16).topSpaceToView(WeiXinLab,20).widthIs(60).heightIs(10);
    //账户余额金额
    WeiXinCashLab = [[UILabel alloc] init];
    WeiXinCashLab.text = @"0.00";
    WeiXinCashLab.textColor = Color(249, 19, 47);
    [WeiXinWhiteBackView addSubview:WeiXinCashLab];
    WeiXinCashLab.sd_layout.leftSpaceToView(WeiXinWhiteBackView,16).topSpaceToView(WeiXinTipsLabTwo,3).widthIs(60).heightIs(20);
    //结算按钮
    UIButton *WeiXinJieSuanBtn = [[UIButton alloc] init];
    WeiXinJieSuanBtn.tag = 102;
    WeiXinJieSuanBtn.layer.cornerRadius = 3;
    WeiXinJieSuanBtn.backgroundColor = [UIColor colorWithRed:53/255.0 green:105/255.0 blue:174/255.0 alpha:1];
    [WeiXinJieSuanBtn setTitle:@"结算" forState:UIControlStateNormal];
    //[PuTongJieSuanBtn setTitleColor: forState:UIControlStateNormal];
    [WeiXinJieSuanBtn addTarget:self action:@selector(ToJieSuan:) forControlEvents:UIControlEventTouchUpInside];
    [WeiXinWhiteBackView addSubview:WeiXinJieSuanBtn];
    WeiXinJieSuanBtn.sd_layout.rightSpaceToView(WeiXinWhiteBackView,20).bottomEqualToView(WeiXinCashLab).widthIs(70).heightIs(30);
    
    
    //微信快捷收款
    UIImageView *WeiXinT0WhiteBackView = [[UIImageView alloc] init];
    WeiXinT0WhiteBackView.backgroundColor = [UIColor whiteColor];
    WeiXinT0WhiteBackView.userInteractionEnabled = YES;
    [Scroll addSubview:WeiXinT0WhiteBackView];
    WeiXinT0WhiteBackView.sd_layout.leftSpaceToView(Scroll,0).topSpaceToView(WeiXinWhiteBackView,5).widthIs(KscreenWidth).heightIs(100);
    
    UILabel *WeiXinT0Lab = [[UILabel alloc] init];
    WeiXinT0Lab.text = @"微信快捷收款";
    WeiXinT0Lab.font = [UIFont systemFontOfSize:15];
    WeiXinT0Lab.textColor = [UIColor blackColor];
    [WeiXinT0WhiteBackView addSubview:WeiXinT0Lab];
    WeiXinT0Lab.sd_layout.leftSpaceToView(WeiXinT0WhiteBackView,16).topSpaceToView(WeiXinT0WhiteBackView,13.4).widthIs(200).heightIs(23.5);
    
    UILabel *WeiXinT0AbleToCardMoneyLabTwo = [[UILabel alloc] init];
    WeiXinT0AbleToCardMoneyLabTwo.text = @"可结算金额";
    WeiXinT0AbleToCardMoneyLabTwo.textColor = Color(149, 149, 150);
    WeiXinT0AbleToCardMoneyLabTwo.textAlignment = NSTextAlignmentRight;
    WeiXinT0AbleToCardMoneyLabTwo.font = [UIFont systemFontOfSize:14];
    [WeiXinT0WhiteBackView addSubview:WeiXinT0AbleToCardMoneyLabTwo];
    
    WeiXinT0WalletLab = [[UILabel alloc] init];
    WeiXinT0WalletLab.text = @"0.00";
    WeiXinT0WalletLab.textColor = Color(249, 19, 47);
    WeiXinT0WalletLab.font = [UIFont systemFontOfSize:14];
    [WeiXinT0WhiteBackView addSubview:WeiXinT0WalletLab];
    
    WeiXinT0WalletLab.sd_layout.rightSpaceToView(WeiXinT0WhiteBackView,16).topSpaceToView(WeiXinT0WhiteBackView,13.4).widthIs(60).heightIs(20);
    WeiXinT0AbleToCardMoneyLabTwo.sd_layout.rightSpaceToView(WeiXinT0WalletLab,5).topSpaceToView(WeiXinT0WhiteBackView,15.4).widthIs(100);
    
    //账户金额Lab
    UILabel *WeiXinT0TipsLabTwo = [[UILabel alloc] init];
    WeiXinT0TipsLabTwo.text = @"账户金额";
    WeiXinT0TipsLabTwo.textColor = Color(149, 149, 150);
    WeiXinT0TipsLabTwo.font = [UIFont systemFontOfSize:12];
    [WeiXinT0WhiteBackView addSubview:WeiXinT0TipsLabTwo];
    WeiXinT0TipsLabTwo.sd_layout.leftSpaceToView(WeiXinT0WhiteBackView,16).topSpaceToView(WeiXinT0Lab,20).widthIs(60).heightIs(10);
    //账户余额金额
    WeiXinT0CashLab = [[UILabel alloc] init];
    WeiXinT0CashLab.text = @"0.00";
    WeiXinT0CashLab.textColor = Color(249, 19, 47);
    [WeiXinT0WhiteBackView addSubview:WeiXinT0CashLab];
    WeiXinT0CashLab.sd_layout.leftSpaceToView(WeiXinT0WhiteBackView,16).topSpaceToView(WeiXinT0TipsLabTwo,3).widthIs(60).heightIs(20);
    //结算按钮
    UIButton *WeiXinT0JieSuanBtn = [[UIButton alloc] init];
    WeiXinT0JieSuanBtn.tag = 103;
    WeiXinT0JieSuanBtn.layer.cornerRadius = 3;
    WeiXinT0JieSuanBtn.backgroundColor = [UIColor colorWithRed:53/255.0 green:105/255.0 blue:174/255.0 alpha:1];
    [WeiXinT0JieSuanBtn setTitle:@"结算" forState:UIControlStateNormal];
    //[PuTongJieSuanBtn setTitleColor: forState:UIControlStateNormal];
    [WeiXinT0JieSuanBtn addTarget:self action:@selector(ToJieSuan:) forControlEvents:UIControlEventTouchUpInside];
    [WeiXinT0WhiteBackView addSubview:WeiXinT0JieSuanBtn];
    WeiXinT0JieSuanBtn.sd_layout.rightSpaceToView(WeiXinT0WhiteBackView,20).bottomEqualToView(WeiXinT0CashLab).widthIs(70).heightIs(30);

}
//金额是否可见
- (void)TouchCanSee {
    isICanSee = !isICanSee;
    if (isICanSee) {
        TotalAmountLab.text = [NSString stringWithFormat:@"%.2f",[allBalance floatValue]];
        PuTongCashLab.text = [NSString stringWithFormat:@"%.2f",[t1EnBalance floatValue]];
        CashLabOne.text = [NSString stringWithFormat:@"%.2f",[t1AllBalance floatValue]];
        KuaiJieCashLab.text = [NSString stringWithFormat:@"%.2f",[t0EnBalance floatValue]];
        CashLabTwo.text = [NSString stringWithFormat:@"%.2f",[t0AllBalance floatValue]];
        [IsICanSeeBtn setImage:[UIImage imageNamed:@"密码可见"] forState:UIControlStateNormal];
    }else {
        TotalAmountLab.text = @"******";
        PuTongCashLab.text = @"******";
        CashLabOne.text = @"******";
        KuaiJieCashLab.text = @"******";
        CashLabTwo.text = @"******";
        [IsICanSeeBtn setImage:[UIImage imageNamed:@"密码不可见"] forState:UIControlStateNormal];
    }
}

//结算方法
- (void)ToJieSuan:(UIButton *)btn {
    
    JieSuanViewController *JieSuanVc = [[JieSuanViewController alloc] init];
    if (btn.tag == 100) { //普通
        JieSuanVc.tag = 100;
        JieSuanVc.T1Money = t1EnBalance;
    }else if (btn.tag == 101){ //快捷
        JieSuanVc.tag = 101;
        JieSuanVc.T0Money = t0EnBalance;
    }else if (btn.tag == 102) { //微信普通
        JieSuanVc.tag = 102;
        JieSuanVc.T1Money = t1EnBalanceQr;
    }
    else if (btn.tag == 103){  //微信快捷
        JieSuanVc.tag = 103;
        JieSuanVc.T0Money = t0EnBalanceQr;
    }else {
        
    }
    JieSuanVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:JieSuanVc animated:YES];
    JieSuanVc.hidesBottomBarWhenPushed = NO;
//    JXPayResultViewController *PayResultVc = [[JXPayResultViewController alloc] init];
//    PayResultVc.tag = 103;
//    [self.navigationController pushViewController:PayResultVc animated:YES];
    
}

//结算
- (void)RequestForYuE {
    
    NSString *url = JXUrl;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *sign = [self md5HexDigest:key];
    NSDictionary *dic1 = @{
                          @"token":token,
                          @"sign":sign
                          };
    NSDictionary *dicc = @{
                           @"action":@"nocardSettleBalanceState",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSLog(@"数据:%@",result);
        NSDictionary *dic = [result JSONValue];
        NSString *code = dic[@"code"];
        NSString *content = dic[@"msg"];
        allBalance = dic[@"allBalance"];
        t0AllBalance = dic[@"t0AllBalanceNocard"];
        t0EnBalance = dic[@"t0EnBalanceNocard"];
        t0UnBalance = dic[@"t0UnBalanceNocard"];
        t1AllBalance = dic[@"t1AllBalanceNocard"];
        t1EnBalance = dic[@"t1EnBalanceNocard"];
        t1UnBalance = dic[@"t1UnBalanceNocard"];
        t1AllBalanceQr = dic[@"t1AllBalanceQr"];
        t1EnBalanceQr = dic[@"t1EnBalanceQr"];
        t0EnBalanceQr = dic[@"t0EnBalanceQr"];
        t0AllBalanceQr = dic[@"t0AllBalanceQr"];
        TotalAmountLab.text = [NSString stringWithFormat:@"%.2f",[allBalance floatValue]];
        PuTongCashLab.text = [NSString stringWithFormat:@"%.2f",[t1EnBalance floatValue]];
        CashLabOne.text = [NSString stringWithFormat:@"%.2f",[t1AllBalance floatValue]];
        KuaiJieCashLab.text = [NSString stringWithFormat:@"%.2f",[t0EnBalance floatValue]];
        CashLabTwo.text = [NSString stringWithFormat:@"%.2f",[t0AllBalance floatValue]];
        WeiXinCashLab.text = [NSString stringWithFormat:@"%.2f",[t1AllBalanceQr floatValue]];
        WeiXinWalletLab.text = [NSString stringWithFormat:@"%.2f",[t1EnBalanceQr floatValue]];
        WeiXinT0CashLab.text = [NSString stringWithFormat:@"%.2f",[t0AllBalanceQr floatValue]];
        WeiXinT0WalletLab.text = [NSString stringWithFormat:@"%.2f",[t0EnBalanceQr floatValue]];
        if ([content isEqualToString:@"Success"]) {
            content = @"密码修改成功！";
        }
            NSLog(@"返回的数据:%@",dic);
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

- (void)back{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
#define mark -

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
