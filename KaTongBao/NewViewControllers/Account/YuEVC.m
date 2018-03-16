//
//  YuEVC.m
//  wujieNew
//
//  Created by rongfeng on 15/12/24.
//  Copyright © 2015年 rongfeng. All rights reserved.
//

#import "YuEVC.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "IBHttpTool.h"
#import "SBJSON.h"
#import <CommonCrypto/CommonDigest.h>
#import "SVProgressHUD.h"
#import "BusiIntf.h"
#import "JieSuanListVC.h"
@implementation YuEVC {
    UIButton *YiBaoBtn;
    UIButton *WuJie;
    UIView *MaskView;
    UILabel *AllMoneyLabCom;
    UILabel *MoneyLab;
    UILabel *AllMoneyLab;
    UITextField *BankFld;
    NSString *PuTongAmount;
    NSString *KuaiJieAmount;
    UIScrollView *scroll;
    NSString *TypeFlag;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    //修改返回按钮
    UIBarButtonItem *left = [[UIBarButtonItem alloc] init];
    left.title = @"返回";
    self.navigationItem.backBarButtonItem = left;
    //普通
    //[self RequestForYuE:@"RB1"];
    //快捷
    
//    [self RequestForYuE:@"RB0"];
//    [self RequestForYuE:@"RB1"];
//    [BusiIntf curPayOrder].TypeOrder = @"RB0";
//    TypeFlag = @"1";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"余额转出";
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *backImg = [[UIImageView alloc] init];
    backImg.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    backImg.backgroundColor = LightGrayColor;
    [self.view addSubview:backImg];
    
    UIScrollView *ScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    //ScrollView.contentSize = (KscreenWidth,KscreenHeight + 100);
    ScrollView.backgroundColor = LightGrayColor;
    if(KscreenHeight < 500) {
        ScrollView.contentSize = CGSizeMake(KscreenWidth, KscreenHeight +100);
    }else {
        ScrollView.contentSize = CGSizeMake(KscreenWidth, KscreenHeight);
    }
    ScrollView.showsVerticalScrollIndicator = NO;
    ScrollView.userInteractionEnabled = YES;
    [self.view addSubview:ScrollView];
    
    //两个按钮
    YiBaoBtn = [[UIButton alloc] init];
    [YiBaoBtn setTitle:@"银联" forState:UIControlStateNormal];
    [YiBaoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    YiBaoBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [YiBaoBtn addTarget:self action:@selector(YiBao) forControlEvents:UIControlEventTouchUpInside];
    [ScrollView addSubview:YiBaoBtn];
    YiBaoBtn.sd_layout.leftSpaceToView(ScrollView,48).topSpaceToView(ScrollView,76.5).widthIs(34).heightIs(18);
    WuJie = [[UIButton alloc] init];
    [WuJie setTitle:@"无界pay" forState:UIControlStateNormal];
    [WuJie setTitleColor:BlueColor forState:UIControlStateNormal];
    //[WuJie setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    WuJie.titleLabel.font = [UIFont systemFontOfSize:17];
    [WuJie addTarget:self action:@selector(WuJie) forControlEvents:UIControlEventTouchUpInside];
    [ScrollView addSubview:WuJie];
    WuJie.sd_layout.leftSpaceToView(ScrollView,220.5).topSpaceToView(ScrollView,76.5).widthIs(66.5).heightIs(18);
    UIImageView *LineView = [[UIImageView alloc] init];
    LineView.backgroundColor = Color(233, 224, 224);
    [ScrollView addSubview:LineView];
    LineView.sd_layout.leftSpaceToView(ScrollView,0).rightSpaceToView(ScrollView,0).topSpaceToView(ScrollView, 100).heightIs(1);
    //滑动视图
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 113.5, KscreenWidth, 226.5)];
    scroll.contentSize = CGSizeMake(273 * 2 + 45, 226.5);
    scroll.userInteractionEnabled = YES;
    scroll.delegate = self;
    scroll.showsHorizontalScrollIndicator = NO;
    
    UIImageView *FastImg = [[UIImageView alloc] initWithFrame:CGRectMake(16, 0, 273, 226.5)];
    FastImg.image = [UIImage imageNamed:@"收款背景.png"];
    FastImg.userInteractionEnabled = YES;
    [scroll addSubview:FastImg];
    
    UIImageView *CommonImg =[[UIImageView alloc] initWithFrame:CGRectMake(304, 0, 273, 226.5)];
    CommonImg.image = [UIImage imageNamed:@"收款背景.png"];
    CommonImg.userInteractionEnabled = YES;
    [scroll addSubview:CommonImg];
    [ScrollView addSubview:scroll];
    
    UILabel *FastLabel = [[UILabel alloc] init];
    FastLabel.text = @"快捷收款账户";
    FastLabel.backgroundColor = [UIColor clearColor];
    FastLabel.font = [UIFont systemFontOfSize:16];
    FastLabel.textColor = [UIColor whiteColor];
    [FastImg addSubview:FastLabel];
    FastLabel.sd_layout.leftSpaceToView(FastImg,20).topSpaceToView(FastImg,17).widthIs(100).heightIs(20);
    
    UITapGestureRecognizer *TapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(KuaiJie)];
    TapOne.numberOfTapsRequired = 1;

    UIImageView *Img = [[UIImageView alloc] init];
    Img.backgroundColor = [UIColor clearColor];
    Img.userInteractionEnabled = YES;
    [Img addGestureRecognizer:TapOne];
    [FastImg addSubview:Img];
    Img.sd_layout.leftSpaceToView(FastImg,180).topSpaceToView(FastImg,10).widthIs(90).heightIs(40);
    
    UIImageView *JieSuanImg = [[UIImageView alloc] init];
    JieSuanImg.image = [UIImage imageNamed:@"Group.png"];
    [FastImg addSubview:JieSuanImg];
    JieSuanImg.sd_layout.leftSpaceToView(FastImg,200).topSpaceToView(FastImg,18).widthIs(14.5).heightIs(18.5);
    
