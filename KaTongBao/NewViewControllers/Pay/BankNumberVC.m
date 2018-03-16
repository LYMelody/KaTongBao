//
//  BankNumberVC.m
//  wujieNew
//
//  Created by rongfeng on 15/12/22.
//  Copyright © 2015年 rongfeng. All rights reserved.
//

#import "BankNumberVC.h"
#import "UIView+SDAutoLayout.h"
#import "Common.h"
#import "OrderNameVC.h"
#import "BusiIntf.h"
#import "IBHttpTool.h"
#import "SBJSON.h"
#import <CommonCrypto/CommonDigest.h>
#import "SVProgressHUD.h"

@implementation BankNumberVC {
    UITextField *BankFld;
    UILabel *BankLab;
}

static NSString *C_HELP_TIP  =
@"信用卡支持银行：\r\
中国工商银行；中国农业银行；中国建设银行；中国银行；中国光大银行；中国民生银行；平安银行；招商银行；浦发银行；中信银行；广发银行；上海银行；邮储银行；华夏银行；兴业银行；北京银行。";
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] init];
    left.title = @"返回";
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    self.navigationItem.backBarButtonItem = left;
    self.title = @"输入卡号";
    self.view.backgroundColor = [UIColor whiteColor];
    [self CreateViews];
}

