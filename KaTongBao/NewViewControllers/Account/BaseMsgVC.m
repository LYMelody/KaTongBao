//
//  BaseMsgVC.m
//  wujieNew
//
//  Created by rongfeng on 16/1/11.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "BaseMsgVC.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "ViewsCell.h"
#import "BaseMsgCell.h"
#import "LocationCell.h"
#import "TDEmpotyCell.h"
#import "SelectProVC.h"
#import "BusiIntf.h"
#import <CoreLocation/CoreLocation.h>
#import "SVProgressHUD.h"
#import "IBHttpTool.h"
#import "SBJSON.h"
#import <CommonCrypto/CommonDigest.h>
#import "GTMBase64.h"


@implementation BaseMsgVC {
    
    UITapGestureRecognizer *TapOne;
    UITapGestureRecognizer *TapTwo;
    NSInteger imgtag;
    UIImageView *CertImg;
    UIImageView *CertBackImg;
    BOOL isFirst;
    BOOL isSecond;
    UIButton *Commit;
    UITableView *table;
    CLLocationManager *maneger;
    CLGeocoder *geocoder;
    NSString *imgUrl;
    NSString *imgUrlBack;
    NSUserDefaults *user;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    [table reloadData];
    NSLog(@"城市:%@",[BusiIntf curPayOrder].cityName);
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"基本信息";
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] init];
    left.title = @"返回";
    self.navigationItem.backBarButtonItem = left;
    isFirst = NO;
    isSecond = NO;
    //背景
    UIImageView *backImg = [[UIImageView alloc] init];
    backImg.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    backImg.backgroundColor = LightGrayColor;
    backImg.userInteractionEnabled = YES;
    [self.view addSubview:backImg];
    self.tag = 1;
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, KscreenWidth, KscreenHeight) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
//    table.showsHorizontalScrollIndicator = YES;
//    table.showsVerticalScrollIndicator = YES;
    [self.view addSubview:table];
    
    UIImageView *footView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 160)];
    footView.backgroundColor = LightGrayColor;
    footView.userInteractionEnabled = YES;
    Commit = [[UIButton alloc] init];
    [Commit setTitle:@"提交" forState:UIControlStateNormal];
    [Commit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Commit.backgroundColor = RedColor;
    Commit.layer.cornerRadius = 3.5;
    Commit.layer.masksToBounds = YES;
    [Commit addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    //如果信息不能修改不能点击
    //[BusiIntf curPayOrder].isBase = @"2";
    if ([[BusiIntf curPayOrder].isEdit isEqualToString:@"1"]) {
        //如果不能编辑 隐藏按钮
        Commit.hidden = YES;
        Commit.enabled = NO;
        Commit.backgroundColor = [UIColor colorWithRed:239/255.0 green:53/255.0 blue:76/255.0 alpha:0.8];
    }
    //Commit.enabled = NO;
    [footView addSubview:Commit];
    Commit.sd_layout.leftSpaceToView(footView,14).topSpaceToView(footView,41).rightSpaceToView(footView,14).heightIs(44);
    
    table.tableFooterView = footView;
    
    TapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TakePhoto:)];
    TapOne.numberOfTapsRequired = 1;
    
    TapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TakePhoto:)];
    TapTwo.numberOfTapsRequired = 1;
    
    //定位
    maneger = [[CLLocationManager alloc] init];
    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//        [maneger requestWhenInUseAuthorization];
//    }
    
    maneger.delegate = self;
    //maneger.desiredAccuracy = kCLLocationAccuracyBest;
    maneger.distanceFilter = 10;
    // [maneger requestAlwaysAuthorization];
    [maneger requestWhenInUseAuthorization];
    //如果城市为空，则开始定位
    if ([[BusiIntf curPayOrder].city isEqualToString:@""]) {
        
        [maneger startUpdatingLocation];
    }
    geocoder = [[CLGeocoder alloc] init];
    user = [NSUserDefaults standardUserDefaults];
    [BusiIntf curPayOrder].cityName = [BusiIntf curPayOrder].city;
    //table.userInteractionEnabled = NO;
}
//提交
- (void)commit {
//    if (!(isSecond && isFirst)) {
//        [self alert:@"请先上传照片!"];
//        return;
//    }
    
    UITextField *fldOne = [self.view viewWithTag:10001];
    UITextField *fldTwo = [self.view viewWithTag:10002];
    if ([fldOne.text isEqualToString:@""] || [fldTwo.text isEqualToString:@""]) {
        [self alert:@"请填写完整信息!"];
        return;
    }else if ([[BusiIntf curPayOrder].ProName isEqualToString:@""] || [BusiIntf curPayOrder].ProName == nil || [[BusiIntf curPayOrder].cityName isEqualToString:@""] || [BusiIntf curPayOrder].cityName == nil) {
        [self alert:@"请打开定位或选择城市"];
        return;
    }
    [self RequestForBaseMsg:fldOne.text CardId:fldTwo.text Pro:[BusiIntf curPayOrder].ProName City:[BusiIntf curPayOrder].cityName];
    
    NSLog(@"上传照片!!!");
}

