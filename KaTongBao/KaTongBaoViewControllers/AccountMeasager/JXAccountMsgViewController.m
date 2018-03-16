//
//  JXAccountMsgViewController.m
//  JingXuan
//
//  Created by rongfeng on 16/6/6.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "JXAccountMsgViewController.h"
#import "Common.h"
#import "macro.h"
#import "TDMegCell.h"
#import "TDViewsCell.h"
#import "BusiIntf.h"
#import "JXAuthCertifyViewController.h"
#import "SVProgressHUD.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import <CommonCrypto/CommonDigest.h>
#import "JXActiveViewController.h"
#import "JXBasicMsgViewController.h"
#import "JXPayWithOrderViewController.h"
#import "JXBankInfoViewController.h"
#import "AuthCertifyVC.h"
#import "KTBbasicMsgViewController.h"
#import "UIView+SDAutoLayout.h"
#import "KTBAuthCertifyViewController.h"
#import "KTBCardManagerViewController.h"
#import "GiFHUD.h"
@interface JXAccountMsgViewController ()

@end

@implementation JXAccountMsgViewController {
    TDMegCell *_Cell;
    UIImageView *LineOne;
    UIImageView *LineTwo;
    UIImageView *LineThird;
    UIImageView *LineFour;
    UIImageView *LineFive;
    UIImageView *LineSix;
    NSUserDefaults *user;
    UITableView *table;
    NSString *selfStatus; 
}

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
    //获取基本信息
    [self RequestForBaseInfo];
    
   [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //禁用右滑返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"个人信息";
    //自定义返回按钮
//    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"  返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
//    self.navigationItem.leftBarButtonItem = left;
//    self.navigationItem.hidesBackButton = YES;
//    self.navigationController.navigationBar.barTintColor = NavBack;
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] init];
    leftBtn.title = @"返回";
    self.navigationItem.backBarButtonItem = leftBtn;
    
    //self.view.backgroundColor = LightGrayColor;
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight + 50) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    table.showsVerticalScrollIndicator = NO;
    //table.backgroundColor = LightGrayColor;
    UIImageView *ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 305)];
    ImageView.backgroundColor = [UIColor whiteColor];
    table.tableFooterView = ImageView;
    [self.view addSubview:table];
    
    LineOne = [[UIImageView alloc] init];
    LineTwo = [[UIImageView alloc] init];
    LineThird = [[UIImageView alloc] init];
    LineFour = [[UIImageView alloc] init];
    LineFive = [[UIImageView alloc] init];
    LineSix = [[UIImageView alloc] init];
    LineOne.backgroundColor = Color(213, 215, 220);
    LineTwo.backgroundColor = Color(213, 215, 220);
    LineThird.backgroundColor = Color(213, 215, 220);
    LineFour.backgroundColor = Color(213, 215, 220);
    LineFive.backgroundColor = Color(213, 215, 220);
    LineSix.backgroundColor = Color(213, 215, 220);

}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 15;
    }
    if (indexPath.row == 1) {
        return 65;
    }
    if (indexPath.row == 2 ) {
        return 15;
    }
    else{
        return 45;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        if (indexPath.row == 0) {
            TDViewsCell *JXCell = [[TDViewsCell alloc] init];
            LineOne.frame = CGRectMake(0, 14, KscreenWidth, 1);
            [JXCell.contentView addSubview:LineOne];
            cell = JXCell;
        }
        if (indexPath.row == 1) {
            _Cell = [[TDMegCell alloc] init];
            _Cell.LeftLable.text = @"头像";
            _Cell.RightLabel.hidden = YES;
            user = [NSUserDefaults standardUserDefaults];
            NSData *DATA = [user objectForKey:@"TXImage"];
            UIImage *image = [UIImage imageWithData:[user objectForKey:@"TXImage"]];
            if (DATA) {
                _Cell.ImageView.image = image;
            }else {
                _Cell.ImageView.image = [UIImage imageNamed:@"人物头像.png"];
            }
            LineTwo.frame = CGRectMake(0, 64.5, KscreenWidth, 1);
            [_Cell.contentView addSubview:LineTwo];
            cell = _Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row == 2 ) {
            TDViewsCell *JXCell = [[TDViewsCell alloc] init];
            LineThird.frame = CGRectMake(0, 14, KscreenWidth, 1);
            [JXCell.contentView addSubview:LineThird];
            cell = JXCell;
        }
        if (indexPath.row == 3) {
            TDMegCell *JXCell = [[TDMegCell alloc] init];
            JXCell.ImageView.hidden = YES;
            JXCell.RightLabel.text = [BusiIntf getUserInfo].UserName;
            JXCell.LeftLable.text = @"账号";
            cell = JXCell;
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row == 4) {
            TDMegCell *JXCell = [[TDMegCell alloc] init];
            JXCell.ImageView.hidden = YES;
            if ([[BusiIntf curPayOrder].shopStatus isEqualToString:@"20"] && [[BusiIntf curPayOrder].isEdit isEqualToString:@"0"]) {
                JXCell.RightLabel.text = @"已认证";
                JXCell.RightLabel.textColor = [UIColor colorWithRed:58/255.0 green:142/255.0 blue:12/255.0 alpha:1];
            }else if ([[BusiIntf curPayOrder].shopStatus isEqualToString:@"11"]) {
                JXCell.RightLabel.text = @"审核中";
                JXCell.RightLabel.textColor = [UIColor orangeColor];
            }else if ([[BusiIntf curPayOrder].shopStatus isEqualToString:@"12"]) {
                JXCell.RightLabel.text = @"审核驳回";
                JXCell.RightLabel.textColor = RedColor;
            }else {
                JXCell.RightLabel.text = @"未认证";
                JXCell.RightLabel.textColor = RedColor;
            }
            JXCell.LeftLable.text = @"实名认证";
            LineFour.frame = CGRectMake(0, 44.5, KscreenWidth, 1);
            //[JXCell.contentView addSubview:LineFour];
            JXCell.RightLabel.sd_layout.rightSpaceToView(JXCell.contentView,6).topSpaceToView(JXCell.contentView,12.5).widthIs(100).heightIs(20);
            cell = JXCell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row == 5) {
            TDMegCell *JXCell = [[TDMegCell alloc] init];
            JXCell.ImageView.hidden = YES;
            selfStatus = [NSString stringWithFormat:@"%@",[BusiIntf curPayOrder].selfStatus];
            if ([selfStatus isEqualToString:@"1"]) {
                JXCell.RightLabel.text = @"激活成功";
                JXCell.RightLabel.textColor = [UIColor colorWithRed:58/255.0 green:142/255.0 blue:12/255.0 alpha:1];
            }else {
                JXCell.RightLabel.text = @"未激活";
                JXCell.RightLabel.textColor = RedColor;
                JXCell.RightLabel.sd_layout.rightSpaceToView(JXCell.contentView,6).topSpaceToView(JXCell.contentView,12.5).widthIs(100).heightIs(20);
                JXCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            JXCell.LeftLable.text = @"账户激活";
            
            cell = JXCell;
        }
        if (indexPath.row == 6) {
            TDMegCell *JXCell = [[TDMegCell alloc] init];
            JXCell.ImageView.hidden = YES;
            if(!([[BusiIntf curPayOrder].bankNumber isEqualToString:@""] || [BusiIntf curPayOrder].bankNumber  == nil)) {
                JXCell.RightLabel.text = @"已绑定";
                JXCell.RightLabel.textColor = [UIColor colorWithRed:58/255.0 green:142/255.0 blue:12/255.0 alpha:1];
            }else {
                JXCell.RightLabel.text = @"未绑定";
                JXCell.RightLabel.textColor = RedColor;
            }
            JXCell.LeftLable.text = @"结算卡绑定";
            JXCell.RightLabel.sd_layout.rightSpaceToView(JXCell.contentView,6).topSpaceToView(JXCell.contentView,12.5).widthIs(100).heightIs(20);
            JXCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            LineFour.frame = CGRectMake(0, 44.5, KscreenWidth, 1);
            [JXCell.contentView addSubview:LineFour];
            cell = JXCell;
            
        }
//        if (indexPath.row == 7) {
//            TDMegCell *JXCell = [[TDMegCell alloc] init];
//            JXCell.LeftLable.text = @"我的地址";
//            JXCell.ImageView.hidden = YES;
//            JXCell.RightLabel.hidden = YES;
//            LineSix.frame = CGRectMake(0, 44.5, KscreenWidth, 1);
//            [JXCell.contentView addSubview:LineSix];
//            cell = JXCell;
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        UIActionSheet *sheet;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册中选择", @"拍照", nil];
        }else {
            
            sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册中选择", nil];
        }
        sheet.tag = 255;
        [sheet showInView:self.view];
    }
    if (indexPath.row == 4) { //实名认证

        
        //获取信息 跳到实名认证
        //[self RequestForBaseInFoBasicInFo];
        
        KTBAuthCertifyViewController *KTBAuth = [[KTBAuthCertifyViewController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:KTBAuth animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    if (indexPath.row == 5) {  //账户激活
//        JXActiveViewController *Acive = [[JXActiveViewController alloc] init];
//        [self.navigationController pushViewController:Acive animated:YES];
        
//        JXPayWithOrderViewController *JXPayWithOrder = [[JXPayWithOrderViewController alloc] init];
//        JXPayWithOrder.tag = 100;
//        [BusiIntf curPayOrder].amount = @"1";
//        [self.navigationController pushViewController:JXPayWithOrder animated:YES];
        //账户激活请求
        if ([selfStatus isEqualToString:@"1"]) { //已激活不能点击
            
            
        }else {
            [self RequestForActiveAccount];
        }
        
    } else if (indexPath.row == 6) {
        
        NSLog(@"卡管理");
        KTBCardManagerViewController *KTB = [[KTBCardManagerViewController alloc] init];
        KTB.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:KTB animated:YES];
        KTB.hidesBottomBarWhenPushed = NO;
    }
}

//ActionSheet 点击方法
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        switch (buttonIndex) {
            case 2:
                return;
            case 0:
                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:imagePickerController animated:YES completion:nil];
                [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
                break;
            case 1:
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:imagePickerController animated:YES completion:nil];
                break;
            default:
                break;
        }
    }
    else {
        switch (buttonIndex) {
            case 1:
                return;
            case 0:
                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:imagePickerController animated:YES completion:nil];
                [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
                break;
            default:
                break;
        }
    }
}

