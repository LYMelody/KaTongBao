//
//  AppDelegate.m
//  KaTongBao
//
//  Created by rongfeng on 16/6/15.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "AppDelegate.h"
#import "JXLoginViewController.h"
#define APPID  @"8266152b039dd499a70faac5899e2584"
#import "LoginViewController.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "Common.h"
#import "GuidViewController.h"
#import <PgySDK/PgyManager.h>
#import <PgyUpdate/PgyUpdateManager.h>

#import <ShareSDKUI/ShareSDKUI.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WeiboSDK.h"
#import "WXApi.h"

#define ShareAppKey @"1bb7a83cc8740"
#define ShareAPPSecrect @"97accdadb09d999d3c68e940aa760501"

#define PPDSDK_sKeyAPPID @"bc76e4ee44fb4a07b7943e70111069de"
#define PPDSDK_PubKey @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCZeZxVixhB7a6v4QIVKYuLU+kuQNcrmqp1G1s7MV5mMIIYxCsqx3gR5T4yHHh3N82tszy2Ri37dIZhxpIqGjrnZy3c2lXMyHTuOAthdwwkzW5XZSKHJ7GVPQN8rryspEFjw52okuuaqOYudOvvAZYD3QmT7NdXYojCipOihkTxpQIDAQAB"
#define PPDSDK_PriKey @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAJl5nFWLGEHtrq/hAhUpi4tT6S5A1yuaqnUbWzsxXmYwghjEKyrHeBHlPjIceHc3za2zPLZGLft0hmHGkioaOudnLdzaVczIdO44C2F3DCTNbldlIocnsZU9A3yuvKykQWPDnaiS65qo5i506+8BlgPdCZPs11diiMKKk6KGRPGlAgMBAAECgYEAlmqo/PIJQTxY1AmcB++i01fXFrz35cV9QK8iF/6HvXHXX7yLbi73D9r0vRpIOtfXXmFnpGFd2a/XsOZ0BI2WogWcHsHlTJmL3oVAnwttAbNoHSyvsbDlJjmeLdYSdlqBfBNSa+EhNI4OnT77+Gd3hNqcvqVZIVF+PQSmLoYMrHUCQQDTOWB6DntK7i/8HDK27fHeLpYWWziykwzR5EkLwWXqlI1yjQQTv07asUrUaQzKG94ZzLyvFtFofbrlks1xkYv3AkEAugJUlWohdNHkP5i1pLVstFOSwKfyN1CitFoZbBkz2oFbFQ031rh/1CP4EiDZE3GJjMms6N4IvwmvRqSd0skwQwJAcd1PXdzqp/UI1w5YZHaW2SAh9oFMai+NTKSUoAqspy1XpvXPydlqZ8gFP8Y1h8pIC35sBLL3Ri3pD5L4vw0n9wJBAJkQ1d3magWhuvwChGc3zG5P35GeIpoWRu22vvjPfHYwwG0AZZTSWo6N0tPIKBnx8kjipOEz5WqfY5b0W9NbL9UCQFGxuWfQPZypDxvGmtIKA1fc0FTP5iK98rpM2btTOguyuneDg7Y2iATQe4JWjjBhtE6e+5OLgIMZeG35kksxXcw="

#define APPLEID @"1184703457"

@interface AppDelegate ()

@end
//@implementation NSURLRequest(DataController)
@implementation AppDelegate {
    NSString *Anotherurl;
    NSString *trackCensoredName;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    //设置状态栏样式
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    //设置返回按钮字体颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
//    GuidViewController *GuidVc = [[GuidViewController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:GuidVc] ;
//    nav.navigationBarHidden = YES;
//    nav.toolbarHidden = YES;
//    self.window.rootViewController = nav;
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"第一次启动!");
        GuidViewController *GuidVc = [[GuidViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:GuidVc] ;
        nav.navigationBarHidden = YES;
        nav.toolbarHidden = YES;
        self.window.rootViewController = nav;
        
    }else{
    
        NSLog(@"不是第一次启动了！");
    
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVC] ;
        nav.navigationBarHidden = YES;
        nav.toolbarHidden = YES;
        self.window.rootViewController = nav;
    }
    
    [self.window makeKeyAndVisible];
    
    
    BOOL IsAPPStore = YES;
    
    //检测更新
