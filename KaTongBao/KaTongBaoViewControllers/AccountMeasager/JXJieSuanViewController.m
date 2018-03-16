//
//  JXJieSuanViewController.m
//  JingXuan
//
//  Created by rongfeng on 16/6/6.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "JXJieSuanViewController.h"
#import "macro.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "BusiIntf.h"
#import <CommonCrypto/CommonDigest.h>
#import "JXJieSuanListViewController.h"
@interface JXJieSuanViewController ()

@end

@implementation JXJieSuanViewController {
    UITextField *MoneyFld;
}
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] init];
    left.title = @"返回";
    self.navigationItem.backBarButtonItem = left;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    
    //    self.navigationController.navigationBar.backgroundColor = DrackBlue;
    self.navigationController.navigationBar.barTintColor = NavBack;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"结算管理";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"结算记录" style:UIBarButtonItemStyleDone target:self action:@selector(ToJieSuan)];
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica-Bold"size:16.0],NSFontAttributeName,Color(255, 159, 36),NSForegroundColorAttributeName,nil]  forState:UIControlStateNormal];
    
    UIImageView *backImg = [[UIImageView alloc] init];
    backImg.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    backImg.backgroundColor = LightGrayColor;
    [self.view addSubview:backImg];
    
    UILabel *DisPlayLab = [[UILabel alloc] init];
    
    if ([[BusiIntf curPayOrder].TypeOrder isEqualToString:@"RB1"]) {
        DisPlayLab.text = @"无界支付普通收款";
    }else if ([[BusiIntf curPayOrder].TypeOrder isEqualToString:@"RB0"]){
        DisPlayLab.text = @"无界支付快捷收款";
    }else if ([[BusiIntf curPayOrder].TypeOrder isEqualToString:@"UP0"]) {
        DisPlayLab.text = @"银联支付快捷收款";
    }else if([[BusiIntf curPayOrder].TypeOrder isEqualToString:@"HST0"]){
        DisPlayLab.text = @"卡刷支付快捷收款";
    }else{
        
    }
    DisPlayLab.textColor = Color(18, 103, 186);
    DisPlayLab.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:DisPlayLab];
    DisPlayLab.sd_layout.leftSpaceToView(self.view,24).topSpaceToView(self.view,82.5).widthIs(120).heightIs(17.5);
    //可结算金额
    UIImageView *ImageViewOne = [[UIImageView alloc] init];
    ImageViewOne.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:ImageViewOne];
    ImageViewOne.sd_layout.leftSpaceToView(self.view,18.5).topSpaceToView(self.view,127 + 64).rightSpaceToView(self.view,28.5).heightIs(50);
    UILabel *LabOne = [[UILabel alloc] init];
    LabOne.text = @"可结算金额";
    LabOne.textColor = TextColor;
    LabOne.font = [UIFont systemFontOfSize:15];
    [ImageViewOne addSubview:LabOne];
    LabOne.sd_layout.leftSpaceToView(ImageViewOne,8).topSpaceToView(ImageViewOne,14.5).widthIs(75).heightIs(20);
    UILabel *MoneyLab = [[UILabel alloc] init];
    MoneyLab.textColor = Color(255, 159, 36);
    
    if ([[BusiIntf curPayOrder].TypeOrder isEqualToString:@"RB1"]) {
        MoneyLab.text = self.T1Money;
    }else if ([[BusiIntf curPayOrder].TypeOrder isEqualToString:@"RB0"]){
        MoneyLab.text = self.T0Money;
    }else if ([[BusiIntf curPayOrder].TypeOrder isEqualToString:@"UP0"]) {
        MoneyLab.text = self.YinLianMoney;
    }else if([[BusiIntf curPayOrder].TypeOrder isEqualToString:@"HST0"]){
        MoneyLab.text = self.HST0Money;
    }else if ([[BusiIntf curPayOrder].TypeOrder isEqualToString:@"AN1"]) {
        MoneyLab.text = self.AN1Money;
    }
    MoneyLab.text = @"100000";
    MoneyLab.textAlignment = NSTextAlignmentCenter;
    MoneyLab.font = [UIFont systemFontOfSize:14];
    [ImageViewOne addSubview:MoneyLab];
    MoneyLab.sd_layout.rightSpaceToView(ImageViewOne,28).topSpaceToView(ImageViewOne,14.5).widthIs(100).heightIs(23.3);
    
    //立即结算
    UIImageView *ImageViewTwo = [[UIImageView alloc] init];
    ImageViewTwo.backgroundColor = [UIColor whiteColor];
    ImageViewTwo.userInteractionEnabled = YES;
    [self.view addSubview:ImageViewTwo];
    ImageViewTwo.sd_layout.leftSpaceToView(self.view,18.5).topSpaceToView(self.view,188.5 + 64).rightSpaceToView(self.view,28.5).heightIs(50);
    UILabel *LabTwo = [[UILabel alloc] init];
    LabTwo.text = @"立即结算";
    LabTwo.textColor = TextColor;
    LabTwo.font = [UIFont systemFontOfSize:15];
    [ImageViewTwo addSubview:LabTwo];
    LabTwo.sd_layout.leftSpaceToView(ImageViewTwo,8).topSpaceToView(ImageViewTwo,14.5).widthIs(75).heightIs(20);
    MoneyFld = [[UITextField alloc] init];
    MoneyFld.placeholder = @"请填写金额";
    MoneyFld.font = [UIFont systemFontOfSize:14];
    MoneyFld.keyboardType = UIKeyboardTypeNumberPad;
    MoneyFld.textAlignment = NSTextAlignmentCenter;
    [ImageViewTwo addSubview:MoneyFld];
    MoneyFld.sd_layout.rightSpaceToView(ImageViewTwo,28).topSpaceToView(ImageViewTwo,13).widthIs(75).heightIs(24);
    
    //结算按钮
    UIButton *CommitBtn = [[UIButton alloc] init];
    [CommitBtn setTitle:@"提交" forState:UIControlStateNormal];
    CommitBtn.layer.cornerRadius = 3;
    [CommitBtn setBackgroundColor:Color(18, 103, 186)];
    [CommitBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CommitBtn];
    
    CommitBtn.sd_layout.leftSpaceToView(self.view,24).rightSpaceToView(self.view,24).topSpaceToView(self.view,308.5).heightIs(40);
    
    UILabel *label = [[UILabel alloc] init];
    if ([[BusiIntf curPayOrder].TypeOrder isEqualToString:@"RB1"]) {
        label.text = self.T1msg;
    }else if ([[BusiIntf curPayOrder].TypeOrder isEqualToString:@"RB0"]) {
        label.text = self.T0msg;
    }else if ([[BusiIntf curPayOrder].TypeOrder isEqualToString:@"UP0"]) {
        label.text = self.UP0msg;
    }else if([[BusiIntf curPayOrder].TypeOrder isEqualToString:@"HST0"]){
        label.text =self.HST0msg;
    }else if ([[BusiIntf curPayOrder].TypeOrder isEqualToString:@"AN1"]) {
        label.text = self.AN1msg;
    }
    //label.text = @"结算规则:";
    label.textColor = TextColor;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label];
    label.sd_layout.leftSpaceToView(self.view,17.5).topSpaceToView(self.view,367.5).rightSpaceToView(self.view,17.5).heightIs(150);
}

