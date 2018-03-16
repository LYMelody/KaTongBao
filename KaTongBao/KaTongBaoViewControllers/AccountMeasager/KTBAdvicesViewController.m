//
//  KTBAdvicesViewController.m
//  KaTongBao
//
//  Created by rongfeng on 16/6/24.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "KTBAdvicesViewController.h"
#import "macro.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import <CommonCrypto/CommonDigest.h>
@interface KTBAdvicesViewController ()

@end

@implementation KTBAdvicesViewController {
    UITextView *TextView;
    
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    //不隐藏导航栏
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.hidden = NO;
    //隐藏工具栏
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:19],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = NavBack;
    //自定义返回按钮
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    right.title = @"返回";
    self.navigationItem.backBarButtonItem = right;
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.title = @"意见反馈";
    
    UIImageView *BackImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    BackImg.backgroundColor = LightGrayColor;
    BackImg.userInteractionEnabled = YES;
    [self.view addSubview:BackImg];
    
    UITapGestureRecognizer *TapHiddenKeyBoard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HiddenKeyBoard)];
    TapHiddenKeyBoard.numberOfTouchesRequired = 1;
    [BackImg addGestureRecognizer:TapHiddenKeyBoard];
    
    TextView = [[UITextView alloc] init];
    TextView.backgroundColor = [UIColor whiteColor];
    TextView.layer.cornerRadius = 3;
    TextView.font = [UIFont systemFontOfSize:16];
    TextView.delegate = self;
    [self.view addSubview:TextView];
    TextView.sd_layout.leftSpaceToView(self.view,20).topSpaceToView(self.view,8).rightSpaceToView(self.view,20).bottomSpaceToView(self.view,100);
    
    UIButton *SendBtn = [[UIButton alloc] init];
    SendBtn.backgroundColor = NavBack;
    SendBtn.layer.cornerRadius = 3;
    [SendBtn setTitle:@"提 交" forState:UIControlStateNormal];
    [SendBtn addTarget:self action:@selector(Send) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:SendBtn];
    SendBtn.sd_layout.leftSpaceToView(self.view,20).topSpaceToView(TextView,30).rightSpaceToView(self.view,20).heightIs(45);
    
}
//发送消息
- (void)Send {
    
    
    if ([TextView.text isEqualToString:@""])  {
        
        [self alert:@"先说点什么再提交吧:)!"];
        return;
        
    }
    
    NSString *url = JXUrl;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    
    //时间戳
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-DD HH:mm:ss"];
    NSTimeZone *timezone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timezone];
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%.0f",[datenow timeIntervalSince1970]];
    
    NSString *md5 = [NSString stringWithFormat:@"%@%@%@",TextView.text ,timeSp,key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                           @"title":timeSp,
                           @"content":TextView.text,
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"shopQuestState",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSLog(@"数据:%@",result);
        NSDictionary *dic = [result JSONValue];
        NSString *code = dic[@"code"];
        NSString *content = dic[@"msg"];
        if ([content isEqualToString:@"Success"]) {
            content = @"提交成功！";
        }
        [self alert:content];
        if ([code isEqualToString:@"000000"]) {
            //注册成功 2 登陆页面
            //LoginViewController *Login = [[LoginViewController alloc] init];
            [self performSelector:@selector(backToRootView) withObject:nil afterDelay:2];
        } else {
            
        }
        NSLog(@"返回的数据:%@",dic);
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
        
    }];

}



- (void)backToRootView {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)HiddenKeyBoard {
    [TextView resignFirstResponder];
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    
//    [self.view endEditing:YES];
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
