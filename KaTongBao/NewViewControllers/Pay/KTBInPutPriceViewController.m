//
//  KTBInPutPriceViewController.m
//  KaTongBao
//
//  Created by rongfeng on 16/6/29.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "KTBInPutPriceViewController.h"
#import "macro.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "SVProgressHUD.h"
#import "BusiIntf.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import <CommonCrypto/CommonDigest.h>
#import "KTBbasicMsgViewController.h"
#import "JXCheckOrderViewController.h"
#import "TwoDBarCodePayViewController.h"
#import "JXBankInfoViewController.h"
#import "KTBAuthCertifyViewController.h"
#import "GiFHUD.h"
@interface KTBInPutPriceViewController ()

@end

@implementation KTBInPutPriceViewController {
    UIImageView *GrayBackImg;
    UILabel *_amtLabel;
    UILabel *MoneyLab;
    NSUserDefaults *user;
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"商户充值";
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = NavBack;
    self.tabBarController.tabBar.hidden = YES;
    self.tabBarController.tabBar.userInteractionEnabled = YES;
    
    
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
   
    //自定义返回按钮
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    right.title = @"返回";
    self.navigationItem.backBarButtonItem = right;
    self.navigationController.navigationBar.barTintColor = NavBack;
    
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    UIImageView *BackImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    BackImg.backgroundColor = LightGrayColor;

    [self.view addSubview:BackImg];
    
    UIScrollView *Scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    //Scroll.contentSize = CGSizeMake(KscreenWidth, KscreenHeight);
    Scroll.backgroundColor = [UIColor lightGrayColor];
    Scroll.userInteractionEnabled = YES;
    //[self.view addSubview:Scroll];
    
    //金额输入视图
    UIImageView *WheitBackImg = [[UIImageView alloc] init];
    WheitBackImg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:WheitBackImg];
    WheitBackImg.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,10 ).rightSpaceToView(self.view,16).heightIs(100);
    UILabel *JinE = [[UILabel alloc] init];
    JinE.text = @"金额";
    JinE.font = [UIFont systemFontOfSize:16];
    [WheitBackImg addSubview:JinE];
    JinE.sd_layout.leftSpaceToView(WheitBackImg,10).topSpaceToView(WheitBackImg,8).widthIs(60).heightIs(20);
    MoneyLab = [[UILabel alloc] init];
    MoneyLab.font = [UIFont systemFontOfSize:30];
    MoneyLab.textColor = LightBlue;
    MoneyLab.text = @"0";
    MoneyLab.textAlignment = NSTextAlignmentCenter;
    [WheitBackImg addSubview:MoneyLab];
    MoneyLab.sd_layout.leftSpaceToView(WheitBackImg,5).rightSpaceToView(WheitBackImg,5).topSpaceToView(JinE,3).heightIs(50);
    UILabel *YuanLab = [[UILabel alloc] init];
    YuanLab.text = @"元";
    [WheitBackImg addSubview:YuanLab];
    YuanLab.sd_layout.rightSpaceToView(WheitBackImg,10).bottomSpaceToView(WheitBackImg,10).widthIs(20).heightIs(15);

    //键盘视图
    GrayBackImg = [[UIImageView alloc] init];
    GrayBackImg.backgroundColor = Color(192, 192, 192);
    GrayBackImg.userInteractionEnabled = YES;
    [self.view addSubview:GrayBackImg];
    GrayBackImg.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).bottomSpaceToView(self.view,0).heightIs(274);
    
     //提示Lab
    _amtLabel = [[UILabel alloc] init];
    _amtLabel.textAlignment = NSTextAlignmentLeft;
    _amtLabel.numberOfLines = 0;
    //_amtLabel.adjustsFontSizeToFitWidth = YES;
    _amtLabel.font = [UIFont systemFontOfSize:11];
    NSString *msgOne = @"1、单笔2万，单卡5万，每日结算额度10万。首次交易的银行卡单笔单日限额7000，7天后自动开放至单笔2万；";
    NSString *msgTwo = @"2、T+1到账(周末节假日不支持到账)；";
    NSString *msgThree = @"3、交易完成后，请进入“钱包”点击结算。";
    _amtLabel.text = [NSString stringWithFormat:@"%@\n%@\n%@\n",msgOne,msgTwo,msgThree];
    if ([[BusiIntf curPayOrder].TypeOrder isEqualToString:@"11"]) {
        _amtLabel.text = [BusiIntf curPayOrder].T1Tip;
    }else if ([[BusiIntf curPayOrder].TypeOrder isEqualToString:@"10"]) {
        _amtLabel.text = [BusiIntf curPayOrder].T0Tip;
    }
    [self.view addSubview:_amtLabel];
    _amtLabel.sd_layout.leftSpaceToView(self.view,9).topSpaceToView(WheitBackImg,3).rightSpaceToView(self.view,9).bottomSpaceToView(GrayBackImg,3);

    [self CreateButtons];

}

