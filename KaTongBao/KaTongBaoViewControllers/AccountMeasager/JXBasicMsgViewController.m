//
//  JXBasicMsgViewController.m
//  JingXuan
//
//  Created by rongfeng on 16/6/6.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "JXBasicMsgViewController.h"
#import "Common.h"
#import "macro.h"
#import "UIView+SDAutoLayout.h"
#import "BusiIntf.h"
#import "BasicCustomView.h"
#import <CommonCrypto/CommonDigest.h>
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "GTMBase64.h"
#import "SVProgressHUD.h"
@interface JXBasicMsgViewController ()<UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,basicCustomViewDelegate>

@property (nonatomic, strong) UIView *animationView;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation JXBasicMsgViewController {
    NSInteger _currentIndex;
    BasicCustomView *_basiccView;
    UITextField *_TF;
    BasicCustomView *basiccViewOne;
    BasicCustomView *basiccViewTwo;
    BasicCustomView *basiccViewThr;
    NSUserDefaults *user;
    NSString *pic1;
    NSString *pic2;
    NSString *pic3;
    NSString *pic4;
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
    self.title = @"基本信息";
    //[self RequestForBaseInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    [self initView];
    [self initScrollView];
    
}

#pragma mark -- 创建导航的三个button
- (void)initView  {
    
    NSArray *buttonTittleArr = [NSArray arrayWithObjects:@"1.个人信息",@"2.银行卡信息",@"3.机构信息", nil];
    UIView *BGView = [[UIView alloc]initWithFrame:CGRectMake(0, 70 - 64, KscreenWidth, 45)];
    BGView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:BGView];
    
    for (int i = 0; i < 3; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*KscreenWidth/3, 0, KscreenWidth/3, 40);
        [button setTitle:buttonTittleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 2000+i;
        [BGView addSubview:button];
    }
    
    self.animationView = [[UIView alloc]initWithFrame:CGRectMake(15, 40, KscreenWidth/3 - 30, 5)];
    self.animationView.backgroundColor = [UIColor colorWithRed:0/255.0 green:172.0/255.0 blue:214.0/255.0 alpha:1];
    [BGView addSubview:self.animationView];
}
#pragma mark -- 创建scrollView
- (void)initScrollView {
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 115 - 64, KscreenWidth, KscreenHeight-115)];
    self.scrollView.contentSize = CGSizeMake(KscreenWidth*3, KscreenHeight - 115);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    for (int i = 0; i < 3; i ++) {
        
        UIScrollView *BGScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(KscreenWidth*i, 0, KscreenWidth, KscreenHeight - 115)];
        BGScroll.contentSize = CGSizeMake(KscreenWidth, (KscreenWidth/2-10)/16*9+40 + 320);
        [self.scrollView addSubview:BGScroll];
        
        _basiccView = [[BasicCustomView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight-115)];
        _basiccView.tag = 200 + i;
        _basiccView.Sendbutton.tag = 100 + i;
        _basiccView.delegate = self;
        [BGScroll addSubview:_basiccView];
        UIButton *button = (UIButton *)[_basiccView viewWithTag:9999];
        UIButton *button1 = (UIButton *)[_basiccView viewWithTag:10000];
        //发送按钮统一点击事件
        
