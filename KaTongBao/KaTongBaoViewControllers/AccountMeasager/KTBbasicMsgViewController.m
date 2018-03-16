//
//  KTBbasicMsgViewController.m
//  KaTongBao
//
//  Created by rongfeng on 16/6/29.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "KTBbasicMsgViewController.h"
#import "macro.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "BaseMsgCell.h"
#import "SVProgressHUD.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonDigest.h>
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "BusiIntf.h"
#import "SJAvatarBrowser.h"
@interface KTBbasicMsgViewController ()

@end

@implementation KTBbasicMsgViewController {
    NSString *Name;
    NSString *CertNumber;
    NSString *BankNumber;
    NSUserDefaults *user;
    NSInteger currentTag;
    NSString *pic1;
    NSString *pic2;
    NSString *pic3;
    NSString *pic4;
    UITableView *table;
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

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册信息";
    pic1 = [BusiIntf curPayOrder].httpPath1;
    pic2 = [BusiIntf curPayOrder].httpPath2;
    pic3 = [BusiIntf curPayOrder].httpPath3;
    pic4 = [BusiIntf curPayOrder].httpPath4;
    table = [[UITableView alloc] init];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = LightGrayColor;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.showsVerticalScrollIndicator  = NO;
    //如果有认证不通过的信息加上headerView
    if (![[BusiIntf curPayOrder].showMsg isEqualToString:@""]) {
        UILabel *TipsLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 45)];
        TipsLab.backgroundColor = RedColor;
        TipsLab.textAlignment = NSTextAlignmentCenter;
        TipsLab.font = [UIFont systemFontOfSize:14];
        TipsLab.text = [BusiIntf curPayOrder].showMsg;
        TipsLab.textColor = [UIColor whiteColor];
        TipsLab.adjustsFontSizeToFitWidth = YES;
        TipsLab.numberOfLines = 0;
        table.tableHeaderView = TipsLab;
    }else {
        
    }
    
    UIImageView *footView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight )];
    footView.userInteractionEnabled = YES;
    footView.backgroundColor = LightGrayColor;
    
    //提示信息
    UILabel *tipsLab = [[UILabel alloc] init];
    tipsLab.text = @"身份证/银行卡正反面照片";
    tipsLab.backgroundColor = [UIColor clearColor];
    tipsLab.font = [UIFont systemFontOfSize:16];
    tipsLab.textAlignment = NSTextAlignmentLeft;
    [footView addSubview:tipsLab];
    tipsLab.sd_layout.leftSpaceToView(footView,20).topSpaceToView(footView,20).widthIs(200).heightIs(15);
    //四张照片白色背景
    UIImageView *backWhiteImg = [[UIImageView alloc] init];
    backWhiteImg.backgroundColor = [UIColor whiteColor];
    backWhiteImg.userInteractionEnabled = YES;
    [footView addSubview:backWhiteImg];
    backWhiteImg.sd_layout.leftSpaceToView(footView,0).topSpaceToView(tipsLab,10).widthIs(KscreenWidth).heightIs(260);
    //身份证正面照
    UIButton *CertFrontBtn = [[UIButton alloc] init];
    [CertFrontBtn setBackgroundImage:[UIImage imageNamed:@"点击上传.png"] forState:UIControlStateNormal];
    if (![pic1 isEqualToString:@""]) {
        [CertFrontBtn setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[BusiIntf curPayOrder].httpPath1]]] forState:UIControlStateNormal];
    }
    CertFrontBtn.tag = 1000;
    CertFrontBtn.layer.cornerRadius = 3;
    [CertFrontBtn addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [backWhiteImg addSubview:CertFrontBtn];
    
    UILabel *certlab = [[UILabel alloc] init];
    certlab.text = @"身份证正面照";
    certlab.font = [UIFont systemFontOfSize:14];
    certlab.textAlignment = NSTextAlignmentCenter;
    [backWhiteImg addSubview:certlab];
    CertFrontBtn.sd_layout.leftSpaceToView(backWhiteImg,16).topSpaceToView(backWhiteImg,16).widthIs(KscreenWidth/2-20).heightIs((KscreenWidth/2-10)/16*9);
    certlab.sd_layout.centerXEqualToView(CertFrontBtn).topSpaceToView(CertFrontBtn,10).widthIs(CertFrontBtn.width).heightIs(15);
    
    //身份证背面照
    UIButton *CertBackBtn = [[UIButton alloc] init];
    [CertBackBtn setBackgroundImage:[UIImage imageNamed:@"点击上传.png"] forState:UIControlStateNormal];
    if (![pic2 isEqualToString:@""]) {
        [CertBackBtn setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[BusiIntf curPayOrder].httpPath2]]] forState:UIControlStateNormal];
    }
    CertBackBtn.tag = 1001;
    CertBackBtn.layer.cornerRadius = 3;
    [CertBackBtn addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [backWhiteImg addSubview:CertBackBtn];
    
    
    UILabel *certbacklab = [[UILabel alloc] init];
    certbacklab.text = @"身份证反面照";
    certbacklab.font = [UIFont systemFontOfSize:14];
    certbacklab.textAlignment = NSTextAlignmentCenter;
    [backWhiteImg addSubview:certbacklab];
    
    CertBackBtn.sd_layout.rightSpaceToView(backWhiteImg,16).topSpaceToView(backWhiteImg,16).widthIs(KscreenWidth/2-20).heightIs((KscreenWidth/2-10)/16*9);
    certbacklab.sd_layout.centerXEqualToView(CertBackBtn).topSpaceToView(CertBackBtn,10).widthIs(CertBackBtn.width).heightIs(15);
    
    //银行卡正面照
    UIButton *BankForntBtn = [[UIButton alloc] init];
    [BankForntBtn setBackgroundImage:[UIImage imageNamed:@"点击上传.png"] forState:UIControlStateNormal];
    if (![pic3 isEqualToString:@""]) {
        [BankForntBtn setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[BusiIntf curPayOrder].httpPath3]]] forState:UIControlStateNormal];
    }
    BankForntBtn.tag = 1002;
    BankForntBtn.layer.cornerRadius = 3;
    [BankForntBtn addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [backWhiteImg addSubview:BankForntBtn];
    
    UILabel *banklab = [[UILabel alloc] init];
    banklab.text = @"银行卡正面照";
    banklab.font = [UIFont systemFontOfSize:14];
    banklab.textAlignment = NSTextAlignmentCenter;
    [backWhiteImg addSubview:banklab];
    BankForntBtn.sd_layout.leftSpaceToView(backWhiteImg,16).topSpaceToView(backWhiteImg,140).widthIs(KscreenWidth/2-20).heightIs((KscreenWidth/2-10)/16*9);
    banklab.sd_layout.centerXEqualToView(BankForntBtn).topSpaceToView(BankForntBtn,10).widthIs(BankForntBtn.width).heightIs(15);
    //手持身份证半身照
    UIButton *HoldCertBtn = [[UIButton alloc] init];
    [HoldCertBtn setBackgroundImage:[UIImage imageNamed:@"点击上传.png"] forState:UIControlStateNormal];
    if (![pic4 isEqualToString:@""]) {
        [HoldCertBtn setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[BusiIntf curPayOrder].httpPath4]]] forState:UIControlStateNormal];
    }
    HoldCertBtn.tag = 1003;
    HoldCertBtn.layer.cornerRadius = 3;
    [HoldCertBtn addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [backWhiteImg addSubview:HoldCertBtn];
    
    
    UILabel *Holdcertlab = [[UILabel alloc] init];
    Holdcertlab.text = @"手持身份证半身照";
    Holdcertlab.font = [UIFont systemFontOfSize:14];
    Holdcertlab.textAlignment = NSTextAlignmentCenter;
    [backWhiteImg addSubview:Holdcertlab];
    HoldCertBtn.sd_layout.rightSpaceToView(backWhiteImg,16).topSpaceToView(backWhiteImg,140).widthIs(KscreenWidth/2-20).heightIs((KscreenWidth/2-10)/16*9);
    Holdcertlab.sd_layout.centerXEqualToView(HoldCertBtn).topSpaceToView(HoldCertBtn,10).widthIs(HoldCertBtn.width).heightIs(15);
    
    UIButton *CommitBtn = [[UIButton alloc] init];
    [CommitBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    [CommitBtn setBackgroundColor:NavBack];
    CommitBtn.layer.cornerRadius = 3;
    [CommitBtn addTarget:self action:@selector(commitBasic) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:CommitBtn];
    CommitBtn.sd_layout.leftSpaceToView(footView,16).topSpaceToView(backWhiteImg,15).rightSpaceToView(footView,16).heightIs(45);
    
    table.tableFooterView = footView;
    
    [self.view addSubview:table];
    
    table.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(self.view,0).rightSpaceToView(self.view,0).heightIs(KscreenHeight);
    
    if ([[BusiIntf curPayOrder].isEdit isEqualToString:@"0"]) {
        //footView.userInteractionEnabled = NO;
        CommitBtn.hidden = YES;
        
    }
}
//点击上传
- (void)commitBasic {
    [self UpLoadBaseMsg];
}
//拍照
- (void)takePhoto:(UIButton *)btn {
   
    //如果不能编辑了，让照片点击放大方法!
    if ([[BusiIntf curPayOrder].isEdit isEqualToString:@"0"]) {
        
        UIImageView *img = [[UIImageView alloc] init];
        
        NSString *pic = nil;
        if (btn.tag == 1000) {
            pic = pic1;
        }else if (btn.tag == 1001) {
            pic = pic2;
        }else if (btn.tag == 1002) {
            pic = pic3;
        }else if (btn.tag == 1003) {
            pic = pic4;
        }
        
        img.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:pic]]];
        img.center = self.view.center;
        [self  magnify:img];
    }else {    //拍照
        
        NSLog(@"拍照。。。");
        //判断是否可以打开相机,模拟器无法使用此功能
        currentTag = btn.tag;
        if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)]) {
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            
            picker.delegate = self;
            //picker.allowsEditing = YES; //是否可编辑
            //摄像头
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:picker animated:YES completion:nil];
            
        }else
            
        {
            //如果没有提示用户
            AlertView(@"没有相机...", @"确定");
        }
    }
}

