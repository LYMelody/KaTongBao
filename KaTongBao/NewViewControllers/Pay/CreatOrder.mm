//
//  CreatOrder.m
//  wujieNew
//
//  Created by rongfeng on 15/12/21.
//  Copyright © 2015年 rongfeng. All rights reserved.
//

#import "CreatOrder.h"
#import "UIComboBox.h"
#import "Common.h"
#import "TDViewsCell.h"
#import "CreateOrderCell.h"
#import "UIView+SDAutoLayout.h"
#import "BankNumberVC.h"
#import "BusiIntf.h"
#import <CommonCrypto/CommonDigest.h>
#import "IBHttpTool.h"
#import "SBJSON.h"
//#import "UPPayPlugin.h"
#import "SVProgressHUD.h"
#import "UIPayCheck.h"
#import "UIPayDefault.h"
#import "UIFinashPay.h"

#define kMode_Development             @"00"
#define PayTips    \
@"支付说明：\r\
1、单笔交易金额最高1万：单卡单日最高3万，笔数不限，单日结算最高10万。注:首次交易的银行卡，单卡单日1万，从首次交易日计算，十五天后该卡交易额度自动开放至单卡单日3万；\r\
2.T+0到账（周末节假日不支持到账），到账时间：9:00-17:00;\r\
3.交易完成后，请进入“钱包”点击结算;\r\
4.法定假日期间交易，工作日第一天结算。"
@implementation CreatOrder {
    UIComboBox *combox;
    UITextField *CashFld;
    UITextField *NoteFld;
    NSString *YinLianOrd;
    NSTimer *_Timer;
    NSInteger index;
    UIButton *NextBtn;
    NSInteger minAmount;
    NSUserDefaults *user;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    NextBtn.enabled = YES;
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] init];
    left.title = @"返回";
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    self.navigationItem.backBarButtonItem = left;
    
    user = [NSUserDefaults standardUserDefaults];
    if (self.tag == 1) {
        self.title = @"普通收款订单";
    }
    else if(self.tag ==4){
       self.title=@"卡刷收款订单";
        
    } else if (self.tag == 5) {
        self.title = @"卡刷收款订单";
    }
    else {
       self.title = @"快捷收款订单";
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [self CreateViews];
    
    NSLog(@"收款 方式 :%@",[BusiIntf curPayOrder].GoodsID);
    
}

