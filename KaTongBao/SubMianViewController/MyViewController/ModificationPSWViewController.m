//
//  ModificationPSWViewController.m
//  JingXuan
//
//  Created by wj on 16/5/17.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "ModificationPSWViewController.h"
#import "macro.h"
#import "ModificationPswView.h"
#import "NSObject+SBJSON.h"
#import "IBHttpTool.h"
#import <CommonCrypto/CommonDigest.h>
@interface ModificationPSWViewController ()
@property (nonatomic, strong) ModificationPswView *modeifcation;
@end

@implementation ModificationPSWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBaseVCAttributes:@"登录密码修改" withLeftName:@"返回" withRightName:nil withColor:NavBack];
    self.view.backgroundColor = LightGrayColor;
    _modeifcation = [[ModificationPswView alloc] initWithFrame:CGRectMake(0, 64, KscreenWidth, KscreenHeight)];
    [_modeifcation.confirmButton addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_modeifcation];
    
    
}
- (void)confirmClick:(UIButton *)sender {
    
    
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *token = [user objectForKey:@"auth"];
        NSString *key = [user objectForKey:@"key"];
        NSString *signStr = [NSString stringWithFormat:@"%@%@%@%@",_modeifcation.primevalPswTF.text,_modeifcation.passTF.text,_modeifcation.conPassTF.text,key];
        NSString *sign = [self md5:signStr];
        NSDictionary *dic1 = @{@"oldPass":_modeifcation.primevalPswTF.text,
                               @"newPass":_modeifcation.passTF.text,
                               @"conPass":_modeifcation.conPassTF.text,
                               @"token":token,
                               @"sign":sign,
                               };
        NSDictionary *dicc = @{@"action":@"ShopModifyPass",
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
- (void)leftEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//键盘下落
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event  {
//    [self. view endEditing:NO];
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
