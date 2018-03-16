//
//  BankSelectVC.m
//  wujieNew
//
//  Created by rongfeng on 16/1/13.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "BankSelectVC.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "LocationCell.h"
#import "IBHttpTool.h"
#import "SBJSON.h"
#import <CommonCrypto/CommonDigest.h>
#import "BusiIntf.h"
#import "SVProgressHUD.h"
@implementation BankSelectVC {
    
    NSUserDefaults *user;
    NSArray *BankArray;
    UITableView *table;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    BankArray = [[NSArray alloc] init];
    [self RequestForBankList];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"选择银行";
    self.view.backgroundColor = [UIColor whiteColor];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight + 50) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    [self.view addSubview:table];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return BankArray.count;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"cell";
    LocationCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell == nil) {
        cell = [[LocationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
        cell.leftLab.width = 260;
        if (BankArray.count == 0) {
            cell.leftLab.text = @"";
        } else {
            cell.leftLab.text = BankArray[indexPath.row];
        }
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [BusiIntf curPayOrder].bankname = BankArray[indexPath.row];
    NSLog(@"银行:%@",[BusiIntf curPayOrder].bankname);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)RequestForBankList {
    [SVProgressHUD show];
    NSString *url = BaseUrl;
    user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *md5 = [NSString stringWithFormat:@"%@%@",@"S",key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                           @"type":@"S",
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"BankInfoList",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    
    //NSLog(@"参数：%@",params);
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSDictionary *dicc = [result JSONValue];
        NSLog(@"返回数据：%@",dicc);
        BankArray = dicc[@"content"];
        [table reloadData];
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

#define mark -
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
