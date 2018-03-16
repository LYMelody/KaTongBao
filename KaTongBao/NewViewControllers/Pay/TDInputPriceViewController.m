//
//  TDInputPriceViewController.m
//  CFT
//
//  Created by 李 玉清 on 15/6/15.
//  Copyright (c) 2015年 TangDi. All rights reserved.
//

#import "TDInputPriceViewController.h"
#import "UIView+SDAutoLayout.h"
#import "Common.h"
#import "JXCheckOrderViewController.h"
#import "macro.h"
#import "SVProgressHUD.h"
#import "BusiIntf.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import <CommonCrypto/CommonDigest.h>
#import "KTBbasicMsgViewController.h"
typedef enum {
    ACTION_UNKNOWN = 0,
    ACTION_FLOW,
    ACTION_TEST,
    ACTION_TEST_EMV,
    ACTION_CONSUM,
    
} EU_POS_ACTION;

@interface TDInputPriceViewController (){

    NSString * _MINAMT;
    NSString * _MAXAMT;
    EU_POS_ACTION m_euAction;
    UIAlertView * Posalter;
    NSInteger _index;
    NSTimer *ConnectBTTimeOut;
    
}

@end

@implementation TDInputPriceViewController {
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self viewWillDisappear:animated];
    //[self disConectMof];
    //将视图设置为可点击
    self.view.userInteractionEnabled = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"请选择收款方式";
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = NavBack;
    self.tabBarController.tabBar.hidden = YES;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    //自定义返回按钮
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    right.title = @"返回";
    self.navigationItem.backBarButtonItem = right;
    self.navigationController.navigationBar.barTintColor = NavBack;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"收款金额";
    //self.view.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight + 49);
    
    UIImageView *BackImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    BackImg.userInteractionEnabled = YES;
    BackImg.backgroundColor = LightGrayColor;
    [self.view addSubview:BackImg];
    
    self.MoneyView.backgroundColor = [UIColor whiteColor];
    
    _amtLabel.textAlignment = NSTextAlignmentLeft;
    _amtLabel.numberOfLines = 0;
    _amtLabel.adjustsFontSizeToFitWidth = YES;
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
    [self.view addSubview:self.MoneyView];
    [self.view addSubview:self.KeyBoardView];
    self.MoneyView.sd_layout.leftSpaceToView(self.view,10).topSpaceToView(self.view,10).rightSpaceToView(self.view,10).heightIs(100);
    self.KeyBoardView.sd_layout.leftSpaceToView(self.view,0).bottomSpaceToView(self.view,40).widthIs(KscreenWidth).heightIs(225);
    self.amtLabel.sd_layout.leftSpaceToView(self.view,10).topSpaceToView(self.MoneyView,10).rightSpaceToView(self.view,10).bottomSpaceToView(self.KeyBoardView,5);

    
}

-(void)viewWillDisappear:(BOOL)animated{
    
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

- (IBAction)clickButton:(UIButton *)sender {
    
    //下订单
    [BusiIntf curPayOrder].amount = _moneyLabel.text;
    NSString *url = JXUrl;
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
    NSString *md5 = [NSString stringWithFormat:@"%@%@%@%@%@",_moneyLabel.text,timeSp,[BusiIntf curPayOrder].TypeOrder,version,key];
    NSString *sign = [self md5:md5];
    NSDictionary *dic1 = @{
                           @"linkId":timeSp,
                           @"orderType":[BusiIntf curPayOrder].TypeOrder,
                           @"amount":_moneyLabel.text,
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
        
        [BusiIntf curPayOrder].OrderNo = oderNo;
        
        
        //微信二维码
        NSString *qrcode = nil;
        
        NSLog(@"上传的时间:%@",oderReqTime);
        //如果是未注册 跳到注册页面
        if ([code isEqualToString:@"ERR504"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"去实名认证" otherButtonTitles:@"取消", nil];
            alertView.tag = 100;
            [alertView show];
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
            checkOrder.amount = _moneyLabel.text;
            checkOrder.orderTime = oderReqTime;
            checkOrder.orderNo = oderNo;
            checkOrder.bankArray = bindCards;
            checkOrder.qrcode = qrcode;
            [self.navigationController pushViewController:checkOrder animated:YES];
        }else {   // 创建未成功 提示错误信息
            [self alertMsg:msg];
        }
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
        
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 100) {
        if (buttonIndex == 0) {
            [self RequestForBaseInfo];
        }else {
            
        }
    }
    
}
//获取商户基本信息状态
- (void)RequestForBaseInfo {
    
    [SVProgressHUD show];
    NSString *url = JXUrl;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
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
            [self.navigationController pushViewController:JXBvc animated:YES];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"网络申请失败:%@",error);
        [SVProgressHUD dismiss];
    }];
    
}

-(void)alertMsg: (NSString *)msg
{
    [SVProgressHUD dismiss];
    
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:nil message: msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
    //[alter release];
}

- (IBAction)clickNumberButton:(UIButton *)sender {
    if (11 == sender.tag){
        if (![_moneyLabel.text isEqualToString:@"0"]) {
            
            if (1 >= _moneyLabel.text.length) {
                _moneyLabel.text = @"0";
            }else{
                _moneyLabel.text = [_moneyLabel.text substringToIndex:_moneyLabel.text.length-1];
            }
        }
    }
    
    if (([_moneyLabel.text length]>[_moneyLabel.text rangeOfString:@"."].location+2 && 11!=sender.tag) || _moneyLabel.text.length>8) {
        return;
    }
    
    if (10 > sender.tag) {//数字
        
        if (![_moneyLabel.text isEqualToString:@"0"]) {
            _moneyLabel.text = [NSString stringWithFormat:@"%@%ld",_moneyLabel.text,(long)sender.tag];
        }else{
            _moneyLabel.text = [NSString stringWithFormat:@"%ld",(long)sender.tag];
        }
        
    }else if (20 == sender.tag){//0
        
        if (![_moneyLabel.text isEqualToString:@"0"]) {
            _moneyLabel.text = [NSString stringWithFormat:@"%@0",_moneyLabel.text];
        }
        
    }else if (21 == sender.tag){ // .
        if ([_moneyLabel.text length] && [_moneyLabel.text rangeOfString:@"."].length==0) {
            _moneyLabel.text = [NSString stringWithFormat:@"%@.",_moneyLabel.text];
        }
        
    }else if (22 == sender.tag){ // 00
        if (![_moneyLabel.text isEqualToString:@"0"]) {
            _moneyLabel.text = [NSString stringWithFormat:@"%@00",_moneyLabel.text];
        }
        
    }
}
//----------------------------------------------- 魔方 ------------------------------------------
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

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:YES];
    
    
}

@end
