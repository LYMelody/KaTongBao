//
//  TDMyMainViewController.m
//  POS
//
//  Created by rongfeng on 15/12/10.
//  Copyright © 2015年 TangDi. All rights reserved.
//

#import "TDMyMainViewController.h"
#import "Common.h"
#import "TDEmpotyCell.h"
#import "UIView+SDAutoLayout.h"
#import "Header.h"
#import "TDTitleViewCell.h"
#import "TDMartCell.h"
#import "TDGameViewCell.h"
//#import "Dialog.h"
#import "TDLifeCell.h"

#import "PayOrderVC.h"
#import "IBHttpTool.h"
#import "SBJSON.h"
#import <CommonCrypto/CommonDigest.h>
#import "SVProgressHUD.h"
#import "PayOrderViewController.h"
#import "WalletViewController.h"
//#import <GFDPlugin/GFDPlugin.h>
#import "BusiIntf.h"
#import "KTBWalletViewController.h"
#import "JXPayResultViewController.h"
#import "KTBCreateCardViewController.h"
#import "KTBCustomerCenterViewController.h"
#import "SVProgressHUD.h"
#import "KTBVIPViewController.h"
#import "KTBAuthCertifyViewController.h"
#import "SDCycleScrollView.h"
#import "CNPPopupController.h"
#import "UIImageView+WebCache.h"
#import "JXBankInfoViewController.h"
#import "KTBKKCardViewController.h"
#import "GiFHUD.h"
//#import "PPDLoanSdk.h"
#define   kNumberOfPages 3

@implementation TDMyMainViewController {
    
    NSArray *imageArray;
    NSMutableArray *imageViewArray;
    UIScrollView *scrollView;
    NSTimer *ImageChangeTimer;
    UILabel *label;
    NSString *Notice;
    UITableView *table;
    UITapGestureRecognizer *Tap;
    NSInteger _index;
    KTBCustomerCenterViewController *Customer;
    UIImageView *ImageView;
    NSUserDefaults *user;
    NSString *Pic5;
}
@synthesize imageScrollview;
@synthesize imagePage;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    self.title = @"首页";
    //返回按钮
    UIBarButtonItem *left = [[UIBarButtonItem alloc] init];
    left.title = @"返回";
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    self.navigationItem.backBarButtonItem = left;
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , KscreenWidth, KscreenHeight - 50) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.showsVerticalScrollIndicator = NO;
    UIImageView *ImageViewOne = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    ImageViewOne.backgroundColor = [UIColor whiteColor];
    table.tableFooterView = ImageViewOne;
    [self.view addSubview:table];
    //获取通知
    //[self RequestForNotice];
    Notice = [BusiIntf curPayOrder].Notice;
    
    //为空不显示
    if ([Notice isEqualToString:@""] || Notice == nil) {
        
        ImageView.hidden = YES;
        label.hidden = YES;
        
    }else {
        ImageView.hidden = NO;
        label.hidden = NO;
        [self moveLable:label];
    }
    
    Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ShowNotice)];
    Tap.numberOfTouchesRequired = 1;
    NSString *noticeFlg = [NSString stringWithFormat:@"%@",[BusiIntf curPayOrder].NoticeFlg];
    if ([noticeFlg isEqualToString:@"1"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"公告" message:Notice delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];

    }else if([noticeFlg isEqualToString:@"0"]){
        NSLog(@"#######");
    }else {
        
    }

    //定义好广告
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 150)];
    

}

