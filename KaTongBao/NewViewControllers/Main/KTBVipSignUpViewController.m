//
//  KTBVipSignUpViewController.m
//  KaTongBao
//
//  Created by rongfeng on 16/8/26.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "KTBVipSignUpViewController.h"
#import "Common.h"
#import "macro.h"
#import "UIView+SDAutoLayout.h"
#import "ViewsCell.h"
#import "MesageCell.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import <CommonCrypto/CommonDigest.h>
#import "SVProgressHUD.h"
#import "BusiIntf.h"
#import "JXCheckOrderViewController.h"
#import "KTBbasicMsgViewController.h"
#import "JXBankInfoViewController.h"
#import "KTBPayMeathodSelectViewController.h"
@implementation KTBVipSignUpViewController {
    MesageCell *NameCell;
    MesageCell *PhoneCell;
    MesageCell *CertCell;
    MesageCell *AddressCell;
    MesageCell *EmailCell;
    NSUserDefaults *user;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"报名信息";
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
    NSLog(@"金额:%@",[BusiIntf curPayOrder].VipPrice);
    //[self RequestForCustomerInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImageView *BackImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
//    BackImg.backgroundColor = LightGrayColor;
    //[self.view addSubview:BackImg];
    
    UITableView *Table = [[UITableView alloc] init];
    Table.dataSource = self;
    Table.delegate = self;
    Table.separatorStyle = UITableViewCellSeparatorStyleNone;
    Table.backgroundColor = [UIColor whiteColor];
    Table.scrollEnabled = NO;
    
    UIImageView *FootView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 300)];
    FootView.userInteractionEnabled = YES;
    FootView.backgroundColor = LightGrayColor;
    UIButton *CommitBtn = [[UIButton alloc] init];
    [CommitBtn setTitle:@"提交" forState:UIControlStateNormal];
    CommitBtn.layer.cornerRadius = 20;
    CommitBtn.backgroundColor = CommonOrange;
    [CommitBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    
    [FootView addSubview:CommitBtn];
    CommitBtn.sd_layout.topSpaceToView(FootView,26).leftSpaceToView(FootView,20).rightSpaceToView(FootView,20).heightIs(44);
    Table.tableFooterView = FootView;
    [self.view addSubview:Table];
    Table.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(self.view,0).rightSpaceToView(self.view,0).heightIs(KscreenHeight);
    
    UITapGestureRecognizer *TapToHideKeyBoard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HideKeyBoard)];
    TapToHideKeyBoard.numberOfTapsRequired = 1;
    TapToHideKeyBoard.cancelsTouchesInView = NO;
    [Table addGestureRecognizer:TapToHideKeyBoard];
}
//隐藏键盘
- (void)HideKeyBoard {
    
    [AddressCell.textFiled resignFirstResponder];
    [EmailCell.textFiled resignFirstResponder];
}
//提交
- (void)commit {
    
    if ([EmailCell.textFiled.text isEqualToString:@""] || [AddressCell.textFiled.text isEqualToString:@""]) {
        [self alert:@"您还有信息没有填写完整哦！"];
        return;
    }
    
    NSString *url = JXUrl;
    user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *MD5Str = [NSString stringWithFormat:@"%@%@%@",AddressCell.textFiled.text,EmailCell.textFiled.text,key];
    NSString *sign = [self md5:MD5Str];
    NSLog(@"%@,%@,%@",token,key,sign);
    NSDictionary *dic = @{
                          @"email":EmailCell.textFiled.text,
                          @"address":AddressCell.textFiled.text,
                          @"token":token,
                          @"sign":sign
                          };
    NSDictionary *actionDic = @{
                                @"action":@"shopVipInfoSubmitState",
                                @"data":dic
                                };
    NSLog(@"actionDic:%@",actionDic);
    NSString *paramis = [actionDic JSONFragment];
    [IBHttpTool postWithURL:url params:paramis success:^(id result) {
        NSDictionary *Dic = [result JSONValue];
        NSLog(@"返回的数据:%@",Dic);
        NSString *code = Dic[@"code"];
        NSString *msg = Dic[@"msg"];
        if (![code isEqualToString:@"000000"]) {
            [self alert:msg];
        }else {
            
            KTBPayMeathodSelectViewController *KTBPaySelect = [[KTBPayMeathodSelectViewController alloc] init];
            KTBPaySelect.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:KTBPaySelect animated:YES];
            KTBPaySelect.hidesBottomBarWhenPushed = NO;
            
            //[self RequestForPay];
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"网络错误!!");
    }];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 15;
    }else {
        return 45;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *indety = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indety];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        if (indexPath.row == 0) {
            ViewsCell *FirstCell = [[ViewsCell alloc] init];
            FirstCell.backgroundColor = LightGrayColor;
            cell = FirstCell;
        }else if (indexPath.row == 1) {
            NameCell = [[MesageCell alloc] init];
            NameCell.label.text = @"姓       名：";
            NameCell.textFiled.placeholder = @"请填写姓名";
            NameCell.textFiled.text = [BusiIntf getUserInfo].ShopName;
            NameCell.textFiled.enabled = NO;
            cell = NameCell;
        }else if (indexPath.row == 2) {
            PhoneCell = [[MesageCell alloc] init];
            PhoneCell.label.text = @"手机号码：";
            PhoneCell.textFiled.placeholder = @"请填写您的手机号码";
            PhoneCell.textFiled.keyboardType = UIKeyboardTypeNumberPad;
            PhoneCell.textFiled.text = [self rePlacePhoneString:[BusiIntf getUserInfo].UserName];
            PhoneCell.textFiled.enabled = NO;
            cell = PhoneCell;
            
        }else if (indexPath.row == 3) {
            CertCell = [[MesageCell alloc] init];
            CertCell.label.text =  @"身份证号：";
            CertCell.textFiled.placeholder = @"请填写您的身份证号";
            CertCell.textFiled.enabled = NO;
            CertCell.textFiled.text = [self rePlaceString:[BusiIntf curPayOrder].shopCard];
            cell = CertCell;
        }else if (indexPath.row == 4) {
            
            AddressCell = [[MesageCell alloc] init];
            AddressCell.label.text = @"邮寄地址：";
            AddressCell.textFiled.placeholder = @"请填写收货地址";
            cell = AddressCell;
            
        }else if (indexPath.row == 5) {
            EmailCell = [[MesageCell alloc] init];
            EmailCell.label.text = @"邮        箱:";
            EmailCell.textFiled.placeholder = @"请填写正确的邮箱地址";
            EmailCell.textFiled.keyboardType = UIKeyboardTypeEmailAddress;
            cell = EmailCell;
        }else {
            
        }
    }
    return cell;
}

