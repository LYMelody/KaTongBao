//
//  PayOrderViewController.m
//  wujieNew
//
//  Created by rongfeng on 16/2/24.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "PayOrderViewController.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "BusiIntf.h"
#import <CommonCrypto/CommonDigest.h>
#import "IBHttpTool.h"
#import "SBJSON.h"
#import "SVProgressHUD.h"
#import "YiBaoVC.h"
#import "CreatOrder.h"
#import "SDImageCache.h"
#import "macro.h"
#import "TDInputPriceViewController.h"
#import "BusiIntf.h"
#import "KTBInPutPriceViewController.h"
@interface PayOrderViewController ()

@end

@implementation PayOrderViewController {
    
    NSString *OrderType;
    NSString *orderStatus;
    NSString *forwardUrl;
    NSString *forwardName;
    
    UIButton *WuJieT1Btn;
    UIButton *YiBaoT1Btn;
    UIButton *WuJieT0Btn;
    UIButton *YinLianT0Btn;
    UIButton *ShuaShuaBtn;
    UIButton *AnNongT1;
    NSString *T1msg;
    NSString *T0msg;
    NSString *UP0msg;
    NSString *HST0msg;
    NSString *ANmsg;
    
    NSString *T1Bank;
    NSString *T0Bank;
    NSString *HST0Bank;
    NSString *ANBank;
    
   
    NSString *CanTimePay;
    UILabel *PTTipsLab;
    UILabel *LargeAmountLab;
}

- (void)viewWillAppear:(BOOL)animated {
    
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
    
    
}
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    //禁止右滑返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"请选择收款方式";
    self.view.backgroundColor = [UIColor whiteColor];
    //self.navigationController.navigationBar.hidden = NO;
    //自定义返回按钮
//    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"  返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
//    self.navigationItem.leftBarButtonItem = left;
//    self.navigationItem.hidesBackButton = YES;
//    self.navigationController.navigationBar.barTintColor = NavBack;
    
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] init];
    leftBtn.title = @"返回";
    //[[UINavigationBar appearance] setTintColor:LightBlue];
    self.navigationItem.backBarButtonItem = leftBtn;
    
    UIScrollView *Scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    Scroll.backgroundColor = LightGrayColor;

    if (KscreenHeight < 568) {
        Scroll.contentSize = CGSizeMake(KscreenWidth, KscreenHeight + 40);
    }else {
        Scroll.contentSize = CGSizeMake(KscreenWidth, KscreenHeight );
    }
    
    [self.view addSubview:Scroll];
    
    
    UIImageView *backImg = [[UIImageView alloc] init];
    backImg.frame = CGRectMake(0, 0 - 60, KscreenWidth, KscreenHeight);
    backImg.backgroundColor = LightGrayColor;
    [Scroll addSubview:backImg];
    
    UIImageView *PuTongBackImg = [[UIImageView alloc] init];
    PuTongBackImg.backgroundColor = [UIColor whiteColor];
    PuTongBackImg.userInteractionEnabled = YES;
    [Scroll addSubview:PuTongBackImg];
    PuTongBackImg.sd_layout.leftSpaceToView(Scroll,16).topSpaceToView(Scroll,81 - 60).rightSpaceToView(Scroll,16).heightIs(170);
    UILabel *PuTongLab = [[UILabel alloc] init];
    PuTongLab.text = @"普通收款";
    PuTongLab.font = [UIFont systemFontOfSize:15];
    PuTongLab.textColor = [UIColor colorWithRed:55/255.0 green:131/255.0 blue:255/255.0 alpha:1];
    [PuTongBackImg addSubview:PuTongLab];
    PuTongLab.sd_layout.leftSpaceToView(PuTongBackImg,17.5).topSpaceToView(PuTongBackImg,16).widthIs(70).heightIs(17.5);
    
    WuJieT1Btn = [[UIButton alloc] init];
    WuJieT1Btn.tag = 101;
    [WuJieT1Btn setBackgroundImage:[UIImage imageNamed:@"卡捷通图标.png"] forState:UIControlStateNormal];
    [WuJieT1Btn addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    [PuTongBackImg addSubview:WuJieT1Btn];
    WuJieT1Btn.sd_layout.leftSpaceToView(PuTongBackImg,112.5).topSpaceToView(PuTongBackImg,53.5).widthIs(63.5).heightIs(63.5);
    
    
    PTTipsLab = [[UILabel alloc] init];
    PTTipsLab.font = [UIFont systemFontOfSize:13];
    PTTipsLab.textAlignment = NSTextAlignmentCenter;
    PTTipsLab.text = @"T+1到账、交易时间：00:00-23:00";
    PTTipsLab.text = [BusiIntf curPayOrder].T1;
    PTTipsLab.textColor = Color(100, 100, 100);
    PTTipsLab.numberOfLines = 0;
    [PuTongBackImg addSubview:PTTipsLab];
    PTTipsLab.sd_layout.leftSpaceToView(PuTongBackImg,16).topSpaceToView(WuJieT1Btn,10).rightSpaceToView(PuTongBackImg,16).heightIs(40);
    
    UIImageView *KBackImg = [[UIImageView alloc] init];
    KBackImg.backgroundColor = [UIColor whiteColor];
    KBackImg.userInteractionEnabled = YES;
    [Scroll addSubview:KBackImg];
    KBackImg.sd_layout.leftSpaceToView(Scroll,16).topSpaceToView(PuTongBackImg,55.5).rightSpaceToView(Scroll,16).heightIs(170);
    UILabel *KuaiJieLab = [[UILabel alloc] init];
    KuaiJieLab.text = @"快捷收款";
    KuaiJieLab.font = [UIFont systemFontOfSize:15];
    KuaiJieLab.textColor = [UIColor colorWithRed:55/255.0 green:131/255.0 blue:255/255.0 alpha:1];
    [KBackImg addSubview:KuaiJieLab];
    KuaiJieLab.sd_layout.leftSpaceToView(KBackImg,17.5).topSpaceToView(KBackImg,15.5).widthIs(70).heightIs(17.5);
    WuJieT0Btn = [[UIButton alloc] init];
    WuJieT0Btn.tag = 103;
    [WuJieT0Btn setBackgroundImage:[UIImage imageNamed:@"卡捷通图标.png"] forState:UIControlStateNormal];
    [WuJieT0Btn addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    [KBackImg addSubview:WuJieT0Btn];
    WuJieT0Btn.sd_layout.leftSpaceToView(KBackImg,112.5).topSpaceToView(KBackImg,53.5).widthIs(63.5).heightIs(63.5);
    
    LargeAmountLab = [[UILabel alloc] init];
    LargeAmountLab.font = [UIFont systemFontOfSize:14];
    LargeAmountLab.textColor = Color(100, 100, 100);
    LargeAmountLab.textAlignment = NSTextAlignmentCenter;
    LargeAmountLab.text = @"实时到账、交易时间：9:00-21:00";
    LargeAmountLab.text = [BusiIntf curPayOrder].T0;
    LargeAmountLab.numberOfLines = 0;
    [KBackImg addSubview:LargeAmountLab];
    LargeAmountLab.sd_layout.leftSpaceToView(KBackImg,16).topSpaceToView(WuJieT0Btn,21.5).rightSpaceToView(KBackImg,16).heightIs(30);

    // Do any additional setup after loading the view.
}
- (void)back {
    
    [self.navigationController popViewControllerAnimated: YES];
    
}

//点击收款
- (void)pay:(UIButton *)btn {
    
    if (btn.tag == 101) { //普通收款
        [BusiIntf curPayOrder].TypeOrder = @"11";
    }else {   //快捷收款
        [BusiIntf curPayOrder].TypeOrder = @"10";
    }
    
//    TDInputPriceViewController *TDInputVc = [[TDInputPriceViewController alloc] init];
//    TDInputVc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:TDInputVc animated:YES];
//    TDInputVc.hidesBottomBarWhenPushed = NO;
    
    KTBInPutPriceViewController *Input = [[KTBInPutPriceViewController alloc] init];
    Input.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:Input animated:YES];
    Input.hidesBottomBarWhenPushed = NO;
}

