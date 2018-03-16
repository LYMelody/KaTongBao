//
//  JXWuKaPayViewController.m
//  JingXuan
//
//  Created by rongfeng on 16/6/2.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "JXWuKaPayViewController.h"
#import "macro.h"
#import "UIView+SDAutoLayout.h"
#import "JXCheckOrderViewController.h"
#import "Common.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import <CommonCrypto/CommonDigest.h>
#import "BusiIntf.h"
#import "PubFunc.h"
#import "JXBasicMsgViewController.h"
#import "SVProgressHUD.h"
@interface JXWuKaPayViewController ()

@end

@implementation JXWuKaPayViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"无卡收款";
    if(self.tag == 100) {
        self.title = @"微信收款";
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:19],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = NavBack;
    //自定义返回按钮
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    right.title = @"返回";
    self.navigationItem.backBarButtonItem = right;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *FirstView = [[UIView alloc] init];
    FirstView.backgroundColor = LightGrayColor;
    [self.view addSubview:FirstView];
    FirstView.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(self.view,0).widthIs(KscreenWidth).heightIs(KscreenHeight);
    UIView *backView = [[UIView alloc] init];
    backView.clipsToBounds = YES;
    backView.layer.cornerRadius = 3;
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    backView.sd_layout.topSpaceToView(self.view,100 - 64).leftSpaceToView(self.view,10).rightSpaceToView(self.view,10).heightIs(70);
    
    UILabel *lable = [[UILabel alloc] init];
    lable.text = @"金额";
    lable.font = [UIFont systemFontOfSize:17];
    [backView addSubview:lable];
    lable.sd_layout.topSpaceToView(backView,26.5).leftSpaceToView(backView,13).widthIs(34).heightIs(18);
    
    _textField = [[UITextField alloc] init];
    _textField.placeholder = @"填写金额";
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    _textField.font = [UIFont systemFontOfSize:17];
    _textField.textAlignment = NSTextAlignmentRight;
    [backView addSubview:_textField];
    _textField.sd_layout.centerYEqualToView(lable).rightSpaceToView(backView,44).widthIs(140).heightIs(20);
    
    UILabel *TipsLab = [[UILabel alloc] init];
    TipsLab.text = @"元";
    TipsLab.font = [UIFont systemFontOfSize:17];
    TipsLab.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:TipsLab];
    TipsLab.sd_layout.leftSpaceToView(_textField,5).centerYEqualToView(_textField).widthIs(17).heightIs(18);
    
    UILabel *reminderLable = [[UILabel alloc] init];
    reminderLable.textColor = [UIColor grayColor];
    reminderLable.textAlignment = NSTextAlignmentLeft;
    reminderLable.lineBreakMode = NSLineBreakByWordWrapping;
    reminderLable.numberOfLines = 3;
    reminderLable.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:reminderLable];
    reminderLable.sd_layout.topSpaceToView(backView,7).leftEqualToView(backView).widthIs(320).heightIs(80);
    reminderLable.center = self.view.center;
    //NSMutableAttributedString *mutableAttString = [[NSMutableAttributedString alloc] initWithString:@"注:1:交易限额:单笔最低10元，最高500000元 \n     2:交易时间:2:00-24:00"];
    
    NSMutableAttributedString *mutableAttString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"注:1:交易限额:单笔最低%@元，最高%@元 \n     2:交易时间:%@-%@",[BusiIntf curPayOrder].nocardOrderMin,[BusiIntf curPayOrder].nocardOrderMax,[BusiIntf curPayOrder].nocardOrderStart,[BusiIntf curPayOrder].nocardOrderEnd]];
    
    [mutableAttString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0/255.0 green:149.0/255.0 blue:216.0/255.0 alpha:1] range:NSMakeRange(13, [BusiIntf curPayOrder].nocardOrderMin.length)];
    [mutableAttString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0/255.0 green:149.0/255.0 blue:216.0/255.0 alpha:1] range:NSMakeRange(17+[BusiIntf curPayOrder].nocardOrderMin.length, [BusiIntf curPayOrder].nocardOrderMax.length)];
    [mutableAttString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0/255.0 green:149.0/255.0 blue:216.0/255.0 alpha:1] range:NSMakeRange(25 + [BusiIntf curPayOrder].nocardOrderMin.length + [BusiIntf curPayOrder].nocardOrderMax.length + 7, 1+[BusiIntf curPayOrder].nocardOrderStart.length + [BusiIntf curPayOrder].nocardOrderEnd.length)];
    reminderLable.attributedText = mutableAttString;
    
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:@"快捷收款" forState:UIControlStateNormal];
    [leftButton setBackgroundColor:[UIColor colorWithRed:0/255.0 green:102.0/255.0 blue:176.0/255.0 alpha:1]];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:19];
    leftButton.tag = 3000;
    leftButton.clipsToBounds = YES;
    leftButton.layer.cornerRadius = 3;
    [leftButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    leftButton.sd_layout.topSpaceToView(reminderLable,80).leftSpaceToView(self.view,20).widthIs(KscreenWidth/2).heightRatioToView(self.view,0.1);
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"普通收款" forState:UIControlStateNormal];
    [rightButton setBackgroundColor:[UIColor colorWithRed:230/255.0 green:177.0/255.0 blue:104.0/255.0 alpha:1]];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:19];
    rightButton.tag = 2000;
    rightButton.clipsToBounds = YES;
    rightButton.layer.cornerRadius = 3;
    [rightButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    rightButton.sd_layout.topSpaceToView(reminderLable,80).xIs(KscreenWidth/2).rightEqualToView(backView).heightRatioToView(self.view,0.1);
    
    
    UIButton *NextBtn = [[UIButton alloc] init];
    [NextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [NextBtn setBackgroundColor:NavBack];
    NextBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    NextBtn.layer.cornerRadius = 3;
    NextBtn.tag = 4000;
    [NextBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NextBtn];
    
    NextBtn.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(reminderLable,80).rightSpaceToView(self.view,16).heightIs(45);
    if (self.tag == 100) {
        NextBtn.hidden = NO;
        leftButton.hidden = YES;
        rightButton.hidden = YES;
    }else {
        NextBtn.hidden = YES;
        leftButton.hidden = NO;
        rightButton.hidden = NO;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    

}

//点击收款（普通快捷）
- (void)buttonClick:(UIButton *)btn {
    
//    JXCheckOrderViewController *checkOrder = [[JXCheckOrderViewController alloc] init];
//    [self.navigationController pushViewController:checkOrder animated:YES];
    
    //err504   __到__ 实名认证
    //时间戳
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-DD HH:mm:ss"];
    NSTimeZone *timezone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timezone];
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%.0f",[datenow timeIntervalSince1970]];
    
    NSLog(@"时间戳:%@",timeSp);
    if ([_textField.text isEqualToString:@""]) {
        [self alert:@"请填写金额!"];
        return;
    }
    
    NSString *url = JXUrl;
    
    NSString *orderType = nil;
    NSString *action = @"nocardOrderCreateState";
    if (btn.tag == 2000) {  //普通
        orderType = @"11";
        [BusiIntf curPayOrder].TypeOrder = @"11";
    }else if (btn.tag == 3000) { //快捷
        orderType = @"10";
        [BusiIntf curPayOrder].TypeOrder = @"10";
    }else if (btn.tag == 4000) { //微信收款
        orderType = @"20";
        [BusiIntf curPayOrder].TypeOrder = @"20";
        action = @"weixinOrderCreateState";
        url = @"http://api.ktb.shier365.com/api/action";
    }
    //获取UUID
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *md5 = [NSString stringWithFormat:@"%@%@%@%@%@",_textField.text,timeSp,orderType,version,key];
    NSString *sign = [self md5:md5];
    NSDictionary *dic1 = @{
                           @"linkId":timeSp,
                           @"orderType":orderType,
                           @"amount":_textField.text,
                           @"version":version,
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":action,
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
        [BusiIntf curPayOrder].amount = _textField.text;
        [BusiIntf curPayOrder].OrderNo = oderNo;
        NSArray *bindCards = [[NSArray alloc] init];
        //商户绑定银行卡列表
        if ([dic[@"bindCards"] isEqualToString:@""]) {
            
        }else {
            bindCards =  dic[@"bindCards"];
        }
        //微信二维码
        NSString *qrcode = nil;
//        if ([dic[@"qrcode"] isEqualToString:@""]) {
//            
//        }else {
//            qrcode = dic[@"qrcode"];
//            
//        }
        NSLog(@"bindCards.count:%d",bindCards.count);
        NSLog(@"上传的时间:%@",oderReqTime);
        //如果是未注册 跳到注册页面
        if ([code isEqualToString:@"ERR504"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"去实名认证" otherButtonTitles:@"取消", nil];
            alertView.tag = 100;
            [alertView show];
        }else if ([msg isEqualToString:@"Success"]){  //创建订单成功跳转
            //NSArray *cardList = [[NSArray alloc] initWithObjects:bankDic1,bankDic2, nil];
            
            JXCheckOrderViewController *checkOrder = [[JXCheckOrderViewController alloc] init];
            //checkOrder.tag = 100;
            checkOrder.amount = _textField.text;
            checkOrder.orderTime = oderReqTime;
            checkOrder.orderNo = oderNo;
            checkOrder.bankArray = bindCards;
            checkOrder.qrcode = qrcode;
            [self.navigationController pushViewController:checkOrder animated:YES];
        }else {   // 创建未成功 提示错误信息
            [self alert:msg];
        }
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
        
    }];
}

- (void)RequestForCreateOrder {
    
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
        //初始化滑动视图
        if ([dicc[@"code"] isEqualToString:@"000000"]) {
            JXBasicMsgViewController *JXBvc = [[JXBasicMsgViewController alloc] init];
            [self.navigationController pushViewController:JXBvc animated:YES];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"网络申请失败:%@",error);
        [SVProgressHUD dismiss];
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 100) {
        if (buttonIndex == 0) {
            [self RequestForBaseInfo];
        }else {
            
        }
    }
    
}
//收缩键盘
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    [self.view endEditing:YES];
//}

- (void)alert:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
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
