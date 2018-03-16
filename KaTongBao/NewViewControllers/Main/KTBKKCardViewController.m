//
//  KTBKKCardViewController.m
//  KaTongBao
//
//  Created by rongfeng on 16/9/14.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "KTBKKCardViewController.h"
#import "Common.h"
#import "macro.h"
#import "UIView+SDAutoLayout.h"
#import "BusiIntf.h"
#import "UIImageView+WebCache.h"
@implementation KTBKKCardViewController


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"KK码";
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
    
    //[self RequestForCustomerInfo];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    UIImageView *BackImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    BackImg.backgroundColor = LightGrayColor;
    [self.view addSubview:BackImg];
    UIScrollView *Scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 64)];
    Scroller.contentSize = CGSizeMake(KscreenWidth, KscreenHeight);
    if (KscreenHeight < 568) {
        Scroller.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight + 20);
        Scroller.contentSize = CGSizeMake(KscreenWidth, KscreenHeight + 100);
    }
    Scroller.showsVerticalScrollIndicator = NO;
    [self.view addSubview:Scroller];
    //背景绿
    UIImageView *BigGreenImg = [[UIImageView alloc] init];
    BigGreenImg.backgroundColor = Color(32, 162, 49);
    BigGreenImg.layer.cornerRadius = 3;
    [Scroller addSubview:BigGreenImg];
    BigGreenImg.sd_layout.leftSpaceToView(Scroller,16).rightSpaceToView(Scroller,16).topSpaceToView(Scroller,40).bottomSpaceToView(Scroller,50);
    //名字
    UILabel *NameLab = [[UILabel alloc] init];
    NameLab.text = [BusiIntf getUserInfo].ShopName;
    NameLab.textColor = [UIColor whiteColor];
    NameLab.font = [UIFont systemFontOfSize:14];
    NameLab.textAlignment = NSTextAlignmentLeft;
    [BigGreenImg addSubview:NameLab];
    NameLab.sd_layout.leftSpaceToView(BigGreenImg,16).topSpaceToView(BigGreenImg,15).widthIs(100).heightIs(25);
    //号码
    UILabel *PhoneLab = [[UILabel alloc] init];
    PhoneLab.text = [self rePlacePhoneString:[BusiIntf getUserInfo].UserName];
    PhoneLab.textColor = [UIColor whiteColor];
    PhoneLab.font = [UIFont systemFontOfSize:14];
    PhoneLab.textAlignment = NSTextAlignmentLeft;
    [BigGreenImg addSubview:PhoneLab];
    PhoneLab.sd_layout.leftSpaceToView(BigGreenImg,16).topSpaceToView(NameLab,-5).widthIs(100).heightIs(25);
    
    //图片
    UIImageView *AliPayLogo = [[UIImageView alloc] init];
    AliPayLogo.image = [UIImage imageNamed:@"支付宝Logo"];
    [BigGreenImg addSubview:AliPayLogo];
    AliPayLogo.sd_layout.rightSpaceToView(BigGreenImg,15).topSpaceToView(BigGreenImg,15).widthIs(56).heightIs(44);
    
    UIImageView *WeiXinLogo = [[UIImageView alloc] init];
    WeiXinLogo.image = [UIImage imageNamed:@"微信支付Logo"];
    [BigGreenImg addSubview:WeiXinLogo];
    WeiXinLogo.sd_layout.rightSpaceToView(AliPayLogo,15).topSpaceToView(BigGreenImg,15).widthIs(44).heightIs(44);
//    UILabel *WeiXinLab = [[UILabel alloc] init];
//    WeiXinLab.text = @"微信支付";
//    WeiXinLab.textColor = [UIColor whiteColor];
//    WeiXinLab.textAlignment = NSTextAlignmentCenter;
//    WeiXinLab.font = [UIFont systemFontOfSize:14];
//    [BigGreenImg addSubview:WeiXinLab];
//    WeiXinLab.sd_layout.centerXEqualToView(WeiXinLogo).topSpaceToView(WeiXinLogo,0).widthIs(100).heightIs(20);
    //中间空白图片
    UIImageView *MidWheitImg = [[UIImageView alloc] init];
    MidWheitImg.backgroundColor = [UIColor whiteColor];
    [BigGreenImg addSubview:MidWheitImg];
    MidWheitImg.sd_layout.leftSpaceToView(BigGreenImg,0).rightSpaceToView(BigGreenImg,0).topSpaceToView(BigGreenImg,75).heightIs(KscreenWidth - 55);
    //二维码
    UIImageView *CodeImg = [[UIImageView alloc] init];
    [CodeImg sd_setImageWithURL:[NSURL URLWithString:self.Pic5]];
    [MidWheitImg addSubview:CodeImg];
    CodeImg.sd_layout.topSpaceToView(MidWheitImg,20).bottomSpaceToView(MidWheitImg,20).widthIs(MidWheitImg.height - 40).centerXEqualToView(MidWheitImg);
    //头像
    UIImageView *HeaderView = [[UIImageView alloc] init];
    HeaderView.layer.cornerRadius = 20;
    HeaderView.layer.masksToBounds = YES;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *DATA = [user objectForKey:@"TXImage"];
    UIImage *image = [UIImage imageWithData:[user objectForKey:@"TXImage"]];
    if (DATA) {
        HeaderView.image = image;
    } else {
        HeaderView.image = [UIImage imageNamed:@"人物头像.png"];
    }
    [CodeImg addSubview:HeaderView];
    HeaderView.sd_layout.centerXEqualToView(CodeImg).centerYEqualToView(CodeImg).widthIs(40).heightIs(40);
    
    UILabel *TipsLab = [[UILabel alloc] init];
    TipsLab.text = @"扫一扫上面的二维码图案，向我付钱";
    TipsLab.textAlignment = NSTextAlignmentCenter;
    TipsLab.textColor = [UIColor whiteColor];
    TipsLab.font = [UIFont systemFontOfSize:14];
    [BigGreenImg addSubview:TipsLab];
    TipsLab.sd_layout.centerXEqualToView(BigGreenImg).topSpaceToView(MidWheitImg,5).heightIs(30).widthIs(KscreenWidth);
    
    UILabel *LastLab = [[UILabel alloc] init];
    LastLab.text = @"本店推荐使用";
    LastLab.font = [UIFont systemFontOfSize:20];
    LastLab.textColor = [UIColor whiteColor];
    LastLab.textAlignment = NSTextAlignmentCenter;
    [BigGreenImg addSubview:LastLab];
    LastLab.sd_layout.topSpaceToView(TipsLab,0).centerXEqualToView(BigGreenImg).bottomSpaceToView(BigGreenImg,5).widthIs(KscreenWidth);
}

//隐私信息打*处理 （电话）
-(NSString*)rePlacePhoneString:(NSString*)string{
    if (![string isKindOfClass:[NSString class]]) {
        return @"";
    }else{
        NSMutableString *mutString = [NSMutableString stringWithString:string];
        NSInteger length = [mutString length];
        if (length>=6) {
            [mutString replaceCharactersInRange:NSMakeRange(3, length-6) withString:@"*****"];
        }else{
            
        }
        
        return (NSString*)mutString;
    }
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
