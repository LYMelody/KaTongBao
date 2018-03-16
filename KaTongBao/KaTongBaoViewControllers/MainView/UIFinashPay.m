//
//  UIFinashPay.m
//  wujie
//
//  Created by rongfeng on 15/11/23.
//  Copyright © 2015年 ND. All rights reserved.
//

#import "UIFinashPay.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
//#import "UIManager.h"
//#import "UIWallet.h"
#import "TDMyMainViewController.h"
#import "WalletVC.h"
#import "WalletViewController.h"
@interface UIFinashPay ()

@end

@implementation UIFinashPay

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self addBackBtn];
    self.navigationItem.hidesBackButton = YES;
    
    self.title = @"支付结果";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"首页" forState:UIControlStateNormal];
    button.backgroundColor = Green58;
    [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.tag = 1005;
    button.layer.cornerRadius = 4;
    [self.view addSubview:button];
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"钱包" forState:UIControlStateNormal];
    btn.backgroundColor = Green58;
    [btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.tag = 1006;
    btn.layer.cornerRadius = 4;
    [self.view addSubview:btn];
    
    UILabel *label = [[UILabel alloc] init];
    if (self.tag == 100) {
        label.text = @"激活成功";
    }else {
        label.text = @"支付完成";
    }
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    
    UILabel *displayLabel = [[UILabel alloc] init];
    if (label.tag == 100) {
        displayLabel.text = @"恭喜！您已激活完成";
    }else {
        displayLabel.text = @"恭喜! 您已完成支付";
    }
    
    displayLabel.font = [UIFont systemFontOfSize:15];
    displayLabel.textColor = [UIColor blackColor];
    [self.view addSubview:displayLabel];
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.backgroundColor = Green58;
    //imgView.frame = CGRectMake(115, 93, 90, 90);
    imgView.layer.cornerRadius = 45;
    imgView.image = [UIImage imageNamed:@"wkzf_pay_success.png"];
    
    [self.view addSubview:imgView];
    
    label.sd_layout.leftSpaceToView(self.view,120).topSpaceToView(self.view,203).widthIs(80).heightIs(30);
    displayLabel.sd_layout.leftSpaceToView(self.view,92.5).topSpaceToView(self.view,241.5).widthIs(135).heightIs(21);
    button.sd_layout.leftSpaceToView(self.view,20).topSpaceToView(self.view,312.5).widthIs(90).heightIs(40);
    btn.sd_layout.rightSpaceToView(self.view,20).topSpaceToView(self.view,312.5).widthIs(90).heightIs(40);
    imgView.sd_layout.leftSpaceToView(self.view,115).topSpaceToView(self.view,93).widthIs(90).heightIs(90);
}

- (void)back:(UIButton *)btn {
    
    if (btn.tag == 1005) {
        //[UIManager doNavWnd:WndPayMain];
//        self.navigationController
        TDMyMainViewController *Main = [[TDMyMainViewController alloc] init];
        [self.navigationController pushViewController:Main animated:YES];
    }else if (btn.tag == 1006) {
       //[UIManager doNavWnd:WndWallet];
        WalletViewController *wallect = [[WalletViewController alloc] init];
        [self.navigationController pushViewController:wallect animated:YES];
    }
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