//        _basiccView.Sendbutton = [[UIButton alloc] init];
//         _basiccView.Sendbutton.tag = 100 + i;
//        _basiccView.Sendbutton.frame = CGRectMake(10, (KscreenWidth/2-10)/16*9+40 + 260, KscreenWidth - 20, 50);
//        [_basiccView.Sendbutton setTitle:@"下一步" forState:UIControlStateNormal];
//        _basiccView.Sendbutton.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
//        [_basiccView.Sendbutton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//        _basiccView.Sendbutton.layer.cornerRadius = 3;
//        [_basiccView addSubview:_basiccView.Sendbutton];
       
        
        
        
        if (i == 0) {
            button.tag = 9999;
            button1.tag = 10000;
            if (![[BusiIntf curPayOrder].shopName isEqualToString:@""]) {
                _basiccView.nameTF.text = [BusiIntf curPayOrder].shopName;
                //_basiccView.nameTF.text = @"周辉平";
                _basiccView.checkLabel.text = [BusiIntf curPayOrder].showMsg;
            }
            if (![[BusiIntf curPayOrder].shopCard isEqualToString:@""]) {
                _basiccView.numberTF.text = [BusiIntf curPayOrder].shopCard;
                
            } else {
                
            }
            
            NSLog(@"身份证号码:^%@",[BusiIntf curPayOrder].shopCard);
        }
        else if (i == 1) {
            _basiccView.informationLab.text = @"结算银行卡信息";
            _basiccView.nameLabel.text = @"银行账户";
            _basiccView.nameTF.placeholder = @"请输入银行账户";
            //_basiccView.nameTF.text = @"周辉平";
            _basiccView.informationLabel.text = @"银行卡号";
            _basiccView.numberTF.placeholder = @"请输入银行卡号";
           // _basiccView.numberTF.text = @"6222021202041714172";
            _basiccView.photoLabel.text = @"银行卡照片";
            _basiccView.frontLabel.text = @"银行卡正面照";
            _basiccView.reverseSideLabel.text = @"手持身份证和银行卡照";
            _basiccView.reverseSideLabel.numberOfLines = 0;
            _basiccView.reverseSideLabel.adjustsFontSizeToFitWidth = YES;
            button.tag = 1000;
            button1.tag = 1001;
            
            if (![[BusiIntf curPayOrder].bankAccont isEqualToString:@""]) {
                _basiccView.nameTF.text = [BusiIntf curPayOrder].bankAccont;
            }
            if (![[BusiIntf curPayOrder].bankNumber isEqualToString:@""]) {
                _basiccView.numberTF.text = [BusiIntf curPayOrder].bankNumber;
            } else {
                
            }
            NSLog(@"银行卡号:^%@",[BusiIntf curPayOrder].bankNumber);
        }else if (i == 2) {
            _basiccView.informationLab.text = @"归属机构信息";
            _basiccView.photoView.hidden = YES;
            //_basiccView.informationBGView.hidden = YES;
            _basiccView.photoLabelView.hidden = YES;
            
            _basiccView.nameLabel.text = @"机构信息";
            _basiccView.nameTF.placeholder = @"请输入机构信息";
            //_basiccView.nameTF.text = @"1604196866456901";
            _basiccView.informationLabel.hidden = YES;
            _basiccView.numberTF.hidden = YES;
            
            if (![[BusiIntf curPayOrder].orgCode isEqualToString:@""]) {
                _basiccView.nameTF.text = [BusiIntf curPayOrder].orgCode;
            }
            
            UIView *hideView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, KscreenWidth, 50)];
            hideView.backgroundColor = [ UIColor colorWithWhite:0.9 alpha:1];
            [_basiccView.informationBGView addSubview:hideView];
            
            
            UIButton * Sendbutton = [UIButton buttonWithType:UIButtonTypeCustom];
            Sendbutton.frame = CGRectMake(10, (KscreenWidth/2-10)/16*9+40 + 260, KscreenWidth - 20, 50);
            [Sendbutton setTitle:@"确定" forState:UIControlStateNormal];
            Sendbutton.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
            [Sendbutton addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
            Sendbutton.clipsToBounds = YES;
            Sendbutton.layer.cornerRadius = 5;
            
            [_basiccView.Sendbutton setBackgroundColor:NavBack];
            [_basiccView.Sendbutton setTitle:@"提交" forState:UIControlStateNormal];
        }
        //设置图片
        if (button.tag == 9999 && ![[BusiIntf curPayOrder].httpPath1 isEqualToString:@""]) {
            [button setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[BusiIntf curPayOrder].httpPath1]]] forState:UIControlStateNormal];
            pic1 = [BusiIntf curPayOrder].httpPath1;
            if (![[BusiIntf curPayOrder].httpPath2 isEqualToString:@""]) {
                [button1 setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[BusiIntf curPayOrder].httpPath2]]] forState:UIControlStateNormal];
                pic2 =[BusiIntf curPayOrder].httpPath2;
            }
        }else if (button.tag == 1000 && ![[BusiIntf curPayOrder].httpPath3 isEqualToString:@""]) {
            [button setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[BusiIntf curPayOrder].httpPath3]]] forState:UIControlStateNormal];
            pic3 = [BusiIntf curPayOrder].httpPath3;
            if (![[BusiIntf curPayOrder].httpPath4 isEqualToString:@""]) {
                [button1 setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[BusiIntf curPayOrder].httpPath4]]] forState:UIControlStateNormal];
                pic4 = [BusiIntf curPayOrder].httpPath4;
            }
        }else {
            
        }
        //是否可编辑
        if (![[BusiIntf curPayOrder].isEdit isEqualToString:@"1"]) {
            _basiccView.userInteractionEnabled = NO;
        }
        
    }
}

