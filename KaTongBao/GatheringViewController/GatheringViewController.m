//
//  GatheringViewController.m
//  JingXuan
//
//  Created by wj on 16/5/12.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "GatheringViewController.h"
#import "macro.h"
#import "GatheringView.h"
#import "NoCardViewController.h"
#import "MessageViewController.h"
#import "QRCodeViewController.h"
@interface GatheringViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation GatheringViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = NavBack;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self setBaseVCAttributes:@"请选择收款方式" withLeftName:@"返回" withRightName:nil withColor:NavBack];
    self.title = @"请选择收款方式";
    self.view.backgroundColor = LightGrayColor;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KscreenWidth, KscreenHeight)];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *imageArray = [NSArray arrayWithObjects:@"蓝牙",@"无界",@"短信",@"扫码",@"微信", nil];
    NSArray *labelArray = [NSArray arrayWithObjects:@"蓝牙收款",@"无卡收款",@"短信收款",@"扫码收款",@"微信收款", nil];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    GatheringView *gatheringCell = [[GatheringView alloc] init];
    gatheringCell.imageView.image = [UIImage imageNamed:imageArray[indexPath.row]];
    gatheringCell.label.text = labelArray[indexPath.row];
    [cell addSubview:gatheringCell];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        NoCardViewController *noCardVC = [[NoCardViewController alloc] init];
        [self.navigationController pushViewController:noCardVC animated:YES];
    }
    if (indexPath.row == 2) {
        MessageViewController *messageVC = [[MessageViewController alloc] init];
        [self.navigationController pushViewController:messageVC animated:YES];
    }
    if (indexPath.row ==3) {
        QRCodeViewController *QRCodeVC = [[QRCodeViewController alloc] init];
        [self.navigationController pushViewController:QRCodeVC animated:YES];
    }
    NSLog(@"%ld",(long)indexPath.row);
}
- (void)leftEvent:(UIButton *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return Cell;
    
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