//    if (IsAPPStore) {
//        [self CheckAPPStoreUpDate];
//    }else {
//        [self RequestForVersionUpdate];
//    }
    
    //设置启动动画
    UIImage *splashImg;
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        splashImg = [UIImage imageNamed:@"launch.jpg"];
    }
    else {
        splashImg = [UIImage imageNamed:@"launch.jpg"];
    }
    UIImageView *launchView = [[UIImageView alloc] initWithImage:splashImg];
    launchView.backgroundColor = [UIColor yellowColor];
    launchView.image = splashImg;
    launchView.contentMode = UIViewContentModeScaleToFill;
    
    NSLog(@"%@", NSStringFromCGSize(splashImg.size));
    [self.window addSubview:launchView];
    
    launchView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.window addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[launchView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(launchView)]];
    
    NSLayoutConstraint *cons = [NSLayoutConstraint constraintWithItem:launchView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:launchView.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    [self.window addConstraint:cons];
    
    NSLayoutConstraint *con2 = [NSLayoutConstraint constraintWithItem:launchView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:launchView attribute:NSLayoutAttributeWidth multiplier:splashImg.size.height/splashImg.size.width constant:0];
    [launchView addConstraint:con2];
    
    NSLog(@"%@", NSStringFromCGRect(launchView.frame));
    [self.window layoutIfNeeded];
    NSLog(@"%@", NSStringFromCGRect(launchView.frame));
    
    CGFloat offset = launchView.frame.size.width - [[UIScreen mainScreen] bounds].size.width;//图片有一个像素空白
    //    return YES;
    
    UIImageView *imgLogo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"卡捷通引导页-"]];
    imgLogo.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    //    imgLogo.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 4);
    [self.window addSubview:imgLogo];
    //imgLogo.sd_layout.centerXEqualToView(self.window).leftSpaceToView(self.window,0).rightSpaceToView(self.window,0);
    
    
    UILabel *labTips = [[UILabel alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 80, [UIScreen mainScreen].bounds.size.width, 80)];
    labTips.text = [[NSString alloc]initWithFormat:@"当前版本 v%@\n浙江融丰信息技术服务有限公司", @"1.0"];
    labTips.textColor = [UIColor whiteColor];
    labTips.textAlignment = NSTextAlignmentCenter;
    labTips.numberOfLines = 0;
    labTips.font = [UIFont boldSystemFontOfSize:12];
    //[self.window addSubview:labTips];
    
    [self.window bringSubviewToFront:launchView];
    [self.window bringSubviewToFront:imgLogo];
    [self.window bringSubviewToFront:labTips];
    
    [UIView animateWithDuration:2.5 animations:^{
        cons.constant = offset;
        [self.window layoutIfNeeded];
    } completion:^(BOOL finished) {
        NSLog(@"%@", NSStringFromCGRect(launchView.frame));
        [UIView animateWithDuration:0.5 animations:^{
            
            launchView.alpha = 0;
            labTips.alpha = 0;
            imgLogo.alpha = 0;
        } completion:^(BOOL finished) {
            [launchView removeFromSuperview];
            [labTips removeFromSuperview];
            [imgLogo removeFromSuperview];
        }];
    }];

    
    //添加各大分享平台：新浪微博、微信、QQ
    
    [ShareSDK registerApp:ShareAppKey activePlatforms:@[
                                                   @(SSDKPlatformTypeQQ),
                                                   @(SSDKPlatformTypeWechat),
                                                   @(SSDKPlatformTypeSinaWeibo)] onImport:^(SSDKPlatformType platformType) {
                                                       switch (platformType) {
                                                           case SSDKPlatformTypeSinaWeibo:  //新浪微博
                                                               [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                                                               break;
                                                           case SSDKPlatformTypeWechat:  //微信
                                                               [ShareSDKConnector connectWeChat:[WXApi class]];
                                                               break;
                                                           case SSDKPlatformTypeQQ:  //QQ
                                                               [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                                                               break;
                                                           default:
                                                               break;
                                                       }
                                                   } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                                                       switch (platformType) {
                                                           case SSDKPlatformTypeSinaWeibo:
                                                               [appInfo SSDKSetupSinaWeiboByAppKey:@"726683382" appSecret:@"cfffd8cbd975c86375475749cf1c37bd" redirectUri:@"http://ktb.4006007909.com/down" authType:SSDKAuthTypeSSO];
                                                               break;
                                                           case SSDKPlatformTypeWechat:
                                                               [appInfo SSDKSetupWeChatByAppId:@"wxde964350d2bca11a" appSecret:@"4ee0e74cbac1e970eb9d82d64ada47e0"];
                                                               break;
                                                           case SSDKPlatformTypeQQ:
                                                               [appInfo SSDKSetupQQByAppId:@"101382273" appKey:@"70459bc55374225f47bd15cb4ca566c2" authType:SSDKAuthTypeBoth];
                                                               break;
                                                           default:
                                                               break;
                                                       }
                                                   }];
    return YES;
}

