//
//  PayOrderVC.m
//  wujieNew
//
//  Created by rongfeng on 15/12/21.
//  Copyright © 2015年 rongfeng. All rights reserved.
//

#import "PayOrderVC.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "CreatOrder.h"
#import "BusiIntf.h"
#import <CommonCrypto/CommonDigest.h>
#import "IBHttpTool.h"
#import "SBJSON.h"
#import "SVProgressHUD.h"
#import "YiBaoVC.h"
@implementation PayOrderVC {
    UIImageView *blueLineL;
    UIImageView *blueLineR;
    UIButton *commonBtn;
    UIButton *FastBtn;
    UIScrollView *scroll;
    NSString *OrderType;
    NSString *orderStatus;
    NSString *forwardUrl;
    NSString *forwardName;
}
- (void)viewWillAppear:(BOOL)animated {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"请选择收款方式";
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = DrackBlue;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] init];
    left.title = @"返回";
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    self.navigationItem.backBarButtonItem = left;
    UIImageView *backImg = [[UIImageView alloc] init];
    backImg.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    backImg.backgroundColor = LightGrayColor;
    [self.view addSubview:backImg];
    //普通快捷按钮
    commonBtn = [[UIButton alloc] init];
    commonBtn.tag = 102;
    [commonBtn setTitle:@"普通收款" forState:UIControlStateNormal];
    [commonBtn setTitleColor:Color(74, 169, 255) forState:UIControlStateNormal];
    commonBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [commonBtn addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commonBtn];
    FastBtn = [[UIButton alloc] init];
    FastBtn.tag = 103;
    [FastBtn setTitle:@"快捷收款" forState:UIControlStateNormal];
    [FastBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    FastBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [FastBtn addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:FastBtn];
    commonBtn.sd_layout.leftSpaceToView(self.view,45).topSpaceToView(self.view,75.5).widthIs(64).heightIs(17.5);
    FastBtn.sd_layout.leftSpaceToView(self.view,194).topSpaceToView(self.view,76.5).widthIs(64).heightIs(17.5);
    //横线
    UIImageView *Line = [[UIImageView alloc] init];
    Line.backgroundColor = Color(216,216,216);
    [self.view addSubview:Line];
    blueLineL = [[UIImageView alloc] init];
    blueLineL.backgroundColor = Color(74, 169, 255);
    blueLineL.hidden = NO;
    [self.view addSubview:blueLineL];
    blueLineR = [[UIImageView alloc] init];
    blueLineR.backgroundColor = Color(74, 169, 255);
    blueLineR.hidden = YES;
    [self.view addSubview:blueLineR];
    Line.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,102.5).heightIs(2);
    blueLineL.sd_layout.leftSpaceToView(self.view,43.5).topSpaceToView(self.view,102.5).widthIs(64.5).heightIs(2);
    blueLineR.sd_layout.leftSpaceToView(self.view,194.5).topSpaceToView(self.view,102.5).widthIs(64.5).heightIs(2);
    
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 104.5, KscreenWidth, KscreenHeight - 104.5)];
    scroll.contentSize = CGSizeMake(KscreenWidth * 2, KscreenHeight - 104.5);
    scroll.pagingEnabled = YES;
    scroll.userInteractionEnabled = YES;
    scroll.delegate = self;
    scroll.showsHorizontalScrollIndicator = NO;
    UIImageView *ImageViewOne = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 104.5)];
    UIImageView *ImageViewTwo = [[UIImageView alloc] initWithFrame:CGRectMake(KscreenWidth, 0, KscreenWidth, KscreenHeight - 104.5)];
    ImageViewOne.backgroundColor = LightGrayColor;
    ImageViewTwo.backgroundColor = LightGrayColor;
    ImageViewOne.userInteractionEnabled = YES;
    ImageViewTwo.userInteractionEnabled = YES;
    [scroll addSubview:ImageViewOne];
    [scroll addSubview:ImageViewTwo];
    [self.view addSubview:scroll];
    [self SetPage:ImageViewOne andRect:0];
    [self SetPage:ImageViewTwo andRect:1];
    OrderType = @"普通收款";
    [BusiIntf curPayOrder].GoodsID = GoodsID_Pay;
    orderStatus = @"易宝";
}
//创建两个页面
- (void)SetPage:(UIImageView *)ImageView andRect:(CGFloat)outset {
    //白色背景
    UIImageView *WhiteImg = [[UIImageView alloc] init];
    WhiteImg.backgroundColor = [UIColor whiteColor];
    WhiteImg.layer.cornerRadius = 8;
    WhiteImg.layer.masksToBounds = YES;
    [ImageView addSubview:WhiteImg];
    WhiteImg.sd_layout.leftSpaceToView(ImageView,16).topSpaceToView(ImageView,25).widthIs(288).heightIs(363);
    //收款方式
    UILabel *label = [[UILabel alloc] init];
    label.text = @"请选择以下收款方式";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = Color(92, 92, 92);
    [ImageView addSubview:label];
    label.sd_layout.leftSpaceToView(ImageView,37).topSpaceToView(ImageView,48).widthIs(126).heightIs(17.5);
    //易宝
    UIButton *YiBao = [[UIButton alloc] init];
    YiBao.tag = 104;
    [YiBao setImage:[UIImage imageNamed:@"易宝.png"] forState:UIControlStateNormal];
    [YiBao addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    [ImageView addSubview:YiBao];
    //无界
    UIButton *WuJie = [[UIButton alloc] init];
    WuJie.tag = 105;
    [WuJie setImage:[UIImage imageNamed:@"无界.png"] forState:UIControlStateNormal];
    [WuJie addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    [ImageView addSubview:WuJie];
    //银联支付
    UIButton *YinLian = [[UIButton alloc] init];
    YinLian.tag = 106;
    [YinLian setImage:[UIImage imageNamed:@"icon_grid_5.png"] forState:UIControlStateNormal];
    [YinLian addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    [ImageView addSubview:YinLian];
    
    
//    YiBao.sd_layout.leftSpaceToView(ImageView,45).topSpaceToView(ImageView,100.5).widthIs(60).heightIs(60);
//    WuJie.sd_layout.leftSpaceToView(ImageView,130).topSpaceToView(ImageView,100.5).widthIs(60).heightIs(60);
//    YinLian.sd_layout.leftSpaceToView(ImageView,215).topSpaceToView(ImageView,100.5).widthIs(60).heightIs(60);
    
    
    
    UILabel *labL = [[UILabel alloc] init];
    labL.text = @"易宝支付";
    labL.font = [UIFont systemFontOfSize:12];
    labL.textColor = Color(136, 136, 136);
    [ImageView addSubview:labL];
    UILabel *labR = [[UILabel alloc] init];
    labR.text = @"无界支付";
    labR.font = [UIFont systemFontOfSize:12];
    labR.textColor = Color(136, 136, 136);
    [ImageView addSubview:labR];
    UILabel *YinLianLab = [[UILabel alloc] init];
    YinLianLab.text = @"银联支付";
    YinLianLab.font = [UIFont systemFontOfSize:12];
    YinLianLab.textColor = Color(136, 136, 136);
    [ImageView addSubview:YinLianLab];
    
    if (outset == 0) {
        YinLian.hidden = YES;
        YinLianLab.hidden = YES;
        
        YiBao.sd_layout.leftSpaceToView(ImageView,130).topSpaceToView(ImageView,100.5).widthIs(60).heightIs(60);
        WuJie.sd_layout.leftSpaceToView(ImageView,45).topSpaceToView(ImageView,100.5).widthIs(60).heightIs(60);
        //YinLian.sd_layout.leftSpaceToView(ImageView,130).topSpaceToView(ImageView,100.5).widthIs(60).heightIs(60);
        
        labL.sd_layout.leftSpaceToView(ImageView,133.5).topSpaceToView(ImageView,170.5).widthIs(48).heightIs(13.5);
        labR.sd_layout.leftSpaceToView(ImageView,52.5).topSpaceToView(ImageView,170.5).widthIs(48).heightIs(13.5);
        //YinLianLab.sd_layout.leftSpaceToView(ImageView,133.5).topSpaceToView(ImageView,170.5).widthIs(48).heightIs(13.5);
    }else {
        YiBao.hidden = YES;
        labL.hidden = YES;
        //YiBao.sd_layout.leftSpaceToView(ImageView,215).topSpaceToView(ImageView,100.5).widthIs(60).heightIs(60);
        WuJie.sd_layout.leftSpaceToView(ImageView,45).topSpaceToView(ImageView,100.5).widthIs(60).heightIs(60);
        YinLian.sd_layout.leftSpaceToView(ImageView,130).topSpaceToView(ImageView,100.5).widthIs(60).heightIs(60);
        
        //labL.sd_layout.leftSpaceToView(ImageView,221.5).topSpaceToView(ImageView,170.5).widthIs(48).heightIs(13.5);
        labR.sd_layout.leftSpaceToView(ImageView,52.5).topSpaceToView(ImageView,170.5).widthIs(48).heightIs(13.5);
        YinLianLab.sd_layout.leftSpaceToView(ImageView,133.5).topSpaceToView(ImageView,170.5).widthIs(48).heightIs(13.5);

    }
//    labL.sd_layout.leftSpaceToView(ImageView,52.5).topSpaceToView(ImageView,170.5).widthIs(48).heightIs(13.5);
//    labR.sd_layout.leftSpaceToView(ImageView,133.5).topSpaceToView(ImageView,170.5).widthIs(48).heightIs(13.5);
//    YinLianLab.sd_layout.leftSpaceToView(ImageView,221.5).topSpaceToView(ImageView,170.5).widthIs(48).heightIs(13.5);
    
    
//    YiBao.sd_layout.leftSpaceToView(ImageView,215).topSpaceToView(ImageView,100.5).widthIs(60).heightIs(60);
//    WuJie.sd_layout.leftSpaceToView(ImageView,45).topSpaceToView(ImageView,100.5).widthIs(60).heightIs(60);
//    YinLian.sd_layout.leftSpaceToView(ImageView,130).topSpaceToView(ImageView,100.5).widthIs(60).heightIs(60);
//    
//    labL.sd_layout.leftSpaceToView(ImageView,221.5).topSpaceToView(ImageView,170.5).widthIs(48).heightIs(13.5);
//    labR.sd_layout.leftSpaceToView(ImageView,52.5).topSpaceToView(ImageView,170.5).widthIs(48).heightIs(13.5);
//    YinLianLab.sd_layout.leftSpaceToView(ImageView,133.5).topSpaceToView(ImageView,170.5).widthIs(48).heightIs(13.5);
    
    
    
    
}
//滑动改变按钮颜色
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.x;
    if (offset >= KscreenWidth) {
        [FastBtn setTitleColor:Color(74, 169, 255) forState:UIControlStateNormal];
        blueLineL.hidden = YES;
        blueLineR.hidden = NO;
        [commonBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        OrderType = @"快捷收款";
        [BusiIntf curPayOrder].GoodsID = GoodsID_Buy;
    }if (offset < KscreenWidth) {
        [commonBtn setTitleColor:Color(74, 169, 255) forState:UIControlStateNormal];
        blueLineL.hidden = NO;
        blueLineR.hidden = YES;
        [FastBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        OrderType = @"普通收款";
        [BusiIntf curPayOrder].GoodsID = GoodsID_Pay;
    }
}
- (void)pay:(UIButton *) btn{
    
    if (btn.tag == 102) {
        OrderType = @"普通收款";
        [BusiIntf curPayOrder].GoodsID = GoodsID_Pay;
        [btn setTitleColor:Color(74, 169, 255) forState:UIControlStateNormal];
        blueLineL.hidden = NO;
        blueLineR.hidden = YES;
        [FastBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
            scroll.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            NSLog(@"动画结束");
        }];

    }else if (btn.tag == 103) {
        OrderType = @"快捷收款";
        [BusiIntf curPayOrder].GoodsID = GoodsID_Buy;
        [btn setTitleColor:Color(74, 169, 255) forState:UIControlStateNormal];
        blueLineL.hidden = YES;
        blueLineR.hidden = NO;
        [commonBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.5 animations:^{
            scroll.contentOffset = CGPointMake(KscreenWidth, 0);
        } completion:^(BOOL finished) {
            NSLog(@"动画结束");
        }];
        
    }else {
        CreatOrder *order = [[CreatOrder alloc] init];
        if ([OrderType isEqualToString:@"普通收款"]) {
            order.tag = 1;
        }
        if ([OrderType isEqualToString:@"快捷收款"]) {
            order.tag = 2;
        }
        if (btn.tag == 104) {
            orderStatus = @"易宝";
            //易宝支付
            [self RequestForYiBao];
        
        }
        if (btn.tag == 105) {
            orderStatus = @"无界";
        }
        NSLog(@"%@   %@",OrderType,orderStatus);
        if (btn.tag == 105 ) {
            [self.navigationController pushViewController:order animated:YES];
        } else if (btn.tag == 106) {
            if ([[BusiIntf curPayOrder].GoodsID isEqualToString:@"1"]) {
                [BusiIntf curPayOrder].GoodsID = @"UP1";
            }else if([[BusiIntf curPayOrder].GoodsID isEqualToString:@"2"]){
                [BusiIntf curPayOrder].GoodsID = @"UP0";
            }
            order.tag = 3;
            [self.navigationController pushViewController:order animated:YES];
        }
        else {
            //[self alert:@"正在建设中..."];
        }
    }
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
- (void)alert:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
}

@end
