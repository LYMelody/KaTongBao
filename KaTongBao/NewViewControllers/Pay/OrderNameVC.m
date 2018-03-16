//
//  OrderNameVC.m
//  wujieNew
//
//  Created by rongfeng on 15/12/22.
//  Copyright © 2015年 rongfeng. All rights reserved.
//

#import "OrderNameVC.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "TDViewsCell.h"
#import "CreateOrderCell.h"
#import "OrderQureyCell.h"
#import "AmountCell.h"
#import "BusiIntf.h"
#import "UISaveCardPay.h"
@implementation OrderNameVC {
    UIImageView *line;
    UIImageView *BottonLine;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    

    UIBarButtonItem *left = [[UIBarButtonItem alloc] init];
    left.title = @"返回";
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    self.navigationItem.backBarButtonItem = left;
    self.title = @"订单支付确认";
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight + 49) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    
    UIImageView *footView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 300)];
    footView.backgroundColor = LightGrayColor;
    footView.userInteractionEnabled = YES;
    //确定按钮
    UIButton *qureBtn = [[UIButton alloc] initWithFrame:CGRectMake(13, 86, KscreenWidth - 26, 44)];
    [qureBtn setTitle:@"确定" forState:UIControlStateNormal];
    qureBtn.backgroundColor = RedColor;
    qureBtn.layer.cornerRadius = 5;
    qureBtn.layer.masksToBounds = YES;
    [qureBtn addTarget:self action:@selector(qure) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:qureBtn];
    table.tableFooterView = footView;
    table.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:table];
    //qureBtn.sd_layout.leftSpaceToView(self.view,13).topSpaceToView(footView,86).rightSpaceToView(self.view,13).heightIs(44);
    line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 1)];
    line.backgroundColor = Color(216, 216, 216);
    BottonLine = [[UIImageView alloc] init];
    BottonLine.backgroundColor = Color(216, 216, 216);
    
    
}
//确定
- (void)qure {
    
    UISaveCardPay *PayVC = [[UISaveCardPay alloc] init];
    [self.navigationController pushViewController:PayVC animated:YES];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 18.5;
    }
    if (indexPath.row == 5) {
        return 64.5;
    }
    if (indexPath.row == 6) {
        return 0;
    }
    else {
        return 40;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        if (indexPath.row == 0) {
            TDViewsCell *Cell = [[TDViewsCell alloc] init];
            line.frame = CGRectMake(0, 18, KscreenWidth, 1);
            //[Cell.contentView addSubview:line];
            cell = Cell;
            [cell.contentView addSubview:line];
        }
        if (indexPath.row == 1) {
            OrderQureyCell *Cell = [[OrderQureyCell alloc] init];
            Cell.LeftLab.text = @"商品名称";
            Cell.RightLab.text = [BusiIntf curPayOrder].OrderName;
            cell =Cell;
        }
        if (indexPath.row == 2) {
            OrderQureyCell *Cell = [[OrderQureyCell alloc] init];
            Cell.RightLab.text = [BusiIntf curPayOrder].OrderAmount;
            Cell.LeftLab.text = @"商品价格";
            cell = Cell;
        }
        if (indexPath.row == 3) {
            OrderQureyCell *Cell = [[OrderQureyCell alloc] init];
            Cell.LeftLab.text = @"卡       号";
            Cell.RightLab.text = [BusiIntf curPayOrder].BankCardNo;
            cell = Cell;
        }
        if (indexPath.row == 4) {
            OrderQureyCell *Cell = [[OrderQureyCell alloc] init];
            Cell.LeftLab.text = @"银       行";
            Cell.RightLab.text = [BusiIntf curPayOrder].BankName;
            cell = Cell;
        }
        if (indexPath.row == 5) {
            AmountCell *Cell = [[AmountCell alloc] init];
            Cell.moneyLab.text = [NSString stringWithFormat:@"支付总额: %@元",[BusiIntf curPayOrder].OrderAmount];
            BottonLine.frame = CGRectMake(0, 64, KscreenWidth, 1);
            [Cell.contentView addSubview:BottonLine];
            cell = Cell;
        }

    }
    return cell;
}
@end