//APPStore版本的版本检测
- (void)CheckAPPStoreUpDate {
    
    //获取当前版本
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"本地版本:%@",appVersion);
    //拼接连接
    NSString *checkUrlString = [NSString stringWithFormat:@"https:itunes.apple.com/lookup?id=%@",APPLEID];
    NSURL *checkUrl = [NSURL URLWithString:checkUrlString];
    
    NSString *appInfoString = [NSString stringWithContentsOfURL:checkUrl encoding:NSUTF8StringEncoding error:nil];
    
    NSError *error = nil;
    NSData *JSONData = [appInfoString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *appinfo = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:&error];
    NSLog(@"版本信息:%@",appinfo);
    if (!error && appinfo) {
        NSArray *resultAry = appinfo[@"results"];
        NSDictionary *resultDic = resultAry.firstObject;
        NSLog(@"版本信息2：%@",resultDic);
        //版本号
        NSString *NewVersion = resultDic[@"version"];
        NSLog(@"版本信息3:%@",NewVersion);
        //下载地址
        trackCensoredName = resultDic[@"trackViewUrl"];
        NSLog(@"下载地址:%@",trackCensoredName);
        //更新提示
        NSString *Tips = resultDic[@"releaseNotes"];
        //比较版本号
        if ([appVersion compare:NewVersion options:NSNumericSearch] == NSOrderedAscending) {
            UIAlertView *UpdataAlert = [[UIAlertView alloc] initWithTitle:@"更新提示" message:Tips delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            UpdataAlert.tag = 100;
            [UpdataAlert show];
        }
    }
}

//检测是不是最新版本并记录
- (void)UpDateMethod:(NSDictionary *)response {
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    if (response != nil) {
        [user setObject:@"0" forKey:@"IsViewNew"];
        [user synchronize];
        
    } else {
        [user setObject:@"1" forKey:@"IsViewNew"];
        [user synchronize];
        
    }
    
    NSLog(@"是否是最新版本:%@",[user objectForKey:@"IsViewNew"]);
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
        //NSString *isUpd = dic[@"isUpd"];
        //NSString *patchVersion = dic[@"patchVersion"];
        NSString *updateMsg = dic[@"updateMsg"];
        NSString *versionCode = dic[@"versionCode"];
        NSString *downloadUrl = dic[@"downloadUrl"];
        //NSString *updateFlg = dic[@"updateFlg"];
        NSString *forturl = @"itms-services:///?action=download-manifest&url=";
        Anotherurl = [NSString stringWithFormat:@"%@%@",forturl,downloadUrl];
        if (downloadUrl != nil) {
            NSString  *Title = [NSString stringWithFormat:@"最新版本为:%@,是否更新?",versionCode];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:Title message:updateMsg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
            //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
        
    }];
}

//
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if (alertView.tag == 100) {
        if (buttonIndex == 0) {
            //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:Anotherurl]];
        }else {
            if (trackCensoredName) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trackCensoredName]];
            }
        }
    }else {
        if (buttonIndex == 0) {
            
            
        }else if (buttonIndex == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:Anotherurl]];
        }

    }
    
    
}

+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
{
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
