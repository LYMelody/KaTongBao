//
//  MyViewController.m
//  JingXuan
//
//  Created by wj on 16/5/12.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "MyViewController.h"
#import "macro.h"
#import "MyView.h"
#import "MyTableViewCell.h"
#import "InformationViewController.h"
#import "WalletViewController.h"
#import "SetupViewController.h"
@interface MyViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:242.0/255.0 alpha:1];
    MyView *my = [[MyView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    [self.view addSubview:my];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 170, KscreenWidth, KscreenHeight)];
    tableView.tableFooterView = [[UIView alloc]init];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.scrollEnabled = NO;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *array = [NSArray arrayWithObjects:@"个人信息",@"钱包",@"Rectangle 159",@"",@"电话",@"Rectangle 161",@"Rectangle 162", nil];
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
    NSLog(@"---%ld",indexPath.row);
    if (indexPath.row == 0) {
        InformationViewController *informationVC = [[InformationViewController alloc] init];
        [self.navigationController pushViewController:informationVC animated:YES];
    }
    if (indexPath.row == 1) {
        WalletViewController *walletVC = [[WalletViewController alloc] init];
        [self.navigationController pushViewController:walletVC animated:YES];
    }
    if (indexPath.row == 2) {
        [self showMsg:@"正在建设..." title:nil];
    }
    if (indexPath.row == 4) {
        //拨打客服
        UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"400-1018-258" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [Alert show];
    }
    if (indexPath.row == 5) {
        [self showMsg:@"正在建设..." title:nil];
    }
    if (indexPath.row == 6) {
        SetupViewController *setupVC = [[SetupViewController alloc] init];
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
