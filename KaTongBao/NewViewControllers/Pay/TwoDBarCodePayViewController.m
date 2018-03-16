//
//  TwoDBarCodePayViewController.m
//  KaTongBao
//
//  Created by rongfeng on 16/7/26.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "TwoDBarCodePayViewController.h"
#import "Common.h"
#import "macro.h"
#import "UIView+SDAutoLayout.h"
#import "TwoDBarCodeCell.h"
#import "SJAvatarBrowser.h"
#import "BusiIntf.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import <CommonCrypto/CommonDigest.h>
#import "SVProgressHUD.h"
#import "KTBWeiXinPayResultViewController.h"
#import "SDImageCache.h"
#import "KTBExampleViewController.h"
#import "GiFHUD.h"
@interface TwoDBarCodePayViewController ()

@end

@implementation TwoDBarCodePayViewController{
    UIImageView *LineOne;
    UIImageView *LineTwo;
    UIImageView *LineThree;
    UIImageView *CodeImg;
    NSInteger _index;
    NSTimer *_Timer;
    KTBWeiXinPayResultViewController *KTBWeiXinPay;
    UIImage *sentImg;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"二维码信息";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:19],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = NavBack;
    //自定义返回按钮
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    right.title = @"返回";
    self.navigationItem.backBarButtonItem = right;
    
    [self AddAnOtherTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = LightGrayColor;
    table.scrollEnabled = NO;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 200)];
    footView.backgroundColor = [UIColor whiteColor];
    footView.userInteractionEnabled = YES;
    
    UILabel *MsgLab = [[UILabel alloc] init];
    //区分下支付宝和微信
    NSString *PayStr = @"";
    if (self.tag == 1) { //微信支付
        PayStr = @"微信";
    }else {              //支付宝支付
        PayStr = @"支付宝";
    }
    NSMutableAttributedString *mutablestring = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"您的好友 [%@] 正在向您发起一笔金额为[%@元]的扫码收款，请扫面以下二维码进行支付。\n长按如下二维码，保存相册并跳转%@扫一扫.",[BusiIntf getUserInfo].ShopName,self.money,PayStr]];
    
    [mutablestring addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6, [BusiIntf getUserInfo].ShopName.length)];
    [mutablestring addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(20+[BusiIntf getUserInfo].ShopName.length, self.money.length + 1)];
    [mutablestring addAttribute:NSForegroundColorAttributeName value:NavBack range:NSMakeRange([BusiIntf getUserInfo].ShopName.length + self.money.length + 41, 22)];
    
    MsgLab.attributedText = mutablestring;
    
    MsgLab.numberOfLines = 0;
    MsgLab.font = [UIFont systemFontOfSize:12];
    [footView addSubview:MsgLab];
    MsgLab.sd_layout.leftSpaceToView(footView,20).topSpaceToView(footView,0).rightSpaceToView(footView,20).heightIs(60);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magout)];
    tap.numberOfTapsRequired = 1;
    
    //单手按
    UITapGestureRecognizer *TapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(WeiXin)];
    TapTwo.numberOfTapsRequired = 1;
    
    //双手按
    UILongPressGestureRecognizer *LongTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(imageLongTapClick:)];
    
    CodeImg = [[UIImageView alloc] init];
    //对图片路径做修改
    if ([_codeImgUrl hasPrefix:@"https"]) {
        _codeImgUrl = [_codeImgUrl substringFromIndex:5];
        NSLog(@"截取后面5位:%@",_codeImgUrl);
        _codeImgUrl = [NSString stringWithFormat:@"http%@",_codeImgUrl];
        NSLog(@"%@",_codeImgUrl);
    } {
        
    }
    NSLog(@"codeimgurl:%@",_codeImgUrl);
    CodeImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.codeImgUrl]]];
    CodeImg.userInteractionEnabled = YES;
    //[CodeImg addGestureRecognizer:tap];
    [CodeImg addGestureRecognizer:LongTap];
    [footView addSubview:CodeImg];
    CodeImg.sd_layout.centerXEqualToView(footView).topSpaceToView(MsgLab,5).widthIs(150).heightIs(150);
    
    UILabel *TipsLab = [[UILabel alloc] init];
    NSString *tip = @"温馨提示：";
    TipsLab.userInteractionEnabled = YES;
    NSString *mutableStr = @"";
    if (self.tag == 2) {  //支付宝支付
        mutableStr = @"";
    }else {               //微信支付
        mutableStr = @"2.微信支付交易限额   点击查看";
    }
    
    NSMutableAttributedString *MutableAttributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n  1.如果您不认识 %@或者不是您的好友，请核实后付款；\n  %@",tip,[BusiIntf getUserInfo].ShopName,mutableStr]];
    
    [MutableAttributeString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(11+6, [BusiIntf getUserInfo].ShopName.length)];
    
    
    TipsLab.attributedText = MutableAttributeString;
    TipsLab.font = [UIFont systemFontOfSize:12];
    TipsLab.numberOfLines = 0;
   
    [footView addSubview:TipsLab];
    TipsLab.sd_layout.leftSpaceToView(footView,30).rightSpaceToView(footView,30).topSpaceToView(CodeImg,0).heightIs(100);
    //支付宝支付去掉 第二条限额
    if (self.tag == 1) {  //微信支付
        [MutableAttributeString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(49+[BusiIntf getUserInfo].ShopName.length, 4)];
         [TipsLab addGestureRecognizer:TapTwo];
    }else {         //支付宝支付
        
    }
    //UILabel *TipsLabTwo = [[UILabel alloc] init];
    
    table.tableFooterView = footView;
    [self.view addSubview:table];
    
    //单元格横线
    LineOne = [[UIImageView alloc] init];
    LineOne.backgroundColor = [UIColor lightGrayColor];
    LineTwo = [[UIImageView alloc] init];
    LineTwo.backgroundColor = [UIColor lightGrayColor];
    LineThree = [[UIImageView alloc] init];
    LineThree.backgroundColor = [UIColor lightGrayColor];
    
    KTBWeiXinPay = [[KTBWeiXinPayResultViewController alloc] init];
    
}
//长按方法
- (void)imageLongTapClick:(UILongPressGestureRecognizer *)longTap {
    
    
    if (longTap.state == UIGestureRecognizerStateBegan) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存图片到相册", nil];
        [actionSheet showInView:self.view];
        
        UIImage *img = [self captureImageFromView:self.view.window];
        sentImg = img;
    }
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存图片到相册", nil];
//    [actionSheet showInView:self.view];
//    //截屏
//    UIImage *img = [self captureImageFromView:self.view.window];
//    sentImg = img;
    
}

