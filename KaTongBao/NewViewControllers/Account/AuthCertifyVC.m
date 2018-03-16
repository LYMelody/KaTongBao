//
//  AuthCertifyVC.m
//  wujieNew
//
//  Created by rongfeng on 15/12/23.
//  Copyright © 2015年 rongfeng. All rights reserved.
//

#import "AuthCertifyVC.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "AuthPhotoVC.h"
#import "ActiveAccountVC.h"
#import "AuthMsgVC.h"
#import "BusiIntf.h"
#import "UISaveCardPay.h"
#define Tips \
@"1，用户填写商户信息，提交进行审核。提交后可进入“商户信息审核”选项卡查看查询状态。若审核通过，则红色提示变绿。\r\
2，完成商户信息审核后，进入账户激活选项卡，在账户激活页面完成本人卡交易后，账户激活完成，红色提示变绿。\r\
3，当商户信息审核和账户激活都完成后，认证完成。"

@implementation AuthCertifyVC {
    
    UIImageView *HelpImg;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] init];
    left.title = @"返回";
    self.navigationItem.backBarButtonItem = left;
    
//    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
//    UIBarButtonItem *Right = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(help)];
//    //[Right setTitle:@""];
//    [Right setBackgroundImage:[UIImage imageNamed:@"HELP.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    self.navigationItem.rightBarButtonItem = Right;
    HelpImg.hidden = NO;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"实名认证";
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *backImg = [[UIImageView alloc] init];
    backImg.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    backImg.backgroundColor = LightGrayColor;
    backImg.userInteractionEnabled = YES;
    [self.view addSubview:backImg];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] init];
    left.title = @"返回";
    self.navigationItem.backBarButtonItem = left;
    //手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Certify)];
    tap.numberOfTapsRequired = 1;
    UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Active)];
    tap.numberOfTapsRequired = 1;
    UITapGestureRecognizer *HelpTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(help)];
    HelpTap.numberOfTapsRequired = 1;
    //信息审核
    UIImageView *Img = [[UIImageView alloc] init];
    Img.layer.cornerRadius = 3;
    Img.layer.masksToBounds = YES;
    Img.backgroundColor = [UIColor whiteColor];
    Img.userInteractionEnabled = YES;
    [Img addGestureRecognizer:tap];
    UILabel *LlabelOne = [[UILabel alloc] init];
    LlabelOne.text = @"信息审核";
    LlabelOne.font = [UIFont systemFontOfSize:15];
    [Img addSubview:LlabelOne];
    LlabelOne.sd_layout.leftSpaceToView(Img,11).topSpaceToView(Img,11.5).widthIs(60).heightIs(21);
    UILabel *RlabelOne = [[UILabel alloc] init];
    RlabelOne.textAlignment = NSTextAlignmentCenter;
    if ([[BusiIntf curPayOrder].shopStatus isEqualToString:@"10A"]) {
        RlabelOne.text = @"审核通过";
    } else {
        RlabelOne.text = @"未审核";
    }
    RlabelOne.font = [UIFont systemFontOfSize:15];
    RlabelOne.textColor = Gray136;
    [Img addSubview:RlabelOne];
    RlabelOne.sd_layout.rightSpaceToView(Img,34.5).topSpaceToView(Img,11.5).widthIs(60).heightIs(21);
    UIImageView *TypeImg = [[UIImageView alloc] init];
    [Img addSubview:TypeImg];
    [self.view addSubview:Img];
    Img.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,116 - 64).rightSpaceToView(self.view,16).heightIs(44);
    //信息审核状态图片
    if ([[BusiIntf curPayOrder].shopStatus isEqualToString:@"10A"]) {
        TypeImg.image = [UIImage imageNamed:@"确定.png"];
        TypeImg.sd_layout.rightSpaceToView(Img,10).topSpaceToView(Img,13).widthIs(20).heightIs(16);
    }else if ([[BusiIntf curPayOrder].shopStatus isEqualToString:@"10C"]){
        TypeImg.image = [UIImage imageNamed:@"＊1.png"];
        TypeImg.sd_layout.rightSpaceToView(Img,14).topSpaceToView(Img,17).widthIs(10).heightIs(10);
    }else {
        TypeImg.image = [UIImage imageNamed:@"realname_auth_edit.png"];
        TypeImg.sd_layout.rightSpaceToView(Img,10).topSpaceToView(Img,10).widthIs(20).heightIs(20);
    }
    //账户激活
    UIImageView *ActiveImg = [[UIImageView alloc] init];
    ActiveImg.layer.cornerRadius = 3;
    ActiveImg.layer.masksToBounds = YES;
    ActiveImg.backgroundColor = [UIColor whiteColor];
    ActiveImg.userInteractionEnabled = YES;
    [ActiveImg addGestureRecognizer:Tap];
    UILabel *LlabelTwo = [[UILabel alloc] init];
    LlabelTwo.text = @"账户激活";
    LlabelTwo.font = [UIFont systemFontOfSize:15];
    [ActiveImg addSubview:LlabelTwo];
    LlabelTwo.sd_layout.leftSpaceToView(ActiveImg,11).topSpaceToView(ActiveImg,11.5).widthIs(60).heightIs(21);
    UILabel *RlabelTwo = [[UILabel alloc] init];
    if ([[BusiIntf curPayOrder].selfStatus isEqualToString:@"1"]) {
        RlabelTwo.text = @"已激活";
        ActiveImg.userInteractionEnabled = NO;
    }else {
        RlabelTwo.text = @"未激活";
    }
    RlabelTwo.font = [UIFont systemFontOfSize:15];
    RlabelTwo.textColor = Gray136;
    RlabelTwo.textAlignment = NSTextAlignmentCenter;
    [ActiveImg addSubview:RlabelTwo];
    RlabelTwo.sd_layout.rightSpaceToView(ActiveImg,34.5).topSpaceToView(ActiveImg,11.5).widthIs(60).heightIs(21);
    UIImageView *TypeImgTwo = [[UIImageView alloc] init];
    //TypeImgTwo.backgroundColor = RedColor;
    //状态图片
    [ActiveImg addSubview:TypeImgTwo];
    [self.view addSubview:ActiveImg];
    if ([[BusiIntf curPayOrder].selfStatus isEqualToString:@"1"]) {
        TypeImgTwo.image = [UIImage imageNamed:@"确定.png"];
        TypeImgTwo.sd_layout.rightSpaceToView(ActiveImg,10).topSpaceToView(ActiveImg,13).widthIs(20).heightIs(16);
    }else {
        TypeImgTwo.image = [UIImage imageNamed:@"＊1.png"];
        TypeImgTwo.sd_layout.rightSpaceToView(ActiveImg,14).topSpaceToView(ActiveImg,17).widthIs(10).heightIs(10);
    }
    ActiveImg.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,176 - 64).rightSpaceToView(self.view,16).heightIs(44);
    