//放大照片方法
- (void)magnify :(UIImageView *)img{
    [SJAvatarBrowser showImage:img];
}

//拍摄完成后要执行的方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    //[SVProgressHUD showWithStatus:@"照片正在上传!"];
    //得到图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSString *url = ImgUrl;
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    
    NSString *encodedImageStr = [GTMBase64 stringByEncodingData:data];
    
    NSString *imageBase64 = [NSString stringWithFormat:@"%@%@",@"data:image/png;base64,",encodedImageStr];
    user = [NSUserDefaults standardUserDefaults];
    NSString *auth = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    
    NSString *sign = [NSString stringWithFormat:@"%@",key];
    NSString *str = [self md5HexDigest:sign];
    
    NSDictionary *dic1 = @{//@"picNbr":imageType,
                           @"fileBase64":imageBase64,
                           @"token":auth,
                           @"sign":str,
                           };
    NSDictionary *dicc = @{@"action":@"fileUploadState",
                           @"data":dic1};
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        //[SVProgressHUD show];
        NSLog(@"数据:%@",result);
        NSDictionary *dic = [result JSONValue];
        NSString *msg = dic[@"msg"];
        NSString *code = dic[@"code"];
        NSString *httpPath = dic[@"httpPath"];
        if ([code isEqualToString:@"000000"]) {
            msg = @"图片上传成功!";
            table.userInteractionEnabled = YES;
        }
        [AlertView(msg, @"确定") show];
        if (currentTag == 1000) {
            pic1 = httpPath;
            NSLog(@"pic1%@",pic1);
            
        }else if (currentTag == 1001) {
            pic2 = httpPath;
            NSLog(@"pic2%@",pic2);
            
        }else if (currentTag == 1002) {
            pic3 = httpPath;
            NSLog(@"pic3%@",pic3);
           
        }else if (currentTag == 1003) {
            pic4 = httpPath;
            NSLog(@"pic4%@",pic4);
            
        }else {
            
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
        [SVProgressHUD dismiss];
    }];
    
    NSLog(@"当前tag:%d",currentTag);
    UIButton *btn = [self.view viewWithTag:currentTag];
    [btn setBackgroundImage:image forState:UIControlStateNormal];

    [self dismissViewControllerAnimated:YES completion:^{
        [SVProgressHUD showWithStatus:@"正在上传图片..."];
        table.userInteractionEnabled = NO;
    }];
    
}
//上传基本信息
- (void)UpLoadBaseMsg {
    
//    UITextField *textfldOne = [self.view viewWithTag:100];
//    UITextField *textflfTwo = [self.view viewWithTag:101];
//    UITextField *textfldThree = [self.view viewWithTag:102];
    
    
    if (pic1 == nil || pic2 == nil || pic3 == nil || pic4 == nil) {
        [self alert:@"您还有照片未上传!"];
        return;
    }else if ([Name isEqualToString:@""] || [CertNumber isEqualToString:@""] || [BankNumber isEqualToString:@""] ) {
        [self alert:@"您还有信息未填写完整!"];
        return;
    }
    NSString *url = JXUrl;
    user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *md5 = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",pic1,pic2,pic3,pic4,Name,BankNumber,CertNumber,key];
    NSLog(@"MD5：%@",md5);
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                           @"shopCert":CertNumber,
                           @"shopAccount":Name,
                           @"shopBank":BankNumber,
                           @"pic1":pic1,
                           @"pic2":pic2,
                           @"pic3":pic3,
                           @"pic4":pic4,
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"shopPerfectState",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSDictionary *dicc = [result JSONValue];
        NSLog(@"返回数据：%@",dicc);
        NSString *code = dicc[@"code"];
        NSString *content = dicc[@"msg"];
        //NSString *content = dicc[@"content"];
        if ([code isEqualToString:@"000000"]) {
            [self alert:@"提交成功!"];
            //回到个人中心
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else {
            [self alert:content];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"网络申请失败:%@",error);
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

- (void)tapOne {
    
}
- (void)tapTwo {
    
}
- (void)tapThree {
    
}
- (void)tapFour {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 45;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identify = [NSString stringWithFormat:@"cell-%d",indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        if (indexPath.row == 0) {
            BaseMsgCell *BaseCell = [[BaseMsgCell alloc] init];
            BaseCell.leftLab.text = @"姓  名";
            BaseCell.rightFld.placeholder = @"请输入姓名";
            if (![[BusiIntf curPayOrder].bankAccont isEqualToString:@""]) {
                Name = [BusiIntf curPayOrder].bankAccont;
            }
            
            BaseCell.rightFld.text = Name;
            BaseCell.rightFld.tag = 100;
            BaseCell.rightFld.delegate = self;
            cell = BaseCell;
            
            
        }else if (indexPath.row == 1) {
            BaseMsgCell *BaseCell = [[BaseMsgCell alloc] init];
            BaseCell.leftLab.text = @"身份证";
            BaseCell.rightFld.placeholder = @"请输入身份证";
            if (![[BusiIntf curPayOrder].shopCard isEqualToString:@""]) {
                CertNumber = [BusiIntf curPayOrder].shopCard;
            }
            if ([[BusiIntf curPayOrder].isEdit isEqualToString:@"0"]) {  //如果不能编辑则显示部分信息
                CertNumber = [self rePlaceString:CertNumber];
            }
            BaseCell.rightFld.text = CertNumber;
            BaseCell.rightFld.tag = 101;
            BaseCell.rightFld.delegate = self;
            BaseCell.rightFld.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            cell = BaseCell;
        }else if (indexPath.row == 2) {
            BaseMsgCell *BaseCell = [[BaseMsgCell alloc] init];
            BaseCell.leftLab.text = @"银行卡";
            BaseCell.rightFld.placeholder = @"请输入银行卡";
            if (![[BusiIntf curPayOrder].bankNumber isEqualToString:@""]) {
                BankNumber = [BusiIntf curPayOrder].bankNumber ;
            }
            if ([[BusiIntf curPayOrder].isEdit isEqualToString:@"0"]) {  //如果不能编辑则显示部分信息
                BankNumber = [self rePlaceString:BankNumber];
            }
            BaseCell.rightFld.text = BankNumber;
            BaseCell.rightFld.tag = 102;
            BaseCell.rightFld.delegate = self;
            BaseCell.rightFld.keyboardType = UIKeyboardTypeNumberPad;
            cell = BaseCell;
        }else {
            
        }
    }
    if ([[BusiIntf curPayOrder].isEdit isEqualToString:@"0"]) {
        cell.userInteractionEnabled = NO;
    }
    return cell;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.tag == 100) {
        Name = textField.text;
    }else if (textField.tag == 101) {
        CertNumber = textField.text;
    }else if (textField.tag == 102) {
        BankNumber = textField.text;
    }else {
        
    }
}

//隐私信息打*处理
-(NSString*)rePlaceString:(NSString*)string{
    if (![string isKindOfClass:[NSString class]]) {
        return @"";
    }else{
        NSMutableString *mutString = [NSMutableString stringWithString:string];
        NSInteger length = [mutString length];
        if (length>=6) {
            [mutString replaceCharactersInRange:NSMakeRange(3, length-6) withString:@"********"];
        }else{
            
        }
        
        return (NSString*)mutString;
    }
}

- (void)alert:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.view endEditing:YES];
//}

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
