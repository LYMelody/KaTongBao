//
//  AuthMsgVC.m
//  wujieNew
//
//  Created by rongfeng on 16/1/11.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "AuthMsgVC.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "OrgCodeVC.h"
#import "BankMsgVC.h"
#import "BaseMsgVC.h"
#import "BusiIntf.h"
#import "SVProgressHUD.h"
#import "IBHttpTool.h"
#import "SBJSON.h"
#import <CommonCrypto/CommonDigest.h>
@implementation AuthMsgVC

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] init];
    left.title = @"返回";
    self.navigationItem.backBarButtonItem = left;
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"信息审核";
    self.view.backgroundColor = [UIColor whiteColor];
    //背景
    UIImageView *backImg = [[UIImageView alloc] init];
    backImg.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    backImg.backgroundColor = LightGrayColor;
    backImg.userInteractionEnabled = YES;
    [self.view addSubview:backImg];
    
    UITapGestureRecognizer *TapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BaseMsg)];
    TapOne.numberOfTapsRequired = 1;
    UITapGestureRecognizer *TapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BankMsg)];
    TapTwo.numberOfTapsRequired = 1;
    UITapGestureRecognizer *TapThird = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OrgMsg)];
    TapThird.numberOfTapsRequired = 1;
    
    //基础信息
    UIImageView *BaseMsg = [[UIImageView alloc] init];
    BaseMsg.backgroundColor = [UIColor whiteColor];
    BaseMsg.layer.borderWidth = 0.5;
    BaseMsg.layer.borderColor = Color(151, 151, 151).CGColor;
    BaseMsg.layer.cornerRadius = 3;
    BaseMsg.userInteractionEnabled = YES;
    [BaseMsg addGestureRecognizer:TapOne];
    [self.view addSubview:BaseMsg];
    BaseMsg.sd_layout.leftSpaceToView(self.view,14).topSpaceToView(self.view,79 - 64).rightSpaceToView(self.view,14).heightIs(44);
    UILabel *BaseLab = [[UILabel alloc] init];
    BaseLab.text = @"基础信息";
    BaseLab.textAlignment = NSTextAlignmentLeft;
    BaseLab.font = [UIFont systemFontOfSize:15];
    BaseLab.textColor = [UIColor blackColor];
    [BaseMsg addSubview:BaseLab];
    BaseLab.sd_layout.leftSpaceToView(BaseMsg,10).topSpaceToView(BaseMsg,14).widthIs(60).heightIs(15.5);
    UILabel *TypeLab = [[UILabel alloc] init];
    if ([[BusiIntf curPayOrder].isBase isEqualToString:@"0"]) {
        TypeLab.text = @"未提交";
    } else  {
        TypeLab.text = @"已提交";
    }
    
    TypeLab.textAlignment = NSTextAlignmentRight ;
    TypeLab.font = [UIFont systemFontOfSize:14];
    TypeLab.textColor = [UIColor blackColor];
    [BaseMsg addSubview:TypeLab];
    TypeLab.sd_layout.rightSpaceToView(BaseMsg,45).topSpaceToView(BaseMsg,14).widthIs(60).heightIs(15.5);
    UIImageView *StartImg = [[UIImageView alloc] init];
    
    [BaseMsg addSubview:StartImg];
    //基础信息状态图
    if ([[BusiIntf curPayOrder].isBase isEqualToString:@"0"]) {
        StartImg.image = [UIImage imageNamed:@"＊1.png"];
        StartImg.sd_layout.rightSpaceToView(BaseMsg,23).centerYEqualToView(BaseMsg).widthIs(10).heightIs(10);
    }else if ([[BusiIntf curPayOrder].isBase isEqualToString:@"1"] && [[BusiIntf curPayOrder].isEdit isEqualToString:@"0"]) {
        StartImg.image = [UIImage imageNamed:@"realname_auth_edit.png"];
        StartImg.sd_layout.rightSpaceToView(BaseMsg,12).centerYEqualToView(BaseMsg).widthIs(20).heightIs(20);
    }else {
        StartImg.image = [UIImage imageNamed:@"确定.png"];
        StartImg.sd_layout.rightSpaceToView(BaseMsg,12).centerYEqualToView(BaseMsg).widthIs(20).heightIs(20);
    }
    
    //银行卡信息
    UIImageView *BankMsg = [[UIImageView alloc] init];
    BankMsg.backgroundColor = [UIColor whiteColor];
    BankMsg.layer.borderWidth = 0.5;
    BankMsg.layer.borderColor = Color(151, 151, 151).CGColor;
    BankMsg.layer.cornerRadius = 3;
    BankMsg.userInteractionEnabled = YES;
    [BankMsg addGestureRecognizer:TapTwo];
    [self.view addSubview:BankMsg];
    BankMsg.sd_layout.leftSpaceToView(self.view,14).topSpaceToView(self.view,133 - 64).rightSpaceToView(self.view,14).heightIs(44);
    UILabel *BankLab = [[UILabel alloc] init];
    BankLab.text = @"银行卡信息";
    BankLab.textAlignment = NSTextAlignmentLeft;
    BankLab.font = [UIFont systemFontOfSize:15];
    BankLab.textColor = [UIColor blackColor];
    [BankMsg addSubview:BankLab];
    BankLab.sd_layout.leftSpaceToView(BankMsg,10).topSpaceToView(BankMsg,14).widthIs(100).heightIs(15.5);
    UILabel *BankTypeLab = [[UILabel alloc] init];
    if ([[BusiIntf curPayOrder].isBank isEqualToString:@"0"]) {
        BankTypeLab.text = @"未提交";
    }else {
        BankTypeLab.text = @"已提交";
    }
    BankTypeLab.textAlignment = NSTextAlignmentRight ;
    BankTypeLab.font = [UIFont systemFontOfSize:14];
    BankTypeLab.textColor = [UIColor blackColor];
    [BankMsg addSubview:BankTypeLab];
    BankTypeLab.sd_layout.rightSpaceToView(BankMsg,45).topSpaceToView(BankMsg,14).widthIs(60).heightIs(15.5);
    UIImageView *BankStartImg = [[UIImageView alloc] init];
    //BankStartImg.image = [UIImage imageNamed:@"＊1.png"];
    [BankMsg addSubview:BankStartImg];
    //银行卡信息状态图
    if ([[BusiIntf curPayOrder].isBank isEqualToString:@"0"]) {
        BankStartImg.image = [UIImage imageNamed:@"＊1.png"];
        BankStartImg.sd_layout.rightSpaceToView(BankMsg,23).centerYEqualToView(BankMsg).widthIs(10).heightIs(10);
    }else if ([[BusiIntf curPayOrder].isBank isEqualToString:@"1"] && [[BusiIntf curPayOrder].isEdit isEqualToString:@"0"]) {
        BankStartImg.image = [UIImage imageNamed:@"realname_auth_edit.png"];
        BankStartImg.sd_layout.rightSpaceToView(BankMsg,12).centerYEqualToView(BankMsg).widthIs(20).heightIs(20);
    }else {
        BankStartImg.image = [UIImage imageNamed:@"确定.png"];
        BankStartImg.sd_layout.rightSpaceToView(BankMsg,12).centerYEqualToView(BankMsg).widthIs(20).heightIs(20);
    }
    
    //机构编码
    UIImageView *OrgMsg = [[UIImageView alloc] init];
    OrgMsg.backgroundColor = [UIColor whiteColor];
    OrgMsg.layer.borderWidth = 0.5;
    OrgMsg.layer.borderColor = Color(151, 151, 151).CGColor;
    OrgMsg.layer.cornerRadius = 3;
    OrgMsg.userInteractionEnabled = YES;
    [OrgMsg addGestureRecognizer:TapThird];
    [self.view addSubview:OrgMsg];
    OrgMsg.sd_layout.leftSpaceToView(self.view,14).topSpaceToView(self.view,189.5 -64).rightSpaceToView(self.view,14).heightIs(44);
    UILabel *OrgLab = [[UILabel alloc] init];
    OrgLab.text = @"机构编码";
    OrgLab.textAlignment = NSTextAlignmentLeft;
    OrgLab.font = [UIFont systemFontOfSize:15];
    OrgLab.textColor = [UIColor blackColor];
    [OrgMsg addSubview:OrgLab];
    OrgLab.sd_layout.leftSpaceToView(OrgMsg,10).topSpaceToView(OrgMsg,14).widthIs(60).heightIs(15.5);
    UILabel *OrgTypeLab = [[UILabel alloc] init];
    if ([[BusiIntf curPayOrder].isOrg isEqualToString:@"0"]) {
        OrgTypeLab.text = @"未提交";
    }else {
        OrgTypeLab.text = @"已提交";
    }
    
    OrgTypeLab.textAlignment = NSTextAlignmentRight ;
    OrgTypeLab.font = [UIFont systemFontOfSize:14];
    OrgTypeLab.textColor = [UIColor blackColor];
    [OrgMsg addSubview:OrgTypeLab];
    OrgTypeLab.sd_layout.rightSpaceToView(OrgMsg,45).topSpaceToView(OrgMsg,14).widthIs(60).heightIs(15.5);
    UIImageView *OrgStartImg = [[UIImageView alloc] init];
    OrgStartImg.image = [UIImage imageNamed:@"＊1.png"];
    [OrgMsg addSubview:OrgStartImg];
    //银行卡信息状态图
    if ([[BusiIntf curPayOrder].isOrg isEqualToString:@"0"]) {
        OrgStartImg.image = [UIImage imageNamed:@"＊1.png"];
        OrgStartImg.sd_layout.rightSpaceToView(OrgMsg,23).centerYEqualToView(OrgMsg).widthIs(10).heightIs(10);
    }else if ([[BusiIntf curPayOrder].isOrg isEqualToString:@"1"] && [[BusiIntf curPayOrder].isEdit isEqualToString:@"0"]) {
        OrgStartImg.image = [UIImage imageNamed:@"realname_auth_edit.png"];
        OrgStartImg.sd_layout.rightSpaceToView(OrgMsg,12).centerYEqualToView(OrgMsg).widthIs(20).heightIs(20);
    }else {
        OrgStartImg.image = [UIImage imageNamed:@"确定.png"];
        OrgStartImg.sd_layout.rightSpaceToView(OrgMsg,12).centerYEqualToView(OrgMsg).widthIs(20).heightIs(20);
    }
    
    UIButton *CommitBtn = [[UIButton alloc] init];
    [CommitBtn setTitle:@"提交" forState:UIControlStateNormal];
    CommitBtn.layer.cornerRadius = 3;
    CommitBtn.backgroundColor = Color(244, 81, 81);
    CommitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [CommitBtn addTarget:self action:@selector(CommitToWuJie) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CommitBtn];
    CommitBtn.sd_layout.leftSpaceToView(self.view,13.5).rightSpaceToView(self.view,13.5).bottomSpaceToView(self.view,36).heightIs(44);
    
    if ([[BusiIntf curPayOrder].isBase isEqualToString:@"1"] && [[BusiIntf curPayOrder].isBank isEqualToString:@"1"] && [[BusiIntf curPayOrder].isOrg isEqualToString:@"1"]) {
        CommitBtn.hidden = NO;
    }else {
        CommitBtn.hidden = YES;
    }
}

