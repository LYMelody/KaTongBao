//
//  WalletVC.m
//  wujieNew
//
//  Created by rongfeng on 15/12/24.
//  Copyright © 2015年 rongfeng. All rights reserved.
//

#import "WalletVC.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "YuEVC.h"
@implementation WalletVC

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
    
    
}

- (void)viewDidLoad {
    
    
    UIImageView *BackImg = [[UIImageView alloc] init];
    BackImg.backgroundColor = Color(115, 126, 144);
    [self.view addSubview:BackImg];
    BackImg.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,43.5+20).heightIs(124);
    //
    UIButton *Btn = [[UIButton alloc] init];
    [Btn setImage:[UIImage imageNamed:@"账户.png"] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(Account) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Btn];
    Btn.sd_layout.leftSpaceToView(self.view,46.5).topSpaceToView(self.view,85).widthIs(49.5).heightIs(48);
    UILabel *AccountLab = [[UILabel alloc] init];
    AccountLab.text = @"账户";
    AccountLab.font = [UIFont systemFontOfSize:17];
    AccountLab.textColor = [UIColor whiteColor];
    [self.view addSubview:AccountLab];
    AccountLab.sd_layout.leftSpaceToView(self.view,56.5).topSpaceToView(self.view,143).widthIs(34).heightIs(18);
    UIButton *BankBtn = [[UIButton alloc] init];
    [BankBtn setImage:[UIImage imageNamed:@"银行卡.png"] forState:UIControlStateNormal];
    [BankBtn addTarget:self action:@selector(Account) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:BankBtn];
    BankBtn.sd_layout.leftSpaceToView(self.view,220.5).topSpaceToView(self.view,85).widthIs(49.5).heightIs(48);
    UILabel *BankLab = [[UILabel alloc] init];
    BankLab.text = @"银行卡";
    BankLab.font = [UIFont systemFontOfSize:17];
    BankLab.textColor = [UIColor whiteColor];
    [self.view addSubview:BankLab];
    BankLab.sd_layout.leftSpaceToView(self.view,226).topSpaceToView(self.view,143).widthIs(51).heightIs(18);
    //无界服务
    UIImageView *ImageView = [[UIImageView alloc] init];
    ImageView.backgroundColor = LightGrayColor;
    [self.view addSubview:ImageView];
    ImageView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view, 189).heightIs(35);
    UILabel *WuJieLab = [[UILabel alloc] init];
    WuJieLab.text = @"无界服务";
    WuJieLab.textColor = Gray136;
    [ImageView addSubview:WuJieLab];
    WuJieLab.sd_layout.leftSpaceToView(ImageView,20.5).topSpaceToView(ImageView,7.5).widthIs(80).heightIs(17.5);
    
    UIButton *YuEBtn = [[UIButton alloc] init];
    [YuEBtn setImage:[UIImage imageNamed:@"余额.png"] forState:UIControlStateNormal];
    [YuEBtn setImage:[UIImage imageNamed:@"余额.png"] forState:UIControlStateHighlighted];
    [YuEBtn addTarget:self action:@selector(YuE) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:YuEBtn];
    YuEBtn.sd_layout.leftSpaceToView(self.view,30).topSpaceToView(self.view,242).widthIs(75).heightIs(75);
    UIButton *PakgeBtn = [[UIButton alloc] init];
    [PakgeBtn setImage:[UIImage imageNamed:@"红包.png"] forState:UIControlStateNormal];
    [PakgeBtn setImage:[UIImage imageNamed:@"红包.png"] forState:UIControlStateHighlighted];
    [PakgeBtn addTarget:self action:@selector(RedPakge) forControlEvents:UIControlEventTouchUpInside];
    PakgeBtn.backgroundColor = RedColor;
    [self.view addSubview:PakgeBtn];
    PakgeBtn.sd_layout.leftSpaceToView(self.view,122.5).topSpaceToView(self.view,242).widthIs(75).heightIs(75);
    UIButton *TransportBtn = [[UIButton alloc] init];
    [TransportBtn setImage:[UIImage imageNamed:@"3.png"] forState:UIControlStateNormal];
    [TransportBtn setImage:[UIImage imageNamed:@"3.png"] forState:UIControlStateHighlighted];
    [TransportBtn addTarget:self action:@selector(Transport) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:TransportBtn];
    TransportBtn.sd_layout.leftSpaceToView(self.view,215).topSpaceToView(self.view,242).widthIs(75).heightIs(75);
}
//余额转出
- (void)YuE {
    NSLog(@"*************");
    YuEVC *Yue = [[YuEVC alloc] init];
    [self.navigationController pushViewController:Yue animated:YES];
}
//账户和银行卡
- (void)Account {
    
    [self alert:@"正在建设中..."];
    
}
//红包
- (void)RedPakge {
    [self alert:@"正在建设中..."];
}

//余额转出
- (void)Transport {
    [self alert:@"正在建设中..."];
}

- (void)alert:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
}

@end
