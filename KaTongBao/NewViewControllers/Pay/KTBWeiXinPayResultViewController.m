//
//  KTBWeiXinPayResultViewController.m
//  KaTongBao
//
//  Created by rongfeng on 16/8/2.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "KTBWeiXinPayResultViewController.h"
#import "Common.h"
#import "macro.h"
#import "UIView+SDAutoLayout.h"
#import "MesageCell.h"
#import "BusiIntf.h"
#import "ViewsCell.h"
#import "KTBWalletViewController.h"
@interface KTBWeiXinPayResultViewController ()

@end

@implementation KTBWeiXinPayResultViewController{
    UIImageView *LogView;
    UILabel *successLab;
    NSInteger _index;
    NSTimer *_Timer;
    UIImageView *HeadImgBackView;
    UIButton *BackToMyAccountBtn;
    UIButton *FreshStatusBtn;
    MesageCell *TimeMesCell;
    UILabel *reasonLab;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"二维码信息";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:19],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = NavBack;
    //自定义返回按钮
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    right.title = @"返回";
    self.navigationItem.backBarButtonItem = right;
    _index = 0;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"支付结果";
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor = LightGrayColor;
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight + 64) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.showsVerticalScrollIndicator = NO;
    //table.separatorStyle = UITableViewCellSeparatorStyleNone;
    //背景图
    HeadImgBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 307)];
    HeadImgBackView.userInteractionEnabled = YES;
    HeadImgBackView.backgroundColor = LightGrayColor;
    //支付成功logo
    LogView = [[UIImageView alloc] init];
    [HeadImgBackView addSubview:LogView];
    LogView.sd_layout.topSpaceToView(HeadImgBackView,9).centerXEqualToView(HeadImgBackView).widthIs(130.5).heightIs(130.5);
    //支付成功lable
    successLab = [[UILabel alloc] init];
    successLab.text = @"订单支付成功!";
    successLab.font = [UIFont systemFontOfSize:16];
    successLab.textAlignment = NSTextAlignmentCenter;
    [HeadImgBackView addSubview:successLab];
    successLab.sd_layout.topSpaceToView(LogView,26.5).centerXEqualToView(HeadImgBackView).widthIs(200).heightIs(20);
    
    reasonLab = [[UILabel alloc] init];
    reasonLab.font = [UIFont systemFontOfSize:16];
    reasonLab.textAlignment = NSTextAlignmentCenter;
    reasonLab.text = @"支付结果原因...";
    reasonLab.hidden = YES;
    [HeadImgBackView addSubview:reasonLab];
    reasonLab.sd_layout.topSpaceToView(successLab,8).centerXEqualToView(HeadImgBackView).widthIs(KscreenWidth).heightIs(20);
    
    UIImageView *Img = [[UIImageView alloc] init];
    Img.backgroundColor = [UIColor whiteColor];
    Img.userInteractionEnabled = YES;
    [HeadImgBackView addSubview:Img];
    Img.sd_layout.leftSpaceToView(HeadImgBackView,0).topSpaceToView(HeadImgBackView,220).widthIs(KscreenWidth).heightIs(50);
    
    //返回商户按钮
    BackToMyAccountBtn = [[UIButton alloc] init];
    [BackToMyAccountBtn setTitle:@"返回首页" forState:UIControlStateNormal];
    [BackToMyAccountBtn setBackgroundColor:[UIColor whiteColor]];
    [BackToMyAccountBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    BackToMyAccountBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    BackToMyAccountBtn.layer.cornerRadius = 3;
    BackToMyAccountBtn.layer.masksToBounds = YES;
    [BackToMyAccountBtn addTarget:self action:@selector(BackToHome) forControlEvents:UIControlEventTouchUpInside];
    [Img addSubview:BackToMyAccountBtn];
    BackToMyAccountBtn.sd_layout.centerXEqualToView(HeadImgBackView).topSpaceToView(HeadImgBackView,217.5).widthIs(200).heightIs(45);
    BackToMyAccountBtn.sd_layout.leftSpaceToView(Img,18).topSpaceToView(Img,8).widthIs(100).heightIs(40);
    
    UIImageView *MidImg = [[UIImageView alloc] init];
    MidImg.backgroundColor = [UIColor blackColor];
    [Img addSubview:MidImg];
    MidImg.sd_layout.leftSpaceToView(Img,KscreenWidth/2.0).topSpaceToView(Img,8).bottomSpaceToView(Img,8).widthIs(1);
    
    //我的钱包按钮
    FreshStatusBtn = [[UIButton alloc] init];
    [FreshStatusBtn setTitle:@"我的钱包" forState:UIControlStateNormal];
    [FreshStatusBtn setBackgroundColor:[UIColor whiteColor]];
    FreshStatusBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [FreshStatusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    FreshStatusBtn.layer.cornerRadius = 3;
    FreshStatusBtn.layer.masksToBounds = YES;
    //FreshStatusBtn.hidden = YES;
    [FreshStatusBtn addTarget:self action:@selector(FreshAction) forControlEvents:UIControlEventTouchUpInside];
    [Img addSubview:FreshStatusBtn];
    FreshStatusBtn.sd_layout.rightSpaceToView(Img,18).topSpaceToView(Img,8).widthIs(100).heightIs(40);
    
    if (self.tag == 1) {  //支付成功
        LogView.image = [UIImage imageNamed:@"支付成功.png"];
        
    }else if (self.tag == 2) { //支付失败
        LogView.image = [UIImage imageNamed:@"支付失败.png"];
        successLab.text = self.failMsg;
    }else {   //待审核
        LogView.image = [UIImage imageNamed:@"审核中.png"];
        successLab.text = @"订单等待支付中...";
    }
    //订单信息label
    UILabel *msgLab = [[UILabel alloc] init];
    msgLab.text = @"订单信息";
    msgLab.font = [UIFont systemFontOfSize:16];
    [HeadImgBackView addSubview:msgLab];
    msgLab.sd_layout.leftSpaceToView(HeadImgBackView,12.5).bottomSpaceToView(HeadImgBackView,10).widthIs(74).heightIs(15.5);
    UIImageView *footView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 100)];
    footView.backgroundColor = LightGrayColor;
    table.tableHeaderView = HeadImgBackView;
    table.tableFooterView = footView;
    [self.view addSubview:table];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        return 0;
    }else {
        return 40;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identy = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell == nil) {
        if (indexPath.row == 0) {
            MesageCell *MesCell = [[MesageCell alloc] init];
            MesCell.label.text = @"订单金额";
            MesCell.textFiled.text = [NSString stringWithFormat:@"%.2f",[[BusiIntf curPayOrder].amount floatValue]];
            MesCell.textFiled.enabled = NO;
            MesCell.textFiled.textColor = [UIColor redColor];
            cell = MesCell;
        }else if (indexPath.row == 1) {
            TimeMesCell = [[MesageCell alloc] init];
            TimeMesCell.label.text = @"交易时间";
            TimeMesCell.textFiled.text = [BusiIntf curPayOrder].OrderTime;
            TimeMesCell.textFiled.enabled = NO;
            cell = TimeMesCell;
        }else if (indexPath.row == 2) {
            MesageCell *MesCell = [[MesageCell alloc] init];
            MesCell.label.text = @"订单编号";
            MesCell.textFiled.text = [BusiIntf curPayOrder].OrderNo;
            MesCell.textFiled.enabled = NO;
            cell = MesCell;
        }
//        else if(indexPath.row == 3){
//            MesageCell *MesCell = [[MesageCell alloc] init];
//            MesCell.label.text = @"订单来源";
//            MesCell.textFiled.text = @"微信扫码";
//            MesCell.textFiled.enabled = NO;
//            cell = MesCell;
//        }
        else {
            ViewsCell *ViewCell = [[ViewsCell alloc] init];
            cell = ViewCell;
        }
    }
    return cell;
}

- (void)BackToHome{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//钱包
- (void)FreshAction {
    
    
    KTBWalletViewController *Wallet = [[KTBWalletViewController alloc] init];
    [self.navigationController pushViewController:Wallet animated:YES];
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