//点击易宝
- (void)RequestForYiBao {
    
    
    NSString *url = BaseUrl;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    //NSString *orderno = [user objectForKey:@"orderNo"];
    NSString *md5 = [NSString stringWithFormat:@"%@%@",token,key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic = @{
                          @"token":token,
                          @"sign":sign
                          };
    NSDictionary *dicc = @{
                           @"action":@"YeepayOrder",
                           @"data":dic
                           };
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        [SVProgressHUD dismiss];
        NSDictionary *dicc = [result JSONValue];
        NSString *code = dicc[@"code"];
        NSString *content = dicc[@"content"];
        forwardUrl = dicc[@"forwardUrl"];
        forwardName = dicc[@"forwardName"];
        NSLog(@"%@",dicc);
        if (![code isEqualToString:@"000000"]) {
            if (forwardUrl) {
                UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"提示" message:content delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"收款宝",nil];
                Alert.tag = 101;
                Alert.delegate = self;
                [Alert show];
            }else {
                UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"提示" message:content delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil,nil];
                Alert.tag = 1001;
                Alert.delegate = self;
                [Alert show];
            }
        }else {
            //易宝支付
            // NSDictionary *url = [self getShopUrl:GoodsID_YB];
            if (content) {
                //[UIManager doNavWnd:WndWebShop inputParam:content];
                YiBaoVC *YiBao = [[YiBaoVC alloc] init];
                YiBao.Url = content;
                YiBao.Name = @"收款宝";
                [self.navigationController pushViewController:YiBao animated:YES];
                
            } else {
                
            }
        }
    }
                    failure:^(NSError *error) {
                        NSLog(@"请求失败:%@",error);
                        [self alert:@"请求网络失败！"];
                        
                        [SVProgressHUD dismiss];
                    }];
}
//收款图片
- (void)RequestForInfo {
    
    NSString *url = BaseUrl;
    [SVProgressHUD show];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    //NSString *orderno = [user objectForKey:@"orderNo"];
    NSString *md5 = [NSString stringWithFormat:@"%@%@",token,key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic = @{
                          @"token":token,
                          @"sign":sign
                          };
    NSDictionary *dicc = @{
                           @"action":@"ChannelList",
                           @"data":dic
                           };
    NSString *params = [dicc JSONFragment];
    
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSDictionary *dicc = [result JSONValue];
        //NSString *code = dicc[@"code"];
        
        NSArray *content = dicc[@"content"];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSLog(@"收款信息内容:%@",content);
        for (NSInteger i = 0;i<content.count;i++) {
            NSDictionary *ImgDic = content[i];
            NSString *url = ImgDic[@"iconUrl"];
            NSString *minPrice  = ImgDic[@"minPrice"];
            //设置收款图标
            if ([ImgDic[@"orderType"] isEqualToString:@"RB1"]) {
                [WuJieT1Btn setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]] forState:UIControlStateNormal];
                [user setObject:url forKey:@"T1url"];
                [user setObject:minPrice forKey:@"RB1MIN"];
            }else if ([ImgDic[@"orderType"] isEqualToString:@"RB0"]) {
                [WuJieT0Btn setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]] forState:UIControlStateNormal];
                [user setObject:url forKey:@"T0url"];
                [user setObject:minPrice forKey:@"RB0MIN"];
            }else if ([ImgDic[@"orderType"] isEqualToString:@"UP0"]) {
                [YinLianT0Btn setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]] forState:UIControlStateNormal];
                [user setObject:url forKey:@"UP0url"];
                [user setObject:minPrice forKey:@"UP0MIN"];
            }else if ([ImgDic[@"orderType"] isEqualToString:@"7"]) {
                [YiBaoT1Btn setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]] forState:UIControlStateNormal];
                [user setObject:url forKey:@"YiBaourl"];
                [user setObject:minPrice forKey:@"7MIN"];
            }else if([ImgDic[@"orderType"] isEqualToString:@"HST0"]){
                [ShuaShuaBtn setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]] forState:UIControlStateNormal];
                NSLog(@"%@",url);
                 [user setObject:url forKey:@"HST0url"];
                [user setObject:minPrice forKey:@"HST0MIN"];
            }else if([ImgDic[@"orderType"] isEqualToString:@"AN1"]){
                [AnNongT1 setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]] forState:UIControlStateNormal];
                NSLog(@"%@",url);
                [user setObject:url forKey:@"AN1url"];
                [user setObject:minPrice forKey:@"AN1MIN"];
            }
            [user synchronize];
        }
        
        NSLog(@"%@",[user objectForKey:@"T1url"]);
        
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"请求失败:%@",error);
        [self alert:@"请求网络失败！"];
        [SVProgressHUD dismiss];
    }];
}
//收款信息
- (void)RequestForMsg:(NSString *)Type {
    
    NSString *url = BaseUrl;
    [SVProgressHUD show];
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
                           @"action":@"ChannelInfo",
                           @"data":dic
                           };
    NSString *params = [dicc JSONFragment];
    
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSDictionary *dicc = [result JSONValue];
       // NSString *code = dicc[@"code"];
        NSString *content = dicc[@"content"];
        NSLog(@"获取到的信息:%@",content);
        if ([Type isEqualToString:@"RB1"]) {//普通收款提示信息
            T1msg = content;
        }else if ([Type isEqualToString:@"RB0"]) { //快捷收款信息
            T0msg = content;
        }else if ([Type isEqualToString:@"UP0"]) { //银联收款提示信息
            UP0msg = content;
        }else if ([Type isEqualToString:@"HST0"]){ //卡刷收款提示信息
            HST0msg = content;
        }else if([Type isEqualToString:@"AN1"]){ //安农收款提示信息
            ANmsg = content;
        }else {
            
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"请求失败:%@",error);
        [self alert:@"请求网络失败！"];
        [SVProgressHUD dismiss];
    }];
}

//银行列表
- (void)RequestForBank:(NSString *)Type {
    
    NSString *url = BaseUrl;
    [SVProgressHUD show];
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
        if ([Type isEqualToString:@"RB1"]) { //普通银行信息
            T1Bank = content;
        }else if ([Type isEqualToString:@"RB0"]) {//快捷银行信息
            T0Bank = content;
        }
        else if ([Type isEqualToString:@"HST0"]){ //卡刷银行信息
            HST0Bank = content;
        }else if([Type isEqualToString:@"AN1"]){ //安农银行信息
            ANBank = content;
        }else {
            
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"请求失败:%@",error);
        [self alert:@"请求网络失败！"];
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 101) {
        if (buttonIndex == 1) {
            YiBaoVC *yibo = [[YiBaoVC alloc] init];
            yibo.Url = forwardUrl;
            yibo.Name = forwardName;
            [self.navigationController pushViewController:yibo animated:YES];
        }else {
            
        }
    }
    
}
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    //开启右滑返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
}
- (void)alert:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
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
