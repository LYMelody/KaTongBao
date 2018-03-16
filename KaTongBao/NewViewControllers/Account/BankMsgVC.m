//
//  BankMsgVC.m
//  wujieNew
//
//  Created by rongfeng on 16/1/11.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "BankMsgVC.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "ViewsCell.h"
#import "LocationCell.h"
#import "BaseMsgCell.h"
#import "TDEmpotyCell.h"
#import "BankSelectVC.h"
#import "BusiIntf.h"
#import "IBHttpTool.h"
#import "SBJSON.h"
#import <CommonCrypto/CommonDigest.h>
#import "SVProgressHUD.h"
#import "GTMBase64.h"
@implementation BankMsgVC {
    
    NSInteger imgtag;
    UIImageView *CertImg;
    UIImageView *CertBackImg;
    BOOL isFirst;
    BOOL isSecond;
    UITapGestureRecognizer *TapOne;
    UITapGestureRecognizer *TapTwo;
    UIButton *Commit;
    UITableView *table;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];

    //[table reloadData];
    [self RequestForBaseInfo];
    UILabel *bankNameLab = [self.view viewWithTag:10005];
    if ( ![[BusiIntf curPayOrder].bankname isEqualToString:@""] && !([BusiIntf curPayOrder].bankname == nil) && !([BusiIntf curPayOrder].bankname == [BusiIntf curPayOrder].bankName2)) {
        [BusiIntf curPayOrder].bankname = [BusiIntf curPayOrder].bankname;
    }else {
        [BusiIntf curPayOrder].bankname = [BusiIntf curPayOrder].bankName2;
    }
    //[BusiIntf curPayOrder].bankname = [BusiIntf curPayOrder].bankName2;
    NSLog(@"银行：%@",[BusiIntf curPayOrder].bankname);
    if ([[BusiIntf curPayOrder].bankname isEqualToString:@""] || [BusiIntf curPayOrder].bankname == nil) {
        bankNameLab.text = @"请选择";
    } else {
        bankNameLab.text = [BusiIntf curPayOrder].bankname;
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"银行卡信息";
    self.view.backgroundColor = [UIColor whiteColor];
    //背景
    UIImageView *backImg = [[UIImageView alloc] init];
    backImg.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    backImg.backgroundColor = LightGrayColor;
    backImg.userInteractionEnabled = YES;
    [self.view addSubview:backImg];
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] init];
    left.title = @"返回";
    self.navigationItem.backBarButtonItem = left;

    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, KscreenWidth, KscreenHeight) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
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
    //银行卡信息不能修改则不能点击
    //[BusiIntf curPayOrder].isBank = @"2";
    if ([[BusiIntf curPayOrder].isEdit isEqualToString:@"1"]) {
        //如果不能点击则隐藏按钮
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
    
}
//上传银行卡信息
- (void)commit {
    
    UILabel *bankNameLab = [self.view viewWithTag:10005];
    UITextField *bankAccountFld = [self.view viewWithTag:10007];
    UITextField *bankNumberLab = [self.view viewWithTag:10006];
    [self RequestForBankQure:[bankNumberLab.text stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ] BankName:[bankNameLab.text stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] BankAccount:[bankAccountFld.text stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ]];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 8;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 16;
    } else if (indexPath.row == 4){
        return 18;
    } else if (indexPath.row == 6) {
        return 0.5;
    } else if (indexPath.row == 7) {
        return 140;
    } else {
        return 45;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identy = [NSString stringWithFormat:@"cell_%ld",(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
        
        ViewsCell *Cell = [[ViewsCell alloc] init];
        LocationCell *Locationcell = [[LocationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
        BaseMsgCell *baseCell = [[BaseMsgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
        TDEmpotyCell *emptyCell = [[TDEmpotyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
        CertImg = [[UIImageView alloc] init];
        UILabel *Lab = [[UILabel alloc] init];
        CertBackImg = [[UIImageView alloc] init];
        UILabel *BackLab = [[UILabel alloc] init];
        switch (indexPath.row) {
            case 0:
                cell = Cell;
                cell.contentView.backgroundColor = LightGrayColor;
                break;
             case 1:
                Locationcell.leftLab.text = @"到账银行卡";
                Locationcell.rightLab.width = 260;
                Locationcell.rightLab.tag = 10005;
                Locationcell.rightLab.textAlignment = NSTextAlignmentRight;
                if ([[BusiIntf curPayOrder].bankname isEqualToString:@""] || [BusiIntf curPayOrder].bankname == nil) {
                    Locationcell.rightLab.text = @"请选择";
                } else {
                    Locationcell.rightLab.text = [BusiIntf curPayOrder].bankname;
                }
                Locationcell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell = Locationcell;
                break;
            case 2:
                baseCell.leftLab.text = @"卡号";
//                if ([Locationcell.rightLab.text isEqualToString:@"请选择"]) {
//                    baseCell.rightFld.enabled = NO;
//                } else {
//                    baseCell.rightFld.enabled = YES;
//                }
                baseCell.rightFld.placeholder = @"请输入卡号";
                if ([[BusiIntf curPayOrder].isBank isEqualToString:@"1"]) {
                    baseCell.rightFld.text = [BusiIntf curPayOrder].bankNumber;
                } else if ([[BusiIntf curPayOrder].isBank isEqualToString:@"2"]) {
                    baseCell.rightFld.text = [BusiIntf curPayOrder].bankNumber;
                    baseCell.rightFld.enabled = NO;
                }
                baseCell.rightFld.tag = 10006;
                cell = baseCell;
                break;
            case 3:
                baseCell.leftLab.text = @"户名";
                if ([[BusiIntf curPayOrder].isBank isEqualToString:@"1"]) {
                    baseCell.rightFld.text = [BusiIntf curPayOrder].bankAccont;
                } else if ([[BusiIntf curPayOrder].isBank isEqualToString:@"2"]) {
                    baseCell.rightFld.text = [BusiIntf curPayOrder].bankAccont;
                    baseCell.rightFld.enabled = NO;
                }
                baseCell.rightFld.placeholder = @"请输入户名";
                baseCell.rightFld.tag = 10007;
                cell = baseCell;
                break;
            case 4:
                cell = Cell;
                cell.contentView.backgroundColor = LightGrayColor;
                break;
            case 5:
                Locationcell.leftLab.text = @"银行卡拍照";
                
                if ([[BusiIntf curPayOrder].httpPath3 isEqualToString:@""] && [[BusiIntf curPayOrder].httpPath4 isEqualToString:@""]) {
                    Locationcell.rightLab.text = @"未上传";
                }else {
                    Locationcell.rightLab.text = @"已上传";
                }
                cell = Locationcell;
                break;
            case 6:
                cell = Cell;
                cell.contentView.backgroundColor = LightGrayColor;
                break;
            case 7:
                
                [CertImg addGestureRecognizer:TapOne];
                CertImg.tag = 1003;
                CertImg.userInteractionEnabled = YES;
                [emptyCell.contentView addSubview:CertImg];
                CertImg.sd_layout.leftSpaceToView(emptyCell.contentView,20).topSpaceToView(emptyCell.contentView,19).widthIs(118.5).heightIs(75);
                if ([[BusiIntf curPayOrder].httpPath3 isEqualToString:@""] || [BusiIntf curPayOrder].httpPath3 == nil) {
                    CertImg.image = [UIImage imageNamed:@"照片.png"];
                } else {
                    CertImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[BusiIntf curPayOrder].httpPath3]]];
                    NSLog(@"#@#@#@#@#%@",[BusiIntf curPayOrder].httpPath3);
                }
                Lab.text = @"银行卡正面照";
                Lab.textColor = TextColor;
                Lab.textAlignment = NSTextAlignmentCenter;
                Lab.font = [UIFont systemFontOfSize:12];
                [emptyCell.contentView addSubview:Lab];
                Lab.sd_layout.centerXEqualToView(CertImg).widthIs(120).topSpaceToView(emptyCell.contentView,104.5).heightIs(13);
        
                CertBackImg.image = [UIImage imageNamed:@"照片.png"];
                [CertBackImg addGestureRecognizer:TapTwo];
                CertBackImg.tag = 1004;
                CertBackImg.userInteractionEnabled = YES;
                [emptyCell.contentView addSubview:CertBackImg];
                CertBackImg.sd_layout.rightSpaceToView(emptyCell.contentView,20).topSpaceToView(emptyCell.contentView,19).widthIs(118.5).heightIs(75);
                if ([[BusiIntf curPayOrder].httpPath4 isEqualToString:@""] || [BusiIntf curPayOrder].httpPath4 == nil) {
                    CertBackImg.image = [UIImage imageNamed:@"照片.png"];
                } else {
                    CertBackImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[BusiIntf curPayOrder].httpPath4]]];
                }
                BackLab.text = @"手持身份证和银行卡正面照";
                BackLab.numberOfLines = 0;
                BackLab.textColor = TextColor;
                BackLab.textAlignment = NSTextAlignmentCenter;
                BackLab.font = [UIFont systemFontOfSize:12];
                [emptyCell.contentView addSubview:BackLab];
                BackLab.sd_layout.centerXEqualToView(CertBackImg).widthIs(120).topSpaceToView(emptyCell.contentView,104.5).heightIs(40);
                cell = emptyCell;
                break;
            default:
                break;
        }
    }
    if ([[BusiIntf curPayOrder].isEdit isEqualToString:@"1"]) {
        cell.contentView.userInteractionEnabled = NO;
        cell.userInteractionEnabled = NO;
    }
    return cell;
}

- (void)TakePhoto:(UITapGestureRecognizer *)sender {
    
    UIImageView *ImgView = (UIImageView *)[sender view];
    imgtag = ImgView.tag;
    NSLog(@"%d",imgtag);
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentModalViewController:picker animated:YES];
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
        case 1003:
            CertImg.image = image;
            isFirst = YES;
            [self RequestForBaseMsg:ImageStr2 PicNbr:@"3"];
            break;
            
        case 1004:
            CertBackImg.image = image;
            isSecond = YES;
            [self RequestForBaseMsg:ImageStr2 PicNbr:@"4"];
            break;
        default:
            break;
    }
    //    if (isFirst && isSecond) {
    //        Commit.enabled = YES;
    //    }
}
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:YES];
    //[BusiIntf curPayOrder].bankname = @"请选择";
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        
        BankSelectVC *selectVC = [[BankSelectVC alloc] init];
        [self.navigationController  pushViewController:selectVC animated:YES];
    }
}