- (void)TakePhoto:(UITapGestureRecognizer *)sender {
    
    UIImageView *ImgView = (UIImageView *)[sender view];
    imgtag = ImgView.tag;
    NSLog(@"%ld",(long)imgtag);
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentModalViewController:picker animated:YES];
        //[self presentViewController:picker animated:YES completion:nil];
        
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有摄像头" delegate:nil cancelButtonTitle:@"知道" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissModalViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:nil];
//    UIImage *newImage = [self imageWithImageSimple:image scaledToSize:CGSizeMake((KscreenWidth-60)*2, 180*2)];
//    NSData *data = UIImageJPEGRepresentation(newImage, 1);
    NSString *imagebase = [GTMBase64 stringByEncodingData:UIImageJPEGRepresentation(image, 0.5)];
    NSString *ImageStr2 = [NSString stringWithFormat:@"%@%@",@"data:image/jpg;base64,",imagebase];
    switch (imgtag) {
        case 1001:
            CertImg.image = image;
            isFirst = YES;
            [self RequestForBaseMsg:ImageStr2 PicNbr:@"1"];
            break;
            
        case 1002:
            CertBackImg.image = image;
            isSecond = YES;
            [self RequestForBaseMsg:ImageStr2 PicNbr:@"2"];
            break;
        default:
            break;
    }
//    if (isFirst && isSecond) {
//        Commit.enabled = YES;
//    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 7.7;
    }
    if (indexPath.row == 3 || indexPath.row == 5) {
        return 16;
    }
    if (indexPath.row == 7) {
        return 0.5;
    }
    if (indexPath.row == 8) {
        return 155;
    }else {
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     NSString *identy = [NSString stringWithFormat:@"cell_%ld",(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        if (indexPath.row == 0 || indexPath.row == 3 || indexPath.row == 5) {
            ViewsCell *Cell = [[ViewsCell alloc] init];
            Cell.contentView.backgroundColor = LightGrayColor;
            cell = Cell;
        }
        if (indexPath.row == 1) {
            BaseMsgCell *Cell = [[BaseMsgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
            Cell.leftLab.text = @"姓名";
            Cell.rightFld.placeholder = @"请填写姓名";
            if ([[BusiIntf curPayOrder].isEdit isEqualToString:@"0"]) {
                Cell.rightFld.text = [[BusiIntf curPayOrder].shopName stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            } else if ([[BusiIntf curPayOrder].isEdit isEqualToString:@"1"]) {
                Cell.rightFld.text = [[BusiIntf curPayOrder].shopName stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                Cell.rightFld.enabled = NO;
            }
            //Cell.rightFld.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            Cell.rightFld.tag = 10001;
            cell = Cell;
        }
        if (indexPath.row == 2) {
            BaseMsgCell *Cell = [[BaseMsgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
            Cell.leftLab.text = @"身份证";
            if ([[BusiIntf curPayOrder].isBase isEqualToString:@"1"]) {
                Cell.rightFld.text = [BusiIntf curPayOrder].shopCard;
            }else if ([[BusiIntf curPayOrder].isBase isEqualToString:@"2"]) {
                Cell.rightFld.text = [BusiIntf curPayOrder].shopCard;
                Cell.rightFld.enabled = NO;
            }
            Cell.rightFld.placeholder = @"请填写身份证号";
            //Cell.rightFld.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            Cell.rightFld.tag = 10002;
            cell = Cell;
        }
        if (indexPath.row == 4) {
            LocationCell *Cell = [[LocationCell alloc] init];
            Cell.leftLab.text = @"所在城市";
            if ([[BusiIntf curPayOrder].cityName isEqualToString:@""] || [BusiIntf curPayOrder].cityName == nil) {
                Cell.rightLab.text = @"";
            }else {
                Cell.rightLab.text = [[BusiIntf curPayOrder].cityName stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            }
            Cell.rightLab.tag = 10003;
            Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell = Cell;
        }
        if (indexPath.row == 6) {
            LocationCell *Cell = [[LocationCell alloc] init];
            Cell.leftLab.text = @"身份证照片";
            if ([[BusiIntf curPayOrder].httpPath1 isEqualToString:@""] && [[BusiIntf curPayOrder].httpPath2 isEqualToString:@""]) {
                Cell.rightLab.text = @"未上传";
            }else {
                Cell.rightLab.text = @"已上传";
            }
            Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell = Cell;
        }
        if (indexPath.row == 8) {
            TDEmpotyCell *Cell = [[TDEmpotyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
            
            CertImg = [[UIImageView alloc] init];
            imgUrl = [user objectForKey:@"imgUrl"];
            imgUrlBack = [user objectForKey:@"imgUrlback"];
            if ([[BusiIntf curPayOrder].httpPath1 isEqualToString:@""] ) {
                CertImg.image = [UIImage imageNamed:@"照片.png"];
            }else {
                CertImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[BusiIntf curPayOrder].httpPath1]]];
            }
            
            [CertImg addGestureRecognizer:TapOne];
            CertImg.tag = 1001;
            CertImg.userInteractionEnabled = YES;
            [Cell.contentView addSubview:CertImg];
            CertImg.sd_layout.leftSpaceToView(Cell.contentView,20).topSpaceToView(Cell.contentView,19).widthIs(118.5).heightIs(75);
            UILabel *Lab = [[UILabel alloc] init];
            Lab.text = @"身份证正面照";
            Lab.textColor = TextColor;
            Lab.textAlignment = NSTextAlignmentCenter;
            Lab.font = [UIFont systemFontOfSize:12];
            [Cell.contentView addSubview:Lab];
            Lab.sd_layout.centerXEqualToView(CertImg).widthIs(120).topSpaceToView(Cell.contentView,104.5).heightIs(13);
            
            CertBackImg = [[UIImageView alloc] init];
            //CertBackImg.backgroundColor = [UIColor orangeColor];
            
            
            if ([[BusiIntf curPayOrder].httpPath2 isEqualToString:@""] ) {
                CertBackImg.image = [UIImage imageNamed:@"照片.png"];
            }else {
                CertBackImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[BusiIntf curPayOrder].httpPath2]]];
            }
            [CertBackImg addGestureRecognizer:TapTwo];
            CertBackImg.tag = 1002;
            CertBackImg.userInteractionEnabled = YES;
            [Cell.contentView addSubview:CertBackImg];
            CertBackImg.sd_layout.rightSpaceToView(Cell.contentView,20).topSpaceToView(Cell.contentView,19).widthIs(118.5).heightIs(75);
            UILabel *BackLab = [[UILabel alloc] init];
            BackLab.text = @"身份证背面照";
            BackLab.textColor = TextColor;
            BackLab.textAlignment = NSTextAlignmentCenter;
            BackLab.font = [UIFont systemFontOfSize:12];
            [Cell.contentView addSubview:BackLab];
            BackLab.sd_layout.centerXEqualToView(CertBackImg).widthIs(120).topSpaceToView(Cell.contentView,104.5).heightIs(13);
            cell = Cell;
        }
    }
    //cell.editing = NO;
    //cell.selected = NO;
    if ([[BusiIntf curPayOrder].isEdit isEqualToString:@"1"]) {
        cell.contentView.userInteractionEnabled = NO;
        cell.userInteractionEnabled = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 4) {
        
        SelectProVC *SelectPro = [[SelectProVC alloc] init];
        [self.navigationController pushViewController:SelectPro animated:YES];
        
    }
}

#define  mark - 定位协议方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [SVProgressHUD show];
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
            [BusiIntf curPayOrder].Location = [placemark.addressDictionary[@"FormattedAddressLines"] objectAtIndex:0];
            [table reloadData];
            [SVProgressHUD dismiss];
        }
        if (error) {
            NSLog(@"获取失败：%@",error);
            [self alert:@"请打开网络"];
            [SVProgressHUD dismiss];
        }
        
    }];
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (error.code == kCLErrorDenied) {
        NSLog(@"%@",error);
    }
}
#define mark -

