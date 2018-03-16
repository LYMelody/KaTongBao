//
//  JXBankInfoViewController.m
//  JingXuan
//
//  Created by rongfeng on 16/6/13.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "JXBankInfoViewController.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "macro.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import <CommonCrypto/CommonDigest.h>
#import "BusiIntf.h"
#import "JXPayWithOrderViewController.h"
@interface JXBankInfoViewController ()

@end

@implementation JXBankInfoViewController {
    UITextField *textFld;
    NSDictionary *dic1;
    NSDictionary *dicc;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"输入卡号";
    //自定义返回按钮
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    right.title = @"返回";
    self.navigationItem.backBarButtonItem = right;
    
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = NavBack;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *BackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    BackView.backgroundColor = LightGrayColor;
    BackView.userInteractionEnabled = YES;
    [self.view addSubview:BackView];
    
    UITapGestureRecognizer *TapHiddenKeyBoard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HiddenKeyBoard)];
    TapHiddenKeyBoard.numberOfTouchesRequired = 1;
    [BackView addGestureRecognizer:TapHiddenKeyBoard];
    
    
    UIView *WhiteView = [[UIView alloc] init];
    WhiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:WhiteView];
    WhiteView.sd_layout.leftSpaceToView(self.view,13.5).topSpaceToView(self.view,79.5 - 64).rightSpaceToView(self.view,13.5).heightIs(45);
    WhiteView.layer.cornerRadius = 2;
    
    textFld = [[UITextField alloc] init];
    textFld.placeholder = @"请输入银行卡卡号";
    textFld.keyboardType = UIKeyboardTypeNumberPad;
    //textFld.text = @"6225768737106433";
    //textFld.text = @"6225768737106433";
    textFld.delegate = self;
    textFld.font = [UIFont systemFontOfSize:16];
    [WhiteView addSubview:textFld];
    textFld.sd_layout.leftSpaceToView(WhiteView,14).rightSpaceToView(WhiteView,14).topSpaceToView(WhiteView,13).heightIs(17.5);
    
    UIButton *SureBtn = [[UIButton alloc] init];
    [SureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [SureBtn setBackgroundColor:NavBack];
    SureBtn.layer.cornerRadius = 2;
    [SureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:SureBtn];
    SureBtn.sd_layout.leftSpaceToView(self.view,14.5).rightSpaceToView(self.view,14.5).topSpaceToView(textFld,80).heightIs(44);
    
    UILabel *TipsLab = [[UILabel alloc] init];
    TipsLab.text = @"使用本人信用卡完成1笔交易，交易完成后，账户激活。";
    TipsLab.numberOfLines = 0;
    TipsLab.textAlignment = NSTextAlignmentCenter;
    TipsLab.font = [UIFont systemFontOfSize:11];
    [self.view addSubview:TipsLab];
    TipsLab.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(SureBtn,8).rightSpaceToView(self.view,16).heightIs(15);
    TipsLab.hidden = YES;
    if (self.tag == 100) {
        TipsLab.hidden = NO;
    }
}

- (void)sure{
    
    NSString *url = JXUrl;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *md5 = [NSString stringWithFormat:@"%@%@%@",[textFld.text stringByReplacingOccurrencesOfString:@" " withString:@""],[BusiIntf curPayOrder].OrderNo,key];
    NSString *sign = [self md5HexDigest:md5];
    dic1 = [[NSDictionary alloc] init];
    dicc = [[NSDictionary alloc] init];
    dic1 = @{
                           @"orderNo":[BusiIntf curPayOrder].OrderNo,
                           @"bankNo":[textFld.text stringByReplacingOccurrencesOfString:@" " withString:@""],
                           @"token":token,
                           @"sign":sign
                           };
    
    dicc = @{
                           @"action":@"nocardOrderBankState",
                           @"data":dic1
                           };
    
    NSString *params = [dicc JSONFragment];
    NSLog(@"上传的参数:%@",params);
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        
        NSDictionary *dic = [result JSONValue];
        NSString *code = dic[@"code"];
        NSString *msg = dic[@"msg"];
        NSString *cardNo = dic[@"orderNo"]; //订单编号
        NSString *selfFlg = dic[@"selfFlg"]; //是否绑卡支付
        NSString *bankNo =dic[@"bankNo"];  //银行卡号
        NSString *bankCardType = dic[@"bankCardType"]; //卡号类型
        NSString *bankCardName = dic[@"bankCardName"]; //银行名称
        NSString *bankPhone = dic[@"bankPhone"];       //绑定电话号码
       // NSString *bankCardIcon = dic[@"bankCardIcon"];  //银行ICON
        
        if (![code isEqualToString:@"000000"]) {
            [self alert:msg];
        }else {
            
            JXPayWithOrderViewController *JXPayWithOrderVc = [[JXPayWithOrderViewController alloc] init];
            //[BusiIntf curPayOrder].amount = @"1";   //激活金额
            [BusiIntf curPayOrder].BankIsSelf = selfFlg;  //是否是绑卡
            [BusiIntf curPayOrder].BankName = bankCardName; //所属银行
            [BusiIntf curPayOrder].BankCardNo = bankNo;   //卡号
            [BusiIntf curPayOrder].BankCardType = bankCardType;   //信用卡
            [BusiIntf curPayOrder].OrderNo = cardNo; //订单
            
            //JXPayWithOrderVc.tag = 101;
            if (self.tag == 100) {    //账户激活
                [BusiIntf curPayOrder].amount = @"1";   //激活金额
                 JXPayWithOrderVc.tag = 101;
            }else {    //账户激活用之前获取的没有星号的电话号码，不是激活用带星号的
                [BusiIntf curPayOrder].cardPhone = bankPhone;  //电话号码
            }
            [self.navigationController pushViewController:JXPayWithOrderVc animated:YES];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"网络请求错误:%@",error);
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
//银行卡
- (void)RequestForAddBankCard {
    
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
//收键盘
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.view endEditing:YES];
//}
//收键盘
- (void)HiddenKeyBoard {
    
    [textFld resignFirstResponder];
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
