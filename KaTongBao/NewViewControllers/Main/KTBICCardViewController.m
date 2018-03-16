//
//  KTBICCardViewController.m
//  KaTongBao
//
//  Created by rongfeng on 16/8/26.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "KTBICCardViewController.h"
#import "Common.h"
#import "macro.h"
#import "UIView+SDAutoLayout.h"
#import "KTBVipCell.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import <CommonCrypto/CommonDigest.h>
#import "BusiIntf.h"
#import "UIImageView+WebCache.h"
#import "KTBCardProtocolViewController.h"
#import "KTBCreateCardViewController.h"
#import "BusiIntf.h"
@implementation KTBICCardViewController {
    UIImageView *LineView;
    UITapGestureRecognizer *TapGes;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"权益详情";
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
    self.hidesBottomBarWhenPushed = YES;
    //[self RequestForCustomerInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *BackImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    BackImg.backgroundColor = LightGrayColor;
    [self.view addSubview:BackImg];
    
    UIImageView *HeaderView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 120)];
    HeaderView.image = [UIImage imageNamed:@"会员专享-免费申请-"];
    
    UITableView *Table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 140)];
    Table.delegate = self;
    Table.dataSource = self;
    Table.showsVerticalScrollIndicator = NO;
    Table.showsHorizontalScrollIndicator = NO;
    Table.separatorStyle = UITableViewScrollPositionNone;
    Table.tableHeaderView = HeaderView;
    [self.view addSubview:Table];
    
    UIButton *Btn = [[UIButton alloc] init];
    [Btn setTitle:@"免费办卡" forState:UIControlStateNormal];
    //[Btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    Btn.layer.cornerRadius = 20;
    Btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [Btn setBackgroundColor:CommonOrange];
    [Btn addTarget:self action:@selector(GetVip) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Btn];
    Btn.sd_layout.leftSpaceToView(self.view,20).rightSpaceToView(self.view,20).bottomSpaceToView(self.view,20).heightIs(40);
    
    LineView = [[UIImageView alloc] init];
    LineView.backgroundColor = Color(187, 188, 190);
    
    TapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapToDetail)];
    TapGes.numberOfTapsRequired = 1;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"服务条款声明" style:UIBarButtonItemStyleDone target:self action:@selector(ToServiceProtocol)];
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica-Bold"size:13.0],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName,nil]  forState:UIControlStateNormal];
    
    if (![[BusiIntf curPayOrder].CardVIPIcon isEqualToString:@""]) {
        [HeaderView sd_setImageWithURL:[NSURL URLWithString:[BusiIntf curPayOrder].CardVIPIcon]];
    }else {
        HeaderView.image = [UIImage imageNamed:@"会员专享-免费申请-"];
    }
    if (![[BusiIntf curPayOrder].IsVip isEqualToString:@"1"]) {
        Btn.hidden = YES;
        Table.height = KscreenHeight;
    }

    //[BusiIntf curPayOrder].IsVip = @"1";
      //[BusiIntf curPayOrder].IsGetCardVip = [NSString stringWithFormat:@"%@",[BusiIntf curPayOrder].IsGetCardVip] ;
      //[BusiIntf curPayOrder].IsGetSafeVip = [NSString stringWithFormat:@"%@",[BusiIntf curPayOrder].IsGetSafeVip];
    
    //判断是联民信用卡还是个险
