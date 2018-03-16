//
//  JieSuanViewController.m
//  wujieNew
//
//  Created by rongfeng on 16/2/24.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "JieSuanViewController.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "IBHttpTool.h"
#import "SBJSON.h"
#import <CommonCrypto/CommonDigest.h>
#import "SVProgressHUD.h"
#import "BusiIntf.h"
#import "JieSuanListVC.h"
#import "JieSuanSuccViewController.h"
#import "macro.h"
#import "JXPayResultViewController.h"
#import "AddCardViewController.h"
#import "KTBCardManagerViewController.h"
@interface JieSuanViewController ()

@end

@implementation JieSuanViewController {
    UITextField *MoneyFld;
    NSString *settleNo;
    NSInteger _index;
    NSTimer *_Timer;
    UILabel *MoneyLab;
    NSString *PayType;
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
    // Do any additional setup after loading the view.
    
    self.title = @"结算管理";
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"结算记录" style:UIBarButtonItemStyleDone target:self action:@selector(ToJieSuan)];
//    
//    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica-Bold"size:16.0],NSFontAttributeName,Color(255, 159, 36),NSForegroundColorAttributeName,nil]  forState:UIControlStateNormal];
    
    UIImageView *backImg = [[UIImageView alloc] init];
    backImg.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    backImg.backgroundColor = LightGrayColor;
    backImg.userInteractionEnabled = YES;
    [self.view addSubview:backImg];
    
    UITapGestureRecognizer *TapHiddenKeyBoard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HiddenKeyBoard)];
    TapHiddenKeyBoard.numberOfTouchesRequired = 1;
    [backImg addGestureRecognizer:TapHiddenKeyBoard];
    
    UILabel *DisPlayLab = [[UILabel alloc] init];
    
    if (self.tag == 100) {  //卡通宝普通
        DisPlayLab.text = @"普通结算";
        [BusiIntf curPayOrder].TypeOrder = @"T1";
        PayType = @"1";
    }else if(self.tag == 101){  //卡通宝快捷
        DisPlayLab.text = @"快捷结算";
        [BusiIntf curPayOrder].TypeOrder = @"T0";
        PayType = @"1";
    }else if(self.tag == 102){   //微信
        DisPlayLab.text = @"微信结算";
        [BusiIntf curPayOrder].TypeOrder = @"T1";
        PayType = @"3";
    }else if (self.tag == 103) {
        [BusiIntf curPayOrder].TypeOrder = @"T0";
        PayType = @"3";
    }
    DisPlayLab.textColor = Color(18, 103, 186);
    DisPlayLab.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:DisPlayLab];
    DisPlayLab.sd_layout.leftSpaceToView(self.view,24).topSpaceToView(self.view,82.5 -  64).widthIs(120).heightIs(17.5);
    //可结算金额
    UIImageView *ImageViewOne = [[UIImageView alloc] init];
    ImageViewOne.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:ImageViewOne];
    ImageViewOne.sd_layout.leftSpaceToView(self.view,18.5).topSpaceToView(self.view,127 - 64).rightSpaceToView(self.view,28.5).heightIs(50);
    UILabel *LabOne = [[UILabel alloc] init];
    LabOne.text = @"可结算金额";
    LabOne.textColor = TextColor;
    LabOne.font = [UIFont systemFontOfSize:15];
    [ImageViewOne addSubview:LabOne];
    LabOne.sd_layout.leftSpaceToView(ImageViewOne,8).topSpaceToView(ImageViewOne,14.5).widthIs(80).heightIs(20);
    MoneyLab = [[UILabel alloc] init];
    MoneyLab.textColor = Color(255, 159, 36);
    if (self.tag == 100 || self.tag == 102) {
        MoneyLab.text = [NSString stringWithFormat:@"%.2f元",[self.T1Money floatValue]];
    }else{
        MoneyLab.text = [NSString stringWithFormat:@"%.2f元",[self.T0Money floatValue]];
    }
    MoneyLab.textAlignment = NSTextAlignmentCenter;
    MoneyLab.font = [UIFont systemFontOfSize:14];
    [ImageViewOne addSubview:MoneyLab];
    MoneyLab.sd_layout.rightSpaceToView(ImageViewOne,28).topSpaceToView(ImageViewOne,14.5).widthIs(100).heightIs(23.3);
    
    //立即结算
    UIImageView *ImageViewTwo = [[UIImageView alloc] init];
    ImageViewTwo.backgroundColor = [UIColor whiteColor];
    ImageViewTwo.userInteractionEnabled = YES;
    [self.view addSubview:ImageViewTwo];
    ImageViewTwo.sd_layout.leftSpaceToView(self.view,18.5).topSpaceToView(self.view,188.5 - 64).rightSpaceToView(self.view,28.5).heightIs(50);
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
    
    CommitBtn.sd_layout.leftSpaceToView(self.view,24).rightSpaceToView(self.view,24).topSpaceToView(self.view,330.5 - 64).heightIs(40);
    UILabel *label = [[UILabel alloc] init];
