//
//  KTBCustomerCenterViewController.m
//  KaTongBao
//
//  Created by rongfeng on 16/8/15.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "KTBCustomerCenterViewController.h"
#import "Common.h"
#import "macro.h"
#import "TwoDBarCodeCell.h"
#import "CustomerCenterTableViewCell.h"
#import "UIView+SDAutoLayout.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "GiFHUD.h"
#import <CommonCrypto/CommonDigest.h>
@interface KTBCustomerCenterViewController ()

@end

@implementation KTBCustomerCenterViewController {
    UITableView *Table;
    CustomerCenterTableViewCell *CodeCellOne;
    CustomerCenterTableViewCell *CodeCellTwo;
    CustomerCenterTableViewCell *CodeCellThr;
    CustomerCenterTableViewCell *CodeCellFour;
    CustomerCenterTableViewCell *CodeCellFive;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"客服中心";
    self.view.backgroundColor = [UIColor whiteColor];
    //修改返回按钮
    UIBarButtonItem *left = [[UIBarButtonItem alloc] init];
    left.title = @"返回";
    self.navigationItem.backBarButtonItem = left;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = NavBack;
    
    //[self RequestForCustomerInfo];
}
//禁止右滑返回手势
- (void)viewDidAppear:(BOOL)animated {
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    Table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    Table.delegate = self;
    Table.dataSource = self;
    Table.separatorStyle = UITableViewCellSeparatorStyleNone;
    Table.backgroundColor = LightGrayColor;
    
    UIImageView *HeaderView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 30)];
    HeaderView.backgroundColor = LightGrayColor;
    UIImageView *LineView = [[UIImageView alloc] init];
    LineView.backgroundColor = [UIColor lightGrayColor];
    [HeaderView addSubview:LineView];
    LineView.sd_layout.leftSpaceToView(HeaderView,0).rightSpaceToView(HeaderView,0).bottomSpaceToView(HeaderView,0).heightIs(0.5);
    Table.tableHeaderView = HeaderView;
    

    [self.view addSubview:Table];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identy = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        if (indexPath.row == 0) {
            CodeCellOne = [[CustomerCenterTableViewCell alloc] init];
            CodeCellOne.LeftLabel.text = @"上级服务商:";
            CodeCellOne.RightLabel.text = self.orgName;
            cell = CodeCellOne;
        }else if (indexPath.row == 1) {
            CodeCellTwo = [[CustomerCenterTableViewCell alloc] init];
            CodeCellTwo.LeftLabel.text = @"客服联系人:";
            CodeCellTwo.RightLabel.text = self.cshName;
            cell = CodeCellTwo;
        }else if(indexPath.row == 2) {
            CodeCellThr = [[CustomerCenterTableViewCell alloc] init];
            CodeCellThr.LeftLabel.text = @"客服电话:";
            CodeCellThr.RightLabel.text = self.cshPhone;
            CodeCellThr.RightLabel.textColor = NavBack;
            cell = CodeCellThr;
        }else if (indexPath.row == 3) {
            CodeCellFour = [[CustomerCenterTableViewCell alloc] init];
            CodeCellFour.LeftLabel.text = @"客服座机:";
            CodeCellFour.RightLabel.text = self.cshTel;
            CodeCellFour.RightLabel.textColor = NavBack;
            cell = CodeCellFour;
        }else if (indexPath.row == 4) {
            CodeCellFive = [[CustomerCenterTableViewCell alloc] init];
            CodeCellFive.LeftLabel.text = @"客服微信:";
            CodeCellFive.RightLabel.text = self.cshWeixin;
            cell = CodeCellFive;
        }else {
            
        }
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 2 && ![self.cshPhone isEqualToString:@""]) {
        UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"提示" message:self.cshPhone delegate:self cancelButtonTitle:@"呼叫" otherButtonTitles:@"取消", nil];
        Alert.tag = 200;
        
        [Alert show];
    }else if ((indexPath.row == 3) && (![self.cshTel isEqualToString:@""])) {
        UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"提示" message:self.cshTel delegate:self cancelButtonTitle:@"呼叫" otherButtonTitles:@"取消", nil];
        Alert.tag = 201;
        [Alert show];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 200) {
        if (buttonIndex == 0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.cshPhone]]];
        }else  {
            NSLog(@"&&&&&&");
        }
    }else if (alertView.tag == 201) {
        if (buttonIndex == 0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.cshTel]]];
        }else  {
            NSLog(@"&&&&&&");
        }
    }
    
}

//- (void)alertView:(UIAlertAction *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    
//    if (buttonIndex == 0) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4006007909"]];
//    }else  {
//        NSLog(@"&&&&&&");
//    }
//}


//- (void)RequestForCustomerInfo {
//    
//    NSString *url = JXUrl;
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *token = [user objectForKey:@"token"];
//    NSString *key = [user objectForKey:@"key"];
//    NSString *sign = [self md5:key];
//    NSLog(@"%@,%@,%@",token,key,sign);
//    NSDictionary *dic = @{
//                          @"token":token,
//                          @"sign":sign
//                          };
//    NSDictionary *actionDic = @{
//                                @"action":@"shopOrgInfo",
//                                @"data":dic
//                                };
//    NSLog(@"actionDic:%@",actionDic);
//    NSString *paramis = [actionDic JSONFragment];
//    [IBHttpTool postWithURL:url params:paramis success:^(id result) {
//        NSDictionary *Dic = [result JSONValue];
//        NSLog(@"返回的数据:%@",Dic);
//        NSString *code = Dic[@"code"];
//        NSString *msg = Dic[@"msg"];
//        NSString *orgName = Dic[@"orgName"];
//       // NSString *orgNick = Dic[@"orgNick"];
//        NSString *cshName = Dic[@"cshName"];
//        NSString *cshPhone = Dic[@"cshPhone"];
//        NSString *cshTel = Dic[@"cshTel"];
//        NSString *cshWeixin = Dic[@"cshWeixin"];
//        //NSString *cshQq = Dic[@"cshQq"];
//        
//        if (![code isEqualToString:@"000000"]) {
//            [self alert:msg];
//        }else {
//            CodeCellOne.RightLabel.text = orgName;
//            CodeCellTwo.RightLabel.text = cshName;
//            CodeCellThr.RightLabel.text = cshPhone;
//            CodeCellFour.RightLabel.text = cshTel;
//            CodeCellFive.RightLabel.text = cshWeixin;
//            //[Table reloadData];
//        }
//        
//    } failure:^(NSError *error) {
//        
//        NSLog(@"网络错误!!");
//    }];
//}

- (void)alert:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
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
- (void)viewWillDisappear:(BOOL)animated {
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
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