- (void)viewWillAppear:(BOOL)animated
{
    //去掉导航栏
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    user = [NSUserDefaults standardUserDefaults];
    self.tabBarController.tabBar.hidden = NO;
    [table reloadData];
    
    _index = 0;
    //是否是APPStore布局
    //[BusiIntf curPayOrder].IsAPPStore = NO;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    if (indexPath.row == 0) {
        return 63.5;
    }
    if (indexPath.row == 1) {
        return 150;
    }
    if (indexPath.row == 2) {
        return 30;
    }
    if (indexPath.row == 3) {
        return 34;
    }
    if (indexPath.row == 5) {
        return 34;
    }
    if (indexPath.row == 4) {
        if ( KscreenHeight < 568) {
            return 202 + 50;
        }else {
            return 202 ;
        }
    }
    if (indexPath.row == 6) {
        //return 230;
        return 98;
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identy = [NSString stringWithFormat:@"cell-%ld",(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        if (indexPath.row == 0) {
            TDEmpotyCell *Cell = [[TDEmpotyCell alloc] init];
            UIImageView *Img = [[UIImageView alloc] init];
            Img.image = [UIImage imageNamed:@"卡捷通首页logo.png"];
            [Cell.contentView addSubview:Img];
            Img.sd_layout.centerXEqualToView(Cell.contentView).topSpaceToView(Cell.contentView,35).widthIs(66.5).heightIs(21);
            cell = Cell;
        }
        if (indexPath.row == 1) {
            TDEmpotyCell *Cell = [[TDEmpotyCell alloc] init];
            [self addImageAD:Cell];
//            UIImageView *ImageView1 = [[UIImageView alloc] init];
//            ImageView1.image = [UIImage imageNamed:@"信用卡图片2.png"];
//            [Cell.contentView addSubview:ImageView1];
//            ImageView1.sd_layout.leftSpaceToView(Cell.contentView,0).topSpaceToView(Cell.contentView,0).widthIs(KscreenWidth).heightIs(150);
            cell = Cell;
        }
        if (indexPath.row == 2) {
            TDEmpotyCell *Cell = [[TDEmpotyCell alloc] init];
            label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 950, 30)];
            
            label.text = Notice;
            label.font = [UIFont systemFontOfSize:13];
            label.textColor = LightBlue;
            label.backgroundColor = [UIColor clearColor];
            label.textAlignment = NSTextAlignmentLeft;
            label.userInteractionEnabled = YES;
            [label addGestureRecognizer:Tap];
            //[label sizeToFit];
            [Cell.contentView addSubview:label];
            [self moveLable:label];
            ImageView = [[UIImageView alloc] init];
            ImageView.image = [UIImage imageNamed:@"通知.png"];
            
            //为空不显示
            if ([Notice isEqualToString:@""] || Notice == nil) {
                
                ImageView.hidden = YES;
                label.hidden = YES;
                
            }else {
                ImageView.hidden = NO;
                label.hidden = NO;
                [self moveLable:label];
            }
            
            [Cell.contentView addSubview:ImageView];
            ImageView.sd_layout.leftSpaceToView(Cell.contentView,17).topSpaceToView(Cell.contentView,5).widthIs(15).heightIs(20);
            UIImageView *IMG = [[UIImageView alloc] init];
            IMG.backgroundColor = [UIColor whiteColor];
            [Cell.contentView addSubview:IMG];
            IMG.sd_layout.leftSpaceToView(Cell.contentView,0).topSpaceToView(Cell.contentView,0).widthIs(17).heightIs(30);
            cell = Cell;
            
        }
        if (indexPath.row == 3 ) {
            TDTitleViewCell *Cell = [[TDTitleViewCell alloc] init];
            Cell.label.text = @"便民生活";
            cell = Cell;
        }
        if (indexPath.row == 4) {
            TDLifeCell *Cell = [[TDLifeCell alloc] init];
            
            [Cell.btnOne setImage:[UIImage imageNamed:@"收款.png"] forState:UIControlStateNormal];
            [Cell.btnTwo setImage:[UIImage imageNamed:@"钱包1.png"] forState:UIControlStateNormal];
            //[Cell.btnTrird setImage:[UIImage imageNamed:@"GFD.png"] forState:UIControlStateNormal];
            NSString *XinYongKaNew = [[NSUserDefaults standardUserDefaults] objectForKey:@"XinYongKaNew"];
            NSString *GFDNew = [[NSUserDefaults standardUserDefaults] objectForKey:@"GFDNew"];
            NSString *CustomerNew = [[NSUserDefaults standardUserDefaults] objectForKey:@"CustomerNew"];
            NSString *KTBVipNew = [[NSUserDefaults standardUserDefaults] objectForKey:@"KTBVipNew"];
            NSString *KK卡New = [[NSUserDefaults standardUserDefaults] objectForKey:@"KKNew"];
            if ([GFDNew isEqualToString:@"0"]) {
                [Cell.btnTrird setImage:[UIImage imageNamed:@"拍拍贷.png"] forState:UIControlStateNormal];
            }else {
                [Cell.btnTrird setImage:[UIImage imageNamed:@"拍拍贷New.png"] forState:UIControlStateNormal];
            }
            if ([XinYongKaNew isEqualToString:@"0"]) {
                [Cell.btnFour setImage:[UIImage imageNamed:@"信用卡.png"] forState:UIControlStateNormal];
            } else {
                [Cell.btnFour setImage:[UIImage imageNamed:@"信用卡New.png"] forState:UIControlStateNormal];
            }
            if ([CustomerNew isEqualToString:@"0"]) {
                [Cell.btnFive setImage:[UIImage imageNamed:@"客服中心"] forState:UIControlStateNormal];
                
            }else {
                [Cell.btnFive setImage:[UIImage imageNamed:@"客服中心"] forState:UIControlStateNormal];
            }
            if ([KTBVipNew isEqualToString:@"0"]) {
                [Cell.btnSix setImage:[UIImage imageNamed:@"VIP会员-.png"] forState:UIControlStateNormal];
            }else {
                [Cell.btnSix setImage:[UIImage imageNamed:@"VipNew.png"] forState:UIControlStateNormal];
            }
            
            if ([KK卡New isEqualToString:@"0"]) {
                [Cell.btnSeven setImage:[UIImage imageNamed:@"KK码.png"] forState:UIControlStateNormal];
            }else {
                [Cell.btnSeven setImage:[UIImage imageNamed:@"KK码New.png"] forState:UIControlStateNormal];
            }
            [Cell.btnEight setImage:[UIImage imageNamed:@"生活.png"] forState:UIControlStateNormal];
            Cell.btnNine.hidden = YES;
            Cell.btnTen.hidden = YES;
            //APPStore去掉按钮8
            if ([BusiIntf curPayOrder].IsAPPStore) {
                
                if ([XinYongKaNew isEqualToString:@"0"]) {
                    [Cell.btnTrird setImage:[UIImage imageNamed:@"信用卡.png"] forState:UIControlStateNormal];
                } else {
                    [Cell.btnTrird setImage:[UIImage imageNamed:@"信用卡New.png"] forState:UIControlStateNormal];
                }
                
                if ([KTBVipNew isEqualToString:@"0"]) {
                    [Cell.btnFour setImage:[UIImage imageNamed:@"VIP会员-.png"] forState:UIControlStateNormal];
                }else {
                    [Cell.btnFour setImage:[UIImage imageNamed:@"VipNew.png"] forState:UIControlStateNormal];
                }
                if ([CustomerNew isEqualToString:@"0"]) {
                    [Cell.btnTrird setImage:[UIImage imageNamed:@"客服中心"] forState:UIControlStateNormal];
                }else {
                    [Cell.btnTrird setImage:[UIImage imageNamed:@"客服中心"] forState:UIControlStateNormal];
                }
                if ([KK卡New isEqualToString:@"0"]) {
                    [Cell.btnFive setImage:[UIImage imageNamed:@"KK码.png"] forState:UIControlStateNormal];
                }else {
                    [Cell.btnFive setImage:[UIImage imageNamed:@"KK码New.png"] forState:UIControlStateNormal];
                }
                
                Cell.btnSix.hidden = YES;
                Cell.btnEight.hidden = YES;
                Cell.btnSeven.hidden = YES;
                
                [Cell.btnOne addTarget:self action:@selector(payInHandle:) forControlEvents:UIControlEventTouchUpInside];
                [Cell.btnTwo addTarget:self action:@selector(ToQianBao) forControlEvents:UIControlEventTouchUpInside];
                [Cell.btnFive addTarget:self action:@selector(ClickToCash) forControlEvents:UIControlEventTouchUpInside];
                [Cell.btnTrird addTarget:self action:@selector(CustomerCenter) forControlEvents:UIControlEventTouchUpInside];
                [Cell.btnFour addTarget:self action:@selector(ClickVip) forControlEvents:UIControlEventTouchUpInside];
                //[Cell.btnSix addTarget:self action:@selector(ClickToCash) forControlEvents:UIControlEventTouchUpInside];
                

            }else {
                [Cell.btnOne addTarget:self action:@selector(payInHandle:) forControlEvents:UIControlEventTouchUpInside];
                [Cell.btnTwo addTarget:self action:@selector(ToQianBao) forControlEvents:UIControlEventTouchUpInside];
                [Cell.btnTrird addTarget:self action:@selector(ToGongFuDai) forControlEvents:UIControlEventTouchUpInside];
                [Cell.btnFour addTarget:self action:@selector(CreateCard) forControlEvents:UIControlEventTouchUpInside];
                [Cell.btnFive addTarget:self action:@selector(CustomerCenter) forControlEvents:UIControlEventTouchUpInside];
                [Cell.btnSix addTarget:self action:@selector(ClickVip) forControlEvents:UIControlEventTouchUpInside];
                [Cell.btnSeven addTarget:self action:@selector(ClickToCash) forControlEvents:UIControlEventTouchUpInside];
                [Cell.btnEight addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
            }
            cell = Cell;
        }
        if ( indexPath.row == 5) {
            TDTitleViewCell *Cell = [[TDTitleViewCell alloc] init];
            Cell.label.text = @"商城特卖";
            cell = Cell;
        }
        if (indexPath.row == 6) {
            TDMartCell *Cell = [[TDMartCell alloc] init];
            [Cell.btnOne setImage:[UIImage imageNamed:@"商城特卖.png"] forState:UIControlStateNormal];
//            [Cell.btnTwo setImage:[UIImage imageNamed:@"打折1.png"] forState:UIControlStateNormal];
//            [Cell.btnThrid setImage:[UIImage imageNamed:@"折3.png"] forState:UIControlStateNormal];
//            [Cell.btnFour setImage:[UIImage imageNamed:@"折2.png"] forState:UIControlStateNormal];
//            [Cell.btnFive setImage:[UIImage imageNamed:@"折4.png"] forState:UIControlStateNormal];
            [Cell.btnOne setImage:[UIImage imageNamed:@"商城特卖.png"] forState:UIControlStateHighlighted];
//            [Cell.btnTwo setImage:[UIImage imageNamed:@"打折1.png"] forState:UIControlStateHighlighted];
//            [Cell.btnThrid setImage:[UIImage imageNamed:@"折3.png"] forState:UIControlStateHighlighted];
//            [Cell.btnFour setImage:[UIImage imageNamed:@"折2.png"] forState:UIControlStateHighlighted];
//            [Cell.btnFive setImage:[UIImage imageNamed:@"折4.png"] forState:UIControlStateHighlighted];
            [Cell.btnOne addTarget:self action:@selector(ClickToMart) forControlEvents:UIControlEventTouchUpInside];
//            [Cell.btnTwo addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//            [Cell.btnThrid addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//            [Cell.btnFour addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//            [Cell.btnFive addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
            
            cell = Cell;
        }
//        if (indexPath.row == 7) {
//            TDTitleViewCell *Cell = [[TDTitleViewCell alloc] init];
//            Cell.label.text = @"金融世界";
//            cell = Cell;
//        }
//        if (indexPath.row == 8) {
//            TDGameViewCell *Cell = [[TDGameViewCell alloc] init];
//            [Cell.btnOne setImage:[UIImage imageNamed:@"金融.png"] forState:UIControlStateNormal];
//            [Cell.btnTwo setImage:[UIImage imageNamed:@"积分1.png"] forState:UIControlStateNormal];
//            [Cell.btnThid setImage:[UIImage imageNamed:@"积分2.png"] forState:UIControlStateNormal];
//            [Cell.btnFour setImage:[UIImage imageNamed:@"积分3 .png"] forState:UIControlStateNormal];
//            [Cell.btnOne setImage:[UIImage imageNamed:@"金融.png"] forState:UIControlStateHighlighted];
//            [Cell.btnTwo setImage:[UIImage imageNamed:@"积分1.png"] forState:UIControlStateHighlighted];
//            [Cell.btnThid setImage:[UIImage imageNamed:@"积分2.png"] forState:UIControlStateHighlighted];
//            [Cell.btnFour setImage:[UIImage imageNamed:@"积分3 .png"] forState:UIControlStateHighlighted];
//            [Cell.btnOne addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//            [Cell.btnTwo addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//            [Cell.btnThid addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//            [Cell.btnFour addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//            cell = Cell;
//          
//        }
//        if (indexPath.row == 9) {
//            TDTitleViewCell *Cell = [[TDTitleViewCell alloc] init];
//            Cell.label.text = @"游戏专区";
//            cell = Cell;
//        }
//        if (indexPath.row == 10) {
//            TDGameViewCell *Cell = [[TDGameViewCell alloc] init];
//            [Cell.btnOne setImage:[UIImage imageNamed:@"游戏.png"] forState:UIControlStateNormal];
//            [Cell.btnTwo setImage:[UIImage imageNamed:@"游戏1.png"] forState:UIControlStateNormal];
//            [Cell.btnThid setImage:[UIImage imageNamed:@"游戏2 .png"] forState:UIControlStateNormal];
//            [Cell.btnFour setImage:[UIImage imageNamed:@"游戏3.png"] forState:UIControlStateNormal];
//            [Cell.btnOne setImage:[UIImage imageNamed:@"游戏.png"] forState:UIControlStateHighlighted];
//            [Cell.btnTwo setImage:[UIImage imageNamed:@"游戏1.png"] forState:UIControlStateHighlighted];
//            [Cell.btnThid setImage:[UIImage imageNamed:@"游戏2 .png"] forState:UIControlStateHighlighted];
//            [Cell.btnFour setImage:[UIImage imageNamed:@"游戏3.png"] forState:UIControlStateHighlighted];
//            [Cell.btnOne addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//            [Cell.btnTwo addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//            [Cell.btnThid addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//            [Cell.btnFour addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//            cell = Cell;
//        }
    }
    return cell;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    if (index == 0) { //办卡
        if([BusiIntf curPayOrder].IsAPPStore) {
            
        }else {
            KTBCreateCardViewController *CreateCardView = [[KTBCreateCardViewController alloc] init];
            CreateCardView.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:CreateCardView animated:YES];
            CreateCardView.hidesBottomBarWhenPushed = NO;
        }
        
    }else if (index == 1) { //功夫贷
        
        if([BusiIntf curPayOrder].IsAPPStore) {
            
        }else {
            [user setObject:@"0" forKey:@"GFDADNew"];
            [user synchronize];
            //[LoansSDK showLoanSdkView:[BusiIntf getUserInfo].UserName withController:self];
        }
        
    }
}

