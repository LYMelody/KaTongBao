//
//  SelectProVC.m
//  wujieNew
//
//  Created by rongfeng on 16/1/11.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "SelectProVC.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "SelectCityVC.h"
#import "BusiIntf.h"
#import <CoreLocation/CoreLocation.h>
#import "SVProgressHUD.h"
#import "KTBSubBankViewController.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import <CommonCrypto/CommonDigest.h>
#import "GiFHUD.h"
@implementation SelectProVC {
    
    NSMutableArray *ProArr;
    NSMutableDictionary *Citydict;
    CLLocationManager *maneger;
    CLGeocoder *geocoder;
    UIButton *LocationBtn;
    
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    //定位
//    maneger = [[CLLocationManager alloc] init];
//    
////    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
////        [maneger requestWhenInUseAuthorization];
////    }
//    
//    maneger.delegate = self;
//    //maneger.desiredAccuracy = kCLLocationAccuracyBest;
//    maneger.distanceFilter = 10;
//    [maneger requestAlwaysAuthorization];
//    [maneger startUpdatingLocation];
//    
//    geocoder = [[CLGeocoder alloc] init];
    //隐藏工具栏
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"选择支行所在省";
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] init];
    left.title = @"返回";
    self.navigationItem.backBarButtonItem = left;
    
    //背景
    UIImageView *backImg = [[UIImageView alloc] init];
    backImg.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    backImg.backgroundColor = LightGrayColor;
    backImg.userInteractionEnabled = YES;
    [self.view addSubview:backImg];
    
    UILabel *CityLab = [[UILabel alloc] init];
    CityLab.text = @"当前定位城市";
    CityLab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:CityLab];
    CityLab.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,5).widthIs(100).heightIs(14.5);
    UIImageView *WheitBackImg = [[UIImageView alloc] init];
    WheitBackImg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:WheitBackImg];
    WheitBackImg.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(self.view,24).widthIs(KscreenWidth).heightIs(40);
    
    LocationBtn = [[UIButton alloc] init];
    LocationBtn.layer.cornerRadius = 4;
    LocationBtn.layer.masksToBounds = YES;
    LocationBtn.layer.borderWidth = 0.5;
    LocationBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    LocationBtn.layer.borderColor = Color(151, 151, 151).CGColor;
    [LocationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [LocationBtn addTarget:self action:@selector(Relocation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:LocationBtn];
    if ([[BusiIntf curPayOrder].cityName isEqualToString:@""] || [BusiIntf curPayOrder].cityName == nil) {
        //[LocationBtn setTitle:@"杭州" forState:UIControlStateNormal];
        //LocationBtn.sd_layout.leftSpaceToView(self.view,17.5).centerYEqualToView(WheitBackImg).widthIs(60).heightIs(31.5);
    }
    else {
        [LocationBtn setTitle:[[BusiIntf curPayOrder].cityName stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forState:UIControlStateNormal];
        
    }
    LocationBtn.sd_layout.leftSpaceToView(self.view,17.5).centerYEqualToView(WheitBackImg).rightSpaceToView(self.view,17.5).heightIs(31.5);
    UILabel *TitleLab = [[UILabel alloc] init];
    TitleLab.text = @"全部";
    TitleLab.font = [UIFont systemFontOfSize:14];
    TitleLab.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:TitleLab];
    TitleLab.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,79).widthIs(40).heightIs(15);
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, KscreenWidth, KscreenHeight - 165) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    [self.view  addSubview:table];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"provinces" ofType:@"plist"];
    ProArr = [[NSMutableArray alloc] initWithContentsOfFile:path];
    NSString *Citypath = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"plist"];
    Citydict = [[NSMutableDictionary alloc] initWithContentsOfFile:Citypath];

    
    //定位
    maneger = [[CLLocationManager alloc] init];
    
    //    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
    //        [maneger requestWhenInUseAuthorization];
    //    }
    
    maneger.delegate = self;
    //maneger.desiredAccuracy = kCLLocationAccuracyBest;
    maneger.distanceFilter = 10;
    [maneger requestAlwaysAuthorization];
    [maneger startUpdatingLocation];
    
    geocoder = [[CLGeocoder alloc] init];
}

