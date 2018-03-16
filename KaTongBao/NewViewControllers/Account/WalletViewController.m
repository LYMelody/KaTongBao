//
//  WalletViewController.m
//  wujieNew
//
//  Created by rongfeng on 16/2/24.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "WalletViewController.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "IBHttpTool.h"
#import "SBJSON.h"
#import <CommonCrypto/CommonDigest.h>
#import "SVProgressHUD.h"
#import "BusiIntf.h"
#import "JieSuanViewController.h"
@interface WalletViewController ()

@end

@implementation WalletViewController {
    
    UILabel *WuJieT1AmoutLab;
    UILabel *WuJieAviLab;
    UILabel *WuJieT0AmoutLab;
    UILabel *WuJieAviT0Lab;
    UILabel *YinLianT0AmoutLab;
    UILabel *YinLianAviT0Lab;
    UILabel *ShuaShuaAviT0Lab;
    UILabel *ShuaShuaT0AmountLab;
    UILabel *KaShuaT1AmountLab;
    UILabel *KaShuaAviLab;
    
    JieSuanViewController *JieSuan;
    float accountValue;
    float settleValue;
    NSString *T1JieSuanMsg;
    NSString *T0JieSuanMsg;
    NSString *UP0JieSuanMsg;
    NSString *HST0JieSuanMsg;
    NSString *AN1jieSuanMsg;
}


- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
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
    
    //    self.navigationController.navigationBar.backgroundColor = DrackBlue;
    self.navigationController.navigationBar.barTintColor = DrackBlue;
    
    // [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBackImg.png"] forBarMetrics:UIBarMetricsDefault];
    JieSuan = [[JieSuanViewController alloc] init];
    [self RequestForYuE:@"RB1"];
    [self RequestForYuE:@"RB0"];
    [self RequestForYuE:@"UP0"];
    [self RequestForYuE:@"HST0"];
    [self RequestForYuE:@"AN1"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"  返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    //UIBarButtonItem *l = [UIBarButtonItem alloc] ini;
    self.navigationItem.leftBarButtonItem = left;
    self.navigationItem.hidesBackButton = YES;
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight + 50)];
    scroll.contentSize = CGSizeMake(KscreenWidth, KscreenHeight + 50 + 150 + 50);
    scroll.backgroundColor = LightGrayColor;
    scroll.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scroll];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *T1Url = [user objectForKey:@"T1url"];
    NSString *T0Url = [user objectForKey:@"T0url"];
    NSString *UP0Url = [user objectForKey:@"UP0url"];
    NSString *HST0Url=[user objectForKey:@"HST0url"];
    NSString *AN1Url = [user objectForKey:@"AN1url"];
    //无界普通
    UIImageView *WuJiePtImg = [[UIImageView alloc] init];
    WuJiePtImg.backgroundColor = [UIColor whiteColor];
    WuJiePtImg.userInteractionEnabled = YES;
    [scroll addSubview:WuJiePtImg];
    WuJiePtImg.sd_layout.leftSpaceToView(scroll,16).topSpaceToView(scroll,16).rightSpaceToView(scroll,16).heightIs(130);
    
    UILabel *WuJieT1Lab = [[UILabel alloc] init];
    WuJieT1Lab.text = @"无界支付普通收款";
    WuJieT1Lab.textColor = [UIColor orangeColor];
    WuJieT1Lab.font = [UIFont systemFontOfSize:14];
    [WuJiePtImg addSubview:WuJieT1Lab];
    WuJieT1Lab.sd_layout.leftSpaceToView(WuJiePtImg,12).topSpaceToView(WuJiePtImg,13.4).widthIs(112).heightIs(23.5);
    UIImageView *ImageOne = [[UIImageView alloc] init];
    ImageOne.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:T1Url]]];
    [WuJiePtImg addSubview:ImageOne];
    ImageOne.sd_layout.rightSpaceToView(WuJiePtImg,13).topSpaceToView(WuJiePtImg,9.5).widthIs(29).heightIs(29);
    WuJieT1AmoutLab = [[UILabel alloc] init];
    WuJieT1AmoutLab.text = @"账户金额:100";
    WuJieT1AmoutLab.font = [UIFont systemFontOfSize:14];
    WuJieT1AmoutLab.textColor = TextColor;
    [WuJiePtImg addSubview:WuJieT1AmoutLab];
    WuJieT1AmoutLab.sd_layout.leftSpaceToView(WuJiePtImg,12).topSpaceToView(WuJiePtImg,50.3).widthIs(93.5).heightIs(23.5);
    WuJieAviLab = [[UILabel alloc] init];
    WuJieAviLab.text = @"可结算金额:100";
    WuJieAviLab.textColor = TextColor;
    WuJieAviLab.font = [UIFont systemFontOfSize:14];
    [WuJiePtImg addSubview:WuJieAviLab];
    WuJieAviLab.sd_layout.leftSpaceToView(WuJiePtImg,11.5).topSpaceToView(WuJiePtImg,87.5).widthIs(110).heightIs(23.5);
    UIButton *Btn = [[UIButton alloc] init];
    Btn.layer.cornerRadius = 2.5;
    Btn.tag = 101;
    [Btn setBackgroundColor:[UIColor colorWithRed:18/255.0 green:103/255.0 blue:186/255.0 alpha:1]];
    [Btn setTitle:@"结算" forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(JieSuan:) forControlEvents:UIControlEventTouchUpInside];
    [WuJiePtImg addSubview:Btn];
    Btn.sd_layout.rightSpaceToView(WuJiePtImg,12).topSpaceToView(WuJiePtImg,87.2).widthIs(65).heightIs(32);
    
    //卡刷普通收款
    UIImageView *KaShuaT1 = [[UIImageView alloc] init];
    KaShuaT1.backgroundColor = [UIColor whiteColor];
    KaShuaT1.userInteractionEnabled = YES;
    [scroll addSubview:KaShuaT1];
    KaShuaT1.sd_layout.leftSpaceToView(scroll,16).topSpaceToView(scroll,166).rightSpaceToView(scroll,16).heightIs(130);

    UILabel *KaShuaT1Lab = [[UILabel alloc] init];
    KaShuaT1Lab.text = @"卡刷支付普通收款";
    KaShuaT1Lab.textColor = [UIColor orangeColor];
    KaShuaT1Lab.font = [UIFont systemFontOfSize:14];
    [KaShuaT1 addSubview:KaShuaT1Lab];
    KaShuaT1Lab.sd_layout.leftSpaceToView(KaShuaT1,12).topSpaceToView(KaShuaT1,13.4 ).widthIs(112).heightIs(23.5);
    UIImageView *KaShuaImageOne = [[UIImageView alloc] init];
    KaShuaImageOne.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:AN1Url]]];
    [KaShuaT1 addSubview:KaShuaImageOne];
    KaShuaImageOne.sd_layout.rightSpaceToView(KaShuaT1,13).topSpaceToView(KaShuaT1,9.5).widthIs(29).heightIs(29);
    KaShuaT1AmountLab = [[UILabel alloc] init];
    KaShuaT1AmountLab.text = @"账户金额:100";
    KaShuaT1AmountLab.font = [UIFont systemFontOfSize:14];
    KaShuaT1AmountLab.textColor = TextColor;
    [KaShuaT1 addSubview:KaShuaT1AmountLab];
    KaShuaT1AmountLab.sd_layout.leftSpaceToView(KaShuaT1,12).topSpaceToView(KaShuaT1,50.3).widthIs(93.5).heightIs(23.5);
    KaShuaAviLab = [[UILabel alloc] init];
    KaShuaAviLab.text = @"可结算金额:100";
    KaShuaAviLab.textColor = TextColor;
    KaShuaAviLab.font = [UIFont systemFontOfSize:14];
    [KaShuaT1 addSubview:KaShuaAviLab];
    KaShuaAviLab.sd_layout.leftSpaceToView(KaShuaT1,11.5).topSpaceToView(KaShuaT1,87.5).widthIs(110).heightIs(23.5);
    UIButton *KaShuaT1Btn = [[UIButton alloc] init];
    KaShuaT1Btn.layer.cornerRadius = 2.5;
    KaShuaT1Btn.tag = 105;
    [KaShuaT1Btn setBackgroundColor:[UIColor colorWithRed:18/255.0 green:103/255.0 blue:186/255.0 alpha:1]];
    [KaShuaT1Btn setTitle:@"结算" forState:UIControlStateNormal];
    [KaShuaT1Btn addTarget:self action:@selector(JieSuan:) forControlEvents:UIControlEventTouchUpInside];
    [KaShuaT1 addSubview:KaShuaT1Btn];
    KaShuaT1Btn.sd_layout.rightSpaceToView(KaShuaT1,12).topSpaceToView(KaShuaT1,87.2).widthIs(65).heightIs(32);
    
    //收款宝
    UIImageView *ShouKuanBaoImg = [[UIImageView alloc] init];
    ShouKuanBaoImg.backgroundColor =[UIColor whiteColor];
    [scroll addSubview:ShouKuanBaoImg];
    ShouKuanBaoImg.sd_layout.leftSpaceToView(scroll,16).rightSpaceToView(scroll,16).topSpaceToView(scroll,166.5 + 150).heightIs(75.5);
    UILabel *ShouKuanLab = [[UILabel alloc] init];
    ShouKuanLab.text = @"收款宝";
    ShouKuanLab.font = [UIFont systemFontOfSize:14];
    ShouKuanLab.textColor = [UIColor orangeColor];
    [ShouKuanBaoImg addSubview:ShouKuanLab];
    ShouKuanLab.sd_layout.leftSpaceToView(ShouKuanBaoImg,10.5).topSpaceToView(ShouKuanBaoImg,5.5).widthIs(42).heightIs(17.5);
    
    UILabel *TipSLab = [[UILabel alloc] init];
    TipSLab.textColor = TextColor;
    TipSLab.text = @"收款宝余额T+1自动到账";
    TipSLab.font = [UIFont systemFontOfSize:13];
    TipSLab.textAlignment = NSTextAlignmentRight;
    [ShouKuanBaoImg addSubview:TipSLab];
    TipSLab.sd_layout.rightSpaceToView(ShouKuanBaoImg,13.5).topSpaceToView(ShouKuanBaoImg,23).widthIs(200).heightIs(17.5);
    
    UILabel *TipsLab2 = [[UILabel alloc] init];
    TipsLab2.textColor = TextColor;
    TipsLab2.text = @"账单详情请前往收款宝查看";
    TipsLab2.font = [UIFont systemFontOfSize:13];
    TipsLab2.textAlignment = NSTextAlignmentRight;
    [ShouKuanBaoImg addSubview:TipsLab2];
    TipsLab2.sd_layout.rightSpaceToView(ShouKuanBaoImg,13.5).topSpaceToView(TipSLab,5).widthIs(200).heightIs(17.5);
    
    //无界支付快捷收款
    UIImageView *WuJieT0Img = [[UIImageView alloc] init];
    WuJieT0Img.backgroundColor = [UIColor whiteColor];
    WuJieT0Img.userInteractionEnabled = YES;
    [scroll addSubview:WuJieT0Img];
    WuJieT0Img.sd_layout.leftSpaceToView(scroll,16).topSpaceToView(scroll,233 + 30 + 150).rightSpaceToView(scroll,16).heightIs(130);
    
    UILabel *WuJieT0Lab = [[UILabel alloc] init];
    WuJieT0Lab.text = @"无界支付快捷收款";
    WuJieT0Lab.textColor = [UIColor orangeColor];
    WuJieT0Lab.font = [UIFont systemFontOfSize:14];
    [WuJieT0Img addSubview:WuJieT0Lab];
    WuJieT0Lab.sd_layout.leftSpaceToView(WuJieT0Img,12).topSpaceToView(WuJieT0Img,13.4).widthIs(112).heightIs(23.5);
    UIImageView *ImageTwo = [[UIImageView alloc] init];
    ImageTwo.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:T0Url]]];
    [WuJieT0Img addSubview:ImageTwo];
    ImageTwo.sd_layout.rightSpaceToView(WuJieT0Img,13).topSpaceToView(WuJieT0Img,9.5).widthIs(29).heightIs(29);
    WuJieT0AmoutLab = [[UILabel alloc] init];
    WuJieT0AmoutLab.text = @"账户金额:100";
    WuJieT0AmoutLab.font = [UIFont systemFontOfSize:14];
    WuJieT0AmoutLab.textColor = TextColor;
    [WuJieT0Img addSubview:WuJieT0AmoutLab];
    WuJieT0AmoutLab.sd_layout.leftSpaceToView(WuJieT0Img,12).topSpaceToView(WuJieT0Img,50.3).widthIs(93.5).heightIs(23.5);
    WuJieAviT0Lab = [[UILabel alloc] init];
    WuJieAviT0Lab.text = @"可结算金额:100";
    WuJieAviT0Lab.textColor = TextColor;
    WuJieAviT0Lab.font = [UIFont systemFontOfSize:14];
    [WuJieT0Img addSubview:WuJieAviT0Lab];
    WuJieAviT0Lab.sd_layout.leftSpaceToView(WuJieT0Img,11.5).topSpaceToView(WuJieT0Img,87.5).widthIs(110).heightIs(23.5);
    UIButton *T0Btn = [[UIButton alloc] init];
    T0Btn.layer.cornerRadius = 2.5;
    T0Btn.tag = 102;
    [T0Btn setBackgroundColor:[UIColor colorWithRed:18/255.0 green:103/255.0 blue:186/255.0 alpha:1]];
    [T0Btn setTitle:@"结算" forState:UIControlStateNormal];
    [T0Btn addTarget:self action:@selector(JieSuan:) forControlEvents:UIControlEventTouchUpInside];
    [WuJieT0Img addSubview:T0Btn];
    T0Btn.sd_layout.rightSpaceToView(WuJieT0Img,12).topSpaceToView(WuJieT0Img,87.2).widthIs(65).heightIs(32);
    
    //唰唰支付快捷收款
    UIImageView *ShuaShuaImg = [[UIImageView alloc] init];
    ShuaShuaImg.backgroundColor = [UIColor whiteColor];
    ShuaShuaImg.userInteractionEnabled = YES;
    [scroll addSubview:ShuaShuaImg];
    ShuaShuaImg.sd_layout.leftSpaceToView(scroll,16).topSpaceToView(scroll,393 + 30 + 150).rightSpaceToView(scroll,16).heightIs(130);
    
    UILabel *ShuaShuaT0Lab = [[UILabel alloc] init];
    ShuaShuaT0Lab.text = @"卡刷支付快捷收款";
    ShuaShuaT0Lab.textColor = [UIColor orangeColor];
    ShuaShuaT0Lab.font = [UIFont systemFontOfSize:14];
    [ShuaShuaImg addSubview:ShuaShuaT0Lab];
    ShuaShuaT0Lab.sd_layout.leftSpaceToView(ShuaShuaImg,12).topSpaceToView(ShuaShuaImg,13.4).widthIs(112).heightIs(23.5);
    
    UIImageView *ShuaShuaTwo = [[UIImageView alloc] init];
    ShuaShuaTwo.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:HST0Url]]];
    [ShuaShuaImg addSubview:ShuaShuaTwo];
    ShuaShuaTwo.sd_layout.rightSpaceToView(ShuaShuaImg,13).topSpaceToView(ShuaShuaImg,9.5).widthIs(29).heightIs(29);
    
    ShuaShuaT0AmountLab = [[UILabel alloc] init];
    ShuaShuaT0AmountLab.text = @"账户金额:100";
    ShuaShuaT0AmountLab.font = [UIFont systemFontOfSize:14];
    ShuaShuaT0AmountLab.textColor = TextColor;
    [ShuaShuaImg addSubview:ShuaShuaT0AmountLab];
    ShuaShuaT0AmountLab.sd_layout.leftSpaceToView(ShuaShuaImg,12).topSpaceToView(ShuaShuaImg,50.3).widthIs(93.5).heightIs(23.5);
    ShuaShuaAviT0Lab = [[UILabel alloc] init];
    ShuaShuaAviT0Lab.text = @"可结算金额:100";
    ShuaShuaAviT0Lab.textColor = TextColor;
    ShuaShuaAviT0Lab.font = [UIFont systemFontOfSize:14];
    [ShuaShuaImg addSubview:ShuaShuaAviT0Lab];
    ShuaShuaAviT0Lab.sd_layout.leftSpaceToView(ShuaShuaImg,11.5).topSpaceToView(ShuaShuaImg,87.5).widthIs(110).heightIs(23.5);
    
    UIButton *ShuaShuaBtn = [[UIButton alloc] init];
    ShuaShuaBtn.layer.cornerRadius = 2.5;
    ShuaShuaBtn.tag = 104;
    [ShuaShuaBtn setBackgroundColor:[UIColor colorWithRed:18/255.0 green:103/255.0 blue:186/255.0 alpha:1]];
    [ShuaShuaBtn setTitle:@"结算" forState:UIControlStateNormal];
    [ShuaShuaBtn addTarget:self action:@selector(JieSuan:) forControlEvents:UIControlEventTouchUpInside];
    [ShuaShuaImg addSubview:ShuaShuaBtn];
    ShuaShuaBtn.sd_layout.rightSpaceToView(ShuaShuaImg,12).topSpaceToView(ShuaShuaImg,87.2).widthIs(65).heightIs(32);
    
    //银联支付快捷收款
