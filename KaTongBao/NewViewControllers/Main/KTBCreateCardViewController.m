//
//  KTBCreateCardViewController.m
//  KaTongBao
//
//  Created by rongfeng on 16/8/15.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "KTBCreateCardViewController.h"
#import "Common.h"
#import "macro.h"
#import "BusiIntf.h"
#define Weburl @"http://ktb.4006007909.com/shop/bank/clb?token="
//app.4006007909.com/shop/bank/clb?token=9a18404a87992e83d760eda00661db9d   http://m.rong360.com/credit/card/landing/4?code=6&utm_source=zjrf&utm_medium=xyk&utm_campaign=cpa
#define CreateCardUrl @"http://m.rong360.com/credit/card/landing/4?code=6&utm_source=zjrf&utm_medium=xyk&utm_campaign=cpa"
#define JSUrl @"https://wm.cib.com.cn/application/cardapp/Fast/BaseInfo/view"
@interface KTBCreateCardViewController ()

@end

@implementation KTBCreateCardViewController {
    UIWebView *Web;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"信用卡";
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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    //self.title = @"办卡";
    self.view.backgroundColor = [UIColor whiteColor];
    Web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 64)];
    Web.delegate = self;
    [Web setScalesPageToFit:YES];
    Web.backgroundColor = [UIColor whiteColor];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    //NSString *key = [user objectForKey:@"key"];
    NSString *Url = [NSString stringWithFormat:@"%@%@",Weburl,token];
    NSURL *url = nil;
    if (self.tag == 1) {
        url = [NSURL URLWithString:Url];
    }else {
        url = [NSURL URLWithString:CreateCardUrl];
    }
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [Web loadRequest:request];
    [self.view addSubview:Web];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *Agent = [request valueForHTTPHeaderField:@"User-Agent"];
    NSLog(@"获取到的Agent：%@",Agent);
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSString * currentURL = webView.request.URL.absoluteString;
    NSLog(@"当前url:%@",currentURL);
    if ([currentURL isEqualToString:@"https://wm.cib.com.cn/application/cardapp/Fast/BaseInfo/view"]) {
    
        NSString *str2 = [NSString stringWithFormat:@"var p = document.getElementById('indentificationId');p.value = '%@';p.readOnly = true;",[BusiIntf curPayOrder].shopCard];
        [webView stringByEvaluatingJavaScriptFromString:str2];
       
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