//    UIButton *JieSuanBtn = [[UIButton alloc] init];
//    [JieSuanBtn setTitle:@"结算记录" forState:UIControlStateNormal];
//    JieSuanBtn.backgroundColor = [UIColor clearColor];
//    JieSuanBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//    [JieSuanBtn addTarget:self action:@selector(JieSuan:) forControlEvents:UIControlEventTouchUpInside];
//    //[FastImg addSubview:JieSuanBtn];
//    JieSuanBtn.sd_layout.leftSpaceToView(FastImg,215).topSpaceToView(FastImg,21.5).widthIs(60).heightIs(10.5);
    
    UILabel *JieSuanLab = [[UILabel alloc] init];
    JieSuanLab.text = @"结算记录";
    JieSuanLab.font = [UIFont systemFontOfSize:12];
    JieSuanLab.textColor = [UIColor whiteColor];
    [FastImg addSubview:JieSuanLab];
    JieSuanLab.sd_layout.leftSpaceToView(FastImg,215).topSpaceToView(FastImg,21.5).widthIs(60).heightIs(10.5);
    
    
    UILabel *MidLab = [[UILabel alloc] init];
    MidLab.text = @"快捷总额(元)";
    MidLab.textColor = [UIColor whiteColor];
    MidLab.backgroundColor = [UIColor clearColor];
    MidLab.font = [UIFont systemFontOfSize:13];
    [FastImg addSubview:MidLab];
    MidLab.sd_layout.leftSpaceToView(FastImg,106.5).topSpaceToView(FastImg,65).widthIs(75).heightIs(17.5);
    AllMoneyLab = [[UILabel alloc] init];
    AllMoneyLab.text = @"0.00";
    AllMoneyLab.adjustsFontSizeToFitWidth = YES;
    AllMoneyLab.textAlignment = NSTextAlignmentCenter;
    AllMoneyLab.textColor = [UIColor whiteColor];
    AllMoneyLab.font  = [UIFont systemFontOfSize:39];
    AllMoneyLab.backgroundColor = [UIColor clearColor];
    [FastImg addSubview:AllMoneyLab];
    AllMoneyLab.sd_layout.leftSpaceToView(FastImg,0).topSpaceToView(FastImg,134).widthIs(273).heightIs(40.5);
    
    UILabel *CommonLabel = [[UILabel alloc] init];
    CommonLabel.text = @"普通收款账户";
    CommonLabel.backgroundColor = [UIColor clearColor];
    CommonLabel.font = [UIFont systemFontOfSize:16];
    CommonLabel.textColor = [UIColor whiteColor];
    [CommonImg addSubview:CommonLabel];
    CommonLabel.sd_layout.leftSpaceToView(CommonImg,20).topSpaceToView(CommonImg,17).widthIs(100).heightIs(20);
    
    UITapGestureRecognizer *TapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PuTong)];
    TapTwo.numberOfTapsRequired = 1;
    UIImageView *PuTongJieSuan = [[UIImageView alloc] init];
    PuTongJieSuan.backgroundColor = [UIColor clearColor];
    PuTongJieSuan.userInteractionEnabled = YES;
    [PuTongJieSuan addGestureRecognizer:TapTwo];
    [CommonImg addSubview:PuTongJieSuan];
    PuTongJieSuan.sd_layout.leftSpaceToView(CommonImg,180).topSpaceToView(CommonImg,10).widthIs(90).heightIs(40);
    
    UIImageView *JieSuanImgCom = [[UIImageView alloc] init];
    JieSuanImgCom.image = [UIImage imageNamed:@"Group.png"];
    [CommonImg addSubview:JieSuanImgCom];
    JieSuanImgCom.sd_layout.leftSpaceToView(CommonImg,200).topSpaceToView(CommonImg,18).widthIs(14.5).heightIs(18.5);
    
