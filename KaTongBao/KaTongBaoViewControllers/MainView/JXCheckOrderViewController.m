//
//  JXCheckOrderViewController.m
//  JingXuan
//
//  Created by rongfeng on 16/6/3.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "JXCheckOrderViewController.h"
#import "macro.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "ShortcutView.h"
#import "TradeNameView.h"
#import "JXPayWithOrderViewController.h"
#import "TDAlertViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "JXBankInfoViewController.h"
#import "BusiIntf.h"
#import <CommonCrypto/CommonDigest.h>
#import "SBJSON.h"
#import "IBHttpTool.h"
@interface JXCheckOrderViewController ()<MyAlertViewPopupDelegate>

@end

@implementation JXCheckOrderViewController {
    TDAlertViewController *AlertViewController;
    UILabel *GoodsNameLab;
    NSArray *arr;
    UITextField *textField;
    UILabel *BankLab;
    UILabel *BankNumberLab;
    UITableView *tableView;
    UIImageView *LineOne;
    UIImageView *LineTwo;
    UIImageView *LineThree;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"确认订单";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:19],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = NavBack;
    //自定义返回按钮
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    right.title = @"返回";
    self.navigationItem.backBarButtonItem = right;
   // NSLog(@"卡的信息:%@,%@",[BusiIntf curPayOrder].AddBankName,[BusiIntf curPayOrder].AddBankNumber);
    
//    if ([BusiIntf curPayOrder].AddBankName ) {
//        textField.hidden = YES;
//        BankLab.hidden = NO;
//        BankLab.text = [BusiIntf curPayOrder].AddBankName;
//        BankNumberLab.hidden = NO;
//        BankNumberLab.text = [BusiIntf curPayOrder].AddBankNumber;
//    }else {
//        
//        
//        
//        
//    }
    
    LineOne = [[UIImageView alloc] init];
    LineOne.backgroundColor = [UIColor lightGrayColor];
    LineTwo = [[UIImageView alloc] init];
    LineTwo.backgroundColor = [UIColor lightGrayColor];
    LineThree =[[UIImageView alloc] init] ;
    LineThree.backgroundColor = [UIColor lightGrayColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LightGrayColor;
    //    _noCardModel = [[NoCardModel alloc] init];
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight + 64) style:UITableViewStylePlain];
    tableView.backgroundColor = LightGrayColor;
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.scrollEnabled = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.cornerRadius = 3;
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    [button setBackgroundColor:NavBack];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.sd_layout.bottomSpaceToView (self.view,100).leftSpaceToView(self.view,20).rightSpaceToView(self.view,20).heightRatioToView(self.view,0.09);
    GoodsNameLab = [[UILabel alloc] init];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.tag == 100) {
        return 1;
    }else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *array = [NSArray arrayWithObjects:@"订单金额:",@"交易时间:",@"订单编号:", nil];
    
    if (indexPath.section == 0) {
        ShortcutView *shortcut = [[ShortcutView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
        [cell addSubview:shortcut];
        if (indexPath.row == 0) {
            shortcut.label1.text = [NSString stringWithFormat:@"%@元",self.amount];
            shortcut.label1.textColor = [UIColor redColor];
        }else {
            shortcut.label1.textColor = LightGrayColor;
            shortcut.label1.font = [UIFont systemFontOfSize:16];
        }
        shortcut.label.text = array[indexPath.row];
        
    }
    if (indexPath.row == 2) {
        
        ShortcutView *shortcut = [[ShortcutView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
        [cell addSubview:shortcut];
        shortcut.label1.text = self.orderNo;
        shortcut.label1.adjustsFontSizeToFitWidth = YES;
        [cell.contentView addSubview:LineOne];
        LineOne.sd_layout.leftSpaceToView(cell.contentView,0).rightSpaceToView(cell.contentView,0).bottomSpaceToView(cell.contentView,0).heightIs(0.5);
    }
    if (indexPath.row == 1) {
        ShortcutView *shortcut = [[ShortcutView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
        [cell addSubview:shortcut];
        shortcut.label1.text = self.orderTime;
        
    }
//    if (indexPath.row == 1) {
//        UIImageView *imageView = [[UIImageView alloc] init];
//        imageView.image = [UIImage imageNamed:@"arrow1"];
//        [cell addSubview:imageView];
//        GoodsNameLab.text = @"餐费";
//        GoodsNameLab.textColor = Gray136;
//        GoodsNameLab.textAlignment = NSTextAlignmentLeft;
//        GoodsNameLab.font = [UIFont systemFontOfSize:16];
//        [cell.contentView addSubview:GoodsNameLab];
//        GoodsNameLab.sd_layout.leftSpaceToView(cell.contentView,113.5).topSpaceToView(cell.contentView,16.5).widthIs(60).heightIs(15.5);
//        imageView.sd_layout.centerYEqualToView(cell).rightSpaceToView(cell,15).widthIs(15).heightIs(20);
//    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        textField = [[UITextField alloc] init];
        textField.placeholder = @"请输入银行卡号";
        textField.keyboardType = UIKeyboardTypeNumberPad;
        [cell addSubview:textField];
        textField.enabled = NO;
        textField.sd_layout.centerYEqualToView(cell).leftSpaceToView(cell,20).widthIs(220).heightIs(40);
        
        BankLab = [[UILabel alloc] init];
        BankLab.adjustsFontSizeToFitWidth = YES;
        [cell.contentView addSubview:BankLab];
        BankLab.hidden = YES;
        BankLab.sd_layout.leftSpaceToView(cell.contentView,20).topSpaceToView(cell.contentView,15).widthIs(71).heightIs(18);
        
        BankNumberLab = [[UILabel alloc] init];
        [cell.contentView addSubview:BankNumberLab];
        BankNumberLab.hidden = YES;
        BankNumberLab.adjustsFontSizeToFitWidth = YES;
        BankNumberLab.sd_layout.leftSpaceToView(BankLab,20).topSpaceToView(cell.contentView,15).widthIs(150).heightIs(17.5);
 
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"确认订单页面下拉"];
        [cell addSubview:imageView];
        imageView.sd_layout.centerYEqualToView(cell).rightSpaceToView(cell,15).widthIs(20).heightIs(20);
        
        if(self.bankArray.count > 0) {
            textField.hidden = YES;
            BankLab.hidden = NO;
            BankLab.adjustsFontSizeToFitWidth = YES;
            BankLab.text = [self.bankArray[0] objectForKey:@"bankName"];
            BankNumberLab.hidden = NO;
            [BusiIntf curPayOrder].AddBankNumber = [self.bankArray[0] objectForKey:@"bankNo"];
            BankNumberLab.text = [self rePlaceString:[BusiIntf curPayOrder].AddBankNumber];
            
        }else {
            
        }
        
        [cell.contentView addSubview:LineTwo];
        [cell.contentView addSubview:LineThree];
        LineTwo.sd_layout.leftSpaceToView(cell.contentView,0).rightSpaceToView(cell.contentView,0).topSpaceToView(cell.contentView,0).heightIs(0.5);
        LineThree.sd_layout.leftSpaceToView(cell.contentView,0).rightSpaceToView(cell.contentView,0).bottomSpaceToView(cell.contentView,0).heightIs(0.5);
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 45)];
    view.backgroundColor = LightGrayColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, KscreenWidth, 45)];
    if (section == 0) {
        label.text = @"订单信息";
    }else if (section == 1) {
        label.text = @"支付银行卡";
    }
    label.textColor = Color(20, 151, 222);
    [view addSubview:label];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 40.0f;
        
    }
    return 45.0f;
}

