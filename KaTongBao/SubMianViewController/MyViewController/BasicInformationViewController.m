//
//  BasicInformationViewController.m
//  JingXuan
//
//  Created by wj on 16/5/18.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "BasicInformationViewController.h"
#import "macro.h"
#import "BasicCustomView.h"
#import "NSObject+SBJSON.h"
#import "IBHttpTool.h"
#import <CommonCrypto/CommonDigest.h>
@interface BasicInformationViewController ()<UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,basicCustomViewDelegate>
{
    NSInteger _currentIndex;
    BasicCustomView *_basiccView;
    UITextField *_TF;
   
   
    
}

@property (nonatomic, strong) UIView *animationView;

@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation BasicInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    
    [self setBaseVCAttributes:@"基本信息" withLeftName:@"返回" withRightName:nil withColor:NavBack];
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    [self initView];
    [self initScrollView];
}
#pragma mark -- 创建导航的三个button
- (void)initView  {
    
    NSArray *buttonTittleArr = [NSArray arrayWithObjects:@"1.个人信息",@"2.银行卡信息",@"3.机构信息", nil];
    UIView *BGView = [[UIView alloc]initWithFrame:CGRectMake(0, 70, KscreenWidth, 45)];
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
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 115, KscreenWidth, KscreenHeight-115)];
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
        
        _basiccView.delegate = self;
        [BGScroll addSubview:_basiccView];
        
        UIButton *button = (UIButton *)[_basiccView viewWithTag:9999];
        UIButton *button1 = (UIButton *)[_basiccView viewWithTag:10000];

        if (i == 1) {
            _basiccView.nameLabel.text = @"银行账户";
            _basiccView.nameTF.placeholder = @"请输入银行账户";
            
            _basiccView.informationLabel.text = @"银行卡号";
            _basiccView.numberTF.placeholder = @"请输入银行卡号";
            _basiccView.photoLabel.text = @"银行卡照片";
            _basiccView.frontLabel.text = @"银行卡正面照";
            _basiccView.reverseSideLabel.text = @"手持身份证和银行卡照";
            
            button.tag = 1000;
            button1.tag = 1001;

        }else if (i == 2) {
            
            _basiccView.photoView.hidden = YES;
            _basiccView.informationBGView.hidden = YES;
            _basiccView.photoLabelView.hidden = YES;
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(KscreenWidth*2, 100, KscreenWidth, 50)];
            view.backgroundColor = [UIColor whiteColor];
            //view.backgroundColor = [UIColor whiteColor];
            [self.scrollView addSubview:view];
            UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, KscreenWidth/2-20, 50)];
            nameLabel.text = @"机构信息";
            [view addSubview:nameLabel];
            _TF = [[UITextField alloc]initWithFrame:CGRectMake(KscreenWidth/4, 0, KscreenWidth/4*3, 50)];
            _TF.borderStyle = UITextBorderStyleNone;
            _TF.placeholder = @"请输入机构信息";
            
            [view addSubview:_TF];
            
             UIButton * Sendbutton = [UIButton buttonWithType:UIButtonTypeCustom];
             Sendbutton.frame = CGRectMake(10, (KscreenWidth/2-10)/16*9+40 + 260, KscreenWidth - 20, 50);
             [Sendbutton setTitle:@"确定" forState:UIControlStateNormal];
              Sendbutton.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
             [Sendbutton addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
             Sendbutton.clipsToBounds = YES;
             Sendbutton.layer.cornerRadius = 5;
            [_basiccView addSubview:Sendbutton];
            
        }
    }
    
}
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
-(void)btnEvent:(UIButton *)sender
{
   BasicCustomView *basiccView = [self.scrollView viewWithTag:200];
//    NSString *str1 = basiccView.nameTF.text;
//    NSString *str2 = basiccView.numberTF.text;
    BasicCustomView *basiccView1 = [self.scrollView viewWithTag:201];
//    NSString *str3 = basiccView1.nameTF.text;
//    NSString *str4 = basiccView1.numberTF.text;
//    NSString *str5 = _TF.text;
//    NSLog(@"姓名%@身份证%@银行账户%@卡号%@机构%@",str1,str2,str3,str4,str5);
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *auth = [user objectForKey:@"auth"];
    NSString *key = [user objectForKey:@"key"];
    NSString *sign = [NSString stringWithFormat:@"%@%@%@%@%@%@",basiccView.nameTF.text,basiccView.numberTF.text,basiccView1.nameTF.text,basiccView1.numberTF.text,@"1604196866456901",key];
    NSLog(@"%@",sign);
    NSString *SIGN = [self md5:sign];
    //转换成16位
    //NSString *SIGN = [[UUID substringFromIndex:8] substringToIndex:16];

    NSDictionary *dic1 = @{@"shopAccount":basiccView.nameTF.text,
                           @"shopCert":basiccView.numberTF.text,
                           @"bankAccount":basiccView1.nameTF.text,
                           @"bankNumber":basiccView1.numberTF.text,
                           @"orgCode":@"1604196866456901",
                           @"token":auth,
                           @"sign":SIGN,
                            };
    NSDictionary *dicc = @{@"action":@"ShopBaseInfo",
                           @"data":dic1};
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:HOST params:params success:^(id result) {
        NSLog(@"数据:%@",result);
        NSDictionary *dic = [result JSONValue];
        NSString *msg = dic[@"msg"];
        [AlertView(msg, @"确定") show];
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
    }];
}