//    UIImageView *YinLianT0Img = [[UIImageView alloc] init];
//    YinLianT0Img.backgroundColor = [UIColor whiteColor];
//    YinLianT0Img.userInteractionEnabled = YES;
//    [scroll addSubview:YinLianT0Img];
//    YinLianT0Img.sd_layout.leftSpaceToView(scroll,16).topSpaceToView(scroll,384).rightSpaceToView(scroll,16).heightIs(130);
//    
//    UILabel *YinLianT0Lab = [[UILabel alloc] init];
//    YinLianT0Lab.text = @"银联支付快捷收款";
//    YinLianT0Lab.textColor = [UIColor orangeColor];
//    YinLianT0Lab.font = [UIFont systemFontOfSize:14];
//    [YinLianT0Img addSubview:YinLianT0Lab];
//    YinLianT0Lab.sd_layout.leftSpaceToView(YinLianT0Img,12).topSpaceToView(YinLianT0Img,13.4).widthIs(112).heightIs(23.5);
//    UIImageView *ImageThree = [[UIImageView alloc] init];
//    ImageThree.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:UP0Url]]];
//    [YinLianT0Img addSubview:ImageThree];
//    ImageThree.sd_layout.rightSpaceToView(YinLianT0Img,13).topSpaceToView(YinLianT0Img,9.5).widthIs(29).heightIs(29);
//    YinLianT0AmoutLab = [[UILabel alloc] init];
//    YinLianT0AmoutLab.text = @"账户金额:100";
//    YinLianT0AmoutLab.font = [UIFont systemFontOfSize:14];
//    YinLianT0AmoutLab.textColor = TextColor;
//    [YinLianT0Img addSubview:YinLianT0AmoutLab];
//    YinLianT0AmoutLab.sd_layout.leftSpaceToView(YinLianT0Img,12).topSpaceToView(YinLianT0Img,50.3).widthIs(93.5).heightIs(23.5);
//    YinLianAviT0Lab = [[UILabel alloc] init];
//    YinLianAviT0Lab.text = @"可结算金额:100";
//    YinLianAviT0Lab.textColor = TextColor;
//    YinLianAviT0Lab.font = [UIFont systemFontOfSize:14];
//    [YinLianT0Img addSubview:YinLianAviT0Lab];
//    YinLianAviT0Lab.sd_layout.leftSpaceToView(YinLianT0Img,11.5).topSpaceToView(YinLianT0Img,87.5).widthIs(110).heightIs(23.5);
//    
//    UIButton *YinLianT0Btn = [[UIButton alloc] init];
//    YinLianT0Btn.layer.cornerRadius = 2.5;
//    YinLianT0Btn.tag = 103;
//    [YinLianT0Btn setBackgroundColor:[UIColor colorWithRed:18/255.0 green:103/255.0 blue:186/255.0 alpha:1]];
//    [YinLianT0Btn setTitle:@"结算" forState:UIControlStateNormal];
//    [YinLianT0Btn addTarget:self action:@selector(JieSuan:) forControlEvents:UIControlEventTouchUpInside];
//    [YinLianT0Img addSubview:YinLianT0Btn];
//    YinLianT0Btn.sd_layout.rightSpaceToView(YinLianT0Img,12).topSpaceToView(YinLianT0Img,87.2).widthIs(65).heightIs(32);

    [self RequestForMsg:@"RB1"];
    [self RequestForMsg:@"RB0"];
    [self RequestForMsg:@"HST0"];
    [self RequestForMsg:@"AN1"];
    
}
- (void)JieSuan:(UIButton *)btn {
    
    if(btn.tag ==101) {
        [BusiIntf curPayOrder].TypeOrder = @"RB1";
        JieSuan.T1msg = T1JieSuanMsg;
    }else if(btn.tag == 102) {
        [BusiIntf curPayOrder].TypeOrder = @"RB0";
        JieSuan.T0msg = T0JieSuanMsg;
    }else if (btn.tag == 103) {
        [BusiIntf curPayOrder].TypeOrder = @"UP0";
        JieSuan.UP0msg = UP0JieSuanMsg;
    }else if(btn.tag==104){
        [BusiIntf curPayOrder].TypeOrder=@"HST0";
        JieSuan.HST0msg =HST0JieSuanMsg;
    }else if (btn.tag == 105) {
        [BusiIntf curPayOrder].TypeOrder=@"AN1";
        JieSuan.AN1msg = AN1jieSuanMsg;
    }
    else
    {
        
    }
    [self.navigationController pushViewController:JieSuan animated:YES];

}