//提交成功跳到支付流程
- (void)RequestForPay{
    
    NSString *url = JXUrl;
    NSString *payType = @"1"; //无卡支付
    NSString *orderType = @"11"; //无卡普通支付
    NSString *Amount = [BusiIntf curPayOrder].VipPrice; //金额 [BusiIntf curPayOrder].VipPrice
    NSString *goodsId = @"6666";  //vip会员申请
    [BusiIntf curPayOrder].amount = Amount;
    [SVProgressHUD show];
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
        NSLog(@"%@",dic);
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
            [SVProgressHUD dismiss];
        }else if ([code isEqualToString:@"ERR528"]) {   //未激活，跳转到激活页面(限额)
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:buttonName otherButtonTitles:@"取消", nil];
            alertView.tag = 101;
            [alertView show];
            [SVProgressHUD dismiss];
        }
        
        else if ([msg isEqualToString:@"Success"]){  //创建订单成功跳转
           
            //商户绑定银行卡列表
            NSArray *bindCards = [[NSArray alloc] init];
            if ([dic[@"bindCards"] isKindOfClass:[NSString class]]) {
                
            }else {
                bindCards =  dic[@"bindCards"];
            }
            NSLog(@"bindCards.count:%d",bindCards.count);
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
            [SVProgressHUD dismiss];
            
        }else {   // 创建未成功 提示错误信息
            [self alert:msg];
            [SVProgressHUD dismiss];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
        [SVProgressHUD dismiss];
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 100) {
        if (buttonIndex == 0) {
            [self RequestForBaseInfo];
        }else {
            
        }
    } else if(alertView.tag == 101){
        if (buttonIndex == 0) {
            //            JXBankInfoViewController *JXBankVC = [[JXBankInfoViewController alloc] init];
            //            JXBankVC.hidesBottomBarWhenPushed = YES;
            //            JXBankVC.tag = 100;
            //            [self.navigationController pushViewController:JXBankVC animated:YES];
            //            JXBankVC.hidesBottomBarWhenPushed = NO;
            [self RequestForActiveAccount];
            
        }else {
            
        }
    }
}

