//
//  SetupViewController.m
//  JingXuan
//
//  Created by wj on 16/5/16.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "SetupViewController.h"
#import "macro.h"
#import "UIView+SDAutoLayout.h"
#import "ModificationPSWViewController.h"
#import "NSObject+SBJSON.h"
#import "IBHttpTool.h"
#import <CommonCrypto/CommonDigest.h>

@interface SetupViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation SetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBaseVCAttributes:@"设置" withLeftName:@"返回" withRightName:nil withColor:NavBack];
    self.view.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:242.0/255.0 alpha:1];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 84, KscreenWidth, KscreenHeight) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:242.0/255.0 alpha:1];
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitBtn setTitle:@"退    出" forState:UIControlStateNormal];
    [exitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    exitBtn.backgroundColor = [UIColor colorWithRed:251.0/255.0 green:38.0/255.0 blue:50.0/255.0 alpha:1];
    exitBtn.clipsToBounds = YES;
    exitBtn.layer.cornerRadius = 3;
    [exitBtn addTarget:self action:@selector(exitClikc:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exitBtn];
    exitBtn.sd_layout.bottomSpaceToView(self.view,100).leftSpaceToView(self.view,20).rightSpaceToView(self.view,20).heightRatioToView(self.view,0.06);
}
- (void)exitClikc:(UIButton *)sender {
    
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *auth = [user objectForKey:@"auth"];
//    NSString *key = [user objectForKey:@"key"];
//    NSString *sign = [NSString stringWithFormat:@"%@%@%@%@%@",orderType,ts,te,@"0",key];
//    NSLog(@"%@",sign);
//    NSString *SIGN = [self md5:sign];
    
//    NSDictionary *dic1 = @{@"orderType":orderType,
//                           @"ts":ts,
//                           @"te":te,
//                           @"page":@"0",
//                           @"token":auth,
//                           @"sign":SIGN,
//                           };
//    NSDictionary *dicc = @{@"action":@"ShopForgetPassReset",
//                           @"data":dic1};
//    NSString *params = [dicc JSONFragment];
//    [IBHttpTool postWithURL:HOST params:params success:^(id result) {
//        NSLog(@"数据:%@",result);
//        NSDictionary *dic = [result JSONValue];
//        NSString *msg = dic[@"msg"];
//        [AlertView(msg, @"确定") show];
//    } failure:^(NSError *error) {
//        NSLog(@"网络请求失败:%@",error);
//    }];
    
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *array = [NSArray arrayWithObjects:@"检测更新",@"关于我们",@"意见反馈",@"用户协议",@"",@"修改登录密码",nil];
    cell.textLabel.text = array[indexPath.row];
    if (indexPath.row == 4) {
        cell.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:242.0/255.0 alpha:1];
    }
    if (indexPath.row == 5) {
        UIImageView *iamgeView = [[UIImageView alloc] initWithFrame:CGRectMake(KscreenWidth-40, cell.frame.size.height/3.5, 15, 20)];
        iamgeView.image = [UIImage imageNamed:@"arrow1"];
        [cell addSubview:iamgeView];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",indexPath.row);
    if (indexPath.row == 5) {
        ModificationPSWViewController *modificationPswVC = [[ModificationPSWViewController alloc] init];
        [self.navigationController pushViewController:modificationPswVC animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        return 20.0f;
    }
    return 50.0f;
}
- (void)leftEvent:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