//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",(long)indexPath.row);
//    if (indexPath.section == 0 && indexPath.row == 1) { //商品名称
//        TradeNameView *tradeName = [[TradeNameView alloc] init];
//        [self.view addSubview:tradeName];
//        arr =  [[NSArray alloc] initWithObjects:@"贷款",@"餐费",@"房租",@"运费",@"代购",@"水电费", nil];
//        alertViewController = nil;
//        alertViewController = [[TDAlertViewController alloc] initWithNibName:@"TDAlertViewController" bundle:nil contentArray:arr titleStr:@"请选择商品名称" tag:1];
//        [alertViewController.view setBackgroundColor:[UIColor whiteColor]];
//        alertViewController.delegate = self;
//        [self presentPopupViewController:alertViewController animationType:MJPopupViewAnimationFade];
//        
//    }
    if (indexPath.section == 1 && indexPath.row == 0) { //银行卡信息
        AlertViewController = nil;
        AlertViewController = [[TDAlertViewController alloc] initWithNibName:@"TDAlertViewController" bundle:nil contentArray:self.bankArray titleStr:@"请选择银行卡" tag:3];
        [AlertViewController.view setBackgroundColor:[UIColor whiteColor]];
        AlertViewController.delegate = self;
        [self presentPopupViewController:AlertViewController animationType:MJPopupViewAnimationFade];
    }
}

