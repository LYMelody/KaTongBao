//
//  YiBaoVC.m
//  wujieNew
//
//  Created by rongfeng on 16/2/17.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "YiBaoVC.h"
#import "Common.h"
#import "SVProgressHUD.h"
@interface YiBaoVC ()

@end

@implementation YiBaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.Name;
    [SVProgressHUD show];
    UIWebView *YiBaoWeb = [[UIWebView alloc] init];
    YiBaoWeb.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight + 50);
    YiBaoWeb.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.Url]];
    [self.view addSubview:YiBaoWeb];
    [YiBaoWeb loadRequest:request];
    
}


#pragma mark - webview delegate

- (void) webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"+++++++++++++++success to load webview");
    [SVProgressHUD dismiss];
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"++++++++++++%@", [error description]);
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
