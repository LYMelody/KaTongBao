//
//  JXLoginViewController.m
//  JingXuan
//
//  Created by rongfeng on 16/6/1.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "JXLoginViewController.h"
#import "Common.h"
#import "BusiIntf.h"
#import "UIView+SDAutoLayout.h"
#import "macro.h"
#import "JXCardManagerViewController.h"
#import "JXOrderListViewController.h"
#import "JXAccountViewController.h"
#import "JXMainViewController.h"
#import "Reachability.h"
#import "PubFunc.h"
#import "ForgetPwdViewController.h"
#import "RegistViewController.h"
#import "JXForgetPwdViewController.h"
#import "JXRegistViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "IBHttpTool.h"
#import "SBJSON.h"
#import "SJAvatarBrowser.h"
#import "AccountCenterVC.h"
#define TAG_BTN_BACK       9990001
#define TAG_INDICATOR       999002
#define TAG_INDICATOR_BACK   999003
@interface JXLoginViewController ()

@end

@implementation JXLoginViewController
{
    
    BOOL isR;
    BOOL _isSelected;
    UIButton *remenberBtn;
    UITabBarController *tabbarController;
    NSString *version;
    UIImageView *DownLoadImg;
    UITabBarItem *tabBarItem2;
}

- (void)viewWillAppear:(BOOL)animated {
    //设置状态栏样式
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.toolbarHidden = YES;
    
    //自定义返回按钮
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    right.title = @"返回";
    self.navigationItem.backBarButtonItem = right;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    self.view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:243.0/255.0 blue:246.0/255.0 alpha:1];
    [self CreateView];
}