//上传图片
- (void)RequestForBaseMsg:(NSString *)imageBase64 PicNbr:(NSString *)picNbr {
    
    //NSString *url = BaseUrl;
    //修改上传图片端口(2.16)
    NSString *url = @"http://pic.wujieapp.net/post/kv";
    user = [NSUserDefaults standardUserDefaults];
    
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *md5 = [NSString stringWithFormat:@"%@%@",picNbr,key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                           @"picNbr":picNbr,
                           @"picBase64":imageBase64,
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"ShopPicInfo",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    //NSLog(@"参数：%@",params);
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSDictionary *dicc = [result JSONValue];
        //NSString *code = dicc[@"code"];
        NSString *content = dicc[@"content"];
        if([content isEqualToString:@"正常"]) {
            content = @"上传成功!";
        }
        [self alert:content];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"网络申请失败:%@",error);
        [SVProgressHUD dismiss];
    }];
}
//基本信息上传
- (void)RequestForBaseMsg:(NSString *)shopName CardId:(NSString*)picNbr Pro:(NSString *)pro City:(NSString *)city {
    
    NSString *url = BaseUrl;
    user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *md5 = [NSString stringWithFormat:@"%@%@%@",[shopName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],picNbr,key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                           @"shopName":[shopName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                           @"shopCard":picNbr,
                           @"shortName":[@"" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                           @"prov":[pro stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                           @"city":[city stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"ShopBaseInfo",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSDictionary *dicc = [result JSONValue];
        NSLog(@"返回数据：%@",dicc);
        NSString *code = dicc[@"code"];
        NSString *content = dicc[@"content"];
        //NSString *content = dicc[@"content"];
        if ([code isEqualToString:@"000000"]) {
            [self alert:@"提交成功!"];
        }else {
            [self alert:content];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"网络申请失败:%@",error);
        [SVProgressHUD dismiss];
    }];
}
//压缩图片
- (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
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

#define mark - 提示信息
- (void)alert:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    [self.view endEditing:YES];
//    
//}
@end