//    if (self.tag == 101) {   //个险
//        if (![[BusiIntf curPayOrder].SafeVIPIcon isEqualToString:@""]) {
//            [HeaderView sd_setImageWithURL:[NSURL URLWithString:[BusiIntf curPayOrder].SafeVIPIcon]];
//        }else {
//             HeaderView.image = [UIImage imageNamed:@"会员专享-免费赠送-"];
//        }
//       
//        if (![[BusiIntf curPayOrder].IsVip isEqualToString:@"1"]) {
//            Btn.hidden = YES;
//            Table.height = KscreenHeight;
//        }else if ([[BusiIntf curPayOrder].IsGetSafeVip isEqualToString:@"1"]) {
//            [Btn setTitle:@"领取处理中" forState:UIControlStateNormal];
//            [Btn setBackgroundColor:CommonOrange];
//            Btn.enabled = NO;
//        }else if ([[BusiIntf curPayOrder].IsGetSafeVip isEqualToString:@"2"]) {
//            [Btn setTitle:@"已领取" forState:UIControlStateNormal];
//            [Btn setBackgroundColor:[UIColor colorWithRed:58/255.0 green:142/255.0 blue:12/255.0 alpha:1]];
//            Btn.enabled = NO;
//        }else if([[BusiIntf curPayOrder].IsGetSafeVip isEqualToString:@"3"]){
//            [Btn setTitle:@"领取失败" forState:UIControlStateNormal];
//            [Btn setBackgroundColor:RedColor];
//        }
//        
//    }else {    //联民信用卡
//        
        //        else if ([[BusiIntf curPayOrder].IsGetCardVip isEqualToString:@"1"]) {
//            [Btn setTitle:@"领取处理中" forState:UIControlStateNormal];
//            [Btn setBackgroundColor:CommonOrange];
//            Btn.enabled = NO;
//        }else if ([[BusiIntf curPayOrder].IsGetCardVip isEqualToString:@"2"]) {
//            [Btn setTitle:@"已领取" forState:UIControlStateNormal];
//            [Btn setBackgroundColor:[UIColor colorWithRed:58/255.0 green:142/255.0 blue:12/255.0 alpha:1]];
//            Btn.enabled = NO;
//        }else if([[BusiIntf curPayOrder].IsGetCardVip isEqualToString:@"3"]){
//            [Btn setTitle:@"领取失败" forState:UIControlStateNormal];
//            [Btn setBackgroundColor:RedColor];
//            
//        }
//    }
}

//服务协议
- (void)ToServiceProtocol {
    
    KTBCardProtocolViewController *CardProtocolView = [[KTBCardProtocolViewController alloc] init];
    CardProtocolView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:CardProtocolView animated:YES];
    CardProtocolView.hidesBottomBarWhenPushed = NO;
    
}