//截屏
-(UIImage *)captureImageFromView:(UIView *)view

{
    
    CGRect screenRect = [view bounds];
    
    UIGraphicsBeginImageContext(screenRect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:ctx];
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}
//actionSheet协议方法
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        
        //[SVProgressHUD show];
        [GiFHUD showWithOverlay];
        //保存相册
        UIImageWriteToSavedPhotosAlbum(sentImg, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
        
    }else {
        
    }
}
//保存照片之后跳转微信、支付宝
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo

{
    
    NSString *message = @"";
    
    if (!error) {
        
        message = @"成功保存到相册";
        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        
//        [alert show];
        
        if (self.tag == 1) { //微信
            BOOL isWeChatCanOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
            if (isWeChatCanOpen) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weixin://"]];
            }else {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您手机还没有安装微信！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }else {     //支付宝
            BOOL isAliPayCanOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay://"]];
            if (isAliPayCanOpen) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"alipay://"]];
            }else {
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您手机还没有安装支付宝！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        
    }else
        
    {

        message = [error description];
        NSInteger Code = error.code;
        if (Code == -3310) {
            message = @"您没有打开APP的照片权限，请您在设置中打开权限!";
        }
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
        
    }
    
   // [SVProgressHUD dismiss];
    [GiFHUD dismiss];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        NSLog(@"1212312312312");
    }else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms://itunes.apple.com/gb/app/id399608199"]];
    }
    
}