//    UIButton *JieSuanBtnCom = [[UIButton alloc] init];
//    [JieSuanBtnCom setTitle:@"结算记录" forState:UIControlStateNormal];
//    JieSuanBtnCom.backgroundColor = [UIColor clearColor];
//    JieSuanBtnCom.titleLabel.font = [UIFont systemFontOfSize:12];
//    [JieSuanBtnCom addTarget:self action:@selector(JieSuan:) forControlEvents:UIControlEventTouchUpInside];
//    //[CommonImg addSubview:JieSuanBtnCom];
//    JieSuanBtnCom.sd_layout.leftSpaceToView(CommonImg,215).topSpaceToView(CommonImg,21.5).widthIs(60).heightIs(10.5);
    
    UILabel *PuTongJieSuanLab = [[UILabel alloc] init];
    PuTongJieSuanLab.text = @"结算记录";
    PuTongJieSuanLab.font = [UIFont systemFontOfSize:12];
    PuTongJieSuanLab.textColor = [UIColor whiteColor];
    [CommonImg addSubview:PuTongJieSuanLab];
    PuTongJieSuanLab.sd_layout.leftSpaceToView(CommonImg,215).topSpaceToView(CommonImg,21.5).widthIs(60).heightIs(10.5);
    
    UILabel *MidLabCom = [[UILabel alloc] init];
    MidLabCom.text = @"普通总额(元)";
    MidLabCom.textColor = [UIColor whiteColor];
    MidLabCom.backgroundColor = [UIColor clearColor];
    MidLabCom.font = [UIFont systemFontOfSize:13];
    [CommonImg addSubview:MidLabCom];
    MidLabCom.sd_layout.leftSpaceToView(CommonImg,106.5).topSpaceToView(CommonImg,65).widthIs(75).heightIs(17.5);
    AllMoneyLabCom = [[UILabel alloc] init];
    AllMoneyLabCom.text = @"0.00";
    AllMoneyLabCom.adjustsFontSizeToFitWidth = YES;
    AllMoneyLabCom.textAlignment = NSTextAlignmentCenter;
    AllMoneyLabCom.textColor = [UIColor whiteColor];
    AllMoneyLabCom.font  = [UIFont systemFontOfSize:39];
    AllMoneyLabCom.backgroundColor = [UIColor clearColor];
    [CommonImg addSubview:AllMoneyLabCom];
    AllMoneyLabCom.sd_layout.leftSpaceToView(CommonImg,0).topSpaceToView(CommonImg,134).widthIs(273).heightIs(40.5);
    
    //可转出金额
    UILabel *TitleLab = [[UILabel alloc] init];
    TitleLab.text = @"可转出金额(元)";
    TitleLab.font = [UIFont systemFontOfSize:15];
    TitleLab.textColor = Color(100, 100, 100);
    TitleLab.textAlignment = NSTextAlignmentCenter;
    [ScrollView addSubview:TitleLab];
    TitleLab.sd_layout.centerXEqualToView(ScrollView).topSpaceToView(ScrollView,355).widthIs(101.5).heightIs(15.5);
    //钱
    MoneyLab = [[UILabel alloc] init];
    MoneyLab.textColor = BlueColor;
    MoneyLab.text = @"0.00元";
    MoneyLab.adjustsFontSizeToFitWidth = YES;
    MoneyLab.textAlignment = NSTextAlignmentCenter;
    MoneyLab.font = [UIFont systemFontOfSize:14];
    [ScrollView addSubview:MoneyLab];
    MoneyLab.sd_layout.centerXEqualToView(ScrollView).topSpaceToView(ScrollView,381).widthIs(200).heightIs(15);

    UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    leftLab.text = @"立即转出:";
    leftLab.font = [UIFont systemFontOfSize:16];
    leftLab.backgroundColor = [UIColor whiteColor];
    leftLab.textAlignment = NSTextAlignmentCenter;
    BankFld = [[UITextField alloc] init];
    BankFld.delegate = self;
    BankFld.backgroundColor = [UIColor whiteColor];
    BankFld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    BankFld.leftViewMode = UITextFieldViewModeAlways;
    BankFld.leftView = leftLab;
    BankFld.layer.cornerRadius = 3;
    BankFld.placeholder = @"请填写转出金额";
    BankFld.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    BankFld.keyboardType = UIKeyboardTypeNumberPad;
    [ScrollView addSubview:BankFld];
    BankFld.sd_layout.leftSpaceToView(ScrollView,16).topSpaceToView(ScrollView,416.5).rightSpaceToView(ScrollView,16).heightIs(44);
    
    UIButton *TransFormBtn = [[UIButton alloc] init];
    [TransFormBtn setTitle:@"转出" forState:UIControlStateNormal];
    [TransFormBtn addTarget:self action:@selector(TransForm) forControlEvents:UIControlEventTouchUpInside];
    TransFormBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    TransFormBtn.layer.cornerRadius = 3;
    TransFormBtn.layer.masksToBounds = YES;
    TransFormBtn.backgroundColor = BlueColor;
    [ScrollView addSubview:TransFormBtn];
    TransFormBtn.sd_layout.leftSpaceToView(ScrollView,16).topSpaceToView(ScrollView,475).widthIs(288).heightIs(40);
    //[self addJieSuanAlertView];
    
    [self RequestForYuE:@"RB0"];
    [self RequestForYuE:@"RB1"];
    [BusiIntf curPayOrder].TypeOrder = @"RB0";
    TypeFlag = @"1";
    
}
//结算提示框
- (void)addJieSuanAlertView {
    
    MaskView = [[UIView alloc] initWithFrame:CGRectMake(0, KscreenHeight * 2, KscreenWidth, KscreenHeight)];
    MaskView.backgroundColor = [UIColor blackColor];
    MaskView.alpha = 0.5;
    
    //[self.view addSubview:MaskView];
    
//    UIImageView *AlertView = [[UIImageView alloc] init];
//    AlertView.backgroundColor = [UIColor whiteColor];
//    AlertView.layer.cornerRadius = 3.5;
//    AlertView.alpha = 1;
//    AlertView.layer.masksToBounds = YES;
//    [MaskView addSubview:AlertView];
//    AlertView.sd_layout.leftSpaceToView(MaskView,16).topSpaceToView(MaskView,120.5).rightSpaceToView(MaskView,16).heightIs(276);
    
}
//结算记录
- (void)JieSuan:(id)sender {
    
    NSLog(@"结算");
    JieSuanListVC *JieSuan = [[JieSuanListVC alloc] init];
    [self.navigationController pushViewController:JieSuan animated:YES];
}