- (void)CreateView {
    
    isR = YES;
    
    UIImageView *BackImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    BackImage.userInteractionEnabled = YES;
    BackImage.image = [UIImage imageNamed:@"登录页背景.png"];
    [self.view addSubview:BackImage];
    
    UIImageView *headImage = [[UIImageView alloc] init];
    headImage.image = [UIImage imageNamed:@"登录页-logo.png"];
    [self.view addSubview:headImage];
    headImage.sd_layout.leftSpaceToView(self.view,80).topSpaceToView(self.view,69.5).rightSpaceToView(self.view,80).heightIs(47.5).centerXIs(self.view.center.x);
    
    version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    NSString *strVer = [NSString stringWithFormat:@"当前版本：%@", version];
    UILabel *verLab = [[UILabel alloc] init];
    verLab.textAlignment = NSTextAlignmentRight;
    verLab.font = [UIFont systemFontOfSize:15];
    verLab.text = strVer;
    [self.view addSubview:verLab];
    verLab.sd_layout.leftSpaceToView(self.view,110).topSpaceToView(self.view,20).widthIs(200).heightIs(20);
    
    UIImageView *InputBackView = [[UIImageView alloc] init];
    InputBackView.image = [UIImage imageNamed:@"Loginback.png"];
    [BackImage addSubview:InputBackView];
    InputBackView.sd_layout.leftSpaceToView(BackImage,20).topSpaceToView(headImage,20).rightSpaceToView(BackImage,20).heightIs(260);
    
    _phoneView = [[UIView alloc] init];
    _phoneView.backgroundColor = [UIColor whiteColor];
    _phoneView.clipsToBounds = YES;
    _phoneView.layer.cornerRadius = 3;
//    _phoneView.layer.borderWidth = 1;
//    _phoneView.layer.borderColor = [[UIColor colorWithRed:239.0/255.0 green:95.0/255.0 blue:7.0/255.0 alpha:1]CGColor];
    [self.view addSubview:_phoneView];
    _phoneView.sd_layout.topSpaceToView(headImage,44 + 10).leftSpaceToView(self.view,36).rightSpaceToView(self.view,36).heightIs(52);
    
    _phoneImageView = [[UIImageView alloc] init];
    _phoneImageView.image = [UIImage imageNamed:@"用户名"];
    [_phoneView addSubview:_phoneImageView];
    _phoneImageView.sd_layout.topSpaceToView(_phoneView,8).leftSpaceToView(_phoneView,5.5).heightIs(38).widthIs(38);
    
    _phoneTF = [[UITextField alloc] init];
    _phoneTF.borderStyle = UITextBorderStyleNone;
    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTF.placeholder = @"请输入用户名";
    _phoneTF.font = [UIFont systemFontOfSize:15];
    [_phoneView addSubview:_phoneTF];
    _phoneTF.sd_layout.topSpaceToView(_phoneView,8).leftSpaceToView(_phoneView,52).heightIs(40).widthIs(160);
    
    _pwdView = [[UIView alloc] init];
    _pwdView.backgroundColor = [UIColor whiteColor];
    _pwdView.clipsToBounds = YES;
    _pwdView.layer.cornerRadius = 3;
//    _pwdView.layer.borderWidth = 1;
//    _pwdView.layer.borderColor = [[UIColor colorWithRed:239.0/255.0 green:95.0/255.0 blue:7.0/255.0 alpha:1]CGColor];
    [self.view addSubview:_pwdView];
    _pwdView.sd_layout.topSpaceToView(_phoneView,16).leftSpaceToView(self.view,36).rightSpaceToView(self.view,36).heightIs(52);
    
    _pwdImageView = [[UIImageView alloc] init];
    _pwdImageView.image = [UIImage imageNamed:@"登录密码"];
    [_pwdView addSubview:_pwdImageView];
    _pwdImageView.sd_layout.topSpaceToView(_pwdView,8).leftSpaceToView(_pwdView,5.5).heightIs(38).widthIs(38);
    
    _pwdTF = [[UITextField alloc] init];
    _pwdTF.borderStyle = UITextBorderStyleNone;
    _pwdTF.placeholder = @"请输入密码";
    _pwdTF.secureTextEntry = YES;
    _pwdTF.font = [UIFont systemFontOfSize:15];
    [_pwdView addSubview:_pwdTF];
    _pwdTF.sd_layout.topSpaceToView(_pwdView,10).leftSpaceToView(_pwdView,50).heightIs(40).widthIs(140);
        
    _showPwd = [UIButton buttonWithType:UIButtonTypeCustom];
    [_showPwd setImage:[UIImage imageNamed:@"密码可见"] forState:UIControlStateNormal];
    [_showPwd addTarget:self action:@selector(showPwdClick:) forControlEvents:UIControlEventTouchUpInside];
    [_pwdView addSubview:_showPwd];
    _showPwd.sd_layout.centerYEqualToView(_pwdView).rightSpaceToView(_pwdView,20).widthIs(35).heightIs(20);
    
    //记住密码
    remenberBtn = [[UIButton alloc] init];
    if (_isSelected) {
        [remenberBtn setImage:[UIImage imageNamed:@"记住.png"] forState:UIControlStateNormal];
    }else {
        [remenberBtn setImage:[UIImage imageNamed:@"正常.png"] forState:UIControlStateNormal];
    }
    [remenberBtn addTarget:self action:@selector(remenber:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:remenberBtn];
    remenberBtn.sd_layout.leftSpaceToView(self.view,36).topSpaceToView(_pwdView,66).widthIs(32).heightIs(32);
    UILabel *lab = [[UILabel alloc] init];
    lab.text = @"记住密码";
    lab.font = [UIFont systemFontOfSize:13];
    lab.textColor = [UIColor redColor];
    [self.view addSubview:lab];
    lab.sd_layout.leftSpaceToView(remenberBtn,6).topSpaceToView(_pwdView,71).widthIs(60).heightIs(17.5);
    
    _forgetPwdBtn = [[UIButton alloc] init];
    _forgetPwdBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_forgetPwdBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [_forgetPwdBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_forgetPwdBtn addTarget:self action:@selector(forgetPwdClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_forgetPwdBtn];
    _forgetPwdBtn.sd_layout.topSpaceToView(_pwdView,60).rightEqualToView(_pwdView).widthIs(80).heightIs(40);
    
    _loginBtn = [[UIButton alloc] init];
    _loginBtn.layer.cornerRadius = 4.0;
    _loginBtn.layer.masksToBounds = YES;
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    _loginBtn.backgroundColor = NavBack;
    [self.view addSubview:_loginBtn];
    _loginBtn.sd_layout.topSpaceToView(_pwdView,16).rightEqualToView(_pwdView).leftEqualToView(_pwdView).heightIs(45);
    
    _bottomView = [[UIView alloc] init];
    _bottomView.backgroundColor = [UIColor grayColor];
    //[self.view addSubview:_bottomView];
    _bottomView.sd_layout.bottomSpaceToView(self.view,60).leftSpaceToView(self.view,0).widthIs(KscreenWidth).heightIs(1);
    
    _registBtn = [[UIButton alloc] init];
    [_registBtn setTitleColor:[UIColor colorWithRed:118.0/255.0 green:118.0/255.0 blue:118.0/255.0 alpha:1] forState:UIControlStateNormal];
    _registBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    _registBtn.backgroundColor = [UIColor clearColor];
    [_registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registBtn addTarget:self action:@selector(registClicked:) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:_registBtn];
    _registBtn.sd_layout.topSpaceToView(_bottomView,-20).centerXEqualToView(_bottomView).widthIs(80).heightIs(40);
    
    UIImageView *ResignImgView = [[UIImageView alloc] init];
    ResignImgView.image = [UIImage imageNamed:@"注册账户"];
    ResignImgView.userInteractionEnabled = YES;
    [self.view addSubview:ResignImgView];
    ResignImgView.sd_layout.leftSpaceToView(self.view,5).rightSpaceToView(self.view,5).bottomSpaceToView(self.view,30).heightIs(15);
    UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registClicked:)];
    Tap.numberOfTapsRequired = 1;
    [ResignImgView addGestureRecognizer:Tap];
    
    //记住密码
    _phoneTF.text = [BusiIntf getUserInfo].UserName;
    if ([BusiIntf getUserInfo].RemPwd) {
        _pwdTF.text = [BusiIntf getUserInfo].Pwd;
        [self setCheckSel:remenberBtn isChecked:YES];
    }
    else {
        [self setCheckSel:remenberBtn isChecked:NO];
    }
    
//    UIButton *DownLoadImgBtn = [[UIButton alloc] init];
//    [DownLoadImgBtn setImage:[UIImage imageNamed:@"W50m"] forState:UIControlStateNormal];
//    [DownLoadImgBtn addTarget:self action:@selector(magnify) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:DownLoadImgBtn];
//    DownLoadImgBtn.sd_layout.centerXEqualToView(self.view).topSpaceToView(InputBackView,30).widthIs(40).heightIs(40);
    //首页二维码
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magnify)];
    tap.numberOfTapsRequired = 1;
    DownLoadImg = [[UIImageView alloc] init];
    DownLoadImg.image = [UIImage imageNamed:@"W50m"];
    DownLoadImg.userInteractionEnabled = YES;
    [DownLoadImg addGestureRecognizer:tap];
    [self.view addSubview:DownLoadImg];
    DownLoadImg.sd_layout.centerXEqualToView(self.view).topSpaceToView(InputBackView,30).widthIs(40).heightIs(40);
    
}