//相片选择方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *data = UIImageJPEGRepresentation(image, 1);
    
    _Cell.ImageView.image = image;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:data forKey:@"TXImage"];
    //同步
    [user synchronize];
    // NSLog(@"%@",data);
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}

//获取商户基本信息状态
- (void)RequestForBaseInfo {
    
    //[SVProgressHUD show];
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
        [BusiIntf getUserInfo].ShopName = dicc[@"shopName"];   //商户姓名
        [BusiIntf curPayOrder].shopName = dicc[@"shopName"];  //商户姓名
        [BusiIntf curPayOrder].shopStatus = dicc[@"shopStatus"];  //商户状态
        [BusiIntf curPayOrder].shortName = dicc[@"shortName"];
        [BusiIntf curPayOrder].isRealName = dicc[@"isRealName"];
        [BusiIntf curPayOrder].orgCode = dicc[@"orgId"];       //机构编码
        [BusiIntf curPayOrder].showMsg = dicc[@"showMsg"];     //显示信息
        [table reloadData];
        //[SVProgressHUD dismiss];
        [GiFHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"网络申请失败:%@",error);
        //[SVProgressHUD dismiss];
        [GiFHUD dismiss];
    }];
}
//实名认证基本信息
- (void)RequestForBaseInFoBasicInFo {
    
    
    //[SVProgressHUD show];
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
        [table reloadData];
        if ([dicc[@"code"] isEqualToString:@"000000"]) {   //获取到信息 跳到实名认证
            KTBbasicMsgViewController *baseVc = [[KTBbasicMsgViewController alloc] init];
            [self.navigationController pushViewController:baseVc animated:YES];
        }else {
            
        }
        //[SVProgressHUD dismiss];
        [GiFHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"网络申请失败:%@",error);
        //[SVProgressHUD dismiss];
        [GiFHUD dismiss];
    }];
}