//    if ([[BusiIntf curPayOrder].TypeOrder isEqualToString:@"RB1"]) {
//        label.text = self.T1msg;
//    }else if ([[BusiIntf curPayOrder].TypeOrder isEqualToString:@"RB0"]) {
//        label.text = self.T0msg;
//    }else if ([[BusiIntf curPayOrder].TypeOrder isEqualToString:@"UP0"]) {
//        label.text = self.UP0msg;
//    }else if([[BusiIntf curPayOrder].TypeOrder isEqualToString:@"HST0"]){
//        label.text =self.HST0msg;
//    }else if ([[BusiIntf curPayOrder].TypeOrder isEqualToString:@"AN1"]) {
//        label.text = self.AN1msg;
//    }
    //label.text = @"结算规则:";
    if([[BusiIntf curPayOrder].TypeOrder isEqualToString:@"T1"]) { //普通
        label.text = [BusiIntf curPayOrder].T1Mcg;
    }else if ([[BusiIntf curPayOrder].TypeOrder isEqualToString:@"T0"]) {//快捷
        label.text = [BusiIntf curPayOrder].T0Mcg;
    }

    label.textColor = TextColor;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label];
    label.sd_layout.leftSpaceToView(self.view,17.5).topSpaceToView(ImageViewTwo,10).rightSpaceToView(self.view,17.5).heightIs(80);
    
    UILabel *reminderLable = [[UILabel alloc] init];
    reminderLable.textColor = [UIColor grayColor];
    reminderLable.textAlignment = NSTextAlignmentLeft;
   // reminderLable.lineBreakMode = NSLineBreakByWordWrapping;
    reminderLable.numberOfLines = 0;
    reminderLable.font = [UIFont systemFontOfSize:15];
    
    
    [self.view addSubview:reminderLable];
    reminderLable.sd_layout.topSpaceToView(ImageViewTwo,10).leftSpaceToView(self.view,16).widthIs(320).heightIs(80);
    reminderLable.center = self.view.center;
    //NSMutableAttributedString *mutableAttString = [[NSMutableAttributedString alloc] initWithString:@"注:1:交易限额:单笔最低10元，最高500000元 \n     2:交易时间:2:00-24:00"];
    
//    NSMutableAttributedString *mutableAttString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"注:1:结算限额:单笔最低%@元，最高%@元 \n     2:结算时间:%@-%@",[BusiIntf curPayOrder].nocardMcgMin,[BusiIntf curPayOrder].nocardMcgMax,[BusiIntf curPayOrder].nocardMcgStart,[BusiIntf curPayOrder].nocardMcgEnd]];
//    
//    [mutableAttString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0/255.0 green:149.0/255.0 blue:216.0/255.0 alpha:1] range:NSMakeRange(13, [BusiIntf curPayOrder].nocardMcgMin.length)];
//    [mutableAttString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0/255.0 green:149.0/255.0 blue:216.0/255.0 alpha:1] range:NSMakeRange(17+[BusiIntf curPayOrder].nocardMcgMin.length, [BusiIntf curPayOrder].nocardMcgMax.length)];
//    [mutableAttString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0/255.0 green:149.0/255.0 blue:216.0/255.0 alpha:1] range:NSMakeRange(25 + [BusiIntf curPayOrder].nocardMcgMin.length + [BusiIntf curPayOrder].nocardMcgMax.length + 7, 1+[BusiIntf curPayOrder].nocardMcgStart.length + [BusiIntf curPayOrder].nocardMcgEnd.length)];
//    reminderLable.attributedText = mutableAttString;
}

//结算记录
- (void)ToJieSuan {
    
    JieSuanListVC *list = [[JieSuanListVC alloc] init];
    [self.navigationController pushViewController:list animated:YES];
}

- (void)commit {
    
    [self TransForm];
    
}