//结算记录
- (void)ToJieSuan {
    
    JXJieSuanListViewController *list = [[JXJieSuanListViewController alloc] init];
    [self.navigationController pushViewController:list animated:YES];
}
- (void)commit {
    
    [self TransForm];
    
}
//立即转出
- (void)TransForm {
    
    NSLog(@"转出");
    
//    if ([MoneyFld.text isEqualToString:@""]) {
//        [self alert:@"请输入金额!"];
//        return;
//    }
//    [SVProgressHUD show];
//    NSString *url = BaseUrl;
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *token = [user objectForKey:@"token"];
//    NSString *key = [user objectForKey:@"key"];
//    NSString *md5 = [NSString stringWithFormat:@"%@%@%@",[BusiIntf curPayOrder].TypeOrder,MoneyFld.text,key];
//    NSString *sign = [self md5HexDigest:md5];
//    NSDictionary *dic1 = @{
//                           @"type":[BusiIntf curPayOrder].TypeOrder,
//                           @"amount":MoneyFld.text,
//                           @"issued":@"0",
//                           @"token":token,
//                           @"sign":sign
//                           };
//    NSDictionary *dicc = @{
//                           @"action":@"SettlePay",
//                           @"data":dic1
//                           };
//    NSString *params = [dicc JSONFragment];
//    NSLog(@"参数：%@",params);
//    [IBHttpTool postWithURL:url params:params success:^(id result) {
//        NSDictionary *dicc = [result JSONValue];
//        NSLog(@"订单列表：%@",dicc);
//        NSString *content = dicc[@"content"];
//        NSString *Free = dicc[@"free"];
//        NSString *ratefree = dicc[@"rateFee"];
//        NSString *receive = dicc[@"receive"];
//        NSString *refund = dicc[@"refund"];
//        if (![content isEqualToString:@"正常"]) {
//            [self alert:content];
//        }
//        else {
//            //提示
//            NSString *msg = [[NSString alloc] init];
//            NSString *exportamount = [NSString stringWithFormat:@"转出金额 : %@",MoneyFld.text];
//            NSString *free = [NSString stringWithFormat:@"提现手续费 : %@",Free];
//            NSString *JieSuanFree = [NSString stringWithFormat:@"结算费率: %@",ratefree];
//            NSString *ReFund = [NSString stringWithFormat:@"系统维护费: %@",refund];
//            NSString *DaoZhang = [NSString stringWithFormat:@"到账金额 : %@",receive];
//            if ([refund isEqualToString:@"0"] || refund == nil) {
//                msg = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n",exportamount,free,JieSuanFree,DaoZhang];
//            } else {
//                msg = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n",exportamount,free,JieSuanFree,ReFund,DaoZhang];
//            }
//            // msg = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n",exportamount,free,JieSuanFree,DaoZhang];
//            UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:@"确认转出" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
//            AlertView.delegate = self;
//            [AlertView show];
//        }
//        [SVProgressHUD dismiss];
//    } failure:^(NSError *error) {
//        NSLog(@"网络申请失败:%@",error);
//        [SVProgressHUD dismiss];
//    }];
    
    
    
}