- (void)initCombox {
    
    [combox.historyArray removeAllObjects];
    [combox addHistory:@"货款"];
    [combox addHistory:@"餐费"];
    [combox addHistory:@"房租"];
    [combox addHistory:@"运费"];
    [combox addHistory:@"代购"];
    [combox addHistory:@"水电费"];
    
    combox.text = [combox.historyArray objectAtIndex:0];
}
- (void)comboBoxChange:(UIComboBox *)comboBox {
    
    [self initCombox];
    
}
- (void)CreateViews {
    
    UIImageView *backImg = [[UIImageView alloc] init];
    backImg.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    backImg.backgroundColor = LightGrayColor;
    [self.view addSubview:backImg];
    
    
    
    UIScrollView *Scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0 - 60, KscreenWidth, KscreenHeight)];
    if (KscreenHeight < 500) {
        Scroll.contentSize = CGSizeMake(KscreenWidth, KscreenHeight + 100);
    }else {
        Scroll.contentSize = CGSizeMake(KscreenWidth, KscreenHeight);
    }
    Scroll.userInteractionEnabled = YES;
    Scroll.backgroundColor = LightGrayColor;
    Scroll.showsVerticalScrollIndicator =NO;
    [self.view addSubview:Scroll];
    //白底
    UIImageView *Img = [[UIImageView alloc] init];
    Img.backgroundColor = [UIColor whiteColor];
    [Scroll addSubview:Img];
    Img.sd_layout.leftSpaceToView(Scroll,0).rightSpaceToView(Scroll,0).topSpaceToView(Scroll,78).heightIs(133.5);
    //收款理由
    UILabel *CauseName = [[UILabel alloc] init];
    CauseName.text = @"收款理由";
    CauseName.font = [UIFont systemFontOfSize:15];
    CauseName.textColor = Color(111, 111, 111);
    [Scroll addSubview:CauseName];
    combox = [[UIComboBox alloc] initWithFrame:CGRectMake(105, 91, 154, 20)];
    [Scroll addSubview:combox];
    [self initCombox];
    CauseName.sd_layout.leftSpaceToView(Scroll,16).topSpaceToView(Scroll,96).widthIs(60).heightIs(15.5);
    //横线
    UIImageView *LineOne = [[UIImageView alloc] init];
    LineOne.backgroundColor = Color(214, 214, 214);
    [Scroll addSubview:LineOne];
    LineOne.sd_layout.leftSpaceToView(Scroll,16).topSpaceToView(Scroll,122).widthIs(KscreenWidth - 16).heightIs(0.5);
    UIImageView *LineTwo = [[UIImageView alloc] init];
    LineTwo.backgroundColor = Color(214, 214, 214);
    [Scroll addSubview:LineTwo];
    LineTwo.sd_layout.leftSpaceToView(Scroll,16).topSpaceToView(Scroll,166.5).widthIs(KscreenWidth - 16).heightIs(0.5);
    UIImageView *LineTird = [[UIImageView alloc] init];
    LineTird.backgroundColor = Color(214, 214, 214);
    [Scroll addSubview:LineTird];
    LineTird.sd_layout.leftSpaceToView(Scroll,0).topSpaceToView(Scroll,211.5).widthIs(KscreenWidth ).heightIs(0.5);
    UIImageView *LineFour = [[UIImageView alloc] init];
    LineFour.backgroundColor = Color(214, 214, 214);
    [Scroll addSubview:LineFour];
    LineFour.sd_layout.leftSpaceToView(Scroll,0).topSpaceToView(Scroll,78).widthIs(KscreenWidth ).heightIs(0.5);
    //收款金额
    UILabel *CashLab = [[UILabel alloc] init];
    CashLab.text = @"收款金额";
    CashLab.textColor = Color(111, 111, 111);
    CashLab.font = [UIFont systemFontOfSize:15];
    [Scroll addSubview:CashLab];
    CashFld = [[UITextField alloc] init];
    CashFld.placeholder = @"请输入实际交易金额";
    CashFld.font = [UIFont systemFontOfSize:14];
    CashFld.keyboardType = UIKeyboardTypeNumberPad;
    [Scroll addSubview:CashFld];
    CashLab.sd_layout.leftSpaceToView(Scroll,16).topSpaceToView(Scroll,137.5).widthIs(60).heightIs(20);
    CashFld.sd_layout.leftSpaceToView(Scroll,105).topSpaceToView(Scroll,137.5).widthIs(160).heightIs(20);
    //备注
    UILabel *NoteLab = [[UILabel alloc] init];
    NoteLab.text = @"备     注";
    NoteLab.textColor = Color(111, 111, 111);
    NoteLab.font = [UIFont systemFontOfSize:15];
    [Scroll addSubview:NoteLab];
    NoteFld = [[UITextField alloc] init];
    NoteFld.font = [UIFont systemFontOfSize:14];
    NoteFld.placeholder = @"需要记录交易物品请填写";
    [Scroll addSubview:NoteFld];
    NoteLab.sd_layout.leftSpaceToView(Scroll,16).topSpaceToView(Scroll,183).widthIs(60).heightIs(20);
    NoteFld.sd_layout.leftSpaceToView(Scroll,104.5).topSpaceToView(Scroll,183).widthIs(154).heightIs(20);
    
    UILabel *bankLab = [[UILabel alloc] init];
    bankLab.textAlignment = NSTextAlignmentLeft;
    bankLab.textColor = [UIColor redColor];
    bankLab.numberOfLines = 0;
    bankLab.font = [UIFont systemFontOfSize:13];
    [Scroll addSubview:bankLab];
    bankLab.hidden = YES;
    if ([[BusiIntf curPayOrder].GoodsID isEqualToString:@"AN1"]){
        bankLab.hidden = NO;
        bankLab.text = self.ANbank;
    }
    //下一步
    NextBtn = [[UIButton alloc] init];
    [NextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    NextBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    NextBtn.layer.cornerRadius = 3.5;
    NextBtn.layer.masksToBounds = YES;
    NextBtn.backgroundColor = Color(255, 30, 30);
    [NextBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [Scroll addSubview:NextBtn];
    NextBtn.sd_layout.leftSpaceToView(Scroll,11).rightSpaceToView(Scroll,11).topSpaceToView(Scroll,290).heightIs(44);
    bankLab.sd_layout.leftSpaceToView(Scroll,17.5).topSpaceToView(NoteLab,10).rightSpaceToView(Scroll,17.5).bottomSpaceToView(NextBtn,5);
    //支付说明+
    UILabel *PayTipLab = [[UILabel alloc] init];
    if ([[BusiIntf curPayOrder].GoodsID isEqualToString:@"1"]) {
        PayTipLab.text = self.T1Msg;
        CashFld.placeholder = [NSString stringWithFormat:@"请输入大于%@的金额",[user objectForKey:@"RB1MIN"]];
    }else if ([[BusiIntf curPayOrder].GoodsID isEqualToString:@"2"]) {
        PayTipLab.text = self.T0Msg;
        CashFld.placeholder = [NSString stringWithFormat:@"请输入大于%d的金额",[[user objectForKey:@"RB0MIN"] integerValue]];
    }else if ([[BusiIntf curPayOrder].GoodsID isEqualToString:@"UP0"]) {
        PayTipLab.text = self.UP0Msg;
        CashFld.placeholder = [NSString stringWithFormat:@"请输入大于%d的金额",[[user objectForKey:@"UP0MIN"] integerValue]];
    }else if([[BusiIntf curPayOrder].GoodsID isEqualToString:@"HST0"])
    {
         PayTipLab.text = self.HST0Msg;
        CashFld.placeholder = [NSString stringWithFormat:@"请输入大于%d的金额",[[user objectForKey:@"HST0MIN"] integerValue]];
    }else if([[BusiIntf curPayOrder].GoodsID isEqualToString:@"AN1"]){
         PayTipLab.text = self.ANmsg;
        CashFld.placeholder = [NSString stringWithFormat:@"请输入大于%d的金额",[[user objectForKey:@"AN1MIN"] integerValue]];
    }else {
        
    }
    //PayTipLab.text = PayTips;
    PayTipLab.textAlignment = NSTextAlignmentLeft;
    PayTipLab.textColor = Color(136, 136, 136);
    //PayTipLab.backgroundColor = RedColor;
    PayTipLab.numberOfLines = 0;
    PayTipLab.font = [UIFont systemFontOfSize:15];
    [Scroll addSubview:PayTipLab];
    PayTipLab.sd_layout.leftSpaceToView(Scroll,17.5).topSpaceToView(Scroll,346.5).rightSpaceToView(Scroll,17.5).heightIs(200);
}

//下一步
- (void)next {
    
    if([CashFld.text isEqualToString:@""]) {
        [self alert:@"请输入金额!"];
        return;
    }
    
    
    if ([[BusiIntf curPayOrder].GoodsID isEqualToString:@"1"]) {
        minAmount = [[user objectForKey:@"RB1MIN"] integerValue];
    }else if ([[BusiIntf curPayOrder].GoodsID isEqualToString:@"AN1"]) {
        minAmount = [[user objectForKey:@"AN1MIN"] integerValue];
    }else if ([[BusiIntf curPayOrder].GoodsID isEqualToString:@"7"]) {
        minAmount = [[user objectForKey:@"7MIN"] integerValue];
    }else if ([[BusiIntf curPayOrder].GoodsID isEqualToString:@"2"]) {
        minAmount = [[user objectForKey:@"RB0MIN"] integerValue];
    }else if ([[BusiIntf curPayOrder].GoodsID isEqualToString:@"HST0"]) {
        minAmount = [[user objectForKey:@"HST0MIN"] integerValue];
    }else if ([[BusiIntf curPayOrder].GoodsID isEqualToString:@"UP0"]) {
        minAmount = [[user objectForKey:@"UP0MIN"] integerValue];
    }else {
        
    }
    if ([CashFld.text integerValue] < minAmount) {
        [self alert:[NSString stringWithFormat:@"最低交易金额为%d",minAmount]];
        return;
    }
    
    NSLog(@"收款方式:%@",[BusiIntf curPayOrder].GoodsID);
    NSLog(@"收款理由:%@",combox.text);
    [BusiIntf curPayOrder].OrderName = combox.text;
    [BusiIntf curPayOrder].OrderAmount = CashFld.text;
    [BusiIntf curPayOrder].OrderDesc = NoteFld.text;
    //tag为3走银联通道
       if(self.tag == 3) {
           [self RequestForYinLian];}
    
    else {
        BankNumberVC *Bank = [[BankNumberVC alloc] init];
        Bank.t1Bank = self.T1bank;
        Bank.t0Bank = self.T0bank;
        Bank.hst0Bank = self.HST0bank;
        Bank.ANbank = self.ANbank;
        [self.navigationController pushViewController:Bank animated:YES];
    }
    
    NextBtn.enabled = NO;
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

//MD516位小写加密
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
//银联支付
- (void)RequestForYinLian {
    
    NSString *url = BaseUrl;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *imsi = @"";
    //获取UUID并进行md5编码
    NSString *UUID = [[UIDevice currentDevice].identifierForVendor UUIDString];
    NSLog(@"uuid:%@",UUID);
    NSString *imsimd5 = [self md5:UUID];
    NSString *UUID16 = [[imsimd5 substringFromIndex:8] substringToIndex:16];
    NSString *mac = @"";
    NSString *md5 = [NSString stringWithFormat:@"%@%@%@%@%@%@",[BusiIntf curPayOrder].GoodsID,[BusiIntf curPayOrder].OrderAmount,UUID16,imsi,mac,key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                           @"type":[BusiIntf curPayOrder].GoodsID,
                           @"amount":[BusiIntf curPayOrder].OrderAmount,
                           @"goodsName":[[BusiIntf curPayOrder].OrderName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                           //@"memo":[[BusiIntf curPayOrder].OrderDesc stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                           @"imei":UUID16,
                           @"imsi":imsi,
                           @"mac":mac,
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"UppayOrderCreate",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSLog(@"数据:%@",result);
        NSDictionary *dic = [result JSONValue];
        NSString *code = dic[@"code"];
        NSString *content = dic[@"content"];
        YinLianOrd = dic[@"orderNo"];
        //存一下订单号
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:dic[@"orderNo"] forKey:@"orderNo"];
        [user synchronize];
        NSLog(@"存下来的订单:%@",[user objectForKey:@"orderNo"]);
        if ([code isEqualToString:@"000000"]) {
            //[UPPayPlugin startPay:YinLianOrd mode:kMode_Development viewController:self delegate:self];
        }else {
            [self alert:content];
        }
    } failure:^(NSError *error) {

    }];
}

//银联回调方法
- (void)UPPayPluginResult:(NSString *)result {
    
    NSLog(@"支付结果:%@",result);
    
    //支付成功
    [SVProgressHUD show];
    if(![result isEqualToString:@"cancel"]) {
        index = index + 9;
        _Timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(StartTimer) userInfo:nil repeats:YES];
        
    }else {
        [SVProgressHUD dismiss];
    }
}
//定时器方法
- (void)StartTimer {
    
    index = index - 3;
    [self RequestForList];
    
}

