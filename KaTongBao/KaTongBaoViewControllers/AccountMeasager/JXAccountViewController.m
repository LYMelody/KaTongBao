//
//  JXAccountViewController.m
//  JingXuan
//
//  Created by rongfeng on 16/6/1.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "JXAccountViewController.h"
#import "UIView+SDAutoLayout.h"
#import "macro.h"
#import "MyTableViewCell.h"
#import "JXSettingViewController.h"
#import "JXAccountMsgViewController.h"
#import "JXWalletViewController.h"
#import "BusiIntf.h"
#import "KTBWalletViewController.h"
#import "JXBankInfoViewController.h"
@interface JXAccountViewController ()

@end

@implementation JXAccountViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    //自定义返回按钮
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    right.title = @"返回";
    self.navigationItem.backBarButtonItem = right;
    self.navigationController.navigationBar.barTintColor = NavBack;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *backImage = [[UIImageView alloc] init];
    backImage.image = [UIImage imageNamed:@"标题"];
    [self.view addSubview:backImage];
    backImage.sd_layout.topSpaceToView(self.view,0).leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).heightIs(150);
    
    UIButton *headButton = [[UIButton alloc] init];
    headButton.clipsToBounds = YES;
    headButton.layer.cornerRadius = 31;
    [headButton setImage:[UIImage imageNamed:@"人物头像"] forState:UIControlStateNormal];
    [headButton addTarget:self action:@selector(headClick:) forControlEvents:UIControlEventTouchUpInside];
    [backImage addSubview:headButton];
    headButton.sd_layout.topSpaceToView(backImage,50).leftSpaceToView(backImage,15).widthIs(63).heightIs(63);
    
    
    
    
    
    
    
    
    UILabel *phoneLabel = [[UILabel alloc] init];
    phoneLabel.textColor = [UIColor whiteColor];
    phoneLabel.text = [BusiIntf getUserInfo].UserName;
    [backImage addSubview:phoneLabel];
    phoneLabel.sd_layout.topEqualToView(headButton).leftSpaceToView(headButton,10).heightIs(30).widthIs(120);
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.text = [NSString stringWithFormat:@"上次登录时间: %@",[BusiIntf getUserInfo].StartDate];
    timeLabel.font = [UIFont systemFontOfSize:13];
    [backImage addSubview:timeLabel];
    timeLabel.sd_layout.topSpaceToView(phoneLabel,0).leftSpaceToView(headButton,10).heightIs(30).widthIs(220);
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 170, KscreenWidth, KscreenHeight - 160)];
    tableView.tableFooterView = [[UIView alloc]init];
    tableView.backgroundColor = [UIColor clearColor];
    //tableView.scrollEnabled = NO;
    
    UIImageView *FootImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 60)];
    FootImageView.backgroundColor = [UIColor clearColor];
    tableView.tableFooterView = FootImageView;
    
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

//点击头像
- (void)headClick:(UIButton *)sender {
    
    
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *array = [NSArray arrayWithObjects:@"个人信息",@"钱包",@"商户管理",@"",@"客服电话",@"帮助",@"设置", nil];
    NSArray *arr = [NSArray arrayWithObjects:@"个人信息",@"钱包",@"商户管理",@"",@"客服电话",@"帮助",@"设置", nil];
    MyTableViewCell *myCell = [[MyTableViewCell alloc] init];
    myCell.imageView.image = [UIImage imageNamed:array[indexPath.row]];
    myCell.label.text = arr[indexPath.row];
    [cell addSubview:myCell];
    if (indexPath.row == 3) {
        cell.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:242.0/255.0 alpha:1];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"---%ld",(long)indexPath.row);
    if (indexPath.row == 0) { //个人信息
        
        JXAccountMsgViewController *JXAccountVC = [[JXAccountMsgViewController alloc] init];
        [self.navigationController pushViewController:JXAccountVC animated:YES];
        
    }
    if (indexPath.row == 1) { //钱包
//        JXWalletViewController *walletvc = [[JXWalletViewController alloc] init];
//        [self.navigationController pushViewController:walletvc animated:YES];
        KTBWalletViewController *ktbWalletVc = [[KTBWalletViewController alloc] init];
        [self.navigationController pushViewController:ktbWalletVc animated:YES];
        
    }
    if (indexPath.row == 2) {
        //[self showMsg:@"正在建设..." title:nil];
    }
    if (indexPath.row == 4) {
        //拨打客服
        UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"400-1018-258" delegate:self cancelButtonTitle:@"呼叫" otherButtonTitles:@"取消", nil];
        [Alert show];
    }
    if (indexPath.row == 5) {
       // [self showMsg:@"正在建设..." title:nil];
    }
    if (indexPath.row == 6) { //设置
        JXSettingViewController *setupVC = [[JXSettingViewController alloc] init];
        [self.navigationController pushViewController:setupVC animated:YES];
    }
}

- (void)showMsg:(NSString *)msg title:(NSString *)title
{
    UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [Alert show];
}

- (void)alertView:(UIAlertAction *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4006007909"]];
    }else  {
        NSLog(@"&&&&&&");
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
