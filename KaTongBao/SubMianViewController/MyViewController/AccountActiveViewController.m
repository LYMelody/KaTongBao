//
//  AccountActiveViewController.m
//  JingXuan
//
//  Created by jinke on 16/5/18.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "AccountActiveViewController.h"
#import "macro.h"
#import "AccountView.h"
#import "CardInformationView.h"
#import "AgreementView.h"

@interface AccountActiveViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation AccountActiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setBaseVCAttributes:@"账户激活" withLeftName:@"返回" withRightName:nil withColor:NavBack];
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    [self initScrollView];
    
}

- (void)initScrollView {
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, KscreenWidth, KscreenHeight-64)];
    self.scrollView.contentSize = CGSizeMake(KscreenWidth, 620);
    [self.view addSubview:self.scrollView];
    
    AccountView *account = [[AccountView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, 190)];
    [self.scrollView addSubview:account];
    
    NSArray *labelArr = [NSArray arrayWithObjects:@"姓  名",@"身份证",@"有效期",@"CVV2",@"手机号",@"验证码", nil];
    NSArray *textFieldArr = [NSArray arrayWithObjects:@"请输入真实姓名",@"请输入持卡人身份证",@"有效期，月、年（如06/15输入0615）",@"CVV2,卡背后三位",@"银行预留手机号",@"短信验证码", nil];
    
    for (int i = 0; i < 6; i ++) {
        CardInformationView *cardView = [[CardInformationView alloc]initWithFrame:CGRectMake(0, 190+40*i, KscreenWidth, 40)];
        cardView.label.text = labelArr[i];
        cardView.textField.placeholder = textFieldArr[i];
        [self.scrollView addSubview:cardView];
        if (i == 5) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(KscreenWidth/4*3, 0, KscreenWidth/4, 40);
            button.backgroundColor = NavBack;
            [button setTitle:@"免费获取" forState:UIControlStateNormal];
            [cardView addSubview:button];
        }
    }
    AgreementView *agreement = [[AgreementView alloc]initWithFrame:CGRectMake(0, 430, KscreenWidth, 100)];
    [self.scrollView addSubview:agreement];
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake(10, 550, KscreenWidth-20, 40);
    [sureButton setTitle:@"确认支付" forState:UIControlStateNormal];
    sureButton.backgroundColor = NavBack;
    sureButton.clipsToBounds = YES;
    sureButton.layer.cornerRadius = 5;
    [self.scrollView addSubview:sureButton];
}

- (void)leftEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- 设置tabBar消失
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
////键盘下落
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.view endEditing:YES];
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