//点击选择支付理由
-(void)tableViewSelect:(TDAlertViewController *)alertViewController tag:(int)myTag selectNum:(int)num{
    if (myTag != 3) {  //商品名称
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
        GoodsNameLab.text = arr[num];
    }else {   //银行卡
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
        NSArray *Array = nil;
        
        if (alertViewController.MidArray == nil) {
            Array = self.bankArray;
        }else {
            Array = alertViewController.MidArray;
        }
        NSInteger row = 0;
        
        if (Array.count >= 5) {
            row = 5;
        }else {
            row = Array.count;
        }
        
        if (num < row) {
            textField.hidden = YES;
            BankLab.hidden = NO;
            BankLab.adjustsFontSizeToFitWidth = YES;
            BankNumberLab.hidden = NO;
            BankLab.text = [Array[num] objectForKey:@"bankName"];
            [BusiIntf curPayOrder].AddBankNumber = [Array[num] objectForKey:@"bankNo"];
            BankNumberLab.text = [self rePlaceString:[BusiIntf curPayOrder].AddBankNumber];
            NSLog(@"%@",_bankArray[num]);
        }else if (num == row){
            JXBankInfoViewController *JXBankInfoVC = [[JXBankInfoViewController alloc] init];
            [self.navigationController pushViewController:JXBankInfoVC animated:YES];
        }else {
            
        }
    }
}

- (void)leftEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)buttonClick:(UIButton *)btn {
    
    //对按钮做防止多次点击处理
    btn.enabled = NO;
    if ([BankLab.text isEqualToString:@""] || [BankNumberLab.text isEqualToString:@""] || BankLab.text == nil || BankNumberLab.text == nil) {
        [self alert:@"请输入一张银行卡!"];
        btn.enabled = YES;
        return;
    }
    NSLog(@"%@%@%@",BankLab.text,BankNumberLab.text,[BusiIntf curPayOrder].AddBankNumber);
    NSString *url = JXUrl;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *md5 = [NSString stringWithFormat:@"%@%@%@",[BusiIntf curPayOrder].AddBankNumber,self.orderNo,key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                           @"orderNo":self.orderNo,
                           @"bankNo":[BusiIntf curPayOrder].AddBankNumber,
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"nocardOrderBankState",
                           @"data":dic1
                           };
    NSLog(@"上传的字典:%@",dicc);
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        
        NSDictionary *dic = [result JSONValue];
        NSLog(@"返回的信息:%@",dic);
        NSString *code = dic[@"code"];
        NSString *msg = dic[@"msg"];
        NSString *cardNo = dic[@"orderNo"]; //订单编号
        NSString *selfFlg = dic[@"selfFlg"]; //是否绑卡支付
        NSString *bankNo =dic[@"bankNo"];  //银行卡号
        NSString *bankCardType = dic[@"bankCardType"]; //卡号类型  1:储蓄卡 2:信用卡
        NSString *bankCardName = dic[@"bankCardName"]; //银行名称
        //NSString *bankCardIcon = dic[@"bankCardIcon"];  //银行ICON
        NSString *bankPhone = dic[@"bankPhone"];
       
        [BusiIntf curPayOrder].OrderNo = cardNo; //订单
        [BusiIntf curPayOrder].BankIsSelf = selfFlg;  //是否是绑卡
        [BusiIntf curPayOrder].BankName = bankCardName; //所属银行
        [BusiIntf curPayOrder].BankCardNo = bankNo;   //卡号
        [BusiIntf curPayOrder].BankCardType = bankCardType;   //信用卡
        [BusiIntf curPayOrder].cardPhone = bankPhone;
        
        if (![code isEqualToString:@"000000"]) {
            [self alert:msg];
        }else {
            
            JXPayWithOrderViewController *PayWithOrder = [[JXPayWithOrderViewController alloc] init];
            PayWithOrder.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:PayWithOrder animated:YES];
            PayWithOrder.hidesBottomBarWhenPushed = NO;
            
        }
        btn.enabled = YES;
    } failure:^(NSError *error) {
        NSLog(@"网络请求错误:%@",error);
        btn.enabled = YES;
    }];
}

-(NSString*)rePlaceString:(NSString*)string{
    if (![string isKindOfClass:[NSString class]]) {
        return @"";
    }else{
        NSMutableString *mutString = [NSMutableString stringWithString:string];
        NSInteger length = [mutString length];
        if (length>=6) {
            [mutString replaceCharactersInRange:NSMakeRange(4, length-8) withString:@"********"];
        }else{
            
        }
        
        return (NSString*)mutString;
    }
    
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

//MD5加密
- (NSString *)md5HexDigest:(NSString*)password
{
    const char *original_str = [password UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    NSString *mdfiveString = [hash lowercaseString];
    return mdfiveString;
}

//收缩键盘
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    [self.view endEditing:YES];
//}

- (void)alert:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
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
