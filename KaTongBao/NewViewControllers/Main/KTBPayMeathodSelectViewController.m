//
//  KTBPayMeathodSelectViewController.m
//  KaTongBao
//
//  Created by rongfeng on 16/10/19.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "KTBPayMeathodSelectViewController.h"
#import "Common.h"
#import "macro.h"
#import "PayMeathodCell.h"
#import "JXCheckOrderViewController.h"
#import "TwoDBarCodePayViewController.h"
#import "BusiIntf.h"
#import "SVProgressHUD.h"
#import "IBHttpTool.h"
#import "SBJSON.h"
#import <CommonCrypto/CommonDigest.h>
#import "GiFHUD.h"
@interface KTBPayMeathodSelectViewController ()

@end

@implementation KTBPayMeathodSelectViewController {
    
    NSUserDefaults *user;
    
//    NSString *oderReqTime;
//    NSString *codeImgUrl;
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"选择支付方式";
    self.view.backgroundColor = [UIColor whiteColor];
    //修改返回按钮
    UIBarButtonItem *left = [[UIBarButtonItem alloc] init];
    left.title = @"返回";
    self.navigationItem.backBarButtonItem = left;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = NavBack;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *Table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight) style:UITableViewStylePlain];
    Table.delegate = self;
    Table.dataSource = self;
    Table.backgroundColor = LightGrayColor;
    Table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:Table];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 20;
    }else {
        return 100;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        if (indexPath.row == 0) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }else if (indexPath.row == 1) {
            PayMeathodCell *PayCell = [[PayMeathodCell alloc] init];
            PayCell.LogoImg.image = [UIImage imageNamed:@"卡捷通无卡"];
            PayCell.PayLab.text = @"无卡支付";
            cell = PayCell;
        }else if (indexPath.row == 2) {
            PayMeathodCell *PayCell = [[PayMeathodCell alloc] init];
            PayCell.LogoImg.image = [UIImage imageNamed:@"微信"];
            PayCell.PayLab.text = @"微信支付";
            cell = PayCell;
        }
    }
    cell.backgroundColor = LightGrayColor;
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (indexPath.row == 1) {  //无卡支付
        
        [self RequestForPay:@"WuKa"];
    }else if (indexPath.row == 2) { //微信支付
        [self RequestForPay:@"WeChat"];
    }
    
}

//提交成功跳到支付流程
- (void)RequestForPay :(NSString *)PayType{
    
    NSString *url = JXUrl;
    NSString *payType = @"1";
    
    NSString *orderType = @"11"; //无卡普通支付
    NSString *Amount = [BusiIntf curPayOrder].VipPrice; //金额 [BusiIntf curPayOrder].VipPrice
    NSString *goodsId = @"6666";  //vip会员申请
    [BusiIntf curPayOrder].amount = Amount;
    
    if ([PayType isEqualToString:@"WuKa"]) { //无卡支付
        payType = @"1";
        orderType = @"11";
    }else if ([PayType isEqualToString:@"WeChat"]) { //微信支付
        payType = @"3";
        orderType = @"10";
    }
    
    
    [GiFHUD showWithOverlay];
    //时间戳
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-DD HH:mm:ss"];
    NSTimeZone *timezone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timezone];
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%.0f",[datenow timeIntervalSince1970]];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *md5 = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",Amount,goodsId,timeSp,orderType,payType,version,key];
    NSString *sign = [self md5:md5];
    NSDictionary *dic1 = @{
                           @"linkId":timeSp,
                           @"payType":payType,
                           @"orderType":orderType,
                           @"goodsId":goodsId,
                           @"amount":Amount,
                           @"version":version,
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"nocardOrderCreateState",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSDictionary *dic = [result JSONValue];
        NSLog(@"Dic:%@",dic);
        NSString *code = dic[@"code"];
        NSString *msg = dic[@"msg"];
        NSString *oderNo = dic[@"orderNo"];
        NSString *oderReqTime = dic[@"orderTime"];
        NSString *codeImgUrl = dic[@"codeImgUrl"];
        NSString *buttonName = dic[@"buttonName"];
        NSString *buttonUrl = dic[@"buttonUrl"];
        [BusiIntf curPayOrder].OrderNo = oderNo;
        
        //微信二维码
        NSString *qrcode = nil;
        NSLog(@"上传的时间:%@",oderReqTime);
        //如果是未注册 跳到注册页面
        if ([code isEqualToString:@"ERR504"]) {   //未实名认证，跳转到实名认证
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"去实名认证" otherButtonTitles:@"取消", nil];
            alertView.tag = 100;
            [alertView show];
            [GiFHUD dismiss];
        }else if ([code isEqualToString:@"ERR528"]) {   //未激活，跳转到激活页面(限额)
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:buttonName otherButtonTitles:@"取消", nil];
            alertView.tag = 101;
            [alertView show];
            [GiFHUD dismiss];
        }
        
        else if ([msg isEqualToString:@"Success"]){  //创建订单成功跳转
            
            if ([PayType isEqualToString:@"WuKa"]) {
                //商户绑定银行卡列表
                NSArray *bindCards = [[NSArray alloc] init];
                if ([dic[@"bindCards"] isKindOfClass:[NSString class]]) {
                    
                }else {
                    bindCards =  dic[@"bindCards"];
                }
                NSLog(@"bindCards.count:%lu",(unsigned long)bindCards.count);
                JXCheckOrderViewController *checkOrder = [[JXCheckOrderViewController alloc] init];
                //checkOrder.tag = 100;
                checkOrder.amount = Amount;
                checkOrder.orderTime = oderReqTime;
                checkOrder.orderNo = oderNo;
                checkOrder.bankArray = bindCards;
                checkOrder.qrcode = qrcode;
                checkOrder.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:checkOrder animated:YES];
                checkOrder.hidesBottomBarWhenPushed = NO;
                [GiFHUD dismiss];
            }else if ([PayType isEqualToString:@"WeChat"]) {
                
                TwoDBarCodePayViewController *TwoDBarCode = [[TwoDBarCodePayViewController alloc] init];
                TwoDBarCode.money = Amount;
                TwoDBarCode.orderTime = oderReqTime;
                TwoDBarCode.orderNo = oderNo;
                TwoDBarCode.codeImgUrl = codeImgUrl;
                NSLog(@"codeImgUrl : %@",codeImgUrl);
                [self.navigationController pushViewController:TwoDBarCode animated:YES];
                [GiFHUD dismiss];
            }
            
            
        }else {   // 创建未成功 提示错误信息
            [self alert:msg];
            [GiFHUD dismiss];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
        [GiFHUD dismiss];
    }];
}

//微信支付
- (void)WeChatPay {
    
    TwoDBarCodePayViewController *TwoDBarCode = [[TwoDBarCodePayViewController alloc] init];
//    TwoDBarCode.money = MoneyLab.text;
//    TwoDBarCode.orderTime = oderReqTime;
//    TwoDBarCode.orderNo = oderNo;
//    TwoDBarCode.codeImgUrl = codeImgUrl;
//    [self.navigationController pushViewController:TwoDBarCode animated:YES];
//    //[SVProgressHUD dismiss];
//    [GiFHUD dismiss];
    
}
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

- (void)alert:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
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