//创建键盘按钮
- (void)CreateButtons {
    
    NSInteger index = 0;
    NSMutableArray *numberAry = [NSMutableArray arrayWithObjects:@"清除",@"✕",@"0",@"3",@"2",@"1",@"6",@"5",@"4",@"9",@"8",@"7", nil];
    for (NSInteger i = 0;i<4;i++) {
        for (NSInteger j = 0; j< 3; j++) {
            UIButton *BtnOne = [[UIButton alloc] init];
            BtnOne.tag = index++;
            [BtnOne setTitle:[numberAry lastObject] forState:UIControlStateNormal];
            [numberAry removeLastObject];
            [BtnOne setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            BtnOne.backgroundColor = [UIColor whiteColor];
            [BtnOne addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [GrayBackImg addSubview:BtnOne];
            BtnOne.sd_layout.leftSpaceToView(GrayBackImg,10 + j*80).topSpaceToView(GrayBackImg,10 + i*65).heightIs(57).widthIs(72);
        }
    }
    //无卡支付
    UIButton *ClearBtn = [[UIButton alloc] init];
    
    ClearBtn.titleLabel.numberOfLines = 0;
    [ClearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    ClearBtn.backgroundColor = [UIColor whiteColor];
    ClearBtn.tag = 100;
    [ClearBtn addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [GrayBackImg addSubview:ClearBtn];
    
    //微信支付
    UIButton *SureBtn = [[UIButton alloc] init];
    
    SureBtn.titleLabel.numberOfLines = 0;
    [SureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    SureBtn.backgroundColor = [UIColor whiteColor];
    SureBtn.tag = 101;
    [SureBtn addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [GrayBackImg addSubview:SureBtn];
   
    //支付宝支付
    UIButton *ZhiFuBaoBtn = [[UIButton alloc] init];
    [ZhiFuBaoBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    ZhiFuBaoBtn.titleLabel.numberOfLines = 0;
    ZhiFuBaoBtn.backgroundColor = [UIColor whiteColor];
    [ZhiFuBaoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    ZhiFuBaoBtn.tag = 102;
    [ZhiFuBaoBtn addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    //三个支付按钮布局
    if ([[BusiIntf curPayOrder].TypeOrder isEqualToString:@"11"]) { //普通收款
        
        [ClearBtn setBackgroundImage:[UIImage imageNamed:@"无卡支付"] forState:UIControlStateNormal];
        [SureBtn setBackgroundImage:[UIImage imageNamed:@"微信支付"] forState:UIControlStateNormal];
        
        ClearBtn.sd_layout.rightSpaceToView(GrayBackImg,10).topSpaceToView(GrayBackImg,10).widthIs(63).heightIs(121);
         SureBtn.sd_layout.rightSpaceToView(GrayBackImg,10).topSpaceToView(ClearBtn,9).widthIs(63).heightIs(121);
        
    }else {   //快捷支付
        
        [ClearBtn setBackgroundImage:[UIImage imageNamed:@"无卡支付2"] forState:UIControlStateNormal];
        [SureBtn setBackgroundImage:[UIImage imageNamed:@"微信支付2"] forState:UIControlStateNormal];
        [ZhiFuBaoBtn setBackgroundImage:[UIImage imageNamed:@"支付宝支付"] forState:UIControlStateNormal];
        
        //快捷支付添加支付宝支付按钮
        [GrayBackImg addSubview:ZhiFuBaoBtn];
        ClearBtn.sd_layout.rightSpaceToView(GrayBackImg,10).topSpaceToView(GrayBackImg,10).widthIs(63).heightIs(80);
        SureBtn.sd_layout.rightSpaceToView(GrayBackImg,10).topSpaceToView(ClearBtn,6).widthIs(63).heightIs(80);
        ZhiFuBaoBtn.sd_layout.rightSpaceToView(GrayBackImg,10).topSpaceToView(SureBtn,6).widthIs(63).heightIs(80);
    }
    
}
//按钮
- (void)ButtonClick:(UIButton *) sender {
    
    NSLog(@"按钮的tag值:%ld",(long)sender.tag);
    
//    if (101 == sender.tag){  //扫码支付
//        //MoneyLab.text = @"0";
//        
//        TwoDBarCodePayViewController *TwoDBarCode = [[TwoDBarCodePayViewController alloc] init];
//        [self.navigationController pushViewController:TwoDBarCode animated:YES];
//        
//    }
    //([MoneyLab.text length]>[MoneyLab.text rangeOfString:@"."].location+2 && 100!=sender.tag) ||
    if(!(sender.tag == 101 || sender.tag == 10)) {
        if ( MoneyLab.text.length>8) {
            return;
        }
    }
    if (9 > sender.tag) {//数字
        
        if (![MoneyLab.text isEqualToString:@"0"]) {
            MoneyLab.text = [NSString stringWithFormat:@"%@%@",MoneyLab.text,sender.titleLabel.text];
        }else{
            MoneyLab.text = [NSString stringWithFormat:@"%@",sender.titleLabel.text];
        }
        
    }else if (9 == sender.tag){//0
        
        if (![MoneyLab.text isEqualToString:@"0"]) {
            MoneyLab.text = [NSString stringWithFormat:@"%@0",MoneyLab.text];
        }
        
    }else if (10 == sender.tag){ // ×
        if (![MoneyLab.text isEqualToString:@"0"]) {
            
            if (1 >= MoneyLab.text.length) {
                MoneyLab.text = @"0";
            }else{
                MoneyLab.text = [MoneyLab.text substringToIndex:MoneyLab.text.length-1];
            }
        }
    }else if (11 == sender.tag){ // 00
//        if (![MoneyLab.text isEqualToString:@"0"]) {
//            MoneyLab.text = [NSString stringWithFormat:@"%@00",MoneyLab.text];
//        }
         MoneyLab.text = @"0";
    }
    if (sender.tag == 100 || sender.tag == 101 || sender.tag == 102) {
        
        if ([MoneyLab.text isEqualToString:@"0"]) {
            [self alert:@"交易额度不能低于1元!"];
            return;
        }
        //下订单
        [BusiIntf curPayOrder].amount = MoneyLab.text;
        NSString *url = JXUrl;
        NSString *payType = nil;
        //支付类型
        if (sender.tag == 100) { //无卡支付
            payType = @"1";
        }else if(sender.tag == 101){  //微信支付
            payType = @"3";
            
        }else {           //支付宝支付
             payType = @"4";
        }
//        if (sender.tag == 101) {
//            if ([[BusiIntf curPayOrder].TypeOrder isEqualToString:@"10"]) {
//                [self alertMsg:@"扫码支付暂不支持快捷收款，请使用普通收款!"];
//                return;
//            }
//        }
        //[SVProgressHUD show];
        [GiFHUD showWithOverlay];
        //时间戳
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-DD HH:mm:ss"];
        NSTimeZone *timezone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [formatter setTimeZone:timezone];
        NSDate *datenow = [NSDate date];
        NSString *timeSp = [NSString stringWithFormat:@"%.0f",[datenow timeIntervalSince1970]];
        
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *token = [user objectForKey:@"token"];
        NSString *key = [user objectForKey:@"key"];
        NSString *md5 = [NSString stringWithFormat:@"%@%@%@%@%@%@",MoneyLab.text,timeSp,[BusiIntf curPayOrder].TypeOrder,payType,version,key];
        NSString *sign = [self md5:md5];
        NSDictionary *dic1 = @{
                               @"linkId":timeSp,
                               @"payType":payType,
                               @"orderType":[BusiIntf curPayOrder].TypeOrder,
                               @"amount":MoneyLab.text,
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
                //[SVProgressHUD dismiss];
                [GiFHUD dismiss];
            }else if ([code isEqualToString:@"ERR528"]) {   //未激活，跳转到激活页面(限额)
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:buttonName otherButtonTitles:@"取消", nil];
                alertView.tag = 101;
                [alertView show];
                //[SVProgressHUD dismiss];
                [GiFHUD dismiss];
            }
            
            else if ([msg isEqualToString:@"Success"]){  //创建订单成功跳转
                if (sender.tag == 100) { //无卡支付
                    //商户绑定银行卡列表
                    NSArray *bindCards = [[NSArray alloc] init];
                    if ([dic[@"bindCards"] isKindOfClass:[NSString class]]) {
                        
                    }else {
                        bindCards =  dic[@"bindCards"];
                    }
                    NSLog(@"bindCards.count:%lu",(unsigned long)bindCards.count);
                    JXCheckOrderViewController *checkOrder = [[JXCheckOrderViewController alloc] init];
                    //checkOrder.tag = 100;
                    checkOrder.amount = MoneyLab.text;
                    checkOrder.orderTime = oderReqTime;
                    checkOrder.orderNo = oderNo;
                    checkOrder.bankArray = bindCards;
                    checkOrder.qrcode = qrcode;
                    checkOrder.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:checkOrder animated:YES];
                    checkOrder.hidesBottomBarWhenPushed = NO;
                    //[SVProgressHUD dismiss];
                    [GiFHUD dismiss];
                }else {              //微信支付、支付宝支付
                    
                    TwoDBarCodePayViewController *TwoDBarCode = [[TwoDBarCodePayViewController alloc] init];
                    TwoDBarCode.money = MoneyLab.text;
                    TwoDBarCode.orderTime = oderReqTime;
                    TwoDBarCode.orderNo = oderNo;
                    TwoDBarCode.codeImgUrl = codeImgUrl;
                    
                    //区分下微信支付和支付宝支付
                    if (sender.tag == 101) { //微信支付
                        TwoDBarCode.tag = 1;
                    }else {                  //支付宝支付
                        TwoDBarCode.tag = 2;
                    }
                    
                    [self.navigationController pushViewController:TwoDBarCode animated:YES];
                    //[SVProgressHUD dismiss];
                    [GiFHUD dismiss];
                }
                
            }else {   // 创建未成功 提示错误信息
                [self alertMsg:msg];
                //[SVProgressHUD dismiss];
                [GiFHUD dismiss];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"网络请求失败:%@",error);
            //[SVProgressHUD dismiss];
            [GiFHUD dismiss];
        }];
    }
}

-(void)alertMsg: (NSString *)msg
{
    [SVProgressHUD dismiss];
    
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:nil message: msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
    //[alter release];
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
    
    //[SVProgressHUD show];
    [GiFHUD showWithOverlay];
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
            KTBAuthCertifyViewController *JXBvc = [[KTBAuthCertifyViewController alloc] init];
            JXBvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:JXBvc animated:YES];
            JXBvc.hidesBottomBarWhenPushed = NO;
        }
        //[SVProgressHUD dismiss];
        [GiFHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"网络申请失败:%@",error);
        //[SVProgressHUD dismiss];
        [GiFHUD dismiss];
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
- (void)alert:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
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

- (void)click {
    NSLog(@"^^&^&^&^&^&^&^&^&");
}

//布局界面
- (void)CreateViews {
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) hideTabBar:(BOOL) hidden{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0];
    
    for(UIView *view in self.tabBarController.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, 568 + 49, view.frame.size.width, view.frame.size.height)];
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x, 568-49, view.frame.size.width, view.frame.size.height)];
            }
        }
        else
        {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 568)];
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width,  568-49)];
            }
        }
    }
    
    [UIView commitAnimations];
}

- (void)makeTabBarHidden:(BOOL)hide
{
    if ( [self.tabBarController.view.subviews count] < 2 )
    {
        return;
    }
    UIView *contentView;
    
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
    {
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    }
    else
    {
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    }
    //    [UIView beginAnimations:@"TabbarHide" context:nil];
    if ( hide )
    {
        contentView.frame = self.tabBarController.view.bounds;
    }
    else
    {
        contentView.frame = CGRectMake(self.tabBarController.view.bounds.origin.x,
                                       self.tabBarController.view.bounds.origin.y,
                                       self.tabBarController.view.bounds.size.width,
                                       self.tabBarController.view.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    }
    
    self.tabBarController.tabBar.hidden = hide;
}

- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
