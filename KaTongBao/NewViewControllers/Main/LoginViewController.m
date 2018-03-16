//
//  LoginViewController.m
//  wujieNew
//
//  Created by rongfeng on 15/12/17.
//  Copyright © 2015年 rongfeng. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "MartViewController.h"
#import "OrderListViewController.h"
#import "MyAccountViewController.h"
#import "UIView+SDAutoLayout.h"
#import "Common.h"
#import "SignInViewController.h"
#import "TDMyMainViewController.h"
#import "BusiIntf.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "Reachability.h"
#import "AccountCenterVC.h"
#import "PubFunc.h"
#import "JXOrderListViewController.h"
#import "SJAvatarBrowser.h"
#import <CommonCrypto/CommonDigest.h>
#import "WLDecimalKeyboard.h"

#define TAG_BTN_BACK       9990001
#define TAG_INDICATOR       999002
#define TAG_INDICATOR_BACK   999003

@implementation LoginViewController {
    NSInteger _index;
    UIButton *remenberbtn;
    UITextField *pwdTextFiled;
    UITextField *accountTextFiled;
    UITabBarController *tabbarController;
    NSString *version;
    UIImageView *DownLoadImg;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.toolbarHidden = YES;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    self.view.backgroundColor = [UIColor whiteColor];
    //是否是APP Store的布局
    [BusiIntf curPayOrder].IsAPPStore = YES;
    
}

- (void)setCheckSel: (UIButton*)btn isChecked: (BOOL)isChecked
{
    btn.selected = isChecked;
    if (btn.selected)
        [btn setImage:[UIImage imageNamed:@"记住.png"] forState:UIControlStateNormal];
    else
        [btn setImage:[UIImage imageNamed:@"正常.png"] forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
//    //判断IOS系统版本号
//    BOOL isIOS6 = false;
//    //NSLog(@"%f", NSFoundationVersionNumber);
//    //手动添加 NSFoundationVersionNumber_iOS_6_1 原因xcode库版本号
//    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
//        ;
//    } else {
//        isIOS6 = true;
//    }
//    //判断是否为iphone5
//    BOOL isphone5 = false;
//    
//    CGSize size = [[UIScreen mainScreen] bounds].size;
//    if (size.height == 568) {
//        isphone5 = true;
//    }
//    /*
//     //背景
//     UIImageView *imageView;
//     if (!isphone5 ) {
//     //IOS6
//     imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
//     [imageView setImage:[UIImage imageNamed:@"background920"]];
//     
//     } else {
//     imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 548)];
//     //[imageView setImage:[UIImage imageNamed:@"bg(1136)"]];
//     [imageView setImage:[UIImage imageNamed:@"background1136"]];
//     
//     }
//     [self.view addSubview:imageView];
//     CGRect rt = imageView.frame;        //rt.origin.y = 0
//     */
//    CGRect rt = [[UIScreen mainScreen] bounds];
//    
//    if (!isphone5) {
//        //NSLog(@"%f, %f", imageView.frame.size.height, imageView.frame.origin.y);
//        //rt.origin.y += 44;
//        rt.origin.y -= 95;
//        //NSLog(@"%f", rt.origin.y);
//        //imageView.frame = rt;
//    }
//    //微调
//    /*
//     if (!isphone5 && isIOS6) {
//     rt.origin.y += 20;
//     }
//     */
//    if (isphone5) {
//        rt.origin.y -= 20;
//    }

    version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    NSString *strVer = [NSString stringWithFormat:@"当前版本：%@", version];
    UILabel *verLab = [[UILabel alloc] init];
    verLab.textAlignment = NSTextAlignmentRight;
    verLab.font = [UIFont systemFontOfSize:15];
    verLab.text = strVer;
    //[self.view addSubview:verLab];
    verLab.sd_layout.leftSpaceToView(self.view,110).topSpaceToView(self.view,20).widthIs(200).heightIs(20);
    //登陆按钮
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(50, 150, 200, 40);
    btn.layer.cornerRadius = 7;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:btn];
    [self createView];
    //自定义返回按钮
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    right.title = @"返回";
    self.navigationItem.backBarButtonItem = right;
    
}