//钱包
- (void)ToQianBao {
    
    KTBWalletViewController *wallect = [[KTBWalletViewController alloc] init];
    wallect.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:wallect animated:YES];
    wallect.hidesBottomBarWhenPushed = NO;
}
//拍拍贷
- (void)ToGongFuDai {
    
    [user setObject:@"0" forKey:@"GFDNew"];
    [user synchronize];
   
    //[LoansSDK showLoanSdkView:[BusiIntf getUserInfo].UserName withController:self];
}
//办卡
- (void)CreateCard {
    
    [user setObject:@"0" forKey:@"XinYongKaNew"];
    [user synchronize];
    KTBCreateCardViewController *CreateCardView = [[KTBCreateCardViewController alloc] init];
    CreateCardView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:CreateCardView animated:YES];
    CreateCardView.hidesBottomBarWhenPushed = NO;
}
//客服中心
- (void)CustomerCenter {
    
    [user setObject:@"0" forKey:@"CustomerNew"];
    [user synchronize];
    Customer = [[KTBCustomerCenterViewController alloc] init];
    Customer.hidesBottomBarWhenPushed = YES;
    [self RequestForCustomerInfo];
}
//VIP
- (void)ClickVip {
    
    [self RequestForBaseInfoWithType:@"Vip"];
    
}