//账户激活
- (void)RequestForActiveAccount {
    
    NSString *url = JXUrl;
    user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    //时间戳
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-DD HH:mm:ss"];
    NSTimeZone *timezone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timezone];
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%.0f",[datenow timeIntervalSince1970]];

    NSString *md5 = [NSString stringWithFormat:@"%@%@",timeSp,key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                           @"linkId":timeSp,
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"shopActivationSmsState",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSDictionary *dic = [result JSONValue];
        NSLog(@"返回的数据:%@",dic);
        NSString *code = dic[@"code"];
        NSString *msg = dic[@"msg"];
        NSString *orderNo = dic[@"orderNo"];
        NSString *cardPhone = dic[@"cardPhone"];
        NSString *shopCert = dic[@"shopCert"];
        NSString *shopAccount = dic[@"shopAccount"];
        
        if ([code isEqualToString:@"000000"]) {
            
            [BusiIntf curPayOrder].OrderNo = orderNo;    //订单号
            [BusiIntf curPayOrder].shopCard = shopCert;   //身份证
            [BusiIntf curPayOrder].bankAccont = shopAccount;   //银行卡姓名
            [BusiIntf curPayOrder].cardPhone = cardPhone;
            JXBankInfoViewController *JXBankInfo = [[JXBankInfoViewController alloc] init];
            JXBankInfo.tag = 100;
            [self.navigationController pushViewController:JXBankInfo animated:YES];
        }else {
            [self alert:msg];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"请求网络错误:%@",error);
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
#define mark -

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    //开启右滑返回
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
}

- (void)alert:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
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