- (void)GetVip {
    
   
//    if (self.tag == 101) {
//        [self RequestForVipMetch:@"SAFE"];
//    }else {
//        [self RequestForVipMetch:@"CARD"];
//    }
    
    KTBCreateCardViewController *KTBCreatCard = [[KTBCreateCardViewController alloc] init];
    KTBCreatCard.tag = 1;
    KTBCreatCard.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:KTBCreatCard animated:YES];
    KTBCreatCard.hidesBottomBarWhenPushed = NO;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        return 78;
    }else {
//        if ([[BusiIntf curPayOrder].IsVip isEqualToString:@"1"]) {
//            return KscreenHeight -
//        }
        return KscreenHeight - 180 - 78 * 2- 120;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identy = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        if (indexPath.row == 0) {
            KTBVipCell *VipCell = [[KTBVipCell alloc] init];
            VipCell.LogoImg.image = [UIImage imageNamed:@"图层-7"];
            if (self.tag == 101) {   //个险
                if (![[BusiIntf curPayOrder].SafeVIPTitle isEqualToString:@""]) {  //
                    VipCell.TitleLab.text = [BusiIntf curPayOrder].SafeVIPTitle;
                }else {
                    VipCell.TitleLab.text = @"权益名称";
                }
                VipCell.LogoImg.image = [UIImage imageNamed:@"图层-5"];
            }else {     //联民信用卡
                if (![[BusiIntf curPayOrder].CardVIPTitle isEqualToString:@""]) {  //
                    VipCell.TitleLab.text = [BusiIntf curPayOrder].CardVIPTitle;
                }else {
                    VipCell.TitleLab.text = @"权益名称";
                }
            }
            //VipCell.TitleLab.text = @"权益名称";
            VipCell.InfoLab.text = @"会员特权";
            [VipCell.contentView addSubview:LineView];
            LineView.sd_layout.leftSpaceToView(VipCell.contentView,0).bottomSpaceToView(VipCell.contentView,0).rightSpaceToView(VipCell.contentView,0).heightIs(1);
            cell = VipCell;
            
        }else if (indexPath.row == 1) {
            KTBVipCell *VipInfoCell = [[KTBVipCell alloc] init];
            VipInfoCell.LogoImg.image = [UIImage imageNamed:@"图层-8"];
            if (self.tag == 101) {    //个险
                VipInfoCell.LogoImg.image = [UIImage imageNamed:@"图层-6"];
//                if (![[BusiIntf curPayOrder].SafeVIPTitle isEqualToString:@""]) {  //会员权益名称
//                    VipInfoCell.TitleLab.text = [BusiIntf curPayOrder].SafeVIPTitle;
//                }else {
//                    VipInfoCell.TitleLab.text = @"权益名称";
//                }
                if (![[BusiIntf curPayOrder].SafeVIPDetail isEqualToString:@""]) {//会员权益详情
                    VipInfoCell.InfoLab.text = [BusiIntf curPayOrder].SafeVIPDetail;
                }else {
                    VipInfoCell.InfoLab.text = @"会员特权";
                }
                
            }else {     //联民信用卡
//                if (![[BusiIntf curPayOrder].CardVIPTitle isEqualToString:@""]) {  //会员权益名称
//                    VipInfoCell.TitleLab.text = [BusiIntf curPayOrder].CardVIPTitle;
//                }else {
//                    VipInfoCell.TitleLab.text = @"权益名称";
//                }
                
                if (![[BusiIntf curPayOrder].CardVIPDetail isEqualToString:@""]) {//会员权益详情
                    VipInfoCell.InfoLab.text = [BusiIntf curPayOrder].CardVIPDetail;
                }else {
                    VipInfoCell.InfoLab.text = @"会员特权";
                }
                VipInfoCell.InfoLab.userInteractionEnabled = YES;
                [VipInfoCell.InfoLab addGestureRecognizer:TapGes];
            }
            VipInfoCell.TitleLab.text = @"权益详情";
            //VipInfoCell.InfoLab.text = @"会员特权";
            cell = VipInfoCell;
        }else {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    return cell;
}

- (void)TapToDetail {
    
    KTBCardProtocolViewController *CardProtocolView = [[KTBCardProtocolViewController alloc] init];
    CardProtocolView.tag = 1;
    CardProtocolView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:CardProtocolView animated:YES];
    CardProtocolView.hidesBottomBarWhenPushed = NO;
    
}
//商户VIP权益信息
- (void)RequestForVipMetch:(NSString *)VipCode {
    
    NSString *url = JXUrl;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *MD5Str = [NSString stringWithFormat:@"%@%@",VipCode,key];
    NSString *sign = [self md5:MD5Str];
    NSLog(@"%@,%@,%@",token,key,sign);
    NSDictionary *dic = @{
                          @"vipCode":VipCode,
                          @"token":token,
                          @"sign":sign
                          };
    NSDictionary *actionDic = @{
                                @"action":@"shopVipDrawState",
                                @"data":dic
                                };
    NSLog(@"actionDic:%@",actionDic);
    NSString *paramis = [actionDic JSONFragment];
    [IBHttpTool postWithURL:url params:paramis success:^(id result) {
        NSDictionary *Dic = [result JSONValue];
        NSLog(@"返回的数据:%@",Dic);
        NSString *code = Dic[@"code"];
        NSString *msg = Dic[@"msg"];
        if ([code isEqualToString:@"000000"]) {
            msg = @"领取成功!";
            [self alert:msg];
        }else {
            [self alert:msg];
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"网络错误!!");
        //[self alert:error];
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

@end
