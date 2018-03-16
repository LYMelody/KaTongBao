//
//  ActivationViewController.m
//  JingXuan
//
//  Created by wj on 16/5/18.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "ActivationViewController.h"
#import "macro.h"
#import "ActivationView.h"
#import "AccountActiveViewController.h"

@interface ActivationViewController ()

@end

@implementation ActivationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBaseVCAttributes:@"账户激活" withLeftName:@"返回" withRightName:nil withColor:NavBack];
    self.view.backgroundColor = LightGrayColor;
    ActivationView *activation = [[ActivationView alloc] initWithFrame:CGRectMake(0, 64, KscreenWidth, KscreenHeight)];
    [activation.paymentBtn addTarget:self action:@selector(paymentClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:activation];
}

- (void)paymentClick:(UIButton *)sender {
    AccountActiveViewController *account = [[AccountActiveViewController alloc]init];
    [self.navigationController pushViewController:account animated:YES];
}

- (void)leftEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- 设置tabBar消失
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.view endEditing:YES];
//}
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
