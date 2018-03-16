//
//  JXSettingViewController.m
//  JingXuan
//
//  Created by rongfeng on 16/6/2.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "JXSettingViewController.h"
#import "Common.h"
#import "macro.h"
#import "JXLoginViewController.h"
#import "ViewsCell.h"
#import "UIView+SDAutoLayout.h"
#import "JXReNameViewController.h"
#import "JXPayProtrolViewController.h"
#import "KTBAdvicesViewController.h"
#import "LoginViewController.h"
#import "IBHttpTool.h"
#import "SBJSON.h"
#import "BusiIntf.h"
//#import "PPDLoanSdk.h"
@interface JXSettingViewController ()

@end

@implementation JXSettingViewController {
    
    UIImageView *LineOne;
    UIImageView *LineTwo;
    UIImageView *LineThird;
    UIImageView *LineFour;
    UIImageView *LineFive;
    UILabel *verLab;
    NSString *downloadUrl;
    NSString *versionCode;
    NSString *updateMsg;
    NSString *Anotherurl;
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
    
    [self RequestForVersionUpdate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"设置";
    self.navigationController.navigationBar.barTintColor = NavBack;
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight + 50) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    table.showsVerticalScrollIndicator = NO;
    table.backgroundColor = LightGrayColor;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];
    
    //头视图
    UIImageView *HeaderView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 100)];
    HeaderView.backgroundColor = LightGrayColor;
    
    UIImageView *LogoImg = [[UIImageView alloc] init];
    LogoImg.image = [UIImage imageNamed:@"卡捷通登录页logo.png"];
    [HeaderView addSubview:LogoImg];
    LogoImg.sd_layout.centerXEqualToView(HeaderView).centerYEqualToView(HeaderView).widthIs(KscreenWidth/2 - 20).heightIs(47.5 - 5);
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    NSString *strVer = [NSString stringWithFormat:@"当前版本 %@", version];
    verLab = [[UILabel alloc] init];
    verLab.textAlignment = NSTextAlignmentCenter;
    verLab.font = [UIFont systemFontOfSize:15];
    verLab.text = strVer;
    [HeaderView addSubview:verLab];
    verLab.sd_layout.centerXEqualToView(LogoImg).topSpaceToView(LogoImg,3).widthIs(200).heightIs(20);
    table.tableHeaderView = HeaderView;
    
    
    //尾视图
    UIImageView *FootView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 300)];
    FootView.userInteractionEnabled = YES;
    FootView.backgroundColor = LightGrayColor;
    UILabel *backLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 54, KscreenWidth - 30, 40)];
    backLabel.text = @"退 出";
    backLabel.textColor = [UIColor whiteColor];
    backLabel.textAlignment = NSTextAlignmentCenter;
    backLabel.layer.cornerRadius = 4;
    backLabel.layer.masksToBounds = YES;
    backLabel.backgroundColor = RedColor;
    backLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickClearButton)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.delegate = self;
    
    [backLabel addGestureRecognizer:singleTap];
    [FootView addSubview:backLabel];
    
    table.tableFooterView = FootView;
    
    
    LineOne = [[UIImageView alloc] init];
    LineOne.backgroundColor = [UIColor lightGrayColor];
    LineTwo = [[UIImageView alloc] init];
    LineTwo.backgroundColor = [UIColor lightGrayColor];
    LineThird = [[UIImageView alloc] init];
    LineThird.backgroundColor = [UIColor lightGrayColor];
    LineFour = [[UIImageView alloc] init];
    LineFour.backgroundColor = [UIColor lightGrayColor];
    LineFive = [[UIImageView alloc] init];
    LineFive.backgroundColor = [UIColor lightGrayColor];

}
//退出登录实现方法
-(void)clickClearButton{
    
    
    //退出小贷
    //[LoansSDK logoutAndCleanLoanSDK];
    
    LoginViewController *controller = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:controller] ;
    navController.navigationBarHidden = YES;
    navController.toolbarHidden = YES;
    [UIApplication sharedApplication].keyWindow.rootViewController = navController;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if ([BusiIntf curPayOrder].IsAPPStore) {
//        return 6;
//    }else {
//        return 7;
//    }
    return 7;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        if ([BusiIntf curPayOrder].IsAPPStore) {
            return 0;
        }else {
            return 16;
        }
    }else if (indexPath.row == 1) {
        if ([BusiIntf curPayOrder].IsAPPStore) {
            return 0;
        }else {
            return 45;
        }
    }else if (indexPath.row == 5){
        return 25;
    }else if (indexPath.row == 2) {
        if ([BusiIntf curPayOrder].IsAPPStore) {
            return 0;
        }else {
            return 45;
        }
    }
    else {
        return 45;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
        if (indexPath.row == 0) {
            ViewsCell *ComCell = [[ViewsCell alloc] init];
            ComCell.contentView.backgroundColor = LightGrayColor;
            cell = ComCell;
        }else if (indexPath.row == 1) {
            if ([BusiIntf curPayOrder].IsAPPStore) {  //APP Store布局
                
            }else {
                cell.textLabel.text = @"检测更新";
                cell.textLabel.font = [UIFont systemFontOfSize:16];
                cell.textLabel.textColor = Gray100;
            }
            
        }else if (indexPath.row == 2) {
            if ([BusiIntf curPayOrder].IsAPPStore) {   //APP Store 布局
                
                
            }else {
                cell.textLabel.text = @"关于我们";
                cell.textLabel.font = [UIFont systemFontOfSize:16];
                cell.textLabel.textColor = Gray100;
                [cell.contentView addSubview:LineOne];
                LineOne.sd_layout.leftSpaceToView(cell.contentView,0).rightSpaceToView(cell.contentView,0).topSpaceToView(cell.contentView,0.5).heightIs(0.5);
            }
        }else if (indexPath.row == 3) {
            cell.textLabel.text = @"意见反馈";
            cell.textLabel.textColor = Gray100;
            [cell.contentView addSubview:LineTwo];
            [cell.contentView addSubview:LineThird];
            
            LineTwo.sd_layout.leftSpaceToView(cell.contentView,0).rightSpaceToView(cell.contentView,0).bottomSpaceToView(cell.contentView,0.5).heightIs(0.5);
            LineThird.sd_layout.leftSpaceToView(cell.contentView,0).rightSpaceToView(cell.contentView,0).topSpaceToView(cell.contentView,0.5).heightIs(0.5);

        }else if (indexPath.row == 4) {
            cell.textLabel.text = @"用户协议";
            cell.textLabel.textColor = Gray100;
            [cell.contentView addSubview:LineFive];
            LineFive.sd_layout.leftSpaceToView(cell.contentView,0).rightSpaceToView(cell.contentView,0).bottomSpaceToView(cell.contentView,0.5).heightIs(0.5);
            
        }
        else if (indexPath.row == 5) {
            ViewsCell *ComCell = [[ViewsCell alloc] init];
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            ComCell.contentView.backgroundColor = LightGrayColor;
            cell = ComCell;
        } else if (indexPath.row == 6) {
            cell.textLabel.text = @"修改登录密码";
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.textLabel.textColor = Gray100;
            
            [cell.contentView addSubview:LineFour];
            LineFour.sd_layout.leftSpaceToView(cell.contentView,0).rightSpaceToView(cell.contentView,0).bottomSpaceToView(cell.contentView,0.5).heightIs(0.5);
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 6) {
        JXReNameViewController *ReName = [[JXReNameViewController alloc] init];
        [self.navigationController pushViewController:ReName animated:YES];
        
    }else if (indexPath.row == 4) {
        JXPayProtrolViewController *JXProtrolVc = [[JXPayProtrolViewController alloc] init];
        [self.navigationController pushViewController:JXProtrolVc animated:YES];
    }else if (indexPath.row == 3) {
        KTBAdvicesViewController *AdvieceVc = [[KTBAdvicesViewController alloc] init];
        [self.navigationController pushViewController:AdvieceVc animated:YES];
    }else if (indexPath.row == 1) {
//        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//        NSLog(@"是否是最新版本:%@",[user objectForKey:@"IsViewNew"]);
        if (downloadUrl != nil) {
            if (downloadUrl != nil) {
                NSString  *Title = [NSString stringWithFormat:@"最新版本为:%@,是否更新?",versionCode];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:Title message:updateMsg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.tag = 10000;
                [alert show];
               
            }
        } else {
            [self alert:@"您已是最新版本!"];
        }
    }
}

