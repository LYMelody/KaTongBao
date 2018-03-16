//
//  RealNameViewController.m
//  JingXuan
//
//  Created by wj on 16/5/18.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "RealNameViewController.h"
#import "BasicInformationViewController.h"
#import "InformationView.h"
#import "macro.h"
#import "ActivationViewController.h"
@interface RealNameViewController ()

@property (nonatomic, strong) NSArray * informationArr;
@property (nonatomic, strong) NSArray *detialArr;

@end

@implementation RealNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setBaseVCAttributes:@"实名认证" withLeftName:@"返回" withRightName:nil withColor:NavBack];
    self.view.backgroundColor = LightGrayColor;
    [self initView];
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(10, KscreenHeight-100, KscreenWidth - 20, 50);
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    submitButton.backgroundColor = [UIColor colorWithRed:16/255.0 green:101/255.0 blue:167/255.0 alpha:1];
    submitButton.clipsToBounds = YES;
    submitButton.layer.cornerRadius = 5;
    [self.view addSubview:submitButton];
}

- (void)initView {
    
    
    self.informationArr = [NSArray arrayWithObjects:@"基本信息",@"账户激活", nil];
    self.detialArr = [NSArray arrayWithObjects:@"已认证", @"激活成功", nil];
    for (int i = 0; i < 2; i ++) {
        InformationView *view = [[InformationView alloc]initWithFrame:CGRectMake(10, 80 + 70*i, KscreenWidth - 20, 50)];
        view.clipsToBounds = YES;
        view.layer.cornerRadius = 3;
        view.informationLabel.text = self.informationArr[i];
        view.detailLabel.text = self.detialArr[i];
        [self.view addSubview:view];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10, 80 + 70*i, KscreenWidth - 20, 50);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1000+i;
        [self.view addSubview:button];
        
    }
}
- (void)buttonClick:(UIButton *)sender {
    if (sender.tag == 1000) {
        BasicInformationViewController *basicVC = [[BasicInformationViewController alloc]init];
        [self.navigationController pushViewController:basicVC animated:YES];
    }else {
        ActivationViewController *activationVC = [[ActivationViewController alloc] init];
        [self.navigationController pushViewController:activationVC animated:YES];
    }
    
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

