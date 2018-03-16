//
//  OrgCodeVC.m
//  wujieNew
//
//  Created by rongfeng on 16/1/11.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "OrgCodeVC.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "IBHttpTool.h"
#import "SBJSON.h"
#import <CommonCrypto/CommonDigest.h>
#import "SVProgressHUD.h"
#import "BusiIntf.h"
@implementation OrgCodeVC {
    UITextField *OrgFld;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"机构编码";
    self.view.backgroundColor = [UIColor whiteColor];
    //背景
    UIImageView *backImg = [[UIImageView alloc] init];
    backImg.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    backImg.backgroundColor = LightGrayColor;
    backImg.userInteractionEnabled = YES;
    [self.view addSubview:backImg];
    
    UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectMake(16.5, 91.5, 85, 16.5)];
    leftLab.text = @"机构编码";
    leftLab.font = [UIFont systemFontOfSize:16];
    leftLab.textAlignment = NSTextAlignmentCenter;
    OrgFld = [[UITextField alloc] init];
    OrgFld.placeholder = @"请输入机构编码";
    if ([[BusiIntf curPayOrder].isOrg isEqualToString:@"0"]) {
        
        
    }else if([[BusiIntf curPayOrder].isOrg isEqualToString:@"1"]){
        
        OrgFld.text = [BusiIntf curPayOrder].orgCode;
        //OrgFld.enabled = NO;
        
    } else {
        OrgFld.text = [BusiIntf curPayOrder].orgCode;
       // OrgFld.enabled = NO;
    }
    
    OrgFld.leftViewMode = UITextFieldViewModeAlways;
    OrgFld.leftView = leftLab;
    OrgFld.layer.borderWidth = 0.5;
    OrgFld.layer.borderColor = Color(151, 151, 151).CGColor;
    [self.view addSubview:OrgFld];
    OrgFld.sd_layout.leftSpaceToView(self.view,0.5).topSpaceToView(self.view,79).widthIs(KscreenWidth - 1).heightIs(44);
    //提交
    UIButton *Commit = [[UIButton alloc] init];
    [Commit setTitle:@"提交" forState:UIControlStateNormal];
    [Commit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Commit.layer.cornerRadius = 3.5;
    Commit.layer.masksToBounds = YES;
    Commit.backgroundColor = RedColor;
    [Commit addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Commit];
    Commit.sd_layout.leftSpaceToView(self.view,13.5).topSpaceToView(self.view, 190).rightSpaceToView(self.view,13.5).heightIs(44);
    
    if ([[BusiIntf curPayOrder].isEdit isEqualToString:@"1"]) {
        Commit.hidden = YES;
        OrgFld.enabled = NO;
    }
}
- (void)commit {
    NSLog(@"@@@@@@@@@@");
    [SVProgressHUD show];
    NSString *url = BaseUrl;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *md5 = [NSString stringWithFormat:@"%@%@",OrgFld.text,key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                           @"code":OrgFld.text,
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"ShopOrgInfo",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    //NSLog(@"参数：%@",params);
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSDictionary *dicc = [result JSONValue];
        NSLog(@"返回数据：%@",dicc);
        NSString *content = dicc[@"content"];
        NSString *code = dicc[@"code"];
        if ([code isEqualToString:@"000000"]) {
            [BusiIntf curPayOrder].orgCode = OrgFld.text;
        }
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
@end