//订单查询
- (void)RequestForList {
    NSString *url = BaseUrl;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *orderNo = [user objectForKey:@"orderNo"];
    NSLog(@"取出来的订单:%@",orderNo);
    NSString *md5 = [NSString stringWithFormat:@"%@%@",orderNo,key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic = @{
                          @"orderNo":orderNo,
                          @"token":token,
                          @"sign":sign
                          };
    NSDictionary *dicc = @{
                           @"action":@"OrderStatusQuery",
                           @"data":dic
                           };
    NSString *params = [dicc JSONFragment];
    NSLog(@"参数：%@",params);
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSDictionary *dicc = [result JSONValue];
        NSLog(@"订单列表：%@",dicc);
        NSString *content = dicc[@"content"];
        NSString *code = dicc[@"code"];
        if ([content isEqualToString:@"SUCC"] || [content isEqualToString:@"FROZEN"]) {
            //支付成功
            //[UIManager doNavWnd:WndFinashPay];
            UIFinashPay *Finash = [[UIFinashPay alloc] init];
            [self.navigationController pushViewController:Finash animated:YES];
            [_Timer invalidate];
            index = 0;
            [SVProgressHUD dismiss];
        }
        else if(index == 0 || [content isEqualToString:@"WAIT"]) {
            //[Dialog showMsg:content];
            
            
            UIPayCheck *check = [[UIPayCheck alloc] init];
            [self.navigationController pushViewController:check animated:YES];
            [_Timer invalidate];
            [SVProgressHUD dismiss];
        }else if ([content isEqualToString:@"FAIL"]) {
            UIPayDefault *defaultVC = [[UIPayDefault alloc] init];
            defaultVC.tag = 101;
            self.model = [[CodeModel alloc] init];
            self.model.code = code;
            self.model.errorMsg = content;
            defaultVC.model = self.model;
            [self.navigationController pushViewController:defaultVC animated:YES];
            [_Timer invalidate];
            index =0;
            [SVProgressHUD dismiss];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"网络申请失败:%@",error);
        [SVProgressHUD dismiss];
    }];
}

- (void)alert:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    [self.view endEditing:YES];
//    
//}
@end