- (void)back{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
//余额查询
- (void)RequestForYuE:(NSString *)type {
    [SVProgressHUD show];
    NSString *url = BaseUrl;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    //NSString *orderNo = [user objectForKey:@"orderNo"];
    NSString *md5 = [NSString stringWithFormat:@"%@%@",type,key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                           @"type":type,
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"SettleBalance",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    NSLog(@"参数：%@",params);
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSDictionary *dicc = [result JSONValue];
        NSLog(@"订单列表：%@",dicc);
         accountValue = [dicc[@"accountBalance"] floatValue];
         settleValue = [dicc[@"settleBalance"] floatValue];
        if ([type isEqualToString:@"RB1"]) {
            WuJieT1AmoutLab.text = [NSString stringWithFormat:@"账户金额:%2.f",accountValue];
            WuJieAviLab.text = [NSString stringWithFormat:@"可结算余额:%2.f",settleValue];
            JieSuan.T1Money = [NSString stringWithFormat:@"%2.f元",settleValue];
        }else if ([type isEqualToString:@"RB0"]) {
            WuJieT0AmoutLab.text = [NSString stringWithFormat:@"账户金额:%2.f",accountValue];
            WuJieAviT0Lab.text = [NSString stringWithFormat:@"可结算余额:%2.f",settleValue];
            JieSuan.T0Money = [NSString stringWithFormat:@"%2.f元",settleValue];
        }else if ([type isEqualToString:@"UP0"]) {
            YinLianT0AmoutLab.text = [NSString stringWithFormat:@"账户金额:%2.f",accountValue];
            YinLianAviT0Lab.text = [NSString stringWithFormat:@"可结算余额:%2.f",settleValue];
            JieSuan.YinLianMoney = [NSString stringWithFormat:@"%2.f元",settleValue];
        }else if([type isEqualToString:@"HST0"]) {
            ShuaShuaAviT0Lab.text=[NSString stringWithFormat:@"可结算余额:%2.f",settleValue];
            ShuaShuaT0AmountLab.text=[NSString stringWithFormat:@"账户金额:%2.f",accountValue];
            JieSuan.HST0Money=[NSString stringWithFormat:@"%2.f元",settleValue];
        }else if ([type isEqualToString:@"AN1"]) {
            KaShuaT1AmountLab.text = [NSString stringWithFormat:@"账户金额:%2.f",accountValue];
            KaShuaAviLab.text = [NSString stringWithFormat:@"可结算余额:%2.f",settleValue];
            JieSuan.AN1Money = [NSString stringWithFormat:@"%2.f元",settleValue];
        }
        
    [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"网络申请失败:%@",error);
        [SVProgressHUD dismiss];
    }];
}
//结算信息
- (void)RequestForMsg:(NSString *)Type {
    
    NSString *url = BaseUrl;
    [SVProgressHUD show];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    //NSString *orderno = [user objectForKey:@"orderNo"];
    NSString *md5 = [NSString stringWithFormat:@"%@%@",Type,key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic = @{
                          @"token":token,
                          @"sign":sign,
                          @"orderType":Type
                          };
    NSDictionary *dicc = @{
                           @"action":@"SettleInfo",
                           @"data":dic
                           };
    NSString *params = [dicc JSONFragment];
    
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSDictionary *dicc = [result JSONValue];
        // NSString *code = dicc[@"code"];
        NSString *content = dicc[@"content"];
        NSLog(@"获取到的信息:%@",content);
        if ([Type isEqualToString:@"RB1"]) {
            T1JieSuanMsg = content;
        }else if ([Type isEqualToString:@"RB0"]) {
            T0JieSuanMsg = content;
        }else if ([Type isEqualToString:@"UP0"]) {
            UP0JieSuanMsg = content;
        }else if([Type isEqualToString:@"HST0"]){
            HST0JieSuanMsg =content;
        }else if ([Type isEqualToString:@"AN1"]) {
            AN1jieSuanMsg = content;
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"请求失败:%@",error);
        [self alert:@"请求网络失败！"];
        [SVProgressHUD dismiss];
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