- (void)CommitToWuJie {
    
    NSLog(@"等哈说肯定会卡上打卡上");
    
    [SVProgressHUD show];
    NSString *url = BaseUrl;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *md5 = [NSString stringWithFormat:@"%@%@",token,key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                           //@"code":OrgFld.text,
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"ShopVerifySubmit",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    //NSLog(@"参数：%@",params);
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSDictionary *dicc = [result JSONValue];
        NSLog(@"返回数据：%@",dicc);
        NSString *content = dicc[@"content"];
        [self alert:content];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"网络申请失败:%@",error);
        [SVProgressHUD dismiss];
    }];
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


//基础信息
- (void)BaseMsg {
    BaseMsgVC *Basemsg = [[BaseMsgVC alloc] init];
    [self.navigationController pushViewController:Basemsg animated:YES];
}
//银行卡信息
- (void)BankMsg {
    BankMsgVC *Bankmsg = [[BankMsgVC alloc] init];
    [BusiIntf curPayOrder].bankname = [BusiIntf curPayOrder].bankName2;
    [self.navigationController pushViewController:Bankmsg animated:YES];
}
//机构编码
- (void)OrgMsg {
    OrgCodeVC *OrgCode = [[OrgCodeVC alloc] init];
    [self.navigationController pushViewController:OrgCode animated:YES];
}
@end
