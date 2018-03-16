//
//  MartViewController.m
//  wujieNew
//
//  Created by rongfeng on 15/12/17.
//  Copyright © 2015年 rongfeng. All rights reserved.
//

#import "MartViewController.h"
#import "Common.h"
#import "BusiIntf.h"
#import "BankNumberVC.h"
#define  Weburl @"http://www.yyg111.com"
#define  MartUrl @"http://mob10.wifenxiao.com/Shop/index/sid/4019089.html?pid=25090858"
#import "macro.h"
#import "GiFHUD.h"
@implementation MartViewController {
    UIWebView *Web;
    NSMutableURLRequest *request;
    NSString *currentUrl;
    NSString *currentURL;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    //设置导航栏背景色和字体
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = NavBack;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    self.tabBarController.tabBar.frame = CGRectZero;   //将tabbar frame 设置为0；
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"  返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
//    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackBtn.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
//    leftBtn.title = nil;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = left;
    
    self.title = @"商城";
    self.view.backgroundColor = [UIColor whiteColor];
    Web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 64 )];
    Web.delegate = self;
    Web.scrollView.bounces = NO;   //
    [Web setScalesPageToFit:YES];
    //NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //NSString *YyToken = [user objectForKey:@"YyToken"];
    //NSString *YySign = [user objectForKey:@"YySign"];
    NSURL *url = [NSURL URLWithString:MartUrl];
    request = [[NSMutableURLRequest alloc] initWithURL:url];
    //[request addValue:YyToken forHTTPHeaderField:@"YyToken"];
    //[request addValue:YySign forHTTPHeaderField:@"YySign"];
    [request setHTTPMethod:@"POST"];
    request = [request copy];
    NSLog(@"请求:%@\n url:%@\n 请求头:%@",request,Weburl,request.allHTTPHeaderFields);
    [Web loadRequest:request];
    [self.view addSubview:Web];
    currentUrl = Weburl;
    
    [GiFHUD showWithOverlay];
    
}
//切换tabbar
- (void)back {
    
    if ([Web canGoBack]) {
        [Web goBack];
    }else {
        self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:0];
    }
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [GiFHUD dismiss];
    //NSLog(@"加载完成");
    currentURL = webView.request.URL.absoluteString;
    NSLog(@"当前url:%@",currentURL);
    //多次获取同一URL时不去请求,否则会导致闪烁
//    if ([currentUrl isEqualToString:currentURL] || currentURL == nil) {
//        return;
//    }else if ([currentURL hasPrefix:@"http://api9.wujieapp.net/yy/pay"] ) {
//        
//        NSLog(@"需要跳转的Url:%@",currentURL);
//        NSString *linkId = [self jiexi:@"linkId" webaddress:currentURL];
//        NSString *price = [self jiexi:@"price" webaddress:currentURL];
//        NSString *frontUrl = [self jiexi:@"frontUrl" webaddress:currentURL];
//        NSString *backUrl = [self jiexi:@"backUrl" webaddress:currentURL];
//        NSString *token = [self jiexi:@"token" webaddress:currentURL];
//        NSString *sign = [self jiexi:@"sign" webaddress:currentURL];
//        NSLog(@"跳转参数:LinkId:%@,price:%@,frontUrl:%@,backUrl:%@,token:%@,sign:%@",linkId,price,frontUrl,backUrl,token,sign);
//        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//        if ([token isEqualToString:[user objectForKey:@"token"]]) { //如果与用户登录的"token"匹配则进行跳转
//            BankNumberVC *bankVc = [[BankNumberVC alloc] init];
//            [BusiIntf curPayOrder].GoodsID = @"1";
//            [BusiIntf curPayOrder].OrderAmount = [NSString stringWithFormat:@"%d",([price intValue]/100)];
//            [BusiIntf curPayOrder].OrderName = @"货款";
//            [BusiIntf curPayOrder].OrderDesc = @"";
//            bankVc.sign = sign;
//            [self.navigationController pushViewController:bankVc animated:YES];
//            
//        }else { //如果不匹配则跳转到“一元中首页”
//            
//        }
//        request.URL = [NSURL URLWithString:Weburl];
//        [webView loadRequest:request];
//        currentUrl = Weburl;
//    }
//    else {
//        request.URL = [NSURL URLWithString:currentURL];
//        [webView loadRequest:request];
//        currentUrl = currentURL;
//    }
}
//正则解析Url获取参数
-(NSString *) jiexi:(NSString *)CS webaddress:(NSString *)webaddress
{
    NSError *error;
    NSString *regTags=[[NSString alloc] initWithFormat:@"(^|&|\\?)+%@=+([^&]*)(&|$)",CS];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    // 执行匹配的过程
    // NSString *webaddress=@"http://www.baidu.com/dd/adb.htm?adc=e12&xx=lkw&dalsjd=12";
    NSArray *matches = [regex matchesInString:webaddress
                                      options:0
                                        range:NSMakeRange(0, [webaddress length])];
    for (NSTextCheckingResult *match in matches) {
        //NSRange matchRange = [match range];
        //NSString *tagString = [webaddress substringWithRange:matchRange];  // 整个匹配串
        //        NSRange r1 = [match rangeAtIndex:1];
        //        if (!NSEqualRanges(r1, NSMakeRange(NSNotFound, 0))) {    // 由时分组1可能没有找到相应的匹配，用这种办法来判断
        //            //NSString *tagName = [webaddress substringWithRange:r1];  // 分组1所对应的串
        //            return @"";
        //        }
        
        NSString *tagValue = [webaddress substringWithRange:[match rangeAtIndex:2]];  // 分组2所对应的串
        //    NSLog(@"分组2所对应的串:%@\n",tagValue);
        return tagValue;
    }
    return @"";
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"开始加载!");
 
}

//视图消失后还原tabbar frame
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.frame = CGRectMake(0, KscreenHeight - 49, KscreenWidth, 49);
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    NSLog(@"%@",error);
    //一个页面没有被完全加载之前收到下一个请求，此时迅速会出现此error,error=-999
    //此时可能已经加载完成，则忽略此error，继续进行加载。
    //http://stackoverflow.com/questions/1024748/how-do-i-fix-nsurlerrordomain-error-999-in-iphone-3-0-os
    if([error code] == NSURLErrorCancelled )
    {
        return;
    } else {
        
    }
}


@end
