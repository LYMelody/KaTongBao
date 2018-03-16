//
//  UIPayDefault.m
//  wujie
//
//  Created by rongfeng on 15/11/23.
//  Copyright © 2015年 ND. All rights reserved.
//

#import "UIPayDefault.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
//#import "UIManager.h"
//#import "UIReadBankNo.h"
#import "TDMyMainViewController.h"
@interface UIPayDefault ()

@end

@implementation UIPayDefault

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self addBackBtn];
    
    self.navigationItem.hidesBackButton = YES;
    self.title = @"支付结果";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"重新支付" forState:UIControlStateNormal];
    button.backgroundColor = LightYellow;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 1007;
    button.layer.cornerRadius = 4;
    [self.view addSubview:button];
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"首页" forState:UIControlStateNormal];
    btn.backgroundColor = Green58;
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 1008;
    btn.layer.cornerRadius = 4;
    [self.view addSubview:btn];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"支付失败";
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    
    UILabel *displayLabel = [[UILabel alloc] init];
    NSMutableString *msg = [[NSMutableString alloc] init];
    [msg appendFormat:@"%@",self.model.errorMsg];
    displayLabel.text = msg;
    displayLabel.textAlignment = NSTextAlignmentCenter;
    displayLabel.font = [UIFont systemFontOfSize:15];
    displayLabel.textColor = [UIColor blackColor];
    [self.view addSubview:displayLabel];
    
    UILabel *codelabel = [[UILabel alloc] init];
    codelabel.text = [NSString stringWithFormat:@"异常代码:%@",self.model.code];
    codelabel.font = [UIFont systemFontOfSize:15];
    codelabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:codelabel];
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.backgroundColor = Coffee;
   
    imgView.image = [UIImage imageNamed:@"wkzf_pay_failed.png"];
    imgView.layer.cornerRadius = 45;
    [self.view addSubview:imgView];
    
    label.sd_layout.leftSpaceToView(self.view,120).topSpaceToView(self.view,203).widthIs(80).heightIs(30);
    displayLabel.sd_layout.leftSpaceToView(self.view,40).topSpaceToView(self.view,241.5).widthIs(240).heightIs(21);
    button.sd_layout.rightSpaceToView(self.view,20).topSpaceToView(self.view,312.5).widthIs(90).heightIs(40);
     btn.sd_layout.leftSpaceToView(self.view,20).topSpaceToView(self.view,312.5).widthIs(90).heightIs(40);
    codelabel.sd_layout.leftSpaceToView(self.view,105).topSpaceToView(self.view,265).widthIs(130).heightIs(20);
    imgView.sd_layout.leftSpaceToView(self.view,119).topSpaceToView(self.view,93).widthIs(90).heightIs(90);
}

- (void)back:(UIButton *)btn {
    if (btn.tag == 1007) {
        //[UIManager doNavWnd:WndReadBankNo];

    }else if (btn.tag == 1008){
        //[UIManager doNavWnd:WndPayMain];
        TDMyMainViewController *Main = [[TDMyMainViewController alloc] init];
        [self.navigationController pushViewController:Main animated:YES];
        
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