//定位
- (void)Relocation {
    
    //[self.navigationController popViewControllerAnimated:YES];
    
    [self RequestForSubBankInfo];
    
}

//获取支行信息
- (void)RequestForSubBankInfo {
    
    NSString *url = JXUrl;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    
    NSString *md5 = [NSString stringWithFormat:@"%@%@%@%@%@",[BusiIntf curPayOrder].AddBankName,[BusiIntf curPayOrder].BankCardType,[BusiIntf curPayOrder].cityName,[BusiIntf curPayOrder].ProName,key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                           @"bankType":[BusiIntf curPayOrder].BankCardType,
                           @"bankName":[BusiIntf curPayOrder].AddBankName,
                           @"province":[BusiIntf curPayOrder].ProName,
                           @"city":[BusiIntf curPayOrder].cityName,
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"bankInfoCnaps",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSLog(@"数据:%@",result);
        NSDictionary *dic = [result JSONValue];
        NSString *code = dic[@"code"];
        NSArray *ListAtr = dic[@"cnapsList"];
        
        if ([code isEqualToString:@"000000"]) {
            //注册成功 2 登陆页面
            //LoginViewController *Login = [[LoginViewController alloc] init];
            //[self performSelector:@selector(backToRootView) withObject:nil afterDelay:2];
            KTBSubBankViewController *ktbsunbank = [[KTBSubBankViewController alloc] init];
            ktbsunbank.tag = 2;
            ktbsunbank.hidesBottomBarWhenPushed = YES;
            ktbsunbank.SubBankArray = ListAtr;
            [self.navigationController pushViewController:ktbsunbank animated:YES];
            ktbsunbank.hidesBottomBarWhenPushed = NO;
            
        } else {
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
        
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return ProArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"cell";
    UITableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (Cell == nil) {
        Cell = [[UITableViewCell alloc] init];
        
        NSString *proName = ProArr[indexPath.row];
        Cell.textLabel.text = proName;
        Cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return Cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *proName = ProArr[indexPath.row];
    [BusiIntf curPayOrder].ProName = proName;
    NSArray *cityarr = Citydict[proName];
    SelectCityVC *CityVC = [[SelectCityVC alloc] init];
    CityVC.CityArray = cityarr;
    CityVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:CityVC animated:YES];
    CityVC.hidesBottomBarWhenPushed = NO;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    //[SVProgressHUD show];
    [GiFHUD showWithOverlay];
    CLLocation *mylocation = [locations lastObject];
    NSLog(@"经纬度为：%f,%f",mylocation.coordinate.latitude,mylocation.coordinate.longitude);
    [maneger stopUpdatingLocation];
    //NSLog(@"%@",mylocation);
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:mylocation.coordinate.latitude longitude:mylocation.coordinate.longitude];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count > 0) {
            
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSLog(@"%@,%@,%@",placemark.locality,placemark.addressDictionary,placemark.administrativeArea);
            [BusiIntf curPayOrder].ProName = placemark.administrativeArea;
            [BusiIntf curPayOrder].cityName = placemark.locality;
            //[BusiIntf curPayOrder].Location = [placemark.addressDictionary[@"FormattedAddressLines"] objectAtIndex:0];
            [LocationBtn setTitle:[BusiIntf curPayOrder].cityName forState:UIControlStateNormal];
            //[SVProgressHUD dismiss];
            [GiFHUD dismiss];
        }
        if (error) {
            NSLog(@"获取失败：%@",error);
            [self alert:@"请打开网络"];
            //[SVProgressHUD dismiss];
            [GiFHUD dismiss];
        }
        
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (error.code == kCLErrorDenied) {
        NSLog(@"%@",error);
    }
}
- (void)alert:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}
@end
