//
//  JieSuanSuccViewController.m
//  wujieNew
//
//  Created by rongfeng on 16/2/25.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "JieSuanSuccViewController.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
@interface JieSuanSuccViewController ()

@end

@implementation JieSuanSuccViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] init];
    left.title = @"返回";
    self.navigationItem.backBarButtonItem = left;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    
    //    self.navigationController.navigationBar.backgroundColor = DrackBlue;
    self.navigationController.navigationBar.barTintColor = DrackBlue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"结算结果";
    
    UIImageView *backImg = [[UIImageView alloc] init];
    backImg.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    backImg.backgroundColor = LightGrayColor;
    [self.view addSubview:backImg];
    
    UILabel *Lab = [[UILabel alloc] init];
    Lab.text =self.Msg;
    Lab.textColor = Color(58, 146, 15);
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:Lab];
    Lab.sd_layout.leftSpaceToView(self.view,50).rightSpaceToView(self.view,50).topSpaceToView(self.view,157).heightIs(26);
    
    UIButton *QureBtn = [[UIButton alloc] init];
    [QureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [QureBtn setBackgroundColor:Color(18, 103, 186)];
    QureBtn.layer.cornerRadius = 3;
    [QureBtn addTarget:self action:@selector(ToWallet) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:QureBtn];
    QureBtn.sd_layout.leftSpaceToView(self.view,35).rightSpaceToView(self.view,35).topSpaceToView(self.view,308).heightIs(40);
    
    // Do any additional setup after loading the view.
}

- (void)ToWallet {
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:([self.navigationController.viewControllers count] -3)] animated:YES];
    
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
