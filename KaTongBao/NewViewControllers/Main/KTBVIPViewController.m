//
//  KTBVIPViewController.m
//  KaTongBao
//
//  Created by rongfeng on 16/8/26.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "KTBVIPViewController.h"
#import "Common.h"
#import "macro.h"
#import "UIView+SDAutoLayout.h"
#import "KTBVipSignUpViewController.h"
#import "KTBICCardViewController.h"
#import "BusiIntf.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import <CommonCrypto/CommonDigest.h>
#import "BusiIntf.h"
#import "SVProgressHUD.h"
#import "GiFHUD.h"

#import "UIImage+scale.h"
#import "PhotoPickerController.h"
#import "ImagePickerController.h"
#import "ImageManager.h"
#import <Photos/Photos.h>
#import "SJAvatarBrowser.h"
@interface KTBVIPViewController ()<ImagePickerControllerDelgate>

@property(nonatomic,strong)UIImageView *HeaderView;
@end

@implementation KTBVIPViewController {
    
    NSString *vipFlg;
    UIImageView *FirstWhietImg;
    UIImageView *HeaderBackImg;
    NSUserDefaults *user;
    //UIImageView *HeaderView;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"VIP会员申请";
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
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [self RequestForBaseInfo];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    user = [NSUserDefaults standardUserDefaults];
    
    UIImageView *BackImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    BackImg.backgroundColor = LightGrayColor;
    [self.view addSubview:BackImg];
    //注册会员
    FirstWhietImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 200)];
    FirstWhietImg.backgroundColor = [UIColor whiteColor];
    FirstWhietImg.userInteractionEnabled = YES;
    //FirstWhietImg.hidden = YES;
    [self.view addSubview:FirstWhietImg];
    
    UIImageView *ImageView = [[UIImageView alloc] init];
    ImageView.image = [UIImage imageNamed:@"VIP会员申请"];
    [FirstWhietImg addSubview:ImageView];
    ImageView.sd_layout.leftSpaceToView(FirstWhietImg,16).rightSpaceToView(FirstWhietImg,16).topSpaceToView(FirstWhietImg,25).heightIs(86);
    
    UIButton *NextBtn = [[UIButton alloc] init];
    [NextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    NextBtn.layer.cornerRadius = 20;
    [NextBtn setBackgroundColor:CommonOrange];
    [NextBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [FirstWhietImg addSubview:NextBtn];
    NextBtn.sd_layout.leftSpaceToView(FirstWhietImg,28).rightSpaceToView(FirstWhietImg,28).topSpaceToView(ImageView,20).heightIs(40);
    
    //已注册会员
    HeaderBackImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 200)];
    HeaderBackImg.backgroundColor = CommonOrange;
    HeaderBackImg.userInteractionEnabled = YES;
    HeaderBackImg.hidden = YES;
    [self.view addSubview:HeaderBackImg];
    
    UITapGestureRecognizer *TapToMagOut = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(MagOut)];
    UILongPressGestureRecognizer *LongPressToSelectPhoto = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LongPressToSelectPhoto:)];
    
    self.HeaderView = [[UIImageView alloc] init];
    if ( [user objectForKey:@"VipTX"] == nil) {
        self.HeaderView.image = [UIImage imageNamed:@"Avatar-sample-374"];
    }else {
        self.HeaderView.image = [UIImage imageWithData:[user objectForKey:@"VipTX"]];
    }
    
    self.HeaderView.userInteractionEnabled = YES;
    self.HeaderView.layer.cornerRadius = 3;
    self.HeaderView.layer.masksToBounds = YES;
    [self.HeaderView addGestureRecognizer:TapToMagOut];
    [self.HeaderView addGestureRecognizer:LongPressToSelectPhoto];
    [HeaderBackImg addSubview:self.HeaderView];
    self.HeaderView.sd_layout.centerXEqualToView(HeaderBackImg).centerYEqualToView(HeaderBackImg).widthIs(88).heightIs(88);
    
    UILabel *NameLab = [[UILabel alloc] init];
    NameLab.text = [NSString stringWithFormat:@"Hi,%@",[BusiIntf getUserInfo].ShopName];
    NameLab.textAlignment = NSTextAlignmentCenter;
    NameLab.textColor = [UIColor whiteColor];
    NameLab.backgroundColor = [UIColor clearColor];
    [HeaderBackImg addSubview:NameLab];
    NameLab.sd_layout.centerXEqualToView(HeaderBackImg).topSpaceToView(self.HeaderView,5).widthIs(200).heightIs(36);

    //会员权益
    UIImageView *SecondWhietImg = [[UIImageView alloc] init];
    SecondWhietImg.backgroundColor = [UIColor whiteColor];
    SecondWhietImg.userInteractionEnabled = YES;
    
    UILabel *VipLab = [[UILabel alloc] init];
    VipLab.text = @"会员权益";
    VipLab.textColor = CommonOrange;
    [SecondWhietImg addSubview:VipLab];
    VipLab.sd_layout.leftSpaceToView(SecondWhietImg,16).topSpaceToView(SecondWhietImg,0).widthIs(100).heightIs(36);
    
    UIImageView *LineView = [[UIImageView alloc] init];
    LineView.backgroundColor = Color(183, 185, 187);
    [SecondWhietImg addSubview:LineView];
    LineView.sd_layout.leftSpaceToView(SecondWhietImg,0).rightSpaceToView(SecondWhietImg,0).topSpaceToView(VipLab,0).heightIs(1);
    
    UIButton *ICCardBtn = [[UIButton alloc] init];
    //[ICCardBtn setBackgroundImage:[UIImage imageNamed:@"联民信用卡"] forState:UIControlStateNormal];
    [ICCardBtn setImage:[UIImage imageNamed:@"联民信用卡"] forState:UIControlStateNormal];
    [ICCardBtn addTarget:self action:@selector(ICCard) forControlEvents:UIControlEventTouchUpInside];
    [SecondWhietImg addSubview:ICCardBtn];
    ICCardBtn.sd_layout.leftSpaceToView(SecondWhietImg,20).topSpaceToView(LineView,10).widthIs(68.2).heightIs(68.2);
    //去掉保险(10.8)