//创建UI
- (void)createView {
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    UIImageView *BackImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    BackImg.backgroundColor = [UIColor clearColor];
    BackImg.userInteractionEnabled = YES;
    [self.view addSubview:BackImg];
    
    UITapGestureRecognizer *TapToResignKeyBoard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ResignKeyBoard)];
    TapToResignKeyBoard.numberOfTouchesRequired = 1;
    [BackImg addGestureRecognizer:TapToResignKeyBoard];
    //logo
    UIImageView *ImageView = [[UIImageView alloc] init];
    ImageView.image = [UIImage imageNamed:@"卡捷通登录页logo.png"];
    [self.view addSubview:ImageView];
    ImageView.sd_layout.centerXEqualToView(self.view).topSpaceToView(self.view,60.5).widthIs(97).heightIs(33);
    //账户名
    UIImageView *accountImg = [[UIImageView alloc] init];
    accountImg.image = [UIImage imageNamed:@"Oval 2.png"];
    [self.view addSubview:accountImg];
    accountTextFiled = [[UITextField alloc] init];
    accountTextFiled.placeholder = @"登录名";
    accountTextFiled.font = [UIFont systemFontOfSize:15];
    //accountTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    accountTextFiled.delegate = self;
    WLDecimalKeyboard *inputView = [[WLDecimalKeyboard alloc] init];
    accountTextFiled.inputView = inputView;
    [accountTextFiled reloadInputViews];
    [self.view addSubview:accountTextFiled];
    
    accountImg.sd_layout.leftSpaceToView(self.view,35).topSpaceToView(self.view,159).widthIs(20.5).heightIs(20);
    accountTextFiled.sd_layout.leftSpaceToView(self.view,77.3).topSpaceToView(self.view,159).rightSpaceToView(self.view,35).heightIs(21);
    UIImageView *bottonLine = [[UIImageView alloc] init];
    bottonLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bottonLine];
    bottonLine.sd_layout.leftSpaceToView(self.view,35).rightSpaceToView(self.view,35).topSpaceToView(self.view,184).heightIs(0.5);
    
    //密码
    UIImageView *pwdImg = [[UIImageView alloc] init];
    pwdImg.image = [UIImage imageNamed:@"Rectangle 21 + Rectangle 22 + Rectangle 23.png"];
    [self.view addSubview:pwdImg];
    pwdTextFiled = [[UITextField alloc] init];
    pwdTextFiled.secureTextEntry = YES;
    pwdTextFiled.placeholder = @"密   码";
    pwdTextFiled.delegate = self;
    pwdTextFiled.font = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:pwdTextFiled];
    
    pwdImg.sd_layout.leftSpaceToView(self.view,39.5).topSpaceToView(self.view,227).widthIs(21).heightIs(19.5);
    pwdTextFiled.sd_layout.leftSpaceToView(self.view,77.3).topSpaceToView(self.view,228).rightSpaceToView(self.view,35).heightIs(21);
    
    UIImageView *bottonLine2 = [[UIImageView alloc] init];
    bottonLine2.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bottonLine2];
    bottonLine2.sd_layout.leftSpaceToView(self.view,35).rightSpaceToView(self.view,35).topSpaceToView(self.view,251.5).heightIs(0.5);
    //记住密码
    remenberbtn = [[UIButton alloc] init];
    if (_isSelected) {
        [remenberbtn setImage:[UIImage imageNamed:@"记住.png"] forState:UIControlStateNormal];
    }else {
        [remenberbtn setImage:[UIImage imageNamed:@"正常.png"] forState:UIControlStateNormal];
    }
    [remenberbtn addTarget:self action:@selector(remenber:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:remenberbtn];
    remenberbtn.sd_layout.leftSpaceToView(self.view,28.5).topSpaceToView(self.view,253.5).widthIs(32).heightIs(32);
    UILabel *lab = [[UILabel alloc] init];
    lab.text = @"记住密码";
    lab.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:lab];
    lab.sd_layout.leftSpaceToView(self.view,56).topSpaceToView(self.view,259.5).widthIs(80).heightIs(14);
    //忘记密码
    UIButton *Forgetbtn = [[UIButton alloc] init];
    //Forgetbtn.backgroundColor = RedColor;
    [Forgetbtn setTitleColor:RedColor forState:UIControlStateNormal];
    [Forgetbtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    Forgetbtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [Forgetbtn addTarget:self action:@selector(forget) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Forgetbtn];
    Forgetbtn.sd_layout.leftSpaceToView(self.view,240.5).topSpaceToView(self.view,257.5).widthIs(58).heightIs(14);
    //登录
    UIButton *logiBtn = [[UIButton alloc] init];
    [logiBtn setBackgroundImage:[UIImage imageNamed:@"Rectangle 8 + 登录.png"] forState:UIControlStateNormal];
    [logiBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logiBtn];
    logiBtn.sd_layout.leftSpaceToView(self.view,30).topSpaceToView(self.view,320).widthIs(260).heightIs(40);
    //注册
    UIButton *signin = [[UIButton alloc] init];
    [signin setBackgroundImage:[UIImage imageNamed:@"注册账户      + Rectangle 32 + Rectangle 32 Copy.png"] forState:UIControlStateNormal];
    [signin setBackgroundImage:[UIImage imageNamed:@"注册账户      + Rectangle 32 + Rectangle 32 Copy.png"] forState:UIControlStateHighlighted];
    [signin addTarget:self action:@selector(signin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signin];
    signin.sd_layout.leftSpaceToView(self.view,30).bottomSpaceToView(self.view,40).widthIs(260).heightIs(13);
    //用户名密码信息
    accountTextFiled.text = [BusiIntf getUserInfo].UserName;
    if ([BusiIntf getUserInfo].RemPwd) {
        pwdTextFiled.text = [BusiIntf getUserInfo].Pwd;
        [self setCheckSel:remenberbtn isChecked:YES];
    }
    else {
        [self setCheckSel:remenberbtn isChecked:NO];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magnify)];
    tap.numberOfTapsRequired = 1;
    DownLoadImg = [[UIImageView alloc] init];
    DownLoadImg.image = [UIImage imageNamed:@"卡捷通"];
    DownLoadImg.userInteractionEnabled = YES;
    [DownLoadImg addGestureRecognizer:tap];
    [self.view addSubview:DownLoadImg];
    DownLoadImg.sd_layout.centerXEqualToView(self.view).topSpaceToView(logiBtn,60).widthIs(60).heightIs(60);
}
//收键盘
- (void)ResignKeyBoard {
    
    [accountTextFiled resignFirstResponder];
    [pwdTextFiled resignFirstResponder];
    
}

