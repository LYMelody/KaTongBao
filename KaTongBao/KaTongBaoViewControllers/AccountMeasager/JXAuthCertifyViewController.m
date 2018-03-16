//
//  JXAuthCertifyViewController.m
//  JingXuan
//
//  Created by rongfeng on 16/6/6.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "JXAuthCertifyViewController.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "macro.h"
#import "BusiIntf.h"
#import "BasicInformationViewController.h"
#import "JXBasicMsgViewController.h"
#import "JXPayWithOrderViewController.h"
#import "JXActiveViewController.h"
#define Tips \
@"1，用户填写商户信息，提交进行审核。提交后可进入“商户信息审核”选项卡查看查询状态。若审核通过，则红色提示变绿。\r\
2，完成商户信息审核后，进入账户激活选项卡，在账户激活页面完成本人卡交易后，账户激活完成，红色提示变绿。\r\
3，当商户信息审核和账户激活都完成后，认证完成。"

@interface JXAuthCertifyViewController ()

@end

@implementation JXAuthCertifyViewController

-(void)viewWillAppear:(BOOL)animated
{
    //隐藏导航栏
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.hidden = NO;
    //隐藏工具栏
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = NavBack;
    //[self RequestForBaseInfo];
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
    //基本信息
    UIImageView *Img = [[UIImageView alloc] init];
    Img.layer.cornerRadius = 3;
    Img.layer.masksToBounds = YES;
    Img.backgroundColor = [UIColor whiteColor];
    Img.userInteractionEnabled = YES;
    [Img addGestureRecognizer:tap];
    UILabel *LlabelOne = [[UILabel alloc] init];
    LlabelOne.text = @"基本信息";
    LlabelOne.font = [UIFont systemFontOfSize:15];
    [Img addSubview:LlabelOne];
    LlabelOne.sd_layout.leftSpaceToView(Img,11).topSpaceToView(Img,11.5).widthIs(60).heightIs(21);
    UILabel *RlabelOne = [[UILabel alloc] init];
    RlabelOne.textAlignment = NSTextAlignmentCenter;
    if ([[BusiIntf curPayOrder].shopStatus isEqual:@10]) {
        RlabelOne.text = @"初始化";
    } else if([[BusiIntf curPayOrder].shopStatus isEqual:@11]){
        RlabelOne.text = @"待审核";
    }else if ([[BusiIntf curPayOrder].shopStatus isEqual:@12]) {
        RlabelOne.text = @"审核驳回";
    }else if ([[BusiIntf curPayOrder].shopStatus isEqual:@19]) {
        RlabelOne.text = @"初审通过";
    }else if ([[BusiIntf curPayOrder].shopStatus isEqual:@20]) {
        RlabelOne.text = @"审核通过";
    }else if ([[BusiIntf curPayOrder].shopStatus isEqual:@30]) {
        RlabelOne.text = @"系统风控";
    }else if ([[BusiIntf curPayOrder].shopStatus isEqual:@99]) {
        RlabelOne.text = @"停用删除";
    }else {
        
    }
    RlabelOne.font = [UIFont systemFontOfSize:15];
    RlabelOne.textColor = Gray136;
    [Img addSubview:RlabelOne];
    RlabelOne.sd_layout.rightSpaceToView(Img,34.5).topSpaceToView(Img,11.5).widthIs(60).heightIs(21);
    UIImageView *TypeImg = [[UIImageView alloc] init];
    [Img addSubview:TypeImg];
    [self.view addSubview:Img];
    Img.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,116).rightSpaceToView(self.view,16).heightIs(44);
    //信息审核状态图片
//    if ([[BusiIntf curPayOrder].shopStatus isEqualToString:@"10A"]) {
//        TypeImg.image = [UIImage imageNamed:@"确定.png"];
//        TypeImg.sd_layout.rightSpaceToView(Img,10).topSpaceToView(Img,13).widthIs(20).heightIs(16);
//    }else if ([[BusiIntf curPayOrder].shopStatus isEqualToString:@"10C"]){
//        TypeImg.image = [UIImage imageNamed:@"＊1.png"];
//        TypeImg.sd_layout.rightSpaceToView(Img,14).topSpaceToView(Img,17).widthIs(10).heightIs(10);
//    }else {
//        TypeImg.image = [UIImage imageNamed:@"realname_auth_edit.png"];
//        TypeImg.sd_layout.rightSpaceToView(Img,10).topSpaceToView(Img,10).widthIs(20).heightIs(20);
//    }
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
    if ([[BusiIntf curPayOrder].selfStatus isEqual:@1]) {
        RlabelTwo.text = @"激活成功";
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
    if ([[BusiIntf curPayOrder].selfStatus isEqual:@1]) {
        TypeImgTwo.image = [UIImage imageNamed:@"确定.png"];
        TypeImgTwo.sd_layout.rightSpaceToView(ActiveImg,10).topSpaceToView(ActiveImg,13).widthIs(20).heightIs(16);
    }else {
        TypeImgTwo.image = [UIImage imageNamed:@"＊1.png"];
        TypeImgTwo.sd_layout.rightSpaceToView(ActiveImg,14).topSpaceToView(ActiveImg,17).widthIs(10).heightIs(10);
    }
    ActiveImg.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,176).rightSpaceToView(self.view,16).heightIs(44);
    
}

//基本信息认证
- (void)Certify {
    
    NSLog(@"信息认证");
    JXBasicMsgViewController *Basic = [[JXBasicMsgViewController alloc] init];
    [self.navigationController pushViewController:Basic animated:YES];
}
//激活
- (void)Active {
    
    NSLog( @"激活");
    
    JXActiveViewController *ActiveVC = [[JXActiveViewController alloc] init];
    [self.navigationController pushViewController:ActiveVC animated:YES];
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