//    UIButton *SecurityBtn = [[UIButton alloc] init];
//    //[SecurityBtn setBackgroundImage:[UIImage imageNamed:@"VIP会员 意外险"] forState:UIControlStateNormal];
//    [SecurityBtn setImage:[UIImage imageNamed:@"个人意外险"] forState:UIControlStateNormal];
//    [SecurityBtn addTarget:self action:@selector(security) forControlEvents:UIControlEventTouchUpInside];
//    [SecondWhietImg addSubview:SecurityBtn];
//    SecurityBtn.sd_layout.leftSpaceToView(ICCardBtn,10).topSpaceToView(LineView,10).widthIs(68.2).heightIs(68.2);
    [self.view addSubview:SecondWhietImg];
    
    SecondWhietImg.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(FirstWhietImg,10).heightIs(120);
    
}
//放大图片
- (void)LongPressToSelectPhoto:(UILongPressGestureRecognizer *)press {
    
    if (press.state == UIGestureRecognizerStateEnded) {
        return;
    }else {
       
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                ImagePickerController *alubmPicker = [[ImagePickerController alloc] initWithDelegate:self];
                [self presentViewController:alubmPicker animated:YES completion:nil];
            }else {
                [self showSetting];
            }
        }];
    }

}

#pragma mark - SelectPhoto
- (void)MagOut {
    
    
     [SJAvatarBrowser showImage:self.HeaderView];
}