- (void)magnify {
    [SJAvatarBrowser showImage:DownLoadImg];
}

//记住密码
- (void)remenber:(UIButton *)btn {
    [self setCheckSel:btn isChecked:!btn.selected];
    NSLog(@"remenber");
}

- (void)forget {
    NSLog(@"forget");
    SignInViewController *signIn = [[SignInViewController alloc] init];
    signIn.tag = 100;
    [self.navigationController pushViewController:signIn animated:YES];
}

//登陆
- (void)login {
    
    //
    tabbarController = [[UITabBarController alloc] init];
    //MainViewController *first = [[MainViewController alloc] init];
    TDMyMainViewController *first = [[TDMyMainViewController alloc] init];
    MartViewController *second = [[MartViewController alloc] init];
    JXOrderListViewController *third = [[JXOrderListViewController alloc] init];
    AccountCenterVC *four = [[AccountCenterVC alloc] init];
    UINavigationController *firstNaVi = [[UINavigationController alloc] initWithRootViewController:first];
    UINavigationController *secondNaVi = [[UINavigationController alloc] initWithRootViewController:second];
    UINavigationController *thirdNaVi = [[UINavigationController alloc] initWithRootViewController:third];
    UINavigationController *fourNaVi = [[UINavigationController alloc] initWithRootViewController:four];
    //APPStore布局
//    if ([BusiIntf curPayOrder].IsAPPStore) {
//        tabbarController.viewControllers = [NSArray arrayWithObjects:firstNaVi,thirdNaVi,fourNaVi, nil];
//    }else {
//        tabbarController.viewControllers = [NSArray arrayWithObjects:firstNaVi,secondNaVi,thirdNaVi,fourNaVi, nil];
//    }
    tabbarController.viewControllers = [NSArray arrayWithObjects:firstNaVi,secondNaVi,thirdNaVi,fourNaVi, nil];
    UITabBar *tabBar                 = tabbarController.tabBar;
    UITabBarItem *tabBarItem1        = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2        = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabbarItem3        = [tabBar.items objectAtIndex:2];
    
//    if ([BusiIntf curPayOrder].IsAPPStore) {   //APPStore布局
//        [tabBarItem1 setTitle:@"首页"];
//        [tabBarItem1 setImage:[UIImage imageNamed:@"HOME"]];
//        [tabBarItem1 setSelectedImage:[UIImage imageNamed:@"HOME_SEL"]];
//        
//        [tabBarItem2 setTitle:@"订单"];
//        [tabBarItem2 setImage:[UIImage imageNamed:@"NOTEPAD"]];
//        [tabBarItem2 setSelectedImage:[UIImage imageNamed:@"NOTEPAD_SEL"]];
//        
//        [tabbarItem3 setTitle:@"我的"];
//        [tabbarItem3 setImage:[UIImage imageNamed:@"USER"]];
//        [tabbarItem3 setSelectedImage:[UIImage imageNamed:@"USER_SEL"]];
//    }else {
//        
//        [tabBarItem1 setTitle:@"首页"];
//        [tabBarItem1 setImage:[UIImage imageNamed:@"HOME"]];
//        [tabBarItem1 setSelectedImage:[UIImage imageNamed:@"HOME_SEL"]];
//        
//        [tabBarItem2 setTitle:@"商城"];
//        [tabBarItem2 setImage:[UIImage imageNamed:@"BAR-GRAPH"]];
//        [tabBarItem2 setSelectedImage:[UIImage imageNamed:@"BAR-GRAPH-SEL"]];
//        
//        [tabbarItem3 setTitle:@"订单"];
//        [tabbarItem3 setImage:[UIImage imageNamed:@"NOTEPAD"]];
//        [tabbarItem3 setSelectedImage:[UIImage imageNamed:@"NOTEPAD_SEL"]];
//        
//        UITabBarItem *tabbarItem4        = [tabBar.items objectAtIndex:3];
//        [tabbarItem4 setTitle:@"我的"];
//        [tabbarItem4 setImage:[UIImage imageNamed:@"USER"]];
//        [tabbarItem4 setSelectedImage:[UIImage imageNamed:@"USER_SEL"]];
//    }

    [tabBarItem1 setTitle:@"首页"];
    [tabBarItem1 setImage:[UIImage imageNamed:@"HOME"]];
    [tabBarItem1 setSelectedImage:[UIImage imageNamed:@"HOME_SEL"]];
    
    [tabBarItem2 setTitle:@"商城"];
    [tabBarItem2 setImage:[UIImage imageNamed:@"BAR-GRAPH"]];
    [tabBarItem2 setSelectedImage:[UIImage imageNamed:@"BAR-GRAPH-SEL"]];
    
    [tabbarItem3 setTitle:@"订单"];
    [tabbarItem3 setImage:[UIImage imageNamed:@"NOTEPAD"]];
    [tabbarItem3 setSelectedImage:[UIImage imageNamed:@"NOTEPAD_SEL"]];
    
    UITabBarItem *tabbarItem4        = [tabBar.items objectAtIndex:3];
    [tabbarItem4 setTitle:@"我的"];
    [tabbarItem4 setImage:[UIImage imageNamed:@"USER"]];
    [tabbarItem4 setSelectedImage:[UIImage imageNamed:@"USER_SEL"]];
    [tabBar setTintColor:[UIColor colorWithRed:23.0/255 green:177.0/255 blue:248.0/255 alpha:1.0]];
    //[self.navigationController pushViewController:tabbarController animated:YES];
    //对输入账户和密码做判断
    if (accountTextFiled.text.length < 1) {
        [self alert:@"请输入用户名"];
        return;
    }
    if (pwdTextFiled.text.length < 1) {
        [self alert:@"请输入密码"];
        return;
    }
    if (![[Reachability reachabilityForInternetConnection] isReachable]) {
        [self alert:@"没有连接网络!"];
        return;
    }
    //保存
    [BusiIntf getUserInfo].UserName = accountTextFiled.text;
    [BusiIntf getUserInfo].Pwd = pwdTextFiled.text;
    [BusiIntf getUserInfo].RemPwd = remenberbtn.selected;
    [BusiIntf getUserInfo].StartDate = [PubFunc getNow];
    [BusiIntf writePlist];
    [self addWait:@"登录中"];
    [self RequestForLogIn];
}