//跳微信
- (void)ToWeChat {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weixin://"]];
}
// 跳商城
- (void)ClickToMart {
    
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
    
}
//弹出视图
- (void)ClickToCash {
    
   
    //[self RequestForAuthwith:@"Cash"];
   
    [self RequestForBaseInfoWithType:@"Cash"];
    
}
//弹出付款码
- (void)showCashCodeAlert {
    
    UIView *CustomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth - 80, KscreenHeight - 200)];
    //头像
    NSData *DATA = [user objectForKey:@"TXImage"];
    UIImage *image = [UIImage imageWithData:[user objectForKey:@"TXImage"]];
    UIImageView *HeaderImg = [[UIImageView alloc] init];
    HeaderImg.backgroundColor = [UIColor orangeColor];
    if (DATA) {
        HeaderImg.image = image;
    } else {
        HeaderImg.image = [UIImage imageNamed:@"人物头像.png"];
    }
    [CustomView addSubview:HeaderImg];
    HeaderImg.sd_layout.leftSpaceToView(CustomView,14).topSpaceToView(CustomView,26).widthIs(60).heightIs(60);
    //商户名
    UILabel *NameLab = [[UILabel alloc] init];
    NameLab.text = [BusiIntf getUserInfo].ShopName;
    NameLab.font = [UIFont systemFontOfSize:14];
    NameLab.textAlignment = NSTextAlignmentLeft;
    
    [CustomView addSubview:NameLab];
    NameLab.sd_layout.leftSpaceToView(HeaderImg,10).topSpaceToView(CustomView,30).widthIs(200).heightIs(25);
    //商户手机号
    UILabel *PhoneLab = [[UILabel alloc] init];
    PhoneLab.text = [self rePlacePhoneString:[BusiIntf getUserInfo].UserName];
    PhoneLab.textAlignment = NSTextAlignmentLeft;
    PhoneLab.font = [UIFont systemFontOfSize:14];
    PhoneLab.textColor = Color(154, 154, 154);
    [CustomView addSubview:PhoneLab];
    PhoneLab.sd_layout.leftSpaceToView(HeaderImg,10).topSpaceToView(NameLab,0).widthIs(200).heightIs(25);
    //收款码
    UIImageView *CodeView = [[UIImageView alloc] init];
    [CodeView sd_setImageWithURL:[NSURL URLWithString:Pic5]];
    [CustomView addSubview:CodeView];
    CodeView.sd_layout.leftSpaceToView(CustomView,14).rightSpaceToView(CustomView,14).topSpaceToView(HeaderImg,10).heightIs(KscreenWidth -108);
    //二维码中间加个头像
    UIImageView *MidImg = [[UIImageView alloc] init];
    if (DATA) {
        MidImg.image = image;
    }else {
        MidImg.image = [UIImage imageNamed:@"人物头像.png"];
    }
    MidImg.layer.cornerRadius = 8;
    MidImg.layer.masksToBounds = YES;
    [CodeView addSubview:MidImg];
    MidImg.sd_layout.centerXEqualToView(CodeView).centerYEqualToView(CodeView).widthIs(50).heightIs(50);
    
    //文字信息
    UILabel *TipsLab = [[UILabel alloc] init];
    TipsLab.text = @"扫一扫上面的二维码图案，向我付钱";
    TipsLab.font = [UIFont systemFontOfSize:13];
    TipsLab.textColor = Color(154, 154, 154);
    [CustomView addSubview:TipsLab];
    TipsLab.sd_layout.leftSpaceToView(CustomView,14).rightSpaceToView(CustomView,14).topSpaceToView(CodeView,10).heightIs(30);
    
    //弹出视图
    self.popupController = [[CNPPopupController alloc] initWithContents:@[CustomView]];
    self.popupController.theme = [CNPPopupTheme defaultTheme];
    self.popupController.theme.popupStyle = CNPPopupStyleCentered;
    self.popupController.delegate = self;
    [self.popupController presentPopupControllerAnimated:YES];
}