- (void)showSetting {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在系统设置中打开“允许访问图片”，否则将无法获取相机的图片" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"去开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    [alertVC addAction:cancle];
    [alertVC addAction:confirm];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - ImagePickerControllerDelgate
- (void)imagePickerController:(PhotoPickerController *)imagePickerController didFinished:(UIImage *)editedImage {
    self.HeaderView.image = nil;
    self.HeaderView.image = [editedImage scaleImage];
    NSData *VipTXData = UIImageJPEGRepresentation([editedImage scaleImage], 1);
    [user setObject:VipTXData forKey:@"VipTX"];
    [user synchronize];
    //    self.imageView.image = editedImage;
    NSLog(@"vc--%@", self.HeaderView.image);
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

//下一步
- (void)next{
    
    KTBVipSignUpViewController *VIPSignUpVc = [[KTBVipSignUpViewController alloc] init];
    VIPSignUpVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VIPSignUpVc animated:YES];
    VIPSignUpVc.hidesBottomBarWhenPushed = NO;
    
}

//联民信用卡
- (void)ICCard {
    
    [self RequestForVipMsg:@"CARD"];
    
}

//个人意外险
- (void)security {
    
    [self RequestForVipMsg:@"SAFE"];

}

//商户VIP权益信息
- (void)RequestForVipMsg:(NSString *)VipCode {
    
        NSString *url = JXUrl;
        user = [NSUserDefaults standardUserDefaults];
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
                                    @"action":@"shopVipInfoState",
                                    @"data":dic
                                    };
        NSLog(@"actionDic:%@",actionDic);
        NSString *paramis = [actionDic JSONFragment];
        [IBHttpTool postWithURL:url params:paramis success:^(id result) {
            NSDictionary *Dic = [result JSONValue];
            NSLog(@"返回的数据:%@",Dic);
            NSString *code = Dic[@"code"];
            NSString *msg = Dic[@"msg"];
            //vipFlg = Dic[@"vipFlg"];
            NSString *vipIcon = Dic[@"vipIcon"];
            NSString *vipTitle = Dic[@"vipTitle"];
            NSString *vipDetail = Dic[@"vipDetail"];
            NSString *drawFlag = Dic[@"drawFlg"];
            if ([VipCode isEqualToString:@"CARD"]) {
                [BusiIntf curPayOrder].IsGetCardVip = drawFlag;
                [BusiIntf curPayOrder].CardVIPIcon = vipIcon;
                [BusiIntf curPayOrder].CardVIPTitle = vipTitle;
                [BusiIntf curPayOrder].CardVIPDetail = vipDetail;
            }else if ([VipCode isEqualToString:@"SAFE"]) {
                [BusiIntf curPayOrder].IsGetSafeVip = drawFlag;
                [BusiIntf curPayOrder].SafeVIPIcon = vipIcon;
                [BusiIntf curPayOrder].SafeVIPTitle = vipTitle;
                [BusiIntf curPayOrder].SafeVIPDetail = vipDetail;
            }
            if (![code isEqualToString:@"000000"]) {
                [self alert:msg];
            }else {
                
                KTBICCardViewController *KTBICCardVc = [[KTBICCardViewController alloc] init];
                KTBICCardVc.hidesBottomBarWhenPushed = YES;
                if ([VipCode isEqualToString:@"CARD"]) {
                    KTBICCardVc.tag = 100;
                }else {
                    KTBICCardVc.tag = 101;
                }
                [self.navigationController pushViewController:KTBICCardVc animated:YES];
                KTBICCardVc.hidesBottomBarWhenPushed = NO;
                
            }
            
        } failure:^(NSError *error) {
            
            NSLog(@"网络错误!!");
        }];
}

//获取商户基本信息状态
- (void)RequestForBaseInfo {
    
    //[GiFHUD showWithOverlay];
    NSString *url = JXUrl;
    user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *md5 = [NSString stringWithFormat:@"%@",key];
    NSString *sign = [self md5HexDigest:md5];
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
        vipFlg = dicc[@"vipFlg"];
        [BusiIntf curPayOrder].IsVip = dicc[@"vipFlg"];
        NSLog(@"vipFlag:%@",vipFlg);
        if ([vipFlg isEqualToString:@"1"] || [vipFlg isEqual:@1]) { //会员
            HeaderBackImg.hidden = NO;
            FirstWhietImg.hidden = YES;
            self.navigationController.navigationBar.barTintColor = CommonOrange;
        }else {                              //非会员
            HeaderBackImg.hidden = YES;
            FirstWhietImg.hidden = NO;
        }
        
        //[GiFHUD dismiss];
        
    } failure:^(NSError *error) {
        NSLog(@"网络申请失败:%@",error);
        //[SVProgressHUD dismiss];
        //[GiFHUD dismiss];
    }];
    //[GiFHUD dismiss];
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

//禁止右滑返回手势
- (void)viewDidAppear:(BOOL)animated {
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

@end
