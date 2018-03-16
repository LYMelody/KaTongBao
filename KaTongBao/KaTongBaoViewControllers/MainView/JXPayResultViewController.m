//
//  JXPayResultViewController.m
//  JingXuan
//
//  Created by rongfeng on 16/6/3.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "JXPayResultViewController.h"
#import "Common.h"
#import "macro.h"
#import "UIView+SDAutoLayout.h"
#import "MesageCell.h"
#import "ViewsCell.h"
#import "BusiIntf.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import <CommonCrypto/CommonDigest.h>
#import "SVProgressHUD.h"
@interface JXPayResultViewController ()

@end

@implementation JXPayResultViewController {
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
    
    _index = 0;
    [SVProgressHUD show];     //开始转菊花
    [self AddAnOtherTimer];
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
    
    
    
    //返回商户按钮
    BackToMyAccountBtn = [[UIButton alloc] init];
    [BackToMyAccountBtn setTitle:@"返回商户" forState:UIControlStateNormal];
    [BackToMyAccountBtn setBackgroundColor:NavBack];
    BackToMyAccountBtn.layer.cornerRadius = 3;
    BackToMyAccountBtn.layer.masksToBounds = YES;
    [BackToMyAccountBtn addTarget:self action:@selector(BackToHome) forControlEvents:UIControlEventTouchUpInside];
    [HeadImgBackView addSubview:BackToMyAccountBtn];
    BackToMyAccountBtn.sd_layout.centerXEqualToView(HeadImgBackView).topSpaceToView(HeadImgBackView,217.5).widthIs(200).heightIs(45);
    
    //刷新状态按钮
    FreshStatusBtn = [[UIButton alloc] init];
    [FreshStatusBtn setTitle:@"刷新状态" forState:UIControlStateNormal];
    [FreshStatusBtn setBackgroundColor:NavBack];
    FreshStatusBtn.layer.cornerRadius = 3;
    FreshStatusBtn.layer.masksToBounds = YES;
    FreshStatusBtn.hidden = YES;
    [FreshStatusBtn addTarget:self action:@selector(FreshAction:) forControlEvents:UIControlEventTouchUpInside];
    [HeadImgBackView addSubview:FreshStatusBtn];
    FreshStatusBtn.sd_layout.rightSpaceToView(HeadImgBackView,11).topSpaceToView(HeadImgBackView,217.5).widthIs(125).heightIs(45);
    
    if (self.tag == 101) {  //支付成功
        LogView.image = [UIImage imageNamed:@"支付成功.png"];
        
    }else if (self.tag == 100) { //支付失败
        LogView.image = [UIImage imageNamed:@"支付失败.png"];
        successLab.text = self.failMsg;
    }else {   //待审核
        LogView.image = [UIImage imageNamed:@"审核中.png"];
        successLab.text = @"订单审核中...";
        FreshStatusBtn.hidden = NO;
        BackToMyAccountBtn.sd_layout.leftSpaceToView(HeadImgBackView,14).topSpaceToView(HeadImgBackView,217.5).widthIs(125).heightIs(45);
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
    
    NSString *identy = [NSString stringWithFormat:@"%d",indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell == nil) {
        if (indexPath.row == 0) {
            MesageCell *MesCell = [[MesageCell alloc] init];
            MesCell.label.text = @"订单金额";
            MesCell.textFiled.text = [BusiIntf curPayOrder].amount;
            MesCell.textFiled.enabled = NO;
            MesCell.textFiled.textColor = [UIColor redColor];
            cell = MesCell;
        }else if (indexPath.row == 1) {
            TimeMesCell = [[MesageCell alloc] init];
            TimeMesCell.label.text = @"交易时间";
            if (self.IsJieSuan) {
                
            }else {
                 TimeMesCell.textFiled.text = [BusiIntf curPayOrder].OrderTime;
            }
            TimeMesCell.textFiled.enabled = NO;
            cell = TimeMesCell;
        }else if (indexPath.row == 2) {
            MesageCell *MesCell = [[MesageCell alloc] init];
            MesCell.label.text = @"订单编号";
            if (self.IsJieSuan) {
                MesCell.textFiled.text = self.settleNo;
            }else {
                MesCell.textFiled.text = [BusiIntf curPayOrder].OrderNo;
            }
            
            MesCell.textFiled.enabled = NO;
            cell = MesCell;
        }else {
            ViewsCell *ViewCell = [[ViewsCell alloc] init];
            cell = ViewCell;
        }
    }
    
    return cell;
}

- (void)BackToHome{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//刷新状态
- (void)FreshAction :(UIButton *) btn{
    [SVProgressHUD show];       //点击刷新按钮转菊花
    if (self.IsJieSuan) { //结算
        [self RequestForJieSuanYuE:self.settleNo];
    }else {    //收款
        [self RequestForCash];
    }
}

//收款状态查询
- (void)RequestForCash {
    NSString *url = JXUrl;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *orderNo = [BusiIntf curPayOrder].OrderNo;
    NSString *md5 = [NSString stringWithFormat:@"%@%@",orderNo,key];
    NSString *sign = [self md5:md5];
    NSDictionary *dic1 = @{
                           @"orderNo":orderNo,
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"nocardOrderQueryState",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        
        NSDictionary *dic = [result JSONValue];
        NSString *code = dic[@"code"];
        NSString *msg = dic[@"msg"];
        NSString *failMsg = dic[@"failMag"];
        NSString *orderTime = dic[@"orderTime"];
        NSString *orderStatus = dic[@"orderStatus"];
        NSString *orderStatusCn = dic[@"orderStatusCn"];
        NSString *orderReason = dic[@"orderReason"];
        if (![code isEqualToString:@"000000"]) {
            [self alertMsg:msg];
        }else if ([orderStatus isEqual:@20]){
            //到支付结果页面 (成功)
            successLab.text = @"支付成功!";
            LogView.image = [UIImage imageNamed:@"支付成功.png"];
            BackToMyAccountBtn.sd_layout.centerXEqualToView(HeadImgBackView).topSpaceToView(HeadImgBackView,217.5).widthIs(200).heightIs(45);
            FreshStatusBtn.hidden = YES;
            [_Timer invalidate];
            _index = 0;
            [SVProgressHUD dismiss];
        }else if ([orderStatus isEqual:@21]) { //失败
            successLab.text = @"支付失败!";
            reasonLab.hidden = NO;
            reasonLab.text = orderReason;
            LogView.image = [UIImage imageNamed:@"支付失败.png"];
            BackToMyAccountBtn.sd_layout.centerXEqualToView(HeadImgBackView).topSpaceToView(HeadImgBackView,217.5).widthIs(200).heightIs(45);
            FreshStatusBtn.hidden = YES;
            [_Timer invalidate];
            _index =0;
            [SVProgressHUD dismiss];
            
        } else if(_index == 0 && [orderStatus isEqual:@11]){   //等待
            successLab.text = @"订单审核中...";
            reasonLab.hidden = NO;
            reasonLab.text = orderReason;
            LogView.image = [UIImage imageNamed:@"审核中.png"];
            FreshStatusBtn.hidden = NO;
            BackToMyAccountBtn.sd_layout.leftSpaceToView(HeadImgBackView,14).topSpaceToView(HeadImgBackView,217.5).widthIs(125).heightIs(45);
            [_Timer invalidate];
            [SVProgressHUD dismiss];
        } else {
            [SVProgressHUD dismiss];
        }
        
        if (!self.IsJieSuan) {  //赋值时间
            TimeMesCell.textFiled.text = orderTime;
        }
    } failure:^(NSError *error) {
        NSLog(@"网络请求错误:%@",error);
        [SVProgressHUD dismiss];
    }];
}

//结算余额查询
- (void)RequestForJieSuanYuE:(NSString *)settleNo {
    
    NSString *url = JXUrl;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    //时间戳
    NSString *md5 = [NSString stringWithFormat:@"%@%@",settleNo,key];
    NSString *sign = [self md5:md5];
    NSDictionary *dic1 = @{
                           @"settleNo":settleNo,
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"nocardSettleQueryState",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSDictionary *dicc = [result JSONValue];
        NSLog(@"订单列表：%@",dicc);
        NSString *code = dicc[@"code"];
        NSString *content = dicc[@"msg"];
        NSString *settleTime = dicc[@"settleTime"];
        NSString *settleStatus = dicc[@"settleStatus"];
        NSString *settleStatusCn = dicc[@"settleStatusCn"];
        NSString *settleReason = dicc[@"settleReason"];
        NSString *preTime = dicc[@"preTime"];
        if (![code isEqualToString:@"000000"]) {
            [self alertMsg:content];
        }else if ([settleStatus isEqual:@20]){
            //到支付结果页面 (成功)
            successLab.text = @"支付成功!";
            LogView.image = [UIImage imageNamed:@"支付成功.png"];
            BackToMyAccountBtn.sd_layout.centerXEqualToView(HeadImgBackView).topSpaceToView(HeadImgBackView,217.5).widthIs(200).heightIs(45);
            FreshStatusBtn.hidden = YES;
            [_Timer invalidate];
            _index = 0;
            [SVProgressHUD dismiss];
        }else if ([settleStatus isEqual:@21]) { //失败
            successLab.text = @"支付失败!";
            reasonLab.hidden = NO;
            reasonLab.text = settleReason;
            LogView.image = [UIImage imageNamed:@"支付失败.png"];
            BackToMyAccountBtn.sd_layout.centerXEqualToView(HeadImgBackView).topSpaceToView(HeadImgBackView,217.5).widthIs(200).heightIs(45);
            FreshStatusBtn.hidden = YES;
            [_Timer invalidate];
            _index =0;
            [SVProgressHUD dismiss];
            
        } else if(_index == 0){   //等待
            successLab.text = @"订单审核中...";
            reasonLab.hidden = NO;
            reasonLab.text = [NSString stringWithFormat:@"预到账:%@",preTime];
            LogView.image = [UIImage imageNamed:@"审核中.png"];
            FreshStatusBtn.hidden = NO;
            BackToMyAccountBtn.sd_layout.leftSpaceToView(HeadImgBackView,14).topSpaceToView(HeadImgBackView,217.5).widthIs(125).heightIs(45);
            [_Timer invalidate];
            [SVProgressHUD dismiss];
        } else {
            
        }
        //赋值时间
        if (self.IsJieSuan) {
            TimeMesCell.textFiled.text = settleTime;
        }

    } failure:^(NSError *error) {
        NSLog(@"网络请求错误!");
        [SVProgressHUD dismiss];
    }];
}

- (void)AddAnOtherTimer {
    _index = _index + 9;
    _Timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(StartTimer) userInfo:nil repeats:YES];
}

- (void)StartTimer {
    
    _index = _index - 3;
    //查询收支结果状态
    if (self.IsJieSuan) { //结算
        [self RequestForJieSuanYuE:self.settleNo];
    }else {    //收款
        [self RequestForCash];
    }

}

//MD516位小写加密
-(NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
}

-(void)alertMsg: (NSString *)msg
{
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message: msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alter.delegate = self;
    [alter show];
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