//上传图片
- (void)RequestForBaseMsg:(NSString *)imageBase64 PicNbr:(NSString *)picNbr {
    //修改上传图片端口(2.16)
    [SVProgressHUD show];
    NSString *url = @"http://pic.wujieapp.net/post/kv";
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
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
        NSLog(@"返回数据：%@",dicc);
        NSString *content = dicc[@"content"];
        //保存上传的图片url
        //        if ([picNbr isEqualToString:@"1"]) {
        //            [user setObject:dicc[@"httpPath"] forKey:@"imgUrl"];
        //        } else {
        //            [user setObject:dicc[@"httpPath"] forKey:@"imgUrlback"];
        //        }
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
//上传银行卡信息
- (void)RequestForBankQure:(NSString *)bankNumber BankName:(NSString *)bankName BankAccount:(NSString *)bankAccount {
    [SVProgressHUD show];
    NSString *url = BaseUrl;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *md5 = [NSString stringWithFormat:@"%@%@",bankNumber,key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                           @"bankNumber":bankNumber,
                           @"bankName":[bankName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                           @"bankAccount":[bankAccount stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"ShopBankInfo",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    //NSLog(@"参数：%@",params);
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSDictionary *dicc = [result JSONValue];
        NSLog(@"返回数据：%@",dicc);
        
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
//获取商户基本信息状态
- (void)RequestForBaseInfo {
    
    [SVProgressHUD show];
    NSString *url = BaseUrl;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
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
        [BusiIntf curPayOrder].prov = dicc[@"prov"];
        [BusiIntf curPayOrder].selfStatus = dicc[@"selfStatus"];
        [BusiIntf curPayOrder].shopCard = dicc[@"shopCard"];
        [BusiIntf curPayOrder].shopName = dicc[@"shopName"];
        [BusiIntf curPayOrder].shopStatus = dicc[@"shopStatus"];
        [BusiIntf curPayOrder].shortName = dicc[@"shortName"];
        [table reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"网络申请失败:%@",error);
        [SVProgressHUD dismiss];
    }];
}
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
