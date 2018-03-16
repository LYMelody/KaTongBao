//
//  JieSuanDetailVC.m
//  wujieNew
//
//  Created by rongfeng on 16/1/7.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "JieSuanDetailVC.h"
#import "Common.h"
#import "JieSuanDetailCell.h"
@implementation JieSuanDetailVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"结算详情";
    self.view.backgroundColor = [UIColor whiteColor];
    //修改返回按钮
    UIBarButtonItem *left = [[UIBarButtonItem alloc] init];
    left.title = @"返回";
    self.navigationItem.backBarButtonItem = left;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = DrackBlue;

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 15, KscreenWidth, KscreenHeight) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    table.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:table];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"cell";
    JieSuanDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell==nil) {
        cell = [[JieSuanDetailCell alloc] init];
        if (indexPath.row == 0) {
            
            cell.LeftLab.text = @"结算单号:";
            cell.RightLab.text = self.model.settleNo;
        }
        if (indexPath.row == 1) {
            cell.LeftLab.text = @"时间:";
            cell.RightLab.text = self.model.settleReqTime;
        }
        if (indexPath.row == 2) {
            cell.LeftLab.text = @"结算金额:";
            cell.RightLab.text = self.model.amount;
        }
        if (indexPath.row == 3) {
            cell.LeftLab.text = @"提现手续费:";
            cell.RightLab.text = self.model.free;
        }
        if (indexPath.row == 4) {
            cell.LeftLab.text = @"结算费:";
            cell.RightLab.text = self.model.settleRateFee;
        }
        if (indexPath.row == 5) {
            cell.LeftLab.text = @"系统维护费:";
            cell.RightLab.text = self.model.refound;
        }
        if (indexPath.row == 6) {
            cell.LeftLab.text = @"到账金额:";
            float receive = [self.model.amount floatValue] - [self.model.free floatValue] - [self.model.refound floatValue] - [self.model.settleRateFee floatValue];
            cell.RightLab.text = [NSString stringWithFormat:@"%.2f",receive];
        }
        if (indexPath.row == 7) {
            cell.LeftLab.text = @"备注:";
            cell.RightLab.text = @"";
        }
    }

    return cell;
    
}
@end