//选择是否付款
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
//    if (buttonIndex == 0) {
//        NSLog(@"取消付款");
//    }else {
//        NSLog(@"付款");
//        [SVProgressHUD show];
//        NSString *url = BaseUrl;
//        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//        NSString *token = [user objectForKey:@"token"];
//        NSString *key = [user objectForKey:@"key"];
//        float amount = [MoneyFld.text floatValue];
//        NSLog(@"%.2f",amount);
//        NSString *md5 = [NSString stringWithFormat:@"%@%.2f%@",[BusiIntf curPayOrder].TypeOrder,amount,key];
//        NSString *sign = [self md5HexDigest:md5];
//        NSDictionary *dic1 = @{
//                               @"type":[BusiIntf curPayOrder].TypeOrder,
//                               @"amount":[NSString stringWithFormat:@"%.2f",amount],
//                               @"issued":@"1",
//                               @"token":token,
//                               @"sign":sign
//                               };
//        NSDictionary *dicc = @{
//                               @"action":@"SettlePay",
//                               @"data":dic1
//                               };
//        NSString *params = [dicc JSONFragment];
//        NSLog(@"参数：%@",params);
//        [IBHttpTool postWithURL:url params:params success:^(id result) {
//            NSDictionary *dicc = [result JSONValue];
//            NSLog(@"订单列表：%@",dicc);
//            NSString *content = dicc[@"content"];
//            
//            
//            //结算列表
//            //                JieSuanListVC *JieSuan = [[JieSuanListVC alloc] init];
//            //                [self.navigationController pushViewController:JieSuan animated:YES];
//            
//            JieSuanSuccViewController *jiesunSUCC = [[JieSuanSuccViewController alloc] init];
//            if (![content isEqualToString:@"正常"]) {
//                //[self alert:content];
//                jiesunSUCC.Msg = content;
//            } else {
//                jiesunSUCC.Msg = @"提交成功!";
//            }
//            
//            [self.navigationController pushViewController:jiesunSUCC animated:YES];
//            
//            [SVProgressHUD dismiss];
//        } failure:^(NSError *error) {
//            NSLog(@"网络申请失败:%@",error);
//            [SVProgressHUD dismiss];
//        }];
//    }
}
//MD5加密
- (NSString *)md5HexDigest:(NSString*)password
{
    const char *original_str = [password UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    NSString *mdfiveString = [hash lowercaseString];
    return mdfiveString;
}
- (void)alert:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    [self.view endEditing:YES];
//    
//}

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