- (void)magnify {
    [SJAvatarBrowser showImage:DownLoadImg];
}

//设置用户密码的显示情况
- (void)setCheckSel: (UIButton*)btn isChecked: (BOOL)isChecked
{
    btn.selected = isChecked;
    if (btn.selected)
        [btn setImage:[UIImage imageNamed:@"记住.png"] forState:UIControlStateNormal];
    else
        [btn setImage:[UIImage imageNamed:@"正常.png"] forState:UIControlStateNormal];
}
- (void)remenber:(UIButton *)btn {
    [self setCheckSel:btn isChecked:!btn.selected];
    NSLog(@"remenber");
}

//显示密码
- (void)showPwdClick:(UIButton *)sender {
    
    if (isR) {
        _pwdTF.secureTextEntry = NO;
        [_showPwd setImage:[UIImage imageNamed:@"密码不可见"] forState:UIControlStateNormal];
    } else {
        _pwdTF.secureTextEntry = YES;
        [_showPwd setImage:[UIImage imageNamed:@"密码可见"] forState:UIControlStateNormal];
    }
    isR = !isR;
}
//忘记密码
- (void)forgetPwdClicked:(UIButton *)btn {
    
    JXForgetPwdViewController *forgetVC = [[JXForgetPwdViewController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];
    
}
//登录
- (void)loginClick:(UIButton *)btn {
    
    
    //
    tabbarController = [[UITabBarController alloc] init];
    tabbarController.delegate = self;
    
    //MainViewController *first = [[MainViewController alloc] init];
    JXMainViewController *first = [[JXMainViewController alloc] init];
    JXCardManagerViewController *second = [[JXCardManagerViewController alloc] init];
    JXOrderListViewController *third = [[JXOrderListViewController alloc] init];
    AccountCenterVC *four = [[AccountCenterVC alloc] init];
    UINavigationController *firstNaVi = [[UINavigationController alloc] initWithRootViewController:first];
    UINavigationController *secondNaVi = [[UINavigationController alloc] initWithRootViewController:second];
    UINavigationController *thirdNaVi = [[UINavigationController alloc] initWithRootViewController:third];
    UINavigationController *fourNaVi = [[UINavigationController alloc] initWithRootViewController:four];
    tabbarController.viewControllers = [NSArray arrayWithObjects:firstNaVi,secondNaVi,thirdNaVi,fourNaVi, nil];
    
    UITabBar *tabBar                 = tabbarController.tabBar;
    //tabBar.delegate = self;
    UITabBarItem *tabBarItem1        = [tabBar.items objectAtIndex:0];
    tabBarItem2        = [tabBar.items objectAtIndex:1];
    tabBarItem2.tag = 100;
    
    UITabBarItem *tabbarItem3        = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabbarItem4        = [tabBar.items objectAtIndex:3];
    tabBarItem1.title = @"首页";
    tabBarItem1.image = [UIImage imageNamed:@"首页"];
    tabBarItem1.selectedImage = [UIImage imageNamed:@"首页1"];
    tabBarItem2.title = @"卡管理";
    tabBarItem2.image = [UIImage imageNamed:@"卡管理"];
    tabBarItem2.selectedImage = [UIImage imageNamed:@"卡管理1"];
    tabbarItem3.title = @"订单";
    tabbarItem3.image = [UIImage imageNamed:@"实名认证"];
    tabbarItem3.selectedImage = [UIImage imageNamed:@"实名认证1"];
    tabbarItem4.title = @"我的";
    tabbarItem4.image = [UIImage imageNamed:@"我的"];
    tabbarItem4.selectedImage = [UIImage imageNamed:@"我的1"];
    
    [tabBar setTintColor:[UIColor colorWithRed:23.0/255 green:177.0/255 blue:248.0/255 alpha:1.0]];
    //[self.navigationController pushViewController:tabbarController animated:YES];
    //对输入账户和密码做判断
    if (_phoneTF.text.length < 1) {
        [self alert:@"请输入用户名"];
        return;
    }
    if (_pwdTF.text.length < 1) {
        [self alert:@"请输入密码"];
        return;
    }
    if (![[Reachability reachabilityForInternetConnection] isReachable]) {
        [self alert:@"没有连接网络!"];
        return;
    }
    //保存
    [BusiIntf getUserInfo].UserName = _phoneTF.text;
    [BusiIntf getUserInfo].Pwd = _pwdTF.text;
    [BusiIntf getUserInfo].RemPwd = remenberBtn.selected;
    [BusiIntf getUserInfo].StartDate = [PubFunc getNow];
    [BusiIntf writePlist];
    [self addWait:@"登录中"];
    [self RequestForLogIn];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    if (item.tag == 100) {
        NSLog(@"选着。。。。。。。。。。。。");
    }else {
        
    }
}

//注册
- (void)registClicked:(UIButton *)btn {
    JXRegistViewController *registVC = [[JXRegistViewController alloc] init];
    [self.navigationController pushViewController:registVC animated:YES];
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
                           @"phone":_phoneTF.text,
                           @"pass":_pwdTF.text,
                           @"os":@"IOS",
                           @"soft":@"JXPAY",
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
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:token forKey:@"token"];
        [user setObject:key forKey:@"key"];
        [user setObject:YyToken forKey:@"YyToken"];
        [user setObject:YySign forKey:@"YySign"];
        [user synchronize];
        NSLog(@"登陆key:%@...token:%@",dic[@"key"],dic[@"auth"]);
        if ([code isEqualToString:@"000000"]) {
            [self.navigationController pushViewController:tabbarController animated:YES];
            
        }else {
            [self alert:content];
        }
        NSLog(@"返回的数据:%@",dic);
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
        [self stopWait];
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

- (void)stopWait
{
    [[self.view viewWithTag:TAG_INDICATOR]removeFromSuperview];
    [[self.view viewWithTag:TAG_INDICATOR_BACK]removeFromSuperview];
    
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    [self.view endEditing:YES];
//    
//}

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
