//
//  AccountMsg.m
//  wujieNew
//
//  Created by rongfeng on 15/12/23.
//  Copyright © 2015年 rongfeng. All rights reserved.
//

#import "AccountMsg.h"
#import "Common.h"
#import "TDMegCell.h"
#import "TDViewsCell.h"
#import "BusiIntf.h"
#import "AuthCertifyVC.h"
#import "WalletVC.h"
#import "IBHttpTool.h"
#import "SBJSON.h"
#import <CommonCrypto/CommonDigest.h>
#import "SVProgressHUD.h"

@implementation AccountMsg {
    
    TDMegCell *_Cell;
    UIImageView *LineOne;
    UIImageView *LineTwo;
    UIImageView *LineThird;
    UIImageView *LineFour;
    UIImageView *LineFive;
    UIImageView *LineSix;
    NSUserDefaults *user;
    UITableView *table;
}

-(void)viewWillAppear:(BOOL)animated
{
    //隐藏导航栏
    self.navigationController.navigationBarHidden = NO;
    //隐藏工具栏
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = DrackBlue;
    [self RequestForBaseInfo];
}

- (void)viewDidLoad {
    
    self.title = @"个人信息";
  
    UIBarButtonItem *left = [[UIBarButtonItem alloc] init];
    left.title = @"返回";
    self.navigationItem.backBarButtonItem = left;
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 15;
    }
    if (indexPath.row == 1) {
        return 65;
    }
    if (indexPath.row == 2 || indexPath.row == 5) {
        return 15;
    }if (indexPath.row == 7) {
        return 0;
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
            TDViewsCell *Cell = [[TDViewsCell alloc] init];
            LineOne.frame = CGRectMake(0, 14, KscreenWidth, 1);
            [Cell.contentView addSubview:LineOne];
            cell = Cell;
        }
        if (indexPath.row == 1) {
            _Cell = [[TDMegCell alloc] init];
            _Cell.LeftLable.text = @"头像";
            _Cell.RightLabel.hidden = YES;
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSData *DATA = [user objectForKey:@"TXImage"];
            UIImage *image = [UIImage imageWithData:[user objectForKey:@"TXImage"]];
            if (DATA) {
                _Cell.ImageView.image = image;
            }else {
                _Cell.ImageView.image = [UIImage imageNamed:@"椭圆-8@2x.png"];
            }
            LineTwo.frame = CGRectMake(0, 64.5, KscreenWidth, 1);
            [_Cell.contentView addSubview:LineTwo];
            cell = _Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row == 2 ) {
            TDViewsCell *Cell = [[TDViewsCell alloc] init];
            LineThird.frame = CGRectMake(0, 14, KscreenWidth, 1);
            [Cell.contentView addSubview:LineThird];
            cell = Cell;
        }
        if (indexPath.row == 3) {
            TDMegCell *Cell = [[TDMegCell alloc] init];
            Cell.ImageView.hidden = YES;
            Cell.RightLabel.text = [BusiIntf getUserInfo].UserName;
            Cell.LeftLable.text = @"账号";
            cell = Cell;
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row == 4) {
            TDMegCell *Cell = [[TDMegCell alloc] init];
            Cell.ImageView.hidden = YES;
            if ([[BusiIntf curPayOrder].isRealName isEqualToString:@"1"]) {
                Cell.RightLabel.text = @"已认证";
            }else {
                Cell.RightLabel.text = @"未认证";
            }
            Cell.LeftLable.text = @"实名认证";
            LineFour.frame = CGRectMake(0, 44.5, KscreenWidth, 1);
            [Cell.contentView addSubview:LineFour];
            cell = Cell;
        }
        if (indexPath.row == 5) {
            TDViewsCell *Cell = [[TDViewsCell alloc] init];
            LineFive.frame = CGRectMake(0, 14, KscreenWidth, 1);
            [Cell.contentView addSubview:LineFive];
            cell = Cell;
        }
        if (indexPath.row == 6) {
            TDMegCell *Cell = [[TDMegCell alloc] init];
            Cell.LeftLable.text = @"我的地址";
            Cell.ImageView.hidden = YES;
            Cell.RightLabel.hidden = YES;
            LineSix.frame = CGRectMake(0, 44.5, KscreenWidth, 1);
            [Cell.contentView addSubview:LineSix];
            cell = Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
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
    if (indexPath.row == 4) {
        AuthCertifyVC *Auth = [[AuthCertifyVC alloc] init];
        [self.navigationController pushViewController:Auth animated:YES];
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
    
}
//获取商户基本信息状态
- (void)RequestForBaseInfo {
    
    [SVProgressHUD show];
    NSString *url = BaseUrl;
    user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *md5 = [NSString stringWithFormat:@"%@%@",token,key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"ShopInfoQuery",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    //NSLog(@"参数：%@",params);
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSDictionary *dicc = [result JSONValue];
        NSLog(@"返回数据：%@",dicc);
        [BusiIntf curPayOrder].bankAccont = dicc[@"bankAccount"];
        [BusiIntf curPayOrder].bankName2 = dicc[@"bankName"];
        [BusiIntf curPayOrder].bankNumber = dicc[@"bankNumber"];
        [BusiIntf curPayOrder].city = dicc[@"city"];
        [BusiIntf curPayOrder].httpPath1 = dicc[@"httpPath1"];
        [BusiIntf curPayOrder].httpPath2 = dicc[@"httpPath2"];
        [BusiIntf curPayOrder].httpPath3 = dicc[@"httpPath3"];
        [BusiIntf curPayOrder].httpPath4 = dicc[@"httpPath4"];
        [BusiIntf curPayOrder].isBank = dicc[@"isBank"];
        [BusiIntf curPayOrder].isBase = dicc[@"isBase"];
        [BusiIntf curPayOrder].isOrg = dicc[@"isOrg"];
        [BusiIntf curPayOrder].isEdit = dicc[@"isEdit"];
        [BusiIntf curPayOrder].prov = dicc[@"prov"];
        [BusiIntf curPayOrder].selfStatus = dicc[@"selfStatus"];
        [BusiIntf curPayOrder].shopCard = dicc[@"shopCard"];
        [BusiIntf curPayOrder].shopName = dicc[@"shopName"];
        [BusiIntf curPayOrder].shopStatus = dicc[@"shopStatus"];
        [BusiIntf curPayOrder].shortName = dicc[@"shortName"];
        [BusiIntf curPayOrder].isRealName = dicc[@"isRealName"];
        [BusiIntf curPayOrder].orgCode = dicc[@"orgCode"];
        
        [table reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"网络申请失败:%@",error);
        [SVProgressHUD dismiss];
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