#pragma mark -- button点击事件
- (void)buttonClick:(UIButton *)sender {
    NSLog(@"%ld",sender.tag);
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


- (void)choosePictureButtonClick:(UIButton *)sender {
    NSLog(@"%----ld",sender.tag);
   
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //1、验证方法是否被调用；2、验证参数buttonIndex的值为多少；
    NSLog(@"click-->%ld", buttonIndex);
    //alert buttonIndex规律：有取消按钮，取消为0，后面一次按照顺序递增；如果没有取消按钮，从0开始依次递增；
    if (buttonIndex == 1) {
        [self addCarema];
    }
    if (buttonIndex == 2) {
        [self openPicLibrary];
    }
}

-(void)btnClick{
    NSLog(@"看看滴滴滴");

    _basiccView = [self.scrollView viewWithTag:200];
    NSLog(@"44444%@",_basiccView.nameTF.text);
    
}
-(void)btnClickWith:(NSInteger )index
{
    
//    BasicCustomView *View = [self.scrollView viewWithTag:201];
//    View.nameTF.text = @"你好";
    
    _currentIndex = index;
    UIButton * btn =[self.scrollView viewWithTag:_currentIndex];
    [btn setImage:nil forState:UIControlStateNormal];
    if (_currentIndex == 1000) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选取照片", nil];
        [alertView show];
    }
    if (_currentIndex == 10000) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选取照片", nil];
        [alertView show];
    }
    if (_currentIndex == 9999) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选取照片", nil];
        [alertView show];
    }
    if (_currentIndex == 1001) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选取照片", nil];
        [alertView show];
    }

    NSLog(@"滴滴滴滴%ld",_currentIndex);
    
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
    //得到图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSLog(@"%@",image);
    
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSString *imageBase64 = [NSString stringWithFormat:@"%@%@",@"data:image/png;base64,",encodedImageStr];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *auth = [user objectForKey:@"auth"];
    NSString *key = [user objectForKey:@"key"];
    
    NSString *sign = [NSString stringWithFormat:@"%@%@",@"1",key];
    NSString *str = [self md5:sign];
    
    NSDictionary *dic1 = @{@"picNbr":@"1",
                           @"picBase64":imageBase64,
                           @"token":auth,
                           @"sign":str,
                           };
    NSDictionary *dicc = @{@"action":@"ShopPicInfo",
                           @"data":dic1};
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:HOST params:params success:^(id result) {
        NSLog(@"数据:%@",result);
        NSDictionary *dic = [result JSONValue];
        NSString *msg = dic[@"msg"];
        [AlertView(msg, @"确定") show];
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
    }];
    
    UIButton * btn =[self.scrollView viewWithTag:_currentIndex];
    
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    
      //图片存入相
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    [self dismissViewControllerAnimated:YES completion:nil];
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
#pragma mark -- scrollView的代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.animationView.frame = CGRectMake(15+ (KscreenWidth/3)*scrollView.contentOffset.x/KscreenWidth, 40, (KscreenWidth/3 - 30), 5);
}
- (void)leftEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- 设置tabBar消失
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
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