//注册
- (void)signin {
    NSLog(@"注册");
    SignInViewController *SignIn = [[SignInViewController alloc] init];
    SignIn.tag = 101;
    [self.navigationController pushViewController:SignIn animated:YES];
}

//登录
- (void)RequestForLogIn {
    
    //[self.navigationController pushViewController:tabbarController animated:YES];
    
    NSString *url = JXUrl;
    //获取UUID
    NSString *imsi = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *UUID = [self md5:imsi];
    NSString *UUID16 = [[UUID substringFromIndex:8] substringToIndex:16];
    NSDictionary *dic1 = @{
                           @"phone":accountTextFiled.text,
                           @"pass":pwdTextFiled.text,
                           @"os":@"IOS",
                           @"soft":@"KTB",
                           @"imsi":@"",
                           @"imei":UUID16,
                           @"version":version
                           };
    NSDictionary *dicc = @{
                           @"action":@"shopLoginState",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSLog(@"数据:%@",result);
        [self stopWait];
        NSDictionary *dic = [result JSONValue];
        NSString *code = dic[@"code"];
        NSString *content = dic[@"msg"];
        NSString *token = dic[@"shopToken"];
        NSString *key = dic[@"shopKey"];
        NSString *YyToken = dic[@"YyToken"];
        NSString *YySign = dic[@"YySign"];
        [BusiIntf curPayOrder].Notice = dic[@"noticeText"];
        [BusiIntf curPayOrder].nocardMcgEnd = dic[@"nocardMcgEnd"];
        [BusiIntf curPayOrder].nocardMcgMax = dic[@"nocardMcgMax"];
        [BusiIntf curPayOrder].nocardMcgMin = dic[@"nocardMcgMin"];
        [BusiIntf curPayOrder].nocardMcgStart = dic[@"nocardMcgStart"];
        [BusiIntf curPayOrder].nocardOrderEnd = dic[@"nocardOrderEnd"];
        [BusiIntf curPayOrder].nocardOrderMax = dic[@"nocardOrderMax"];
        [BusiIntf curPayOrder].nocardOrderMin = dic[@"nocardOrderMin"];
        [BusiIntf curPayOrder].nocardOrderStart = dic[@"nocardOrderStart"];
        [BusiIntf curPayOrder].T0 = dic[@"T0"];
        [BusiIntf curPayOrder].T0Mcg = dic[@"T0Mcg"];
        [BusiIntf curPayOrder].T0Tip = dic[@"T0Tip"];
        [BusiIntf curPayOrder].T1 = dic[@"T1"];
        [BusiIntf curPayOrder].T1Mcg = dic[@"T1Mcg"];
        [BusiIntf curPayOrder].T1Tip = dic[@"T1Tip"];
        [BusiIntf curPayOrder].NoticeFlg = dic[@"noticeFlg"];
        [BusiIntf getUserInfo].ShopName = dic[@"shopName"];
        [BusiIntf curPayOrder].VipPrice = dic[@"vipPrice"];
        NSLog(@"会员申请价格:%@",[BusiIntf curPayOrder].VipPrice);
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:token forKey:@"token"];
        [user setObject:key forKey:@"key"];
        [user setObject:YyToken forKey:@"YyToken"];
        [user setObject:YySign forKey:@"YySign"];
        [user synchronize];
        NSLog(@"登陆key:%@...token:%@",dic[@"key"],dic[@"auth"]);
        if ([code isEqualToString:@"000000"]) {
            
            tabbarController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:tabbarController animated:YES];
            tabbarController.hidesBottomBarWhenPushed = NO;
        }else {
            [self alert:content];
        }
        NSLog(@"返回的数据:%@",dic);
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
        [self stopWait];
    }];
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
//
- (void)addWait:(NSString*)caption
{
    int width = 32, height = 32;
    CGRect frame = CGRectMake(80,180, 160, 130);
    int x = frame.size.width;
    int y = frame.size.height;
    
    frame = CGRectMake((x - width) / 2, (y - height) / 2, width, height);
    UIActivityIndicatorView* progressInd = [[UIActivityIndicatorView alloc]initWithFrame:frame];
    [progressInd startAnimating];
    progressInd.activityIndicatorViewStyle= UIActivityIndicatorViewStyleWhiteLarge;
    
    frame = CGRectMake((x - 80)/2,(y - height) / 2 + height, 80, 20);
    UILabel *waitingLable = [[UILabel alloc] initWithFrame:frame];
    waitingLable.text= caption;
    waitingLable.textColor= [UIColor whiteColor];
    waitingLable.font= [UIFont systemFontOfSize:15];
    waitingLable.backgroundColor = [UIColor clearColor];
    waitingLable.textAlignment = NSTextAlignmentCenter;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha= 0.1;
    [backView setTag:TAG_INDICATOR_BACK];
    [self.view addSubview:backView];
    
    frame = CGRectMake(80,180, 160, 130);
    UIView* theView = [[UIView alloc] initWithFrame:frame];
    theView.backgroundColor = [UIColor blackColor];
    theView.layer.cornerRadius = 10;
    theView.alpha= 0.7;
    [theView addSubview:progressInd];
    [theView addSubview:waitingLable];
    
    [theView setTag:TAG_INDICATOR];
    [self.view addSubview:theView];
    
    [[NSRunLoop currentRunLoop] limitDateForMode:NSDefaultRunLoopMode];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

- (void)stopWait
{
    [[self.view viewWithTag:TAG_INDICATOR]removeFromSuperview];
    [[self.view viewWithTag:TAG_INDICATOR_BACK]removeFromSuperview];
    
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    [self.view endEditing:YES];
//    
//    
//}
@end