- (void)CreateViews {
    
    UIImageView *backImg = [[UIImageView alloc] init];
    backImg.frame = CGRectMake(0, 0 , KscreenWidth, KscreenHeight);
    backImg.backgroundColor = LightGrayColor;
    backImg.userInteractionEnabled = YES;
    [self.view addSubview:backImg];
    //卡号
    UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 60, 44)];
    leftLab.text = @"  卡号:";
    leftLab.textColor = Color(100, 100, 100);
    leftLab.font = [UIFont systemFontOfSize:16];
    leftLab.backgroundColor = [UIColor whiteColor];
    leftLab.textAlignment = NSTextAlignmentRight;
    BankFld = [[UITextField alloc] init];
    BankFld.backgroundColor = [UIColor whiteColor];
    //BankFld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    BankFld.leftViewMode = UITextFieldViewModeAlways;
    BankFld.leftView = leftLab;
    BankFld.layer.cornerRadius = 3;
    //BankFld.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    BankFld.keyboardType = UIKeyboardTypeNumberPad;
    BankFld.delegate = self;
    [self.view addSubview:BankFld];
    [BankFld becomeFirstResponder];
    BankFld.sd_layout.leftSpaceToView(self.view,11).topSpaceToView(self.view,103 - 60).rightSpaceToView(self.view,11).heightIs(44);
    BankFld.text = @"";
    //确定 6258091644927670
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    btn.backgroundColor = [UIColor redColor];
    btn.layer.cornerRadius = 4.5;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(Sure) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.sd_layout.leftSpaceToView(self.view,13).topSpaceToView(self.view,199 - 60).rightSpaceToView(self.view,13).heightIs(44);
    //支持银行卡
    BankLab = [[UILabel alloc] init];
    if ([[BusiIntf curPayOrder].GoodsID isEqualToString:@"1"]) {
        if ([self.t1Bank isEqualToString:@""] || self.t1Bank == nil) {
            [self RequestForBank:@"RB1"];
        }else {
            BankLab.text = self.t1Bank;
        }
    }else if ([[BusiIntf curPayOrder].GoodsID isEqualToString:@"2"]) {
        BankLab.text = self.t0Bank;
    }else if ([[BusiIntf curPayOrder].GoodsID isEqualToString:@"HST0"]){
        BankLab.text = self.hst0Bank;
    }else if([[BusiIntf curPayOrder].GoodsID isEqualToString:@"AN1"]){
        BankLab.text = self.ANbank;
    }else {
        
    }
    
    //BankLab.text = C_HELP_TIP;
    BankLab.textColor = Color(136, 136, 136);
    BankLab.font = [UIFont systemFontOfSize:15];
    BankLab.numberOfLines = 0;
    [self.view addSubview:BankLab];
    BankLab.sd_layout.leftSpaceToView(self.view,17.5).topSpaceToView(self.view,311.5 - 60).rightSpaceToView(self.view,17.5).heightIs(150);
}
- (void)Sure {
    //银行卡初步验证
    NSString *BankNum = [BankFld.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (BankNum.length > 19 || BankNum.length < 14) {
        [self alert:@"输入卡号有误!"];
        return;
    }
    [SVProgressHUD show];
    //银行卡验证
    NSString *url = BaseUrl;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *md5 = [NSString stringWithFormat:@"%@%@%@%@",[BusiIntf curPayOrder].GoodsID,[BankFld.text stringByReplacingOccurrencesOfString:@" " withString:@""],[BusiIntf curPayOrder].OrderAmount,key];
    NSLog(@"!!!!!!!!!!!!!!!!!!%@!!!!!!!!!!!!",[BusiIntf curPayOrder].GoodsID);
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                           @"type":[BusiIntf curPayOrder].GoodsID,
                           @"cardNo":[BankFld.text stringByReplacingOccurrencesOfString:@" " withString:@""],
                           @"amount":[BusiIntf curPayOrder].OrderAmount,
                           @"goodsName":[[BusiIntf curPayOrder].OrderName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                           @"memo":[[BusiIntf curPayOrder].OrderDesc stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"OrderVerify",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSLog(@"数据:%@",result);
        NSDictionary *dic = [result JSONValue];
        NSString *code = dic[@"code"];
        NSString *content = dic[@"content"];
        //[self alert:content];
        NSString *cardBank = dic[@"cardBank"];
        NSString *cardType = dic[@"cardType"];
        NSString *isSelf = dic[@"isSelf"];
        NSString *orderNo = dic[@"orderNo"];
        [BusiIntf curPayOrder].OrderNo = orderNo;
        [BusiIntf curPayOrder].BankName = cardBank;
        [BusiIntf curPayOrder].BankCardNo = BankFld.text;
        [BusiIntf curPayOrder].BankCardType = cardType;
        [BusiIntf curPayOrder].BankIsSelf = isSelf;
        if ([code isEqualToString:@"000000"]) {
            //订单确认支付
          OrderNameVC *Order = [[OrderNameVC alloc] init];
          [self.navigationController pushViewController:Order animated:YES];
        } else {
            [self alert:content];
        }
        NSLog(@"返回的数据:%@",dic);
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
        [SVProgressHUD dismiss];
    }];
//    OrderNameVC *Order = [[OrderNameVC alloc] init];
//    [self.navigationController pushViewController:Order animated:YES];
    
}
//支持银行信息(融宝普通)
- (void)RequestForBank:(NSString *)Type {
    
    NSString *url = BaseUrl;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    //NSString *orderno = [user objectForKey:@"orderNo"];
    NSString *md5 = [NSString stringWithFormat:@"%@%@",Type,key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic = @{
                          @"token":token,
                          @"sign":sign,
                          @"orderType":Type
                          };
    NSDictionary *dicc = @{
                           @"action":@"ChannelBank",
                           @"data":dic
                           };
    NSString *params = [dicc JSONFragment];
    
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSDictionary *dicc = [result JSONValue];
        // NSString *code = dicc[@"code"];
        NSString *content = dicc[@"content"];
        NSLog(@"获取到的信息:%@",content);
        if ([BankLab.text isEqualToString:@""] || BankLab.text  == nil) {
            BankLab.text = content;
        }
       
    } failure:^(NSError *error) {
        NSLog(@"请求失败:%@",error);
        [self alert:@"请求网络失败！"];
        
    }];
}

//银行卡输入显示
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //    if (!textField.isBankNoField)
    //        return YES;
    
    __block NSString *text = [textField text];
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *newString = @"";
    while (text.length > 0) {
        NSString *subString = [text substringToIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, 4)];
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];

    [textField setText:newString];
    
    return NO;
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
//    [self.view endEditing:YES];
//}
@end