////是否实名认证
//- (void)RequestForAuthwith:(NSString *)type {
//    
//    //参数
//    NSString *Money = @"1";
//    NSString *payType = @"1";
//    NSString *url = JXUrl;
//    NSString *orderType = @"11";
//    //时间戳
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"YYYY-MM-DD HH:mm:ss"];
//    NSTimeZone *timezone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//    [formatter setTimeZone:timezone];
//    NSDate *datenow = [NSDate date];
//    NSString *timeSp = [NSString stringWithFormat:@"%.0f",[datenow timeIntervalSince1970]];
//    
//    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
//    
//    NSString *token = [user objectForKey:@"token"];
//    NSString *key = [user objectForKey:@"key"];
//    NSString *md5 = [NSString stringWithFormat:@"%@%@%@%@%@%@",Money,timeSp,orderType,payType,version,key];
//    NSString *sign = [self md5HexDigest:md5];
//    NSDictionary *dic1 = @{
//                           @"linkId":timeSp,
//                           @"payType":payType,
//                           @"orderType":orderType,
//                           @"amount":Money,
//                           @"version":version,
//                           @"token":token,
//                           @"sign":sign
//                           };
//    NSDictionary *dicc = @{
//                           @"action":@"nocardOrderCreateState",
//                           @"data":dic1
//                           };
//    NSString *params = [dicc JSONFragment];
//    [IBHttpTool postWithURL:url params:params success:^(id result) {
//        NSDictionary *dic = [result JSONValue];
//        NSLog(@"%@",dic);
//        NSString *code = dic[@"code"];
//        NSString *msg = dic[@"msg"];
////        NSString *oderNo = dic[@"orderNo"];
////        NSString *oderReqTime = dic[@"orderTime"];
////        NSString *codeImgUrl = dic[@"codeImgUrl"];
////        NSString *buttonName = dic[@"buttonName"];
////        NSString *buttonUrl = dic[@"buttonUrl"];
////        [BusiIntf curPayOrder].OrderNo = oderNo;
//        
//        //如果是未注册 跳到注册页面
//        if ([code isEqualToString:@"ERR504"]) {   //未实名认证，跳转到实名认证
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"去实名认证" otherButtonTitles:@"取消", nil];
//            alertView.tag = 100;
//            [alertView show];
//            [SVProgressHUD dismiss];
//        }else if ([code isEqualToString:@"000000"]) {
//            
//            if ([type isEqualToString:@"Vip"]) {  //Vip跳转
//                KTBVIPViewController *Vip = [[KTBVIPViewController alloc] init];
//                Vip.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:Vip animated:YES];
//                Vip.hidesBottomBarWhenPushed = NO;
//                [user setObject:@"0" forKey:@"KTBVipNew"];
//            }else if ([type isEqualToString:@"Cash"]) { //kk卡收款处理
//                
//                [self RequestForBaseInfoWithType:@"Cash"];
//                
//            }
//            
//        }else {
//            
//        }
//    } failure:^(NSError *error) {
//        NSLog(@"网络请求失败:%@",error);
//        [SVProgressHUD dismiss];
//    }];
//}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 100) {
        if (buttonIndex == 0) {
            KTBAuthCertifyViewController *JXBvc = [[KTBAuthCertifyViewController alloc] init];
            JXBvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:JXBvc animated:YES];
            JXBvc.hidesBottomBarWhenPushed = NO;
        }else {
            
        }
    }
}

//获取商户基本信息状态
- (void)RequestForBaseInfoWithType:(NSString *)type {
    
    [GiFHUD showWithOverlay];
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
        Pic5 = dicc[@"pic5"];
        
        if ([dicc[@"code"] isEqualToString:@"000000"]) {
            
            if ([[BusiIntf curPayOrder].shopStatus isEqualToString:@"20"]) {  //已实名认证
                if ([type isEqualToString:@"Vip"]) {  //Vip跳转
                     [GiFHUD dismiss];
                    KTBVIPViewController *Vip = [[KTBVIPViewController alloc] init];
                    Vip.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:Vip animated:YES];
                    Vip.hidesBottomBarWhenPushed = NO;
                    [user setObject:@"0" forKey:@"KTBVipNew"];
                    [user synchronize];
                }else if ([type isEqualToString:@"Cash"]) { //kk卡收款处理
                     [GiFHUD dismiss];
                    KTBKKCardViewController *KKCardView = [[KTBKKCardViewController alloc] init];
                    KKCardView.Pic5 = Pic5;
                    KKCardView.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:KKCardView animated:YES];
                    KKCardView.hidesBottomBarWhenPushed = NO;
                    [user setObject:@"0" forKey:@"KKNew"];
                    [user synchronize];
                }

            }else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您还没有实名认证" delegate:self cancelButtonTitle:@"去实名认证" otherButtonTitles:@"取消", nil];
                alertView.tag = 100;
                [alertView show];
            }
        }
        
        [GiFHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"网络申请失败:%@",error);

        [GiFHUD dismiss];
        
    }];
    
}

