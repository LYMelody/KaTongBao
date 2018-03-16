//
//  JXCashMeathodViewController.m
//  JingXuan
//
//  Created by rongfeng on 16/6/2.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "JXCashMeathodViewController.h"
#import "macro.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "GatheringView.h"
#import "JXWuKaPayViewController.h"
@interface JXCashMeathodViewController ()

@end

@implementation JXCashMeathodViewController

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
    self.tabBarController.tabBar.hidden = YES;
    //自定义返回按钮
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    right.title = @"返回";
    self.navigationItem.backBarButtonItem = right;
    self.title = @"请选择收款方式";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    backView.backgroundColor = LightGrayColor;
    [self.view addSubview:backView];
    self.navigationController.navigationBar.barTintColor = NavBack;
    //self.view.backgroundColor = LightGrayColor;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight )];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    tableView.showsHorizontalScrollIndicator = YES;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *imageArray = [NSArray arrayWithObjects:@"蓝牙.png",@"无卡.png",@"短信.png",@"微信.png",@"扫码.png", nil];
    NSArray *labelArray = [NSArray arrayWithObjects:@"蓝牙收款",@"无卡收款",@"短信收款",@"微信收款",@"扫码收款", nil];
    imageArray = [NSArray arrayWithObjects:@"无卡.png", nil];
    labelArray = [NSArray arrayWithObjects:@"无卡收款",nil];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    GatheringView *gatheringCell = [[GatheringView alloc] init];
    gatheringCell.imageView.image = [UIImage imageNamed:imageArray[indexPath.row]];
    gatheringCell.label.text = labelArray[indexPath.row];
    [cell addSubview:gatheringCell];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) { //无卡收款
        JXWuKaPayViewController *noCardVC = [[JXWuKaPayViewController alloc] init];
        [self.navigationController pushViewController:noCardVC animated:YES];
    }
    if (indexPath.row == 1) { //微信收款
        JXWuKaPayViewController *noCardVC = [[JXWuKaPayViewController alloc] init];
        noCardVC.tag = 100;
        [self.navigationController pushViewController:noCardVC animated:YES];
    }
    if (indexPath.row ==3) {
//        QRCodeViewController *QRCodeVC = [[QRCodeViewController alloc] init];
//        [self.navigationController pushViewController:QRCodeVC animated:YES];
    }
    NSLog(@"%ld",(long)indexPath.row);
}

- (void)leftEvent:(UIButton *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 95;
    
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