//放大图片
- (void)magout {
    [SJAvatarBrowser showImage:CodeImg];
    
}
//微信限额
- (void)WeiXin {
    KTBExampleViewController *ExampleVc = [[KTBExampleViewController alloc] init];
    ExampleVc.hidesBottomBarWhenPushed = YES;
    ExampleVc.tag = 105;
    [self.navigationController pushViewController:ExampleVc animated:YES];
    ExampleVc.hidesBottomBarWhenPushed = NO;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    }else {
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identify = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        if (indexPath.section == 0) {
            if (indexPath.row == 0 ) {
                
                TwoDBarCodeCell *TwoDBarCode = [[TwoDBarCodeCell alloc] init];
                TwoDBarCode.LeftLabel.text = @"订单编号";
                TwoDBarCode.RightLabel.text = self.orderNo;
                [TwoDBarCode.contentView addSubview:LineOne];
                LineOne.sd_layout.leftSpaceToView(TwoDBarCode.contentView,0).rightSpaceToView(TwoDBarCode.contentView,0).heightIs(0.5).topSpaceToView(TwoDBarCode.contentView,0);
                cell = TwoDBarCode;
            }else if (indexPath.row == 1) {
                TwoDBarCodeCell *TwoDBarCode = [[TwoDBarCodeCell alloc] init];
                TwoDBarCode.LeftLabel.text = @"订单时间";
                TwoDBarCode.RightLabel.text = self.orderTime;
                [TwoDBarCode.contentView addSubview:LineTwo];
                LineTwo.sd_layout.leftSpaceToView(TwoDBarCode.contentView,0).rightSpaceToView(TwoDBarCode.contentView,0).heightIs(0.5).bottomSpaceToView(TwoDBarCode.contentView,0);
                cell = TwoDBarCode;
            }
            
        }
        else  {
            
        }
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 40.0f;
        
    }else {
        return 45.0f;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 45)];
    view.backgroundColor = LightGrayColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, KscreenWidth, 45)];
    if (section == 0) {
        label.text = @"订单信息";
    }else if (section == 1) {
        label.text = @"二维码信息";
    }
    label.textColor = Color(20, 151, 222);
    [view addSubview:label];
    return view;
}
//查询微信支付状态
- (void)RequestForCash {
    NSString *url = JXUrl;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *orderNo = [BusiIntf curPayOrder].OrderNo;
    NSString *md5 = [NSString stringWithFormat:@"%@%@",orderNo,key];
    NSString *sign = [self md5:md5];
    NSDictionary *dic1 = @{
                           @"orderNo":orderNo,
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"nocardOrderQueryState",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        
        NSDictionary *dic = [result JSONValue];
        NSString *code = dic[@"code"];
        NSString *msg = dic[@"msg"];
        NSString *failMsg = dic[@"failMag"];
        NSString *orderTime = dic[@"orderTime"];
        NSString *orderStatus = dic[@"orderStatus"];
        NSString *orderStatusCn = dic[@"orderStatusCn"];
        NSString *orderReason = dic[@"orderReason"];
        [BusiIntf curPayOrder].OrderTime = orderTime;
        NSLog(@"获取到的信息:%@",dic);
        
        if (![code isEqualToString:@"000000"]) {
            [self alertMsg:msg];
        }else if ([orderStatus isEqual:@20]){
            //到支付结果页面 (成功)
            [_Timer invalidate];
            _index = 0;
            KTBWeiXinPay.tag = 1;
            [self.navigationController pushViewController:KTBWeiXinPay animated:YES];
        }else if ([orderStatus isEqual:@21]) { //失败
            [_Timer invalidate];
            _index =0;
            KTBWeiXinPay.tag = 2;
            [self.navigationController pushViewController:KTBWeiXinPay animated:YES];
        } else if(_index == 0 && [orderStatus isEqual:@11]){   //等待
            [_Timer invalidate];
            KTBWeiXinPay.tag = 3;
            [self.navigationController pushViewController:KTBWeiXinPay animated:YES];
        } else {
            
        }
    } failure:^(NSError *error) {
        NSLog(@"网络请求错误:%@",error);
        //[SVProgressHUD dismiss];
    }];
}

//MD516位小写加密
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
-(void)alertMsg: (NSString *)msg
{
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message: msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alter.delegate = self;
    [alter show];
}

- (void)AddAnOtherTimer {
    _index = _index + 120;
    _Timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(StartTimer) userInfo:nil repeats:YES];
}
//
- (void)StartTimer {
    
    _index = _index - 10;
    //查询收支结果状态
    [self RequestForCash];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    if (_index != 0) {  //如果页面退出没有请求完毕，则取消这个定时器
        [_Timer invalidate];
    }else {
        
    }
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * __nullable credential))completionHandler
{
    NSLog(@"didReceiveChallenge");
    completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]);
}

+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
{
    return YES;
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