//快捷结算
-(void)KuaiJie {
    NSLog(@"结算");
    if ([TypeFlag isEqualToString:@"0"]) {
        [BusiIntf curPayOrder].TypeOrder = @"UP0";
    } else {
        [BusiIntf curPayOrder].TypeOrder = @"RB0";
    }
    JieSuanListVC *JieSuan = [[JieSuanListVC alloc] init];
    [self.navigationController pushViewController:JieSuan animated:YES];
}
-(void)PuTong {
    NSLog(@"结算");
    if ([TypeFlag isEqualToString:@"1"]) {
        [BusiIntf curPayOrder].TypeOrder = @"RB1";
        JieSuanListVC *JieSuan = [[JieSuanListVC alloc] init];
        [self.navigationController pushViewController:JieSuan animated:YES];
    }else {
        
    }
    
}
//立即转出
- (void)TransForm {
    
    NSLog(@"转出");
//    [UIView animateWithDuration:0.3 animations:^{
//        CGRect frame = MaskView.frame;
//        frame.origin.x = 0;
//        frame.origin.y = 0;
//        MaskView.frame = frame;
//    } completion:^(BOOL finished) {
//        NSLog(@"动画完成!");
//    }];
    //提示
//    NSString *msg = [[NSString alloc] init];
//    NSString *exportamount = [NSString stringWithFormat:@"转出金额 : %@",@"60.00"];
//    NSString *free = [NSString stringWithFormat:@"提现手续费 : %@",@"1.00"];
//    NSString *JieSuanFree = [NSString stringWithFormat:@"结算费: %@",@"1.00"];
//    NSString *DaoZhang = [NSString stringWithFormat:@"到账金额 : %@",@"1.00"];
//    msg = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n",exportamount,free,JieSuanFree,DaoZhang];
//    UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:@"确认转出" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
//    AlertView.delegate = self;
    
    if ([BankFld.text isEqualToString:@""]) {
        [self alert:@"请输入金额!"];
        return;
    }
    [SVProgressHUD show];
    NSString *url = BaseUrl;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *md5 = [NSString stringWithFormat:@"%@%@%@",[BusiIntf curPayOrder].TypeOrder,BankFld.text,key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                           @"type":[BusiIntf curPayOrder].TypeOrder,
                           @"amount":BankFld.text,
                           @"issued":@"0",
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"SettlePay",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    NSLog(@"参数：%@",params);
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSDictionary *dicc = [result JSONValue];
        NSLog(@"订单列表：%@",dicc);
        NSString *content = dicc[@"content"];
       // NSString *code = dicc[@"code"];
        NSString *Free = dicc[@"free"];
        NSString *ratefree = dicc[@"rateFee"];
        NSString *receive = dicc[@"receive"];
       // NSString *refund = dicc[@"refund"];
        if (![content isEqualToString:@"正常"]) {
            [self alert:content];
        }
        else {
            //提示
            NSString *msg = [[NSString alloc] init];
            NSString *exportamount = [NSString stringWithFormat:@"转出金额 : %@",BankFld.text];
            NSString *free = [NSString stringWithFormat:@"提现手续费 : %@",Free];
            NSString *JieSuanFree = [NSString stringWithFormat:@"结算费率: %@",ratefree];
            NSString *DaoZhang = [NSString stringWithFormat:@"到账金额 : %@",receive];
            msg = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n",exportamount,free,JieSuanFree,DaoZhang];
            UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:@"确认转出" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            AlertView.delegate = self;
            [AlertView show];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"网络申请失败:%@",error);
        [SVProgressHUD dismiss];
    }];

    //[AlertView show];

}
//选择是否付款
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        NSLog(@"取消付款");
    }else {
        NSLog(@"付款");
        [SVProgressHUD show];
        NSString *url = BaseUrl;
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *token = [user objectForKey:@"token"];
        NSString *key = [user objectForKey:@"key"];
        float amount = [BankFld.text floatValue];
        NSLog(@"%.2f",amount);
        NSString *md5 = [NSString stringWithFormat:@"%@%.2f%@",[BusiIntf curPayOrder].TypeOrder,amount,key];
        NSString *sign = [self md5HexDigest:md5];
        NSDictionary *dic1 = @{
                               @"type":[BusiIntf curPayOrder].TypeOrder,
                               @"amount":[NSString stringWithFormat:@"%.2f",amount],
                               @"issued":@"1",
                               @"token":token,
                               @"sign":sign
                               };
        NSDictionary *dicc = @{
                               @"action":@"SettlePay",
                               @"data":dic1
                               };
        NSString *params = [dicc JSONFragment];
        NSLog(@"参数：%@",params);
        [IBHttpTool postWithURL:url params:params success:^(id result) {
            NSDictionary *dicc = [result JSONValue];
            NSLog(@"订单列表：%@",dicc);
            NSString *content = dicc[@"content"];
            if (![content isEqualToString:@"正常"]) {
                [self alert:content];
            }
            else {
                //结算列表
                JieSuanListVC *JieSuan = [[JieSuanListVC alloc] init];
                [self.navigationController pushViewController:JieSuan animated:YES];
            }
            [SVProgressHUD dismiss];
        } failure:^(NSError *error) {
            NSLog(@"网络申请失败:%@",error);
            [SVProgressHUD dismiss];
        }];

    }
    
}
- (void)YiBao {
    
    [YiBaoBtn setTitleColor:BlueColor forState:UIControlStateNormal];
    [WuJie setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    TypeFlag = @"0";
    [BusiIntf curPayOrder].TypeOrder = @"UP0";
    [self RequestForYuE:@"UP0"];
    
}
- (void)WuJie {
    [YiBaoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [WuJie setTitleColor:BlueColor  forState:UIControlStateNormal];
    TypeFlag = @"1";
    [self RequestForYuE:@"RB0"];
    [self RequestForYuE:@"RB1"];
}
//余额查询
- (void)RequestForYuE:(NSString *)type {
    [SVProgressHUD show];
    NSString *url = BaseUrl;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    //NSString *orderNo = [user objectForKey:@"orderNo"];
    NSString *md5 = [NSString stringWithFormat:@"%@%@",type,key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                           @"type":type,
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"SettleBalance",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    NSLog(@"参数：%@",params);
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSDictionary *dicc = [result JSONValue];
        NSLog(@"订单列表：%@",dicc);
        
        float accountValue = [dicc[@"accountBalance"] floatValue];
        float settleValue = [dicc[@"settleBalance"] floatValue];
        if ([TypeFlag isEqualToString:@"0"]) {
            AllMoneyLab.text = [NSString stringWithFormat:@"%.2f",accountValue];
            MoneyLab.text = [NSString stringWithFormat:@"%.2f",settleValue];
            KuaiJieAmount = [NSString stringWithFormat:@"%.2f",settleValue];
            
            AllMoneyLabCom.text = [NSString stringWithFormat:@"%.2f",0.00];
            //MoneyLab.text = [NSString stringWithFormat:@"%.2f",settleValue];
            PuTongAmount = [NSString stringWithFormat:@"%.2f",0.00];
            if (scroll.contentOffset.x >= 200) {
                MoneyLab.text = PuTongAmount;
            }
        } else {
            if ([type isEqualToString:@"RB1"]) {
                AllMoneyLabCom.text = [NSString stringWithFormat:@"%.2f",accountValue];
                //MoneyLab.text = [NSString stringWithFormat:@"%.2f",settleValue];
                PuTongAmount = [NSString stringWithFormat:@"%.2f",settleValue];
            }
            if ([type isEqualToString:@"RB0"]) {
                AllMoneyLab.text = [NSString stringWithFormat:@"%.2f",accountValue];
                MoneyLab.text = [NSString stringWithFormat:@"%.2f",settleValue];
                KuaiJieAmount = [NSString stringWithFormat:@"%.2f",settleValue];
            }
            if (scroll.contentOffset.x >= 200) {
                MoneyLab.text = PuTongAmount;
            }

        }
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
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.x;
    if (offset >= 200) {
        
        //NSLog(@"右滑动!!!!");
        //普通
        //[self RequestForYuE:@"RB1"];
        MoneyLab.text = PuTongAmount;
        if ([TypeFlag isEqualToString:@"0"]) {
            //[BusiIntf curPayOrder].TypeOrder = @"UP0";
        }else {
            [BusiIntf curPayOrder].TypeOrder = @"RB1";
        }
        
        
    }if (offset <= 200) {
        
        //NSLog(@"左滑动!!!!");
        //快捷
        //[self RequestForYuE:@"RB0"];
        MoneyLab.text = KuaiJieAmount;
        if ([TypeFlag isEqualToString:@"0"]) {
            [BusiIntf curPayOrder].TypeOrder = @"UP0";
        }else {
            [BusiIntf curPayOrder].TypeOrder = @"RB0";
        }
        
    }
}
//控制偏移量
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    CGFloat x = targetContentOffset -> x;
    NSLog(@"%f",x);
    if (x >= 200) {
        targetContentOffset -> x = 273 * 2 + 45;
    } else {
        targetContentOffset -> x = 0;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    
    NSLog(@"滑动结束!");
    
}

//textFieldDele
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [self moveup];
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self movedown];
}
- (void)moveup
{
    NSTimeInterval animationDuration = 0.300000011920929;
    CGRect frame = self.view.frame;
    frame.origin.y -= 50 + 80;
    //frame.size.height += kOFFSET_FOR_KEYBOARD + 10;
#if (QDFLAG == 6)
    frame.origin.y -= 110;
    //frame.size.height += 110;
#endif
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
}
- (void)movedown
{
    NSTimeInterval animationDuration = 0;//0.300000011920929;
    CGRect frame = self.view.frame;
    frame.origin.y += 50 + 80;
    //frame.size.height -= kOFFSET_FOR_KEYBOARD + 10;
#if (QDFLAG == 6)
    frame.origin.y += 110;
    //frame.size.height -= 110;
#endif
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
}
- (void)alert:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    [self.view endEditing:YES];
//    
//    
//}
@end
