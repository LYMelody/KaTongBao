//
//  JXActiveViewController.m
//  JingXuan
//
//  Created by rongfeng on 16/6/6.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "JXActiveViewController.h"
#import "macro.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "BusiIntf.h"
#import "SBJSON.h"
#import <CommonCrypto/CommonDigest.h>
#import "IBHttpTool.h"
@interface JXActiveViewController ()

@end

@implementation JXActiveViewController {
    
    UITextField *BankFld;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户激活";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *Img = [[UIImageView alloc] init];
    //Img.backgroundColor = DarkBlack;
    [self.view addSubview:Img];
    Img.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,0).heightIs(200);
    UILabel *label = [[UILabel alloc] init];
    label.text = @"付款";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    label.sd_layout.centerXEqualToView(self.view).topSpaceToView(self.view,74).widthIs(30).heightIs(21);
    UILabel *MoneyLabel = [[UILabel alloc] init];
    MoneyLabel.text = @"￥1.00元";
    MoneyLabel.textColor = [UIColor whiteColor];
    MoneyLabel.font = [UIFont systemFontOfSize:30];
    MoneyLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:MoneyLabel];
    MoneyLabel.sd_layout.centerXEqualToView(self.view).topSpaceToView(self.view,110.5).widthIs(200).heightIs(43);
    
    UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    leftLab.text = @"  电话:";
    leftLab.textColor = Color(100, 100, 100);
    leftLab.font = [UIFont systemFontOfSize:16];
    leftLab.backgroundColor = [UIColor whiteColor];
    leftLab.textAlignment = NSTextAlignmentRight;
    BankFld = [[UITextField alloc] init];
    BankFld.placeholder = @"请输入电话号码";
    BankFld.backgroundColor = [UIColor whiteColor];
    BankFld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    BankFld.leftViewMode = UITextFieldViewModeAlways;
    BankFld.leftView = leftLab;
    BankFld.layer.cornerRadius = 3;
    BankFld.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    BankFld.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:BankFld];
    [BankFld becomeFirstResponder];
    BankFld.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,212).rightSpaceToView(self.view,16).heightIs(44);
    
    UIButton *PayBtn = [[UIButton alloc] init];
    [PayBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [PayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    PayBtn.layer.cornerRadius = 3;
    PayBtn.layer.masksToBounds = YES;
    PayBtn.backgroundColor = NavBack;
    [PayBtn addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    PayBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:PayBtn];
    PayBtn.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,293).rightSpaceToView(self.view,16).heightIs(44);
    
    UILabel *ActiveLab = [[UILabel alloc] init];
    ActiveLab.numberOfLines = 0;
    ActiveLab.font = [UIFont systemFontOfSize:12];
    ActiveLab.text = @"使用本人信用卡完成一笔交易，交易完成后，完成账户激活";
    [self.view addSubview:ActiveLab];
    ActiveLab.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,16).topSpaceToView(self.view,353.5).heightIs(33);

}
//支付
- (void)pay {
    //银行卡初步验证
//    if (BankFld.text.length > 19 || BankFld.text.length < 14) {
//        [self alert:@"输入卡号有误!"];
//        return;
//    }
    
//    //银行卡验证
//    NSString *url = JXUrl;
//    //金额
//    [BusiIntf curPayOrder].OrderAmount = @"1";
//    [BusiIntf curPayOrder].OrderDesc = @"";
//    
//    //时间戳
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"YYYY-MM-DD HH:mm:ss"];
//    NSTimeZone *timezone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//    [formatter setTimeZone:timezone];
//    NSDate *datenow = [NSDate date];
//    NSString *timeSp = [NSString stringWithFormat:@"%.0f",[datenow timeIntervalSince1970]];
//    
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *token = [user objectForKey:@"token"];
//    NSString *key = [user objectForKey:@"key"];
//    NSString *md5 = [NSString stringWithFormat:@"%@%@%@%@",[BusiIntf curPayOrder].GoodsID,BankFld.text,[BusiIntf curPayOrder].OrderAmount,key];
//    NSString *sign = [self md5HexDigest:md5];
//    NSDictionary *dic1 = @{
//                           @"type":[BusiIntf curPayOrder].GoodsID,
//                           @"cardNo":BankFld.text,
//                           @"amount":[BusiIntf curPayOrder].OrderAmount,
//                           @"goodsName":[[BusiIntf curPayOrder].OrderName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
//                           @"memo":[[BusiIntf curPayOrder].OrderDesc stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
//                           @"token":token,
//                           @"sign":sign
//                           
//                           };
//    NSDictionary *dicc = @{
//                           @"action":@"OrderVerify",
//                           @"data":dic1
//                           };
//    NSString *params = [dicc JSONFragment];
//    [IBHttpTool postWithURL:url params:params success:^(id result) {
//        NSLog(@"数据:%@",result);
//        NSDictionary *dic = [result JSONValue];
//        NSString *code = dic[@"code"];
//        NSString *content = dic[@"content"];
//        //[self alert:content];
//        NSString *cardBank = dic[@"cardBank"];
//        NSString *cardType = dic[@"cardType"];
//        NSString *isSelf = dic[@"isSelf"];
//        NSString *orderNo = dic[@"orderNo"];
//        [BusiIntf curPayOrder].OrderNo = orderNo;
//        [BusiIntf curPayOrder].BankName = cardBank;
//        [BusiIntf curPayOrder].BankCardNo = BankFld.text;
//        [BusiIntf curPayOrder].BankCardType = cardType;
//        [BusiIntf curPayOrder].BankIsSelf = isSelf;
//        if ([code isEqualToString:@"000000"]) {
//            //订单确认支付
////            OrderNameVC *Order = [[OrderNameVC alloc] init];
////            [self.navigationController pushViewController:Order animated:YES];
//        } else {
//            [self alert:content];
//        }
//        NSLog(@"返回的数据:%@",dic);
//    } failure:^(NSError *error) {
//        NSLog(@"网络请求失败:%@",error);
//        
//    }];

    
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