//获取商户基本信息状态
- (void)RequestForBaseInfo {
    
    [SVProgressHUD show];
    NSString *url = JXUrl;
    user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *md5 = [NSString stringWithFormat:@"%@",key];
    NSString *sign = [self md5:md5];
    NSDictionary *dic1 = @{
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"shopInfoState",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    //NSLog(@"参数：%@",params);
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSDictionary *dicc = [result JSONValue];
        NSLog(@"返回数据：%@",dicc);
        [BusiIntf curPayOrder].bankAccont = (NSString *)dicc[@"shopAccount"];  //结算卡账号
        [BusiIntf curPayOrder].bankName2 = dicc[@"bankName"];
        [BusiIntf curPayOrder].bankNumber = dicc[@"shopBank"];   //结算卡号码
        [BusiIntf curPayOrder].city = dicc[@"city"];
        [BusiIntf curPayOrder].httpPath1 = dicc[@"pic1"];     //身份证正面
        [BusiIntf curPayOrder].httpPath2 = dicc[@"pic2"];     //身份证反面
        [BusiIntf curPayOrder].httpPath3 = dicc[@"pic3"];     //银行卡正面
        [BusiIntf curPayOrder].httpPath4 = dicc[@"pic4"];     //银行卡 + 人合影
        [BusiIntf curPayOrder].isBank = dicc[@"isBank"];
        [BusiIntf curPayOrder].isBase = dicc[@"isBase"];
        [BusiIntf curPayOrder].isOrg = dicc[@"isOrg"];
        [BusiIntf curPayOrder].isEdit = dicc[@"isEdit"];    //是否可编辑
        [BusiIntf curPayOrder].prov = dicc[@"prov"];
        [BusiIntf curPayOrder].selfStatus = dicc[@"selfStatus"];  //激活状态
        [BusiIntf curPayOrder].shopCard = (NSString *)dicc[@"shopCert"];      //商户身份证号码
        [BusiIntf curPayOrder].shopName = dicc[@"shopName"];   //商户姓名
        [BusiIntf curPayOrder].shopStatus = dicc[@"shopStatus"];  //商户状态
        [BusiIntf curPayOrder].shortName = dicc[@"shortName"];
        [BusiIntf curPayOrder].isRealName = dicc[@"isRealName"];
        [BusiIntf curPayOrder].orgCode = dicc[@"orgId"];       //机构编码
        [BusiIntf curPayOrder].showMsg = dicc[@"showMsg"];     //显示信息
        //[table reloadData];
        
        if ([dicc[@"code"] isEqualToString:@"000000"]) {
            KTBbasicMsgViewController *JXBvc = [[KTBbasicMsgViewController alloc] init];
            JXBvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:JXBvc animated:YES];
            JXBvc.hidesBottomBarWhenPushed = NO;
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"网络申请失败:%@",error);
        [SVProgressHUD dismiss];
    }];
}

//账户激活
- (void)RequestForActiveAccount {
    
    NSString *url = JXUrl;
    user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    //时间戳
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-DD HH:mm:ss"];
    NSTimeZone *timezone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timezone];
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%.0f",[datenow timeIntervalSince1970]];
    
    NSString *md5 = [NSString stringWithFormat:@"%@%@",timeSp,key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                           @"linkId":timeSp,
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"shopActivationSmsState",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSDictionary *dic = [result JSONValue];
        NSLog(@"返回的数据:%@",dic);
        NSString *code = dic[@"code"];
        NSString *msg = dic[@"msg"];
        NSString *orderNo = dic[@"orderNo"];
        NSString *cardPhone = dic[@"cardPhone"];
        NSString *shopCert = dic[@"shopCert"];
        NSString *shopAccount = dic[@"shopAccount"];
        
        if ([code isEqualToString:@"000000"]) {
            
            [BusiIntf curPayOrder].OrderNo = orderNo;    //订单号
            [BusiIntf curPayOrder].shopCard = shopCert;   //身份证
            [BusiIntf curPayOrder].bankAccont = shopAccount;   //银行卡姓名
            [BusiIntf curPayOrder].cardPhone = cardPhone;
            JXBankInfoViewController *JXBankInfo = [[JXBankInfoViewController alloc] init];
            JXBankInfo.tag = 100;
            JXBankInfo.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:JXBankInfo animated:YES];
            JXBankInfo.hidesBottomBarWhenPushed = NO;
        }else {
            [self alert:msg];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"请求网络错误:%@",error);
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

//隐私信息打*处理
-(NSString*)rePlaceString:(NSString*)string{
    if (![string isKindOfClass:[NSString class]]) {
        return @"";
    }else{
        NSMutableString *mutString = [NSMutableString stringWithString:string];
        NSInteger length = [mutString length];
        if (length>=6) {
            [mutString replaceCharactersInRange:NSMakeRange(3, length-6) withString:@"********"];
        }else{
            
        }
        
        return (NSString*)mutString;
    }
}

//隐私信息打*处理 （电话）
-(NSString*)rePlacePhoneString:(NSString*)string{
    if (![string isKindOfClass:[NSString class]]) {
        return @"";
    }else{
        NSMutableString *mutString = [NSMutableString stringWithString:string];
        NSInteger length = [mutString length];
        if (length>=6) {
            [mutString replaceCharactersInRange:NSMakeRange(3, length-6) withString:@"*****"];
        }else{
            
        }
        
        return (NSString*)mutString;
    }
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    [self.view endEditing:YES];
//}

@end