#pragma mark -- button点击事件
- (void)buttonClick:(UIButton *)sender {
    NSLog(@"%ld",(long)sender.tag);
    if (sender.tag == 2000) {
        self.scrollView.contentOffset = CGPointMake(0, 0);
        self.animationView.frame = CGRectMake(15, 40, KscreenWidth/3 - 30, 5);
        if (sender.isSelected == YES) {
            [sender setTitleColor:[UIColor colorWithRed:0/255.0 green:172.0/255.0 blue:214.0/255.0 alpha:1] forState:UIControlStateNormal];
        }else {
            [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }else if (sender.tag == 2001){
        self.scrollView.contentOffset = CGPointMake(KscreenWidth, 0);
        self.animationView.frame = CGRectMake(KscreenWidth/3+15, 40, KscreenWidth/3-30, 5);
        if (sender.isSelected == YES) {
            [sender setTitleColor:[UIColor colorWithRed:0/255.0 green:172.0/255.0 blue:214.0/255.0 alpha:1] forState:UIControlStateNormal];
        }else {
            [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
        }
    }else if (sender.tag == 2002) {
        self.scrollView.contentOffset = CGPointMake(KscreenWidth*2, 0);
        self.animationView.frame = CGRectMake(KscreenWidth/3*2+15, 40, KscreenWidth/3-30, 5);
        if (sender.isSelected == YES) {
            [sender setTitleColor:[UIColor colorWithRed:0/255.0 green:172.0/255.0 blue:214.0/255.0 alpha:1] forState:UIControlStateNormal];
        }else {
            [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
}
//确定
- (void)btnEvent:(UIButton *)btn {
    
    
    
}
- (void)choosePictureButtonClick:(UIButton *)sender {
    NSLog(@"%----ld",(long)sender.tag);
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //1、验证方法是否被调用；2、验证参数buttonIndex的值为多少；
    NSLog(@"click-->%ld", (long)buttonIndex);
    //alert buttonIndex规律：有取消按钮，取消为0，后面一次按照顺序递增；如果没有取消按钮，从0开始依次递增；
    if (buttonIndex == 1) {
        [self addCarema];
    }
    if (buttonIndex == 2) {
        [self openPicLibrary];
    }
}
//下一步按钮点击方法
-(void)btnClick:(NSInteger) tag{

    _basiccView = [self.scrollView viewWithTag:200];
    NSLog(@"44444%@",_basiccView.nameTF.text);
    
    basiccViewOne = [self.scrollView viewWithTag:200];
    basiccViewTwo = [self.scrollView viewWithTag:201];
    basiccViewThr = [self.scrollView viewWithTag:202];
    //BasicCustomView *basiccViewFou = [self.scrollView viewWithTag:203];
    
    if (tag == 100) {
        NSLog(@"100");
        if ([basiccViewOne.nameTF.text isEqualToString:@""]) {
            [self alert:@"请填写完整账户信息!"];
        }else {
            [UIView animateWithDuration:0.5 animations:^{
                self.scrollView.contentOffset = CGPointMake(KscreenWidth, 0);
                self.animationView.frame = CGRectMake(KscreenWidth/3+15, 40, KscreenWidth/3-30, 5);
            }];
            
        }
    }else if (tag == 101) {
        NSLog(@"101");
        if ([basiccViewTwo.nameTF.text isEqualToString:@""]) {
            [self alert:@"请填写完整银行卡信息!"];
        }else {
            [UIView animateWithDuration:0.5 animations:^{
                self.scrollView.contentOffset = CGPointMake(KscreenWidth*2, 0);
                self.animationView.frame = CGRectMake(KscreenWidth/3*2+15, 40, KscreenWidth/3-30, 5);
            }];
        }
        
    }else if (tag == 102) {
        NSLog(@"102");
        if ([basiccViewThr.nameTF.text isEqualToString:@""]) {
            [self alert:@"请填写完整机构信息!"];
        } else {
            //上传基本信息
            [self UpLoadBaseMsg];
        }
    }else {
        NSLog(@"%d",tag);
    }
}
//导航按钮的点击方法
-(void)btnClickWith:(NSInteger )index
{
    
    //    BasicCustomView *View = [self.scrollView viewWithTag:201];
    //    View.nameTF.text = @"你好";
    
    _currentIndex = index;
    UIButton * btn =[self.scrollView viewWithTag:_currentIndex];
    [btn setImage:nil forState:UIControlStateNormal];
    //拍照
    [self addCarema];
    
    
//    if (_currentIndex == 1000) {
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选取照片", nil];
//        [alertView show];
//    }
//    if (_currentIndex == 10000) {
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选取照片", nil];
//        [alertView show];
//    }
//    if (_currentIndex == 9999) {
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选取照片", nil];
//        [alertView show];
//    }
//    if (_currentIndex == 1001) {
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选取照片", nil];
//        [alertView show];
//    }
//    
//    NSLog(@"滴滴滴滴%ld",(long)_currentIndex);
    
    
    //    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选取照片", nil];
    //    [alertView show];
}

-(void)addCarema
{
    //判断是否可以打开相机,模拟器无法使用此功能
    
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

//拍摄完成后要执行的方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    //[SVProgressHUD showWithStatus:@"照片正在上传!"];
    //得到图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSString *url = @"http://upd.ktb.shier365.com/api/action";
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
        }
        [AlertView(msg, @"确定") show];
        if (_currentIndex == 9999) {
            pic1 = httpPath;
            NSLog(@"pic1%@",pic1);
            //[SVProgressHUD dismiss];
        }else if (_currentIndex == 10000) {
            pic2 = httpPath;
            NSLog(@"pic2%@",pic2);
            //[SVProgressHUD dismiss];
        }else if (_currentIndex == 1000) {
            pic3 = httpPath;
            NSLog(@"pic3%@",pic3);
            //[SVProgressHUD dismiss];
        }else if (_currentIndex == 1001) {
            pic4 = httpPath;
            NSLog(@"pic4%@",pic4);
           // [SVProgressHUD dismiss];
        }else {
            
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
        [SVProgressHUD dismiss];
    }];
   
    UIButton * btn =[self.scrollView viewWithTag:_currentIndex];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    
    //图片存入相
//    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
   [self dismissViewControllerAnimated:YES completion:^{
       [SVProgressHUD showWithStatus:@"正在上传图片..."];
   }];
    
}
-(void)openPicLibrary
{
    //相册是可以用模拟器打开的
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        
        //打开相册选择照片
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:nil];
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"你没有摄像头" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"取消", nil];
        [alert show];
    }
}

//上传基本信息
- (void)UpLoadBaseMsg {
    
    if (pic1 == nil || pic2 == nil || pic3 == nil || pic4 == nil) {
        [self alert:@"您还有照片未上传!"];
        return;
    }
    NSString *url = JXUrl;
    user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *md5 = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",basiccViewThr.nameTF.text ,pic1,pic2,pic3,pic4,basiccViewTwo.nameTF.text ,basiccViewTwo.numberTF.text,basiccViewOne.numberTF.text,basiccViewOne.nameTF.text,key];
    NSLog(@"MD5：%@",md5);
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                           @"shopName":basiccViewOne.nameTF.text ,
                           @"shopCert":basiccViewOne.numberTF.text,
                           @"shopAccount":basiccViewTwo.nameTF.text,
                           @"shopBank":basiccViewTwo.numberTF.text,
                           @"orgId":basiccViewThr.nameTF.text,
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

//获取商户基本信息状态
- (void)RequestForBaseInfo {
    
    [SVProgressHUD show];
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
        //[table reloadData];
        //初始化滑动视图
        
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"网络申请失败:%@",error);
        [SVProgressHUD dismiss];
    }];
}

//上传照片信息
- (void)UpLoadPhotoMsg {
    
    
    
}

#pragma mark -- scrollView的代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.animationView.frame = CGRectMake(15+ (KscreenWidth/3)*scrollView.contentOffset.x/KscreenWidth, 40, (KscreenWidth/3 - 30), 5);
}

- (void)leftEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    [self.view endEditing:YES];
//}
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