////账户激活
//- (void)RequestForActiveAccount {
//    
//    NSString *url = JXUrl;
//    user = [NSUserDefaults standardUserDefaults];
//    NSString *token = [user objectForKey:@"token"];
//    NSString *key = [user objectForKey:@"key"];
//    //时间戳
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"YYYY-MM-DD HH:mm:ss"];
//    NSTimeZone *timezone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//    [formatter setTimeZone:timezone];
//    NSDate *datenow = [NSDate date];
//    NSString *timeSp = [NSString stringWithFormat:@"%.0f",[datenow timeIntervalSince1970]];
//    
//    NSString *md5 = [NSString stringWithFormat:@"%@%@",timeSp,key];
//    NSString *sign = [self md5HexDigest:md5];
//    NSDictionary *dic1 = @{
//                           @"linkId":timeSp,
//                           @"token":token,
//                           @"sign":sign
//                           };
//    NSDictionary *dicc = @{
//                           @"action":@"shopActivationSmsState",
//                           @"data":dic1
//                           };
//    NSString *params = [dicc JSONFragment];
//    [IBHttpTool postWithURL:url params:params success:^(id result) {
//        NSDictionary *dic = [result JSONValue];
//        NSLog(@"返回的数据:%@",dic);
//        NSString *code = dic[@"code"];
//        NSString *msg = dic[@"msg"];
//        NSString *orderNo = dic[@"orderNo"];
//        NSString *cardPhone = dic[@"cardPhone"];
//        NSString *shopCert = dic[@"shopCert"];
//        NSString *shopAccount = dic[@"shopAccount"];
//        
//        if ([code isEqualToString:@"000000"]) {
//            
//            [BusiIntf curPayOrder].OrderNo = orderNo;    //订单号
//            [BusiIntf curPayOrder].shopCard = shopCert;   //身份证
//            [BusiIntf curPayOrder].bankAccont = shopAccount;   //银行卡姓名
//            [BusiIntf curPayOrder].cardPhone = cardPhone;
//            JXBankInfoViewController *JXBankInfo = [[JXBankInfoViewController alloc] init];
//            JXBankInfo.tag = 100;
//            JXBankInfo.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:JXBankInfo animated:YES];
//            JXBankInfo.hidesBottomBarWhenPushed = NO;
//        }else {
//            [self alert:msg];
//        }
//        
//    } failure:^(NSError *error) {
//        NSLog(@"请求网络错误:%@",error);
//    }];
//}

//商户基本信息
- (void)RequestForCustomerInfo {
    
    //[SVProgressHUD show];
    [GiFHUD showWithOverlay];
    NSString *url = JXUrl;
    user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *sign = [self md5HexDigest:key];
    NSLog(@"token:%@,key:%@,sign:%@",token,key,sign);
    NSDictionary *dic = @{
                          @"token":token,
                          @"sign":sign
                          };
    NSDictionary *actionDic = @{
                                @"action":@"shopOrgInfo",
                                @"data":dic
                                };
    NSLog(@"actionDic:%@",actionDic);
    NSString *paramis = [actionDic JSONFragment];
    [IBHttpTool postWithURL:url params:paramis success:^(id result) {
        NSDictionary *Dic = [result JSONValue];
        NSLog(@"返回的数据:%@",Dic);
        NSString *code = Dic[@"code"];
        NSString *msg = Dic[@"msg"];
        NSString *orgName = Dic[@"orgName"];
        NSString *cshName = Dic[@"cshName"];
        NSString *cshPhone = Dic[@"cshPhone"];
        NSString *cshTel = Dic[@"cshTel"];
        NSString *cshWeixin = Dic[@"cshWeixin"];
        
        if (![code isEqualToString:@"000000"]) {
            [self alert:msg];
        }else {
            Customer.orgName = orgName;
            Customer.cshName = cshName;
            Customer.cshPhone = cshPhone;
            Customer.cshTel = cshTel;
            Customer.cshWeixin = cshWeixin;
        }
        [self.navigationController pushViewController:Customer animated:YES];
        Customer.hidesBottomBarWhenPushed = NO;
        //[SVProgressHUD dismiss];
        [GiFHUD dismiss];
    } failure:^(NSError *error) {
        
        NSLog(@"网络错误!!");
        //[SVProgressHUD dismiss];
        [GiFHUD dismiss];
    }];
}

-(void)payInHandle:(id)sender
{
//    PayOrderVC *payorder = [[PayOrderVC alloc] init];
//    [self.navigationController pushViewController:payorder animated:YES];
    
    PayOrderViewController *payorder = [[PayOrderViewController alloc] init];
    [self.navigationController pushViewController:payorder animated:YES];
    
//    if (nil == [TDCustomer loginCustomer].CTTYPE||[TDCustomer loginCustomer].CTTYPE.length <= 0) {
//        
//        UIAlertView * al = [[[UIAlertView alloc]initWithTitle:@"账户提示" message:@"当前账户尚未绑定POS机" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:@"立即绑定", nil]autorelease];
//        al.tag = 100005;
//        [al show];
//    }else{
//        [self selectRat];
//    }
}

//-(void)selectRat{
//    
//    [SVProgressHUD show];
//    ASIFormDataRequest *request = [[HXHttpSolution defaultSolution] requestForRatWithCustMP:[TDCustomer loginCustomer].cust_id];
//    
//    [request setCompletionBlock:^{
//        NSLog(@"充值订单：response:%@ \n %@", [[NSString alloc]initWithData:request.responseData encoding:NSUTF8StringEncoding],request.responseString);
//        
//        //解析数据
//        ZZXmlRspHandler *handler = [[ZZXmlRspHandler alloc] initWithTag:KRspHandlerTag_Rat];
//        handler.parseXmlFinish = ^(BOOL succeed) {
//            
//            if (succeed) {
//                ZZXmlRspHeader *head = handler.rspHeader;
//                if ([head.code isEqualToString:RspCode_OK]) {
//                    TDXmlRspRat *content = (TDXmlRspRat *)handler.rspContent;
//                    NSDictionary *tempDic = [content rats][0];
//                    
//                    TDInputPriceViewController * collectController = [[[TDInputPriceViewController alloc]init] autorelease];
//                    collectController.hidesBottomBarWhenPushed = YES;
//                    collectController.rat= [tempDic objectForKey:@"CHANNELCODE"];
//                    [self.navigationController pushViewController:collectController animated:YES];
//                    
//                }else if ([head.code isEqualToString:RspCode_timeOut]){
//                    [self.view makeToast:head.msg duration:2.0 position:@"center"];
//                    [self performSelector:@selector(backToLoginView) withObject:nil afterDelay:2.0f];
//                    
//                } else {
//                    [self.view makeToast:head.msg duration:1.0 position:@"center"];
//                }
//            } else {
//                [self.view makeToast:@"提交订单失败" duration:1.0 position:@"center"];
//            }
//        };
//        [handler startParse:request.responseData];
//        [handler release];
//        [SVProgressHUD dismiss];
//    }];
//    [ request setFailedBlock:^{
//        [SVProgressHUD dismiss];
//        [self.view makeToast:@"网络异常" duration:1.0 position:@"center"];
//    }];
//    
//    [request startAsynchronous];
//    
//}