//    //如果基本信息没有审核通过账户激活不能点击
//    if (![[BusiIntf curPayOrder].shopStatus isEqualToString:@"10A"]) {
//        ActiveImg.userInteractionEnabled = NO;
//        UIImageView *ShadowView = [[UIImageView alloc] init];
//        ShadowView.backgroundColor = Color(151, 151, 151);
//        ShadowView.alpha = 0.3;
//        ShadowView.layer.cornerRadius = 3;
//        ShadowView.layer.masksToBounds = YES;
//        [self.view addSubview:ShadowView];
//        ShadowView.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,176).rightSpaceToView(self.view,16).heightIs(44);
//    }
    
    //认证流程
    UIImageView *BackImg = [[UIImageView alloc] init];
    BackImg.layer.cornerRadius = 4;
    BackImg.backgroundColor = [UIColor orangeColor];
    //[self.view addSubview:BackImg];
    BackImg.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,16).topSpaceToView(self.view,271).heightIs(200);
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.text = @"商户认证流程";
    label.font = [UIFont systemFontOfSize:15];
    //[self.view addSubview:label];
    label.sd_layout.leftSpaceToView(self.view,115).topSpaceToView(self.view,286).widthIs(90).heightIs(21);
    UILabel *msgLab = [[UILabel alloc] init];
    msgLab.text = Tips;
    msgLab.font = [UIFont systemFontOfSize:12];
    msgLab.numberOfLines = 0;
    msgLab.textColor = [UIColor whiteColor];
    //[self.view addSubview:msgLab];
    msgLab.sd_layout.leftSpaceToView(self.view,38.5).topSpaceToView(self.view,313).widthIs(243.5).heightIs(132);
    
    //帮助
    HelpImg = [[UIImageView alloc] initWithFrame:CGRectMake(270, 9.2, 25, 25)];
    HelpImg.image = [UIImage imageNamed:@"HELP.png"];
    HelpImg.userInteractionEnabled = YES;
    //[HelpImg addGestureRecognizer:HelpTap];
    //HelpImg.hidden = YES;
    [self.navigationController.navigationBar addSubview:HelpImg];
    UIImageView *TapImg = [[UIImageView alloc] initWithFrame:CGRectMake(260, 8, 40, 30)];
    TapImg.backgroundColor = [UIColor clearColor];
    TapImg.userInteractionEnabled = YES;
    [TapImg addGestureRecognizer:HelpTap];
    [self.navigationController.navigationBar addSubview:TapImg];
    //HelpImg.sd_layout.rightSpaceToView(self.navigationController.navigationBar,18).topSpaceToView(self.navigationController.navigationBar,31.5).widthIs(21).heightIs(21);
}

- (void)help {
    
    UIAlertView *helpAlert = [[UIAlertView alloc] initWithTitle:@"商户认证流程" message:Tips delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [helpAlert show];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:YES];
    HelpImg.hidden = YES;
}

//基本信息认证
- (void)Certify {
    
    NSLog(@"信息认证");
    AuthMsgVC *MsgVC = [[AuthMsgVC alloc] init];
    [self.navigationController pushViewController:MsgVC animated:YES];
    
}
- (void)Active {
    
    NSLog( @"激活");
//    ActiveAccountVC *Activew = [[ActiveAccountVC alloc] init];
//    [self.navigationController pushViewController:Activew animated:YES];
    
    [BusiIntf curPayOrder].OrderAmount = @"1";
    [BusiIntf curPayOrder].BankCardType = @"1";
    UISaveCardPay *ActivePay = [[UISaveCardPay alloc] init];
    ActivePay.tag = 100;
    [self.navigationController pushViewController:ActivePay animated:YES];
    

}
@end
