//
//  JXWalletViewController.m
//  JingXuan
//
//  Created by rongfeng on 16/6/6.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "JXWalletViewController.h"
#import "Common.h"
#import "macro.h"
#import "UIView+SDAutoLayout.h"
#import "BusiIntf.h"
#import "JXJieSuanViewController.h"
#import "KTBWalletViewController.h"
@interface JXWalletViewController ()

@end

@implementation JXWalletViewController {
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
    
    JXJieSuanViewController *JieSuan;
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
    
    //    self.navigationController.navigationBar.backgroundColor = DrackBlue;
    self.navigationController.navigationBar.barTintColor = NavBack;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBackImg.png"] forBarMetrics:UIBarMetricsDefault];
    JieSuan = [[JXJieSuanViewController alloc] init];
//    [self RequestForYuE:@"RB1"];
//    [self RequestForYuE:@"RB0"];
//    [self RequestForYuE:@"UP0"];
//    [self RequestForYuE:@"HST0"];
//    [self RequestForYuE:@"AN1"];
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

}

- (void)back{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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