- (void)click{
    
    //[Dialog showMsg:@"正在建设中..."];
    [self alert:@"正在建设中..."];
    
//    JXPayResultViewController *JXpay = [[JXPayResultViewController alloc] init];
//    [self.navigationController pushViewController:JXpay animated:YES];
}

//添加广告
-(void)addImageAD:(TDEmpotyCell *)cell{
    
    //scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 150)];
//    scrollView.contentSize = CGSizeMake(KscreenWidth*2, 150);
//    UIImageView *imageView[2];
//    scrollView.pagingEnabled = YES;
//    scrollView.directionalLockEnabled = YES;
//    scrollView.showsHorizontalScrollIndicator = NO;
//    imageArray=[NSArray arrayWithObjects: [UIImage imageNamed:APPP01],[UIImage imageNamed:APPP02], nil];
//    for (int i=0;i<2;i++) {
//        imageView[i] = [[UIImageView alloc] init];
//        CGRect frame = CGRectMake(0, 0, KscreenWidth, 150);
//        frame.origin.x = frame.size.width * i;
//        frame.origin.y = 0;
//        imageView[i].frame = frame;
//        [imageView[i] setImage:imageArray[i]];
//        [scrollView addSubview:imageView[i]];
//    }
//    [cell.contentView addSubview:scrollView];
//    static NSInteger time = 10;
//    NSLog(@"index :%d",index);
//    if (index == 0) {   //开启定时器
//        ImageChangeTimer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
//    }else {
//        
//    }
//    index ++;
    
    
     if ([BusiIntf curPayOrder].IsAPPStore){
        imageArray=[NSArray arrayWithObjects: [UIImage imageNamed:APPP04],[UIImage imageNamed:APPP05], nil];
    }else {
        if ([[user objectForKey:@"GFDADNew"] isEqualToString:@"0"]) {  //不带“new”
            imageArray=[NSArray arrayWithObjects: [UIImage imageNamed:APPP01],[UIImage imageNamed:APPP02], nil];
        }else {
            imageArray=[NSArray arrayWithObjects: [UIImage imageNamed:APPP01],[UIImage imageNamed:APPP03], nil];
        }
    }
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KscreenWidth, 150) shouldInfiniteLoop:YES imageNamesGroup:imageArray];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [cell.contentView addSubview:cycleScrollView];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    cycleScrollView.autoScrollTimeInterval = 5;
    self.automaticallyAdjustsScrollViewInsets = NO;
    //cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
}
//变换图片
- (void)changeImage {
    
//    CGPoint point = scrollView.contentOffset;
//    point.x = (int)(point.x + 320) % (int)(320*3);
//    scrollView.contentOffset = point;
    
    [UIView animateWithDuration:0.5 animations:^{
         CGPoint point = scrollView.contentOffset;
        // NSLog(@"point:(%f,%f)",point.x,point.y);
         point.x = (int)(point.x + 320) % (int)(320*2);
         //NSLog(@"point:(%f,%f)",point.x,point.y);
         scrollView.contentOffset = point;
    } completion:^(BOOL finished) {
        NSLog(@"动画完成!");
    }];
}

//滚动文字
- (void) moveLable : (UILabel *)lb {
    CGRect lbFrame = lb.frame;
    lbFrame.origin.x = 320;
    lb.frame = lbFrame;
    
    [UIView beginAnimations:@"test" context:NULL];
    [UIView setAnimationDuration:20.0];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:999999];
    
    lbFrame.origin.x = -800;
    lb.frame = lbFrame;
    [UIView commitAnimations];
}

- (void)alert:(NSString *)msg{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

- (void)RequestForNotice {
    
    NSString *url = JXUrl; //(8.24修改)
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
                           @"action":@"SystemNotice",
                           @"data":dic
                           };
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSDictionary *dicc = [result JSONValue];
        NSString *code = dicc[@"code"];
        NSString *content = dicc[@"content"];
        NSLog(@"%@",dicc);
        if ([code isEqualToString:@"000000"]) {
            Notice = content;
            //如果通知内容为空则不显示
            if ([content isEqualToString:@""]) {
                label.hidden = YES;
                ImageView.hidden = YES;
            }else {
                label.hidden = NO;
            }
        }else {
            Notice = @"融丰欢迎您!";
        }
        [table reloadData];
    } failure:^(NSError *error) {
        NSLog(@"请求失败:%@",error);
        [self alert:@"请求网络失败！"];
    }];
    
}

