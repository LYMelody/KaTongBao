//
//  JXCardManagerViewController.m
//  JingXuan
//
//  Created by rongfeng on 16/6/1.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "JXCardManagerViewController.h"
#import "macro.h"
//#import <GFDPlugin/GFDPlugin.h>
#import "BusiIntf.h"
#import "UIView+SDAutoLayout.h"
@interface JXCardManagerViewController ()

@end

@implementation JXCardManagerViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = NavBack;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.hidden = NO;
    //self.tabBarController.tabBar.hidden = YES;
    //自定义返回按钮
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    right.title = @"返回";
    self.navigationItem.backBarButtonItem = right;
    self.title = @"卡管理";
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    UIButton *GFDBtn = [[UIButton alloc] init];
    [GFDBtn setTitle:@"功夫贷" forState:UIControlStateNormal];
    GFDBtn.layer.cornerRadius = 3;
    GFDBtn.backgroundColor = NavBack;
    [GFDBtn addTarget:self action:@selector(GFD) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:GFDBtn];
    GFDBtn.sd_layout.leftSpaceToView(self.view,30).topSpaceToView(self.view,100).rightSpaceToView(self.view,30).heightIs(50);
    
    // Do any additional setup after loading the view.
}

- (void)GFD {
    
    NSLog(@"用户名:%@",[BusiIntf getUserInfo].UserName);
    //[[GFDPlugin sharedInstance] showOnNavigateController:self.navigationController phone:[BusiIntf getUserInfo].UserName];
    
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
