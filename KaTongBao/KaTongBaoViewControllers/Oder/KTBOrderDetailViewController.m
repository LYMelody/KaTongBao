//
//  KTBOrderDetailViewController.m
//  KaTongBao
//
//  Created by rongfeng on 16/6/21.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "KTBOrderDetailViewController.h"
#import "macro.h"
#import "Common.h"
#import "OrderDetailCell.h"
#import "OrderHeaderCell.h"
#import "BusiIntf.h"
@interface KTBOrderDetailViewController ()

@end

@implementation KTBOrderDetailViewController

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
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = LightGrayColor;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 40)];
    headerView.backgroundColor = [UIColor clearColor];
    table.tableHeaderView = headerView;
    
    [self.view addSubview:table];
    
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    
//    return 6;
//    
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 60;
    }else {
        return 40;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        if (indexPath.row == 0) {
            
            OrderHeaderCell *DetailCell = [[OrderHeaderCell alloc] init];
            if ([[BusiIntf curPayOrder].action isEqualToString:@"nocardOrderListState"]) {
                DetailCell.HeaderLab.text = self.model.orderStatusName;
                if ([self.model.orderStatusName isEqualToString:@"支付成功"]) {
                    DetailCell.HeaderLab.textColor = [UIColor colorWithRed:58/255.0 green:142/255.0 blue:12/255.0 alpha:1];
                }else if ([self.model.orderStatusName isEqualToString:@"支付失败"]) {
                    DetailCell.HeaderLab.textColor = [UIColor colorWithRed:243/255.0 green:12/255.0 blue:12/255.0 alpha:1];
                }else {
                    DetailCell.HeaderLab.textColor = [UIColor orangeColor];
                }
            }else {
                DetailCell.HeaderLab.text = self.model.settleStatusName;
                if ([self.model.settleStatusName isEqualToString:@"支付成功"]) {
                    DetailCell.HeaderLab.textColor = [UIColor colorWithRed:58/255.0 green:142/255.0 blue:12/255.0 alpha:1];
                }else if ([self.model.settleStatusName isEqualToString:@"支付失败"]) {
                    DetailCell.HeaderLab.textColor = [UIColor colorWithRed:243/255.0 green:12/255.0 blue:12/255.0 alpha:1];
                }else {
                    DetailCell.HeaderLab.textColor = [UIColor orangeColor];
                }
            }
            //DetailCell.HeaderLab.text = @"审核中";
            
            cell = DetailCell;
        }
        else if (indexPath.row == 1) {
            OrderDetailCell *DetailCell = [[OrderDetailCell alloc] init];
            DetailCell.LeftLab.text = @"交易流水:";
            if ([[BusiIntf curPayOrder].action isEqualToString:@"nocardOrderListState"]) {
                DetailCell.RightLab.text = self.model.orderNo;
            }else {
                DetailCell.RightLab.text = self.model.settleNo;
            }
            DetailCell.RightLab.adjustsFontSizeToFitWidth = YES;
            cell = DetailCell;
        }
        else if (indexPath.row == 2) {
            OrderDetailCell *DetailCell = [[OrderDetailCell alloc] init];
            DetailCell.LeftLab.text = @"交易银行:";
            DetailCell.RightLab.text = self.model.bankName;
            cell = DetailCell;
        }else if (indexPath.row == 3) {
            OrderDetailCell *DetailCell = [[OrderDetailCell alloc] init];
            DetailCell.LeftLab.text = @"交易金额:";
            DetailCell.RightLab.text = [NSString stringWithFormat:@"%.2f元",[self.model.amount floatValue]];
            cell = DetailCell;
        }else if (indexPath.row == 4) {
            OrderDetailCell *DetailCell = [[OrderDetailCell alloc] init];
            DetailCell.LeftLab.text = @"交易卡号:";
            DetailCell.RightLab.text = self.model.bankNo;
            cell = DetailCell;
        }else if (indexPath.row == 5) {
            OrderDetailCell *DetailCell = [[OrderDetailCell alloc] init];
            DetailCell.LeftLab.text = @"交易时间:";
            if ([[BusiIntf curPayOrder].action isEqualToString:@"nocardOrderListState"]) {
                DetailCell.RightLab.text = self.model.orderReqTime;
            }else {
                DetailCell.RightLab.text = self.model.settleReqTime;
            }
            cell = DetailCell;
        }else {
            
        }
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
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