- (void)ShowNotice {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"公告" message:Notice delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
    
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
//关闭定时器
- (void)viewDidDisappear:(BOOL)animated {
    
    [ImageChangeTimer invalidate];
    
}
//- (void)getMainKey
//{
//    NSString *term_id = [TDCustomer loginCustomer].moblie;
//    ASIFormDataRequest *request = [[HXHttpSolution defaultSolution] requestForGetMainKeyWithTermId:term_id cust_id:[TDCustomer loginCustomer].cust_id phone:[TDCustomer loginCustomer].moblie];
//    [request setCompletionBlock:^{
//        NSLog(@"response=%@", request.responseString);
//        //解析数据
//        ZZXmlRspHandler *handler = [[ZZXmlRspHandler alloc] init];
//        handler.parseXmlFinish = ^(BOOL succeed) {
//            if (succeed) {
//                ZZXmlRspHeader *head = handler.rspHeader;
//                if ([head.code isEqualToString:RspCode_OK]) {
//                    ZZXmlRspContent *rspContent = handler.rspContent;
//                    NSString *mainKey = [rspContent.data objectForKey:@"TMKEY"];
//                    if (0 < mainKey.length) {
//                        NSString *mainKeyDe = [NSString decrypt:mainKey withKey:ZMK];
//                        [[NSUserDefaults standardUserDefaults] setObject:mainKeyDe forKey:KPayMainKey];
//                    }
//                } else {
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:head.msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                    [alert show];
//                    [alert release];
//                }
//            } else {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"获取主密钥失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                [alert show];
//                [alert release];
//            }
//        };
//        [handler startParse:request.responseData];
//        [handler release];
//    }];
//    [ request setFailedBlock:^{
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络异常" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//        [alert release];
//    }];
//    
//    [request startAsynchronous];
//}

//- (void)getCustomerInfo
//{
//    ASIFormDataRequest *request = [[HXHttpSolution defaultSolution] requestForCustomerInfo:[TDCustomer loginCustomer].cust_id];
//    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [SVProgressHUD show];
//    
//    [request setCompletionBlock:^{
//        
//        NSLog(@"用户信息response=%@", [[NSString alloc]initWithData:request.responseData encoding:NSUTF8StringEncoding]);
//        
//        //解析数据
//        ZZXmlRspHandler *handler = [[ZZXmlRspHandler alloc] init];
//        
//        handler.parseXmlFinish = ^(BOOL succeed) {
//            if (succeed) {
//                ZZXmlRspHeader *head = handler.rspHeader;
//                if ([head.code isEqualToString:RspCode_OK]) {
//                    
//                    [TDCustomer loginCustomer].cert_status = [[head.myData valueForKey:@"USR_STATUS"] intValue];
//                    [TDCustomer loginCustomer].cust_name = [head.myData valueForKey:@"USERNAME"];
//                    [TDCustomer loginCustomer].cert_type = [[head.myData valueForKey:@"IDTYPECOD"] intValue];
//                    [TDCustomer loginCustomer].cert_no = [head.myData valueForKey:@"USERNO"];
//                    [TDCustomer loginCustomer].branch = [head.myData valueForKey:@"EMAIL"];
//                    [TDCustomer loginCustomer].oper_id = [head.myData valueForKey:@"USRID"];
//                    [TDCustomer loginCustomer].card_no = [head.myData valueForKey:@"TER_ACTION"];
//                    [TDCustomer loginCustomer].cert_failed_reason = [head.myData valueForKey:@"CUST_REG_STATUS"];
//                    [TDCustomer loginCustomer].CTTYPE = [head.myData valueForKey:@"TER_ACTION"];
//                    
//                    if ([TDCustomer loginCustomer].cert_status == 0||[TDCustomer loginCustomer].cert_status == 3||[TDCustomer loginCustomer].cert_status == 2||[head.myData valueForKey:@"TER_ACTION"] == nil) {
//                        NSString * string1 = @"";
//                        NSString * string2 = @"";
//                        NSString * string3 = @"";
//                        if ([TDCustomer loginCustomer].cert_status == 0||[TDCustomer loginCustomer].cert_status == 3) {
//                            string1 = @"当前账户尚未实名认证，是否立即认证";
//                            string2 = @"取消";
//                            string3 = @"确定";
//                            UIAlertView * al = [[[UIAlertView alloc]initWithTitle:@"账户提示" message:string1 delegate:self cancelButtonTitle:string2 otherButtonTitles:string3, nil]autorelease];
//                            al.tag = 100005;
//                            [al show];
//                        }else if([TDCustomer loginCustomer].cert_status == 2){
//                            if ([head.myData valueForKey:@"TER_ACTION"] == nil) {
//                                string1 = @"当前账户尚未绑定POS机";
//                                string2 = @"知道了";
//                                string3 = @"立即绑定";
//                                UIAlertView * al = [[[UIAlertView alloc]initWithTitle:@"账户提示" message:string1 delegate:self cancelButtonTitle:string2 otherButtonTitles:string3, nil]autorelease];
//                                al.tag = 100005;
//                                [al show];
//                            }
//                        }
//                    }
////                    //初始化功能视图数据
////                    if (!self.MyViewC.beginArray) {
////                        NSDictionary *tempDic = [head.myData copy];
////                        NSLog(@"获取到的字典：%@",tempDic);
////                        //将九宫格图片放在一个数组中
////                        NSArray *keyArray = [NSArray arrayWithObjects:@"CONSUME",@"BALANCEQUERY",@"CONSUMECANCEL",@"CREDITREPAY",@"TRANSFER",@"MOBILECHARGE",@"PAYMENT",@"LOTTERY",@"GAMECHARGE", nil];
////                        
////                        if (!self.buttonArr) {
////                            self.buttonArr = [[[NSMutableArray alloc] init] autorelease];
////                        }
////                        
////                        for (NSString *keyString in keyArray) {
////                            if ([[tempDic objectForKey:keyString] integerValue] == 1) {
////                                [self.buttonArr addObject:keyString];
////                            }
////                        }
////                        //给主视图添加九宫格
////                        self.MyViewC = [[[MyViewController alloc] init]autorelease];
////                        [self.MyViewC setBeginArray:self.buttonArr];
////                        self.MyViewC.view.frame = CGRectMake(0, 210, self.view.bounds.size.width, 240+20);
////                        self.MyViewC.delegate = self;
////                        self.MyViewC.view.backgroundColor = [UIColor clearColor];
////                        [_scrollView addSubview:self.MyViewC.view];
//                    
////                    }else{
////                        [self pushselectRat];
////                    }
//                } else {
//                    [self.view makeToast:head.msg duration:1.0 position:@"center"];
//                }
//            } else {
//                [self.view makeToast:@"获取信息失败" duration:1.0 position:@"center"];
//            }
//        };
//        [handler startParse:request.responseData];
//        [handler release];
//        [SVProgressHUD dismiss];
//        
//    }];
//    [ request setFailedBlock:^{
//        [SVProgressHUD dismiss];
//        
//    }];
//    [request startAsynchronous];
//}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    
//    if (alertView.tag == 100005) {
//        if (buttonIndex == 1) {
//            TDInfoAuthViewController *VC = [[TDInfoAuthViewController alloc] init];
//            [self.navigationController pushViewController:VC animated:YES];
//        }
//        else  {
//            
//            
//        }
//    }
//}
@end