//立即转出
- (void)TransForm {
    
    NSLog(@"转出");
    
    if ([MoneyFld.text isEqualToString:@""]) {
        [self alert:@"请输入金额!"];
        return;
    }
    if ([MoneyFld.text floatValue] > [MoneyLab.text floatValue]) {
        [self alert:@"商户余额不足!"];
        return;
    }
    
    [SVProgressHUD show];
    NSString *url = JXUrl;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    //时间戳
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-DD HH:mm:ss"];
    NSTimeZone *timezone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timezone];
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%.0f",[datenow timeIntervalSince1970]];
    NSString *issued = @"0";
    NSString *md5 = [NSString stringWithFormat:@"%@%@%@%@%@%@",MoneyFld.text,issued,timeSp,PayType,[BusiIntf curPayOrder].TypeOrder,key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                           @"type":[BusiIntf curPayOrder].TypeOrder,
                           @"payType":PayType,
                           @"amount":MoneyFld.text,
                           @"issued":issued,
                           @"linkId":timeSp,
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"nocardSettleMcgState",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    NSLog(@"参数：%@",params);
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSDictionary *dicc = [result JSONValue];
        NSLog(@"订单列表：%@",dicc);
        NSString *content = dicc[@"msg"];
        NSString *settleNo = dicc[@"settleNo"];
        NSString *rateCharge = dicc[@"rateCharge"];
        NSString *rateFee = dicc[@"rateFee"];
        NSString *receive = dicc[@"receive"];
        NSString *maintainace = dicc[@"maintainace"];
        NSString *code = dicc[@"code"];
        NSString *msg = dicc[@"msg"];
        if (![content isEqualToString:@"Success"]) {
            if ([code isEqualToString:@"ERR605"]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"绑定结算卡", nil];
                alertView.tag = 100;
                alertView.delegate = self;
                [alertView show];
            }else {
                [self alert:content];
            }
            
        }
        else {
            //提示
            NSString *msg = [[NSString alloc] init];
            NSString *exportamount = [NSString stringWithFormat:@"转出金额 : %@",MoneyFld.text];
            NSString *free = [NSString stringWithFormat:@"提现手续费 : %@",rateCharge];
            NSString *JieSuanFree = [NSString stringWithFormat:@"结算费率: %@",rateFee];
            NSString *ReFund = [NSString stringWithFormat:@"系统维护费: %@",maintainace];
            NSString *DaoZhang = [NSString stringWithFormat:@"到账金额 : %@",receive];
            if ([maintainace isEqualToString:@"0"] || maintainace == nil) {
                 msg = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n",exportamount,free,JieSuanFree,DaoZhang];
            } else {
                msg = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n",exportamount,free,JieSuanFree,ReFund,DaoZhang];
            }
           // msg = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n",exportamount,free,JieSuanFree,DaoZhang];
            UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:@"确认转出" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            AlertView.delegate = self;
            [AlertView show];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"网络申请失败:%@",error);
        [SVProgressHUD dismiss];
    }];
}
//选择是否付款
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 100) {
        if (buttonIndex == 1) {
            KTBCardManagerViewController *AddCard = [[KTBCardManagerViewController alloc] init];
            AddCard.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:AddCard animated:YES];
            AddCard.hidesBottomBarWhenPushed = NO;
        }else{
            
        }
            
    }else {
        if (buttonIndex == 0) {
            NSLog(@"取消付款");
        }else {
            NSLog(@"付款");
            [SVProgressHUD show];
            NSString *url = JXUrl;
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSString *token = [user objectForKey:@"token"];
            NSString *key = [user objectForKey:@"key"];
            //时间戳
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"YYYY-MM-DD HH:mm:ss"];
            NSTimeZone *timezone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
            [formatter setTimeZone:timezone];
            NSDate *datenow = [NSDate date];
            NSString *timeSp = [NSString stringWithFormat:@"%.0f",[datenow timeIntervalSince1970]];
            NSString *issued = @"1";
            NSString *md5 = [NSString stringWithFormat:@"%@%@%@%@%@%@",MoneyFld.text,issued,timeSp,PayType,[BusiIntf curPayOrder].TypeOrder,key];
            NSString *sign = [self md5HexDigest:md5];
            NSDictionary *dic1 = @{
                                   @"type":[BusiIntf curPayOrder].TypeOrder,
                                   @"payType":PayType,
                                   @"amount":MoneyFld.text,
                                   @"issued":issued,
                                   @"linkId":timeSp,
                                   @"token":token,
                                   @"sign":sign
                                   };
            NSDictionary *dicc = @{
                                   @"action":@"nocardSettleMcgState",
                                   @"data":dic1
                                   };
            NSString *params = [dicc JSONFragment];
            NSLog(@"参数：%@",params);
            [IBHttpTool postWithURL:url params:params success:^(id result) {
                NSDictionary *dicc = [result JSONValue];
                NSLog(@"订单列表：%@",dicc);
                NSString *content = dicc[@"msg"];
                settleNo = dicc[@"settleNo"];
                [BusiIntf curPayOrder].amount = MoneyFld.text;
                //商户余额查询
                JXPayResultViewController *JXpayResultVc = [[JXPayResultViewController alloc] init];
                JXpayResultVc.settleNo = settleNo;
                JXpayResultVc.IsJieSuan = YES;
                [self.navigationController pushViewController:JXpayResultVc animated:YES];
                
                [SVProgressHUD dismiss];
            } failure:^(NSError *error) {
                NSLog(@"网络申请失败:%@",error);
                [SVProgressHUD dismiss];
            }];
        }

    }
    
    
}

//结算余额查询
- (void)RequestForJieSuanYuE:(NSString *)settleNo {
    NSString *url = JXUrl;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    //时间戳
    NSString *md5 = [NSString stringWithFormat:@"%@%@",settleNo,key];
    NSString *sign = [self md5HexDigest:md5];
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
        NSString *content = dicc[@"msg"];
        
        
    } failure:^(NSError *error) {
        NSLog(@"网络请求错误!");
    }];
}

- (void)AddAnOtherTimer {
    _index = _index + 9;
    _Timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(StartTimer) userInfo:nil repeats:YES];
}

- (void)StartTimer {
    
    _index = _index - 3;
    [self RequestForJieSuanYuE:settleNo];
    
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

- (void)HiddenKeyBoard {
    [MoneyFld resignFirstResponder];
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
