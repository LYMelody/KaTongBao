//
//  KTBAuthCertifyViewController.m
//  KaTongBao
//
//  Created by rongfeng on 16/7/27.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "KTBAuthCertifyViewController.h"
#import "Common.h"
#import "macro.h"
#import "MesageCell.h"
#import "UIView+SDAutoLayout.h"
#import "ViewsCell.h"
#import "SVProgressHUD.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonDigest.h>
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "BusiIntf.h"
#import "SJAvatarBrowser.h"
#import "KTBExampleViewController.h"
//#import <SDWebImage/UIButton+WebCache.h>
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
//#import <SDWebImage/UIImageView+WebCache.h>
@interface KTBAuthCertifyViewController ()

@end

@implementation KTBAuthCertifyViewController {
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
    MesageCell *Mesage;
    MesageCell *Mesagecell;
    UIButton *CommitBtn;
}

-(void)viewWillAppear:(BOOL)animated
{
    //不隐藏导航栏
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
    //测试
    //[BusiIntf curPayOrder].isEdit = @"1";
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] init];
    leftBtn.title = @"返回";
    self.navigationItem.backBarButtonItem = leftBtn;
    
    pic1 = [BusiIntf curPayOrder].httpPath1;
    pic2 = [BusiIntf curPayOrder].httpPath2;
    pic3 = [BusiIntf curPayOrder].httpPath3;
    pic4 = [BusiIntf curPayOrder].httpPath4;
    NSLog(@"%@%@%@%@",pic1,pic2,pic3,pic4);
    self.title = @"商户实名认证";
    self.view.backgroundColor = [UIColor whiteColor];
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 64)];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = LightGrayColor;
    table.showsVerticalScrollIndicator = NO;
    
    UITapGestureRecognizer *TapToResignKeyBoard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ResignKeyBord)];
    TapToResignKeyBoard.numberOfTouchesRequired = 1;
    TapToResignKeyBoard.cancelsTouchesInView = NO;
    [table addGestureRecognizer:TapToResignKeyBoard];
    
    //table.scrollEnabled = NO;
    UIView *footView = [[UIView alloc] init];
    if (KscreenHeight <= 480) {
        footView.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight - 100);
    } else {
        footView.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight - 160);
    }
    footView.userInteractionEnabled = YES;
    footView.backgroundColor = [UIColor whiteColor];
    table.tableFooterView = footView;
    [self.view addSubview:table];
    //身份证正面照
    UIButton *CardFontBtn = [[UIButton alloc] init];
    CardFontBtn.tag = 1000;
    CardFontBtn.layer.cornerRadius = 3;
    [CardFontBtn setBackgroundImage:[UIImage imageNamed:@"点击上传.png"] forState:UIControlStateNormal];
    if (![pic1 isEqualToString:@""]) {
       
        //[CardFontBtn setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[BusiIntf curPayOrder].httpPath1]]] forState:UIControlStateNormal];
        //[CardFontBtn setBackgroundImageWithURL:[NSURL URLWithString:[BusiIntf curPayOrder].httpPath1] forState:UIControlStateNormal];
        [CardFontBtn sd_setImageWithURL:[NSURL URLWithString:[BusiIntf curPayOrder].httpPath1] forState:UIControlStateNormal];
        //[CardFontBtn sd_setImageWithURL:[NSURL URLWithString:pic1] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"点击上传.png"] options:SDWebImageRefreshCached];
    
    }
    [CardFontBtn addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:CardFontBtn];
    CardFontBtn.sd_layout.leftSpaceToView(footView,16).topSpaceToView(footView,10).widthIs(90).heightIs(90);

    UILabel *MidLab = [[UILabel alloc] init];
    MidLab.text = @"上传您的身份证正面照";
    MidLab.font = [UIFont systemFontOfSize:14];
    MidLab.textAlignment = NSTextAlignmentLeft;
    [footView addSubview:MidLab];
    MidLab.sd_layout.leftSpaceToView(CardFontBtn,10).topSpaceToView(footView,15).widthIs(200).heightIs(20);
    
    UIButton *CaseBtn = [[UIButton alloc] init];
    CaseBtn.tag = 2001;
    [CaseBtn setTitle:@"查看示例" forState:UIControlStateNormal];
    [CaseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    CaseBtn.layer.cornerRadius = 3;
    CaseBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    CaseBtn.backgroundColor = LightGrayColor;
    [CaseBtn addTarget:self action:@selector(Example:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:CaseBtn];
    CaseBtn.sd_layout.rightSpaceToView(footView,10).topSpaceToView(MidLab,30).widthIs(80).heightIs(28);
    
    UIView *LineOne = [[UIView alloc] init];
    LineOne.backgroundColor = [UIColor lightGrayColor];
    [footView addSubview:LineOne];
    LineOne.sd_layout.leftSpaceToView(footView,16).topSpaceToView(CardFontBtn,5).widthIs(KscreenWidth - 20).heightIs(0.5);
    
    //身份证背面照
    UIButton *CardBackBtn = [[UIButton alloc] init];
    CardBackBtn.tag = 1001;
    CardBackBtn.layer.cornerRadius = 3;
    [CardBackBtn setBackgroundImage:[UIImage imageNamed:@"点击上传.png"] forState:UIControlStateNormal];
    if (![pic2 isEqualToString:@""]) {
      
        //[CardBackBtn setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:pic2]]] forState:UIControlStateNormal];
        //[CardBackBtn setBackgroundImageWithURL:[NSURL URLWithString:[BusiIntf curPayOrder].httpPath2] forState:UIControlStateNormal];
        [CardBackBtn sd_setImageWithURL:[NSURL URLWithString:[BusiIntf curPayOrder].httpPath2] forState:UIControlStateNormal];
        //[CardFontBtn sd_setImageWithURL:[NSURL URLWithString:pic2] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"点击上传.png"] options:SDWebImageRefreshCached];
    }
    [CardBackBtn addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:CardBackBtn];
    CardBackBtn.sd_layout.leftSpaceToView(footView,16).topSpaceToView(LineOne,10).widthIs(90).heightIs(90);
    
    UILabel *BackMidLab = [[UILabel alloc] init];
    BackMidLab.text = @"上传您的身份证背面照";
    BackMidLab.font = [UIFont systemFontOfSize:14];
    BackMidLab.textAlignment = NSTextAlignmentLeft;
    [footView addSubview:BackMidLab];
    BackMidLab.sd_layout.leftSpaceToView(CardBackBtn,10).topSpaceToView(LineOne,13).widthIs(200).heightIs(20);
    
    UIButton *BackCaseBtn = [[UIButton alloc] init];
    BackCaseBtn.tag = 2002;
    [BackCaseBtn setTitle:@"查看示例" forState:UIControlStateNormal];
    [BackCaseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    BackCaseBtn.layer.cornerRadius = 3;
    BackCaseBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    BackCaseBtn.backgroundColor = LightGrayColor;
    [BackCaseBtn addTarget:self action:@selector(Example:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:BackCaseBtn];
    BackCaseBtn.sd_layout.rightSpaceToView(footView,10).topSpaceToView(BackMidLab,30).widthIs(80).heightIs(28);
    
    UIView *LineTwo = [[UIView alloc] init];
    LineTwo.backgroundColor = [UIColor lightGrayColor];
    [footView addSubview:LineTwo];
    LineTwo.sd_layout.leftSpaceToView(footView,16).topSpaceToView(CardBackBtn,5).widthIs(KscreenWidth - 20).heightIs(0.5);
    
    //手持身份证
    UIButton *HoldCardBtn = [[UIButton alloc] init];
    HoldCardBtn.tag = 1002;
    HoldCardBtn.layer.cornerRadius = 3;
    [HoldCardBtn setBackgroundImage:[UIImage imageNamed:@"点击上传.png"] forState:UIControlStateNormal];
    if (![pic4 isEqualToString:@""]) {
        //[HoldCardBtn sd_setImageWithURL:[NSURL URLWithString:[BusiIntf curPayOrder].httpPath4] forState:UIControlStateNormal];
        [HoldCardBtn sd_setImageWithURL:[NSURL URLWithString:[BusiIntf curPayOrder].httpPath4] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"点击上传.png"] options:SDWebImageRefreshCached];
    }
    [HoldCardBtn addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:HoldCardBtn];
    HoldCardBtn.sd_layout.leftSpaceToView(footView,16).topSpaceToView(LineTwo,10).widthIs(90).heightIs(90);
    
    UILabel *HoldMidLab = [[UILabel alloc] init];
    HoldMidLab.text = @"上传您的手持证件半身照";
    HoldMidLab.font = [UIFont systemFontOfSize:14];
    HoldMidLab.textAlignment = NSTextAlignmentLeft;
    [footView addSubview:HoldMidLab];
    HoldMidLab.sd_layout.leftSpaceToView(HoldCardBtn,10).topSpaceToView(LineTwo,13).widthIs(200).heightIs(20);
    
    UIButton *HlodCaseBtn = [[UIButton alloc] init];
    HlodCaseBtn.tag = 2003;
    [HlodCaseBtn setTitle:@"查看示例" forState:UIControlStateNormal];
    [HlodCaseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    HlodCaseBtn.layer.cornerRadius = 3;
    HlodCaseBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    HlodCaseBtn.backgroundColor = LightGrayColor;
    [HlodCaseBtn addTarget:self action:@selector(Example:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:HlodCaseBtn];
    HlodCaseBtn.sd_layout.rightSpaceToView(footView,10).topSpaceToView(HoldMidLab,30).widthIs(80).heightIs(28);
    
    UIView *LineThree = [[UIView alloc] init];
    LineThree.backgroundColor = [UIColor lightGrayColor];
    [footView addSubview:LineThree];
    LineThree.sd_layout.leftSpaceToView(footView,0).topSpaceToView(HoldCardBtn,5).widthIs(KscreenWidth ).heightIs(0.5);
    
    //提交审核
    UIImageView *Img = [[UIImageView alloc] init];
    Img.backgroundColor = LightGrayColor;
    Img.userInteractionEnabled = YES;
    [footView addSubview:Img];
    Img.sd_layout.leftSpaceToView(footView,0).topSpaceToView(LineThree,0).widthIs(KscreenWidth).bottomSpaceToView(footView,0);
    
    CommitBtn = [[UIButton alloc] init];
    [CommitBtn setTitle:@"提交审核" forState:UIControlStateNormal];
    CommitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [CommitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CommitBtn.layer.cornerRadius = 3;
    CommitBtn.userInteractionEnabled = YES;
    CommitBtn.backgroundColor = NavBack;
    [CommitBtn addTarget:self action:@selector(Commit) forControlEvents:UIControlEventTouchUpInside];
    [Img addSubview:CommitBtn];
    CommitBtn.sd_layout.leftSpaceToView(Img,20).topSpaceToView(Img,15).rightSpaceToView(Img,20).heightIs(40);
    
    if ([[BusiIntf curPayOrder].isEdit isEqualToString:@"0"]) {
        //footView.userInteractionEnabled = NO;
        CommitBtn.hidden = YES;
        
    }
}

//提交
- (void)Commit{
    CommitBtn.enabled = NO;
    [self UpLoadBaseMsg];
    
}

//上传基本信息
- (void)UpLoadBaseMsg {
    
    //    UITextField *textfldOne = [self.view viewWithTag:100];
    //    UITextField *textflfTwo = [self.view viewWithTag:101];
    //    UITextField *textfldThree = [self.view viewWithTag:102];
    
    [SVProgressHUD show];
    if (pic1 == nil || pic2 == nil || pic4 == nil || [pic1 isEqualToString:@""] || [pic2 isEqualToString:@""] || [pic4 isEqualToString:@""]) {
        [self alert:@"您还有照片未上传,或者重新拍照上传"];
        CommitBtn.enabled = YES;
        return;
    }else if ([Name isEqualToString:@""] || [CertNumber isEqualToString:@""]  ) {
        [self alert:@"您还有信息未填写完整!"];
        CommitBtn.enabled = YES;
        return;
    }
    NSString *url = JXUrl;
    user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *md5 = [NSString stringWithFormat:@"%@%@%@%@%@%@",pic1,pic2,pic4,Name,CertNumber,key];
    //NSLog(@"MD5：%@",md5);
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                           @"shopCert":CertNumber,
                           @"shopAccount":Name,
                           //@"shopBank":BankNumber,
                           @"pic1":pic1,
                           @"pic2":pic2,
                           @"pic4":pic4,
                           //@"pic4":pic4,
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
        //NSLog(@"返回数据：%@",dicc);
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
        [SVProgressHUD dismiss];
        CommitBtn.enabled = YES;
    } failure:^(NSError *error) {
        NSLog(@"网络申请失败:%@",error);
        [SVProgressHUD dismiss];
        CommitBtn.enabled = YES;
    }];
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
            pic = pic4;
        }else {
            
        }
        
        NSData *imagedata = [NSData dataWithContentsOfURL:[NSURL URLWithString:pic]];
        img.image = [UIImage imageWithData:imagedata];
        img.center = self.view.center;
        //显示不了照片就不放大(16.12.29)
        if (imagedata.length) {
            [self  magnify:img];
        }else{
            
        }
        
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
    
    table.userInteractionEnabled = NO;
    
    [SVProgressHUD showWithStatus:@"照片正在上传..."];
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
        NSLog(@"上传图片成功数据:%@",result);
        NSDictionary *dic = [result JSONValue];
        NSString *msg = dic[@"msg"];
        NSString *code = dic[@"code"];
        NSString *httpPath = dic[@"httpPath"];
        if ([code isEqualToString:@"000000"]) {
            msg = @"图片上传成功!";
        }
        [AlertView(msg, @"确定") show];
        if (currentTag == 1000) {
            pic1 = httpPath;
            NSLog(@"pic1：%@",pic1);
            
        }else if (currentTag == 1001) {
            pic2 = httpPath;
            NSLog(@"pic2：%@",pic2);
            
        }else if (currentTag == 1002) {
            pic4 = httpPath;
            NSLog(@"pic4：%@",pic4);
            
        }else if (currentTag == 1003) {
            //pic4 = httpPath;
            NSLog(@"pic4：%@",pic4);
            
        }else {
            
        }
        table.userInteractionEnabled = YES;
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
        //[self alert:[NSString stringWithFormat:@"%@",error]];
        table.userInteractionEnabled = YES;
        [SVProgressHUD dismiss];
    }];
    
    NSLog(@"当前tag:%ld",(long)currentTag);
    UIButton *btn = [self.view viewWithTag:currentTag];
    //[btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:^{
        //[SVProgressHUD showWithStatus:@"正在上传图片..."];
       // table.userInteractionEnabled = YES;
    }];
}
//举个例子
- (void)Example:(UIButton *)btn {
    
    KTBExampleViewController *ExampleVc = [[KTBExampleViewController alloc] init];
    
    if (btn.tag == 2001) {
        ExampleVc.tag = 101;
    }else if (btn.tag == 2002) {
        ExampleVc.tag = 102;
    }else if (btn.tag == 2003) {
        ExampleVc.tag = 103;
    }
    
    ExampleVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ExampleVc animated:YES];
    ExampleVc.hidesBottomBarWhenPushed = NO;
    
    NSLog(@"举个例子");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        if ([[BusiIntf curPayOrder].showMsg isEqualToString:@""]) {
            return 0;
        }else {
            return 45;
        }
    }
    return 45;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identy = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        
            if (indexPath.row == 0) {
                
                ViewsCell *Viewcell = [[ViewsCell alloc] init];
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, Viewcell.height)];
                label.text = [NSString stringWithFormat:@"   %@",[BusiIntf curPayOrder].showMsg];
                label.textColor = GreenColor;
                label.font = [UIFont systemFontOfSize:14];
                label.backgroundColor = LightGrayColor;
                label.adjustsFontSizeToFitWidth = YES;
                [Viewcell addSubview:label];
                cell = Viewcell;
                
            }else if (indexPath.row == 1) {
                Mesage = [[MesageCell alloc] init];
                Mesage.label.text = @"真实姓名";
                Mesage.textFiled.placeholder = @"请输入姓名";
                Mesage.textFiled.tag = 100;
                Mesage.textFiled.keyboardType = UIKeyboardTypeDefault;
                Mesage.textFiled.delegate = self;
                if (![[BusiIntf curPayOrder].bankAccont isEqualToString:@""]) {
                    Name = [BusiIntf curPayOrder].bankAccont;
                }
                
                Mesage.textFiled.text = Name;
                cell = Mesage;
            }else if (indexPath.row == 2) {
                Mesagecell = [[MesageCell alloc] init];
                Mesagecell.label.text = @"身份证号";
                Mesagecell.textFiled.placeholder = @"请输入身份证号";
                Mesagecell.textFiled.keyboardType = UIKeyboardTypeDefault;
                Mesagecell.textFiled.tag = 101;
                Mesagecell.textFiled.delegate = self;
                if (![[BusiIntf curPayOrder].shopCard isEqualToString:@""]) {
                    CertNumber = [BusiIntf curPayOrder].shopCard;
                }
                if ([[BusiIntf curPayOrder].isEdit isEqualToString:@"0"]) {  //如果不能编辑则显示部分信息
                    CertNumber = [self rePlaceString:CertNumber];
                }
                Mesagecell.textFiled.text = CertNumber;
                cell = Mesagecell;
            }else if (indexPath.row == 3) {
                ViewsCell *Viewcell = [[ViewsCell alloc] init];
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, Viewcell.height)];
                label.text = @"   上传以下资料可申请认证";
                label.textColor = [UIColor blackColor];
                label.font = [UIFont systemFontOfSize:14];
                label.backgroundColor = LightGrayColor;
                [Viewcell addSubview:label];
                cell = Viewcell;
            }
        if ([[BusiIntf curPayOrder].isEdit isEqualToString:@"0"]) {
            cell.userInteractionEnabled = NO;
        }
        
    }
    return cell;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.tag == 100) {
        Name = textField.text;
    }else if (textField.tag == 101) {
        CertNumber = textField.text;
    }else {
        
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

- (void)alert:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

//隐私信息打*处理
-(NSString*)rePlaceString:(NSString*)string{
    if (![string isKindOfClass:[NSString class]]) {
        return @"";
    }else{
        NSMutableString *mutString = [NSMutableString stringWithString:string];
        NSInteger length = [mutString length];
        if (length>=6) {
            [mutString replaceCharactersInRange:NSMakeRange(4, length-8) withString:@"******"];
        }else{
            
        }
        
        return (NSString*)mutString;
    }
}

//隐藏键盘
- (void)ResignKeyBord {
    
    //[table resignFirstResponder];
    [Mesage.textFiled resignFirstResponder];
    [Mesagecell.textFiled resignFirstResponder];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
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