//检测版本更新
- (void)RequestForVersionUpdate {
    
    NSString *url = JXUrl;
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    NSString *identify = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleInfoDictionaryVersionKey];
    NSString *Ver = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前版本:%@,%@,%@",version,identify,Ver);
    NSDictionary *dic1 = @{
                           @"os":@"IOS",
                           @"version":version
                           };
    NSDictionary *dicc = @{
                           @"action":@"shopSdkVersionState",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSLog(@"数据:%@",result);
        NSDictionary *dic = [result JSONValue];
        NSString *isUpd = dic[@"isUpd"];
        NSString *patchVersion = dic[@"patchVersion"];
        updateMsg = dic[@"updateMsg"];
        versionCode = dic[@"versionCode"];
        downloadUrl = dic[@"downloadUrl"];
        NSString *updateFlg = dic[@"updateFlg"];
        NSString *forturl = @"itms-services:///?action=download-manifest&url=";
        Anotherurl = [NSString stringWithFormat:@"%@%@",forturl,downloadUrl];
        verLab.text = [NSString stringWithFormat:@"当前版本:V%@",Ver];
//        if (downloadUrl != nil) {
//            NSString  *Title = [NSString stringWithFormat:@"最新版本为:%@,是否更新?",versionCode];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:Title message:updateMsg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            alert.tag = 10000;
//            [alert show];
//            //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
//        }
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
        
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
   if (alertView.tag == 10000) {
       if (buttonIndex == 0) {
           
       }else if (buttonIndex == 1) {
           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:Anotherurl]];
       }
   }
}

- (void)alert:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    //禁用右滑返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    //开启右滑返回
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
