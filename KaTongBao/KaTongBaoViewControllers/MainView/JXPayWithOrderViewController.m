//
//  JXPayWithOrderViewController.m
//  JingXuan
//
//  Created by rongfeng on 16/6/3.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "JXPayWithOrderViewController.h"
#import "SendMegCell.h"
#import "ViewsCell.h"
#import "BankCell.h"
#import "MesageCell.h"
#import "Common.h"
#import "macro.h"
#import "UIView+SDAutoLayout.h"
#import "BusiIntf.h"
#import "JXPayResultViewController.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import <CommonCrypto/CommonDigest.h>
#import "SVProgressHUD.h"
#import "JXPayProtrolViewController.h"
#import "GiFHUD.h"
#import "WLDecimalKeyboard.h"
@interface JXPayWithOrderViewController ()

@end

@implementation JXPayWithOrderViewController {
    
    NSString  *_cardType;
    NSNumber  *_isSelf;
    SendMegCell *_sendCell;
    NSInteger _time;
    NSTimer *_timer;
    NSTimer *_Timer;
    UITableView *_table;
    NSInteger index;
    UIImageView *_Img;
    UITextField *text104;
    UITextField *text105;
    UITextField *text106;
    NSInteger _index;
    NSString *sms;
    NSString *NameStr;
    NSString *CardID;
    NSString *YXQ;
    NSString *CVV;
    NSString *PhoneNum;
    UITextField *BankFld;
    UIImageView *LineOne;
    UIImageView *LineTwo;
    UIImageView *LineThree;
    UIImageView *LineFour;
    UIButton *payBtn;
    MesageCell *NameCell;
    MesageCell *CertCell;
    MesageCell *ValidDateCell;
    MesageCell *CVVCell;
    MesageCell *PhoneCell;
    UIButton *SelfCardBtn;
    NSUserDefaults *user;
    WLDecimalKeyboard *WLKeyBoard;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    //自定义返回按钮
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    right.title = @"返回";
    self.navigationItem.backBarButtonItem = right;
    _isSelf = [NSNumber numberWithInt:[[BusiIntf curPayOrder].BankIsSelf integerValue]];
    NSLog(@"isself:%@",_isSelf);
    _cardType = [BusiIntf curPayOrder].BankCardType;
    
    WLKeyBoard = [[WLDecimalKeyboard alloc] init];
     user = [NSUserDefaults standardUserDefaults];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单支付";
    //添加一个table
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight + 52 ) style:UITableViewStylePlain];
    _table.dataSource = self;
    _table.delegate = self;
    _table.backgroundColor = LightGrayColor;
    _table.showsVerticalScrollIndicator = NO;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UITapGestureRecognizer *TapHiddenKeyBoard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HiddenKeyBoard)];
    TapHiddenKeyBoard.numberOfTouchesRequired = 1;
    TapHiddenKeyBoard.cancelsTouchesInView = NO;
    [_table addGestureRecognizer:TapHiddenKeyBoard];
    
    UIImageView *ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 65)];
    ImageView.backgroundColor = PayBackColor;
    UILabel *label = [[UILabel alloc] init];
    label.text = @"付款";
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    //[ImageView addSubview:label];
    
    UILabel *CarshLabel = [[UILabel alloc] init];
    CarshLabel.text = [NSString stringWithFormat:@"￥%@.00",[BusiIntf curPayOrder].amount];
    CarshLabel.textColor = [UIColor colorWithRed:255/255.0 green:117/255.0 blue:0/255.0 alpha:0.8];
    CarshLabel.font = [UIFont systemFontOfSize:24];
    CarshLabel.textAlignment = NSTextAlignmentCenter;
    CarshLabel.backgroundColor = [UIColor clearColor];
    [ImageView addSubview:CarshLabel];
    
    //设置table的头视图
    _table.tableHeaderView = ImageView;
    [self.view insertSubview:_table belowSubview:self.view];
    //布局头视图
    label.sd_layout.centerXEqualToView(_table).widthIs(100).heightIs(20).topSpaceToView(ImageView,5);
    CarshLabel.sd_layout.centerXEqualToView(_table).widthIs(200).heightIs(30).topSpaceToView(ImageView,24.5);
    //设置table的尾视图(非本人交易)
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 300)];
    footView.backgroundColor = GrayColor;
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btn];
    _Img = [[UIImageView alloc] init];
    _Img.image = [UIImage imageNamed:@"comfir.png"];
    [footView addSubview:_Img];
    UIButton *Deleagebtn = [[UIButton alloc] init];
//    Deleagelabel.text = @"《无界支付服务协议》";
//    Deleagelabel.font = [UIFont systemFontOfSize:13];
//    Deleagelabel.textAlignment = NSTextAlignmentCenter;
//    Deleagelabel.textColor = [UIColor blueColor];
//    Deleagelabel.backgroundColor = [UIColor clearColor];
    [Deleagebtn setTitle:@"《服务协议》" forState:UIControlStateNormal];
    Deleagebtn.titleLabel.font = [UIFont systemFontOfSize:13];
    Deleagebtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [Deleagebtn setTitleColor:Color(80, 148, 255) forState:UIControlStateNormal];
    Deleagebtn.backgroundColor = [UIColor clearColor];
    [Deleagebtn addTarget:self action:@selector(Propol) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:Deleagebtn];
    UILabel *agreeLabel = [[UILabel alloc] init];
    agreeLabel.text = @"同意";
    agreeLabel.backgroundColor = [UIColor clearColor];
    agreeLabel.font = [UIFont systemFontOfSize:13];
    agreeLabel.textAlignment = NSTextAlignmentCenter;
    [footView addSubview:agreeLabel];
    UILabel *tipsLabel = [[UILabel alloc] init];
    tipsLabel.backgroundColor = [UIColor clearColor];
    NSMutableString *msg = [[NSMutableString alloc] init];
    [msg appendFormat:@"小提示:\r\n"];
    [msg appendFormat:@"每笔限额:无；具体限额以银行卡为准。"];
    tipsLabel.text = msg;
    tipsLabel.font = [UIFont systemFontOfSize:12];
    tipsLabel.textAlignment = NSTextAlignmentLeft;
    tipsLabel.lineBreakMode = NSLineBreakByCharWrapping;
    tipsLabel.numberOfLines = 0;
    [footView addSubview:tipsLabel];
    payBtn = [[UIButton alloc] init];
    payBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [payBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [payBtn addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    payBtn.backgroundColor = Color(93, 93, 93);
    payBtn.layer.cornerRadius = 3;
    payBtn.enabled = NO;
    [footView addSubview:payBtn];
    //布局尾视图
    btn.sd_layout.leftSpaceToView(footView,19).topSpaceToView(footView,7).widthIs(18).heightIs(18);
    agreeLabel.sd_layout.leftSpaceToView(footView,46.5).topSpaceToView(footView,6).widthIs(30).heightIs(20);
    Deleagebtn.sd_layout.leftSpaceToView(footView,76.5).topSpaceToView(footView,6).widthIs(140).heightIs(20);
    tipsLabel.sd_layout.leftSpaceToView(footView,18).topSpaceToView(footView,20).widthIs(270).heightIs(67);
    payBtn.sd_layout.leftSpaceToView(footView,20).topSpaceToView(footView,75.5).widthIs(280).heightIs(38);
    _Img.sd_layout.leftSpaceToView(footView,18.5).topSpaceToView(footView,7).widthIs(20).heightIs(20);
    //设置table的尾视图(本人交易)
    UIView *SelfFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 276)];
    SelfFootView.backgroundColor = GrayColor;
    UIButton *FastPay = [[UIButton alloc] init];
    [FastPay setTitle:@"一键支付付款" forState:UIControlStateNormal];
    [FastPay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    FastPay.titleLabel.font = [UIFont systemFontOfSize:15];
    FastPay.backgroundColor = LightYellow;
    FastPay.layer.cornerRadius = 7;
    [FastPay addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    [SelfFootView addSubview:FastPay];
    FastPay.sd_layout.leftSpaceToView(SelfFootView,16).topSpaceToView(SelfFootView,68).widthIs(288).heightIs(38);
    
    if (![_isSelf isEqual:@1]) {
        _table.tableFooterView = footView;
    }else if ([_isSelf  isEqual:@1]) {
        _table.tableFooterView = SelfFootView;
        _table.scrollEnabled = NO;
    }
    //_table.tableFooterView = footView;
    
    //激活银行卡布局
    UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    leftLab.text = @"银行卡号:";
    //leftLab.textColor = Color(100, 100, 100);
    leftLab.font = [UIFont systemFontOfSize:16];
    leftLab.backgroundColor = [UIColor whiteColor];
    leftLab.textAlignment = NSTextAlignmentLeft;
    BankFld = [[UITextField alloc] init];
    BankFld.placeholder = @"请输入银行卡号";
    BankFld.backgroundColor = [UIColor whiteColor];
    BankFld.font = [UIFont systemFontOfSize:15];
    BankFld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    BankFld.leftViewMode = UITextFieldViewModeAlways;
    BankFld.leftView = leftLab;
    BankFld.delegate = self;
    BankFld.layer.cornerRadius = 3;
    BankFld.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    BankFld.keyboardType = UIKeyboardTypeNumberPad;
    //BankFld.text = @"6225758381617413";
    BankFld.tag = 10010;
    //[self.view addSubview:BankFld];
    //lines
    LineOne = [[UIImageView alloc] init];
    LineOne.backgroundColor = Gray136;
    LineTwo = [[UIImageView alloc] init];
    LineTwo.backgroundColor = Gray136;
    LineThree = [[UIImageView alloc] init];
    LineThree.backgroundColor = Gray136;
    LineFour = [[UIImageView alloc] init];
    LineFour.backgroundColor = Gray136;
    
    //本人卡按钮
    SelfCardBtn = [[UIButton alloc] init];
    [SelfCardBtn setTitle:@"本人卡？" forState:UIControlStateNormal];
    SelfCardBtn.layer.cornerRadius = 3;
    SelfCardBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    SelfCardBtn.backgroundColor = NavBack;
    [SelfCardBtn addTarget:self action:@selector(SelfCard) forControlEvents:UIControlEventTouchUpInside];
    
}

//本人卡按钮
- (void)SelfCard {
    SelfCardBtn.enabled = NO;
    [self RequestForName];
    
}

//获取下商户姓名
- (void)RequestForName {
    
    NSString *url = JXUrl;
    user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *md5 = [NSString stringWithFormat:@"%@",key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"shopInfoState",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    //NSLog(@"参数：%@",params);
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSDictionary *dicc = [result JSONValue];
        //NSLog(@"返回数据：%@",dicc);
        [BusiIntf curPayOrder].bankAccont = (NSString *)dicc[@"shopAccount"];  //结算卡账号
        [BusiIntf curPayOrder].shopCard = (NSString *)dicc[@"shopCert"];
        NameStr = [BusiIntf curPayOrder].bankAccont;
        NameCell.textFiled.text = [BusiIntf curPayOrder].bankAccont;
        CardID = [BusiIntf curPayOrder].shopCard;
        CertCell.textFiled.text = [BusiIntf curPayOrder].shopCard;
        SelfCardBtn.enabled = YES;
    } failure:^(NSError *error) {
        NSLog(@"网络申请失败:%@",error);
        SelfCardBtn.enabled = YES;
    }];
}

//协议
- (void)Propol {
    
    JXPayProtrolViewController *protrol = [[JXPayProtrolViewController alloc] init];
    [self.navigationController pushViewController:protrol animated:YES];
}
//点击打勾按钮
- (void)selectAction {
    index++;
    if (index%2 == 0) {
        _Img.hidden = NO;
    }else {
        _Img.hidden = YES;
    }
}
//确认支付
- (void)pay:(UIButton *)btn {
    
    NSString *url = JXUrl;
    //[SVProgressHUD show];
    [GiFHUD showWithOverlay];
    _table.userInteractionEnabled = NO;
    btn.enabled = NO;
    sms = @"123456";
    if ([_cardType isEqual:@1]&&![_isSelf isEqual:@1]) {
        UITextField *text102 = [self.view viewWithTag:102];
        sms = text102.text;
    }else {
        sms = _sendCell.text.text;
    }
    if ([sms isEqualToString:@""] || sms == nil) {
        [self alertMsg:@"请输入验证码"];
        btn.enabled = YES;
        //[SVProgressHUD dismiss];
        [GiFHUD dismiss];
        _table.userInteractionEnabled = YES;
    }else {
        btn.enabled = YES;
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *token = [user objectForKey:@"token"];
        NSString *key = [user objectForKey:@"key"];
        NSString *orderNo = [BusiIntf curPayOrder].OrderNo;
        //如果没有创建订单给个提示，并返回.
        if (orderNo == nil) {
            //[Dialog showMsg:@"您还没有获取验证码!"];
            [self alertMsg:@"您还没有获取验证码!"];
            //[SVProgressHUD dismiss];
            [GiFHUD dismiss];
            _table.userInteractionEnabled = YES;
            btn.enabled = YES;
            return;
        }
        NSString *md5 = [NSString stringWithFormat:@"%@%@%@",orderNo,sms,key];
        NSString *sign = [self md5HexDigest:md5];
        NSDictionary *dic1 = @{
                               @"orderNo":orderNo,
                               @"smsCode":sms,
                               @"token":token,
                               @"sign":sign
                               };
        NSDictionary *dicc = @{
                               @"action":@"nocardOrderPayState",
                               @"data":dic1
                               };
        
        NSString *params = [dicc
                            JSONFragment];
        [IBHttpTool postWithURL:url params:params success:^(id result) {
            
            NSDictionary *dicc = [result JSONValue];
            NSLog(@"订单确认:%@",dicc);
            NSString *code = dicc[@"code"];
            NSString *errorMsg = dicc[@"msg"];
            NSString *orderPayTime = dicc[@"orderPayTime"];
            [BusiIntf curPayOrder].OrderTime = orderPayTime;
            NSLog(@"%@",dicc);
            if ([code isEqualToString:@"000000"]){
                //做一个银行校验
//                [self performSelector:@selector(AddAnOtherTimer) withObject:nil afterDelay:0];
//                btn.enabled = YES;
            
                
                //push到失败页面
//                UIPayDefault *defaultVC = [[UIPayDefault alloc] init];
//                self.model = [[CodeModel alloc] init];
//                self.model.code = code;
//                self.model.errorMsg = errorMsg;
//                defaultVC.model = self.model;
//                [self.navigationController pushViewController:defaultVC animated:YES];
                JXPayResultViewController *PayResultVc = [[JXPayResultViewController alloc] init];
                //PayResultVc.tag = 100;
                [self.navigationController pushViewController:PayResultVc animated:YES];
                btn.enabled = YES;
                //[SVProgressHUD dismiss];
                [GiFHUD dismiss];
                _table.userInteractionEnabled = YES;
            }else {
                [self alertMsg:errorMsg];
                //[SVProgressHUD dismiss];
                [GiFHUD dismiss];
                _table.userInteractionEnabled = YES;
            }
            
        }failure:^(NSError *error) {
            //[SVProgressHUD dismiss];
            [GiFHUD dismiss];
            _table.userInteractionEnabled = YES;
            btn.enabled = YES;
            NSLog(@"请求失败:%@",error);
            // [UIManager doNavWnd:WndPayDefault];
        }];
    }
}

- (void)AddAnOtherTimer {
    _index = _index + 9;
    _Timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(StartTimer) userInfo:nil repeats:YES];
}

- (void)StartTimer {
    
    _index = _index - 3;
    [self requestForList:sms];
    
}
//订单状态查询
- (void)requestForList:(NSString *)sms {
    
    NSString *url = JXUrl;
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *orderNo = [BusiIntf curPayOrder].OrderNo;
    NSString *md5 = [NSString stringWithFormat:@"%@%@",orderNo,key];
    NSString *sign = [self md5:md5];
    NSDictionary *dic1 = @{
                           @"orderNo":orderNo,
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"nocardOrderQueryState",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        
        NSDictionary *dic = [result JSONValue];
        NSLog(@"交易状态:%@",dic);
        NSString *code = dic[@"code"];
        NSString *msg = dic[@"msg"];
        NSString *failMsg = dic[@"failMag"];
        NSString *orderTime = dic[@"orderTime"];
        NSString *orderStatus = dic[@"orderStatus"];
        NSString *orderStatusCn = dic[@"orderStatusCn"];
        NSString *orderReason = dic[@"orderReason"];
        [BusiIntf curPayOrder].OrderTime = orderTime;
        if (![code isEqualToString:@"000000"]) {
            [self alertMsg:msg];
        }
//        else if ([orderStatus isEqual:@20]){
//            //到支付结果页面 (成功)
//            JXPayResultViewController *payResultVc = [[JXPayResultViewController alloc] init];
//            [self.navigationController pushViewController:payResultVc animated:YES];
//            payResultVc.tag = 101;
//            [_Timer invalidate];
//            _index = 0;
//            [SVProgressHUD dismiss];
//        }else if ([orderStatus isEqual:@21]) { //失败
//            JXPayResultViewController *payResultVc = [[JXPayResultViewController alloc] init];
//            payResultVc.tag = 100;
//            payResultVc.failMsg = failMsg;
//            [self.navigationController pushViewController:payResultVc animated:YES];
//            [_Timer invalidate];
//            _index =0;
//            [SVProgressHUD dismiss];
//            
//        } else if(_index == 0 && [orderStatus isEqual:@11]){   //等待
//            
//            JXPayResultViewController *payResultVc = [[JXPayResultViewController alloc] init];
//            payResultVc.tag = 102;
//            [self.navigationController pushViewController:payResultVc animated:YES];
//            [_Timer invalidate];
//            [SVProgressHUD dismiss];
//        } else {
//            
//        }
        
        JXPayResultViewController *payResultVc = [[JXPayResultViewController alloc] init];
        payResultVc.IsJieSuan = NO;
        [self.navigationController pushViewController:payResultVc animated:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"网络请求错误:%@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([_isSelf isEqual:@1]) {
        return 5;
    } else if ([_cardType  isEqual: @1]){
        return 7;
    }else {
        return 9;
    }
   // return 9;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
//        if ([_isSelf isEqual:@1]) {
//            return 10;
//        }else {
//            return 36;
//        }
        return 36;
    } else if(indexPath.row == 1){
        return 65;
    }else if(indexPath.row == 2) {
        if ([_isSelf isEqual:@1]) {
            return 24;
        }else {
            return 7;
        }
        //return 7;
    }else {
        return 40;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identy = [NSString stringWithFormat:@"%d",indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        if (indexPath.row == 0) {
//            if ([_isSelf isEqual:@1]) {
//                cell = [[ViewsCell alloc] init];
//            }else {
//                ViewsCell *Viewcell = [[ViewsCell alloc] init];
//                Viewcell.lael.text = @"   填写银行卡信息";
//                Viewcell.lael.textAlignment = NSTextAlignmentLeft;
//                Viewcell.backgroundColor = [UIColor whiteColor];
//                UIImageView *Img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 0.5)];
//                Img.backgroundColor = Gray136;
//                [Viewcell addSubview:Img];
//                cell = Viewcell;
//            }
            ViewsCell *Viewcell = [[ViewsCell alloc] init];
            Viewcell.lael.text = @"   填写银行卡信息";
            Viewcell.lael.textAlignment = NSTextAlignmentLeft;
            Viewcell.backgroundColor = [UIColor whiteColor];
            UIImageView *Img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 0.5)];
            Img.backgroundColor = Gray136;
            [Viewcell addSubview:Img];
            cell = Viewcell;
        }
        if (indexPath.row == 1) {
            if (self.tag == 100) {
                [cell.contentView addSubview:BankFld];
                BankFld.sd_layout.leftSpaceToView(cell.contentView,16).rightSpaceToView(cell.contentView,16).topSpaceToView(cell.contentView,10).heightIs(20);
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }else {
                cell = [[BankCell alloc] init];
            }
            
            if ([_isSelf isEqual:@1]) {
                UIButton *ChangeBtn = [[UIButton alloc] init];
                [ChangeBtn setTitle:@"已变更?" forState:UIControlStateNormal];
                ChangeBtn.backgroundColor = NavBack;
                ChangeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                ChangeBtn.layer.cornerRadius = 3;
                [ChangeBtn addTarget:self action:@selector(ChangStatus:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:ChangeBtn];
                ChangeBtn.sd_layout.rightSpaceToView(cell.contentView,26.5).topSpaceToView(cell.contentView,17).widthIs(90).heightIs(26.5);
            }
            [cell.contentView addSubview:LineThree];
            LineThree.sd_layout.leftSpaceToView(cell.contentView,0).rightSpaceToView(cell.contentView,0).bottomSpaceToView(cell.contentView,0).heightIs(0.5);
//            cell = [[BankCell alloc] init];
//            UIImageView *Img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, KscreenWidth, 0.5)];
//            Img.backgroundColor = Gray136;
//            [cell addSubview:Img];
        }
        if (indexPath.row == 2) {
            cell = [[ViewsCell alloc] init];
            cell.backgroundColor = LightGrayColor;
        }
        if ([_isSelf isEqual:@1]) {//认证本人卡
            if (indexPath.row == 3) {
                MesageCell *megcell = [[MesageCell alloc] init];
                megcell.label.text = @"手机号";
                megcell.textFiled.tag = 106;
                megcell.textFiled.text = PhoneNum;
                megcell.textFiled.keyboardType = UIKeyboardTypeNumberPad;
                //megcell.textFiled.placeholder = @"银行预留手机号";
                //测试
                // megcell.textFiled.text = @"15228935891";
                if (self.tag == 101 || [_isSelf isEqual:@1]) {
                    megcell.textFiled.text = [BusiIntf curPayOrder].cardPhone;
                    megcell.textFiled.enabled = NO;
                }
                cell = megcell;
//                [cell.contentView addSubview:LineOne];
//                LineOne.sd_layout.leftSpaceToView(cell.contentView,0).rightSpaceToView(cell.contentView,0).topSpaceToView(cell.contentView,0).heightIs(0.5);
            }
            
            if (indexPath.row == 4) {
                _sendCell = [[SendMegCell alloc] init];
                _sendCell.text.tag = 110;
                _sendCell.text.delegate = self;
                _sendCell.text.inputView = WLKeyBoard;
                [_sendCell.text reloadInputViews];
                [_sendCell.button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
                //_sendCell.text.keyboardType = UIKeyboardTypeNumberPad;
                [_sendCell.sendButton addTarget:self action:@selector(reSendAction:) forControlEvents:UIControlEventTouchUpInside];
                _sendCell.button.hidden = NO;
                cell = _sendCell;
                [cell.contentView addSubview:LineFour];
                LineFour.sd_layout.leftSpaceToView(cell.contentView,0).rightSpaceToView(cell.contentView,0).bottomSpaceToView(cell.contentView,0).heightIs(0.5);
            }
        }else if([_cardType  isEqual: @1]) { //储蓄卡
            if (indexPath.row == 3) {
                MesageCell *megcell = [[MesageCell alloc] init];
                megcell.label.text = @"姓     名";
                megcell.textFiled.placeholder = @"请输入真实姓名";
                megcell.textFiled.tag = 201;
                megcell.textFiled.delegate = self;
                
                cell = megcell;
            }
            if (indexPath.row == 4) {
                MesageCell *megcell = [[MesageCell alloc] init];
                megcell.label.text = @"身份证";
                megcell.textFiled.placeholder = @"请输入持卡人身份证";
                megcell.textFiled.tag = 100;
                megcell.textFiled.delegate = self;
                megcell.textFiled.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                
                cell = megcell;
            }
            if (indexPath.row == 5) {
                MesageCell *megcell = [[MesageCell alloc] init];
                megcell.label.text = @"手机号";
                megcell.textFiled.tag = 101;
                megcell.textFiled.delegate = self;
                megcell.textFiled.placeholder = @"银行预留手机号";
                megcell.textFiled.keyboardType = UIKeyboardTypeNumberPad;
                cell = megcell;
            }
            if (indexPath.row == 6) {
                _sendCell = [[SendMegCell alloc] init];
                _sendCell.text.tag = 102;
                _sendCell.text.delegate = self;
                
                [_sendCell.button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
                _sendCell.text.keyboardType = UIKeyboardTypeNumberPad;
                [_sendCell.sendButton addTarget:self action:@selector(reSendAction:) forControlEvents:UIControlEventTouchUpInside];
                _sendCell.button.hidden = NO;
                cell = _sendCell;
            }
        }else {   //信用卡
        
            if (indexPath.row == 3) {
                NameCell = [[MesageCell alloc] init];
                NameCell.label.text = @"姓   名";
                NameCell.textFiled.placeholder = @"请输入真实姓名";
                //测试
                //NameStr = @"斯亚东";
                NameCell.textFiled.text = NameStr;
                NameCell.textFiled.tag = 200;
                NameCell.textFiled.delegate = self;
                
                [NameCell.contentView addSubview:SelfCardBtn];
                SelfCardBtn.sd_layout.rightSpaceToView(NameCell.contentView,26.5).topSpaceToView(NameCell.contentView,7).widthIs(90).heightIs(26.5);
                
                if ([_isSelf isEqual:@1] || self.tag == 101) {
                    NameCell.textFiled.text = [BusiIntf curPayOrder].bankAccont;
                    NameCell.textFiled.enabled = NO;
                }else {
                    
                    
                }
                cell = NameCell;
//                [cell.contentView addSubview:LineOne];
//                LineOne.sd_layout.leftSpaceToView(cell.contentView,0).rightSpaceToView(cell.contentView,0).topSpaceToView(cell.contentView,0).heightIs(0.5);
            }
            if (indexPath.row == 4) {
                CertCell = [[MesageCell alloc] init];
                CertCell.label.text = @"身份证";
                CertCell.textFiled.tag = 103;
                CertCell.textFiled.delegate = self;
                CertCell.textFiled.placeholder = @"请输入持卡人身份证";
                CertCell.textFiled.text = CardID;
                //测试
                //megcell.textFiled.text = @"511321198912046198";
                CertCell.textFiled.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                if (  self.tag == 101) {
                    
                    CertCell.textFiled.text = [BusiIntf curPayOrder].shopCard;
                    CertCell.textFiled.enabled = NO;
                }else if ([_isSelf isEqual:@1]) {
                    CertCell.textFiled.text = [BusiIntf getUserInfo].UserName;
                    CertCell.textFiled.enabled = NO;
                }
                cell = CertCell;
            }
            if (indexPath.row == 5) {
                ValidDateCell = [[MesageCell alloc] init];
                ValidDateCell.label.text = @"有效期";
                ValidDateCell.textFiled.tag = 104;
                ValidDateCell.textFiled.delegate = self;
//                WLDecimalKeyboard *WLDKeyBoard = [[WLDecimalKeyboard alloc] init];
                ValidDateCell.textFiled.inputView = WLKeyBoard;
                [ValidDateCell.textFiled reloadInputViews];
                ValidDateCell.textFiled.text = YXQ;
                //ValidDateCell.textFiled.keyboardType = UIKeyboardTypeNumberPad;
                ValidDateCell.textFiled.placeholder = @"有效期,月/年(如06/15输入0615)";
                //测试
                //megcell.textFiled.text = @"1220";
                cell = ValidDateCell;
            }
            if (indexPath.row == 6) {
                CVVCell = [[MesageCell alloc] init];
                CVVCell.label.text = @"CVV2";
                CVVCell.textFiled.delegate = self;
                CVVCell.textFiled.text = CVV;
                CVVCell.textFiled.tag = 105;
               // CVVCell.textFiled.keyboardType = UIKeyboardTypeNumberPad;
                CVVCell.textFiled.inputView = WLKeyBoard;
                [CVVCell.textFiled reloadInputViews];
                CVVCell.textFiled.placeholder = @"CVV2,卡背后三位";
                //测试
                // megcell.textFiled.text = @"600";
                CVVCell.textFiled.secureTextEntry = YES;
                cell = CVVCell;
            }
            if (indexPath.row == 7) {
                PhoneCell = [[MesageCell alloc] init];
                PhoneCell.label.text = @"手机号";
                PhoneCell.textFiled.tag = 106;
                PhoneCell.textFiled.delegate = self;
                PhoneCell.textFiled.text = PhoneNum;
               // PhoneCell.textFiled.keyboardType = UIKeyboardTypeNumberPad;
                PhoneCell.textFiled.inputView = WLKeyBoard;
                [PhoneCell.textFiled reloadInputViews];
                PhoneCell.textFiled.placeholder = @"银行预留手机号";
                //测试
                //megcell.textFiled.text = @"15228935891";
                if (self.tag == 101 || [_isSelf isEqual:@1]) { //激活时候可以修改（101 激活）
                    PhoneCell.textFiled.text = [BusiIntf curPayOrder].cardPhone;
                    if ([_isSelf isEqual:@1]) {
                        PhoneCell.textFiled.enabled = NO;
                    }
                }
                cell = PhoneCell;
            }
            if (indexPath.row == 8) {
                _sendCell = [[SendMegCell alloc] init];
                _sendCell.text.tag = 107;
                _sendCell.text.delegate = self;
                //_sendCell.text.keyboardType = UIKeyboardTypeNumberPad;
                //WLDecimalKeyboard *WLKeyBoard = [[WLDecimalKeyboard alloc] init];
                _sendCell.text.inputView = WLKeyBoard;
                [_sendCell.text reloadInputViews];
                
                [_sendCell.button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
                [_sendCell.sendButton addTarget:self action:@selector(reSendAction:) forControlEvents:UIControlEventTouchUpInside];
                _sendCell.button.hidden = NO;
                cell = _sendCell;
                [cell.contentView addSubview:LineTwo];
                LineTwo.sd_layout.leftSpaceToView(cell.contentView,0).rightSpaceToView(cell.contentView,0).topSpaceToView(cell.contentView,39.5).heightIs(0.5);
            }
        }
    }
    return cell;
}

- (void)ChangStatus:(UIButton *)btn {
    btn.enabled = NO;
    NSLog(@"&*&*&*&*&*&*&*&*&*&*&*&*");
    [BusiIntf curPayOrder].BankIsSelf = @"0";
    JXPayWithOrderViewController *JXPay  = [[JXPayWithOrderViewController alloc] init];
    [self.navigationController pushViewController:JXPay animated:YES];
    btn.enabled = YES;
}
//获取短信验证码
- (void)clickAction:(UIButton *)btn {
    
    
    NSString *url = JXUrl;
    btn.enabled = NO;
    //[SVProgressHUD show];
    [GiFHUD showWithOverlay];
    _table.userInteractionEnabled = NO;
    OrderInfo *info = [BusiIntf curPayOrder];
    user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
   
    NSString *cardNbr = @"";
    //NSString *orderType = [BusiIntf curPayOrder].TypeOrder;
    NSString *cardPhone = @"";
    NSString *cardCvv = @"";
    NSString *cardYxq = @"";
    //NSString *imsi = @"";
    NSString *cardName = @"";
    //获取UUID并进行md5编码
    NSString *UUID = [[UIDevice currentDevice].identifierForVendor UUIDString];
    NSLog(@"uuid:%@",UUID);
   // NSString *imsimd5 = [self md5:UUID];
    //NSString *UUID16 = [[imsimd5 substringFromIndex:8] substringToIndex:16];
    NSString *mac = @"";
    if ([_cardType  isEqual: @1] && ![_isSelf isEqual:@1]) {  //储蓄卡
        UITextField *text100 = (UITextField *)[self.view viewWithTag:100];
        UITextField *text101 = (UITextField *)[self.view viewWithTag:101];
        UITextField *text201 = (UITextField *)[self.view viewWithTag:201];
        cardNbr = text100.text;
        cardPhone = text101.text;
        cardName = text201.text;
    } else if ([_cardType isEqual:@2]&&!([_isSelf isEqual:@1] )) {  //信用卡
        UITextField *text103 = (UITextField *)[self.view viewWithTag:103];
        text104 = (UITextField *)[self.view viewWithTag:104];
        text105 = (UITextField *)[self.view viewWithTag:105];
        text106 = (UITextField *)[self.view viewWithTag:106];
        UITextField *text200 = (UITextField *)[self.view viewWithTag:200];
        cardNbr = text103.text;
        cardYxq = text104.text;
        cardCvv = text105.text;
        cardName = text200.text;
        cardPhone = text106.text;
    }else {
        cardNbr = @"";
        cardPhone = @"";
        cardCvv = @"";
        cardYxq = @"";
        mac = @"";
    }
    if ([_cardType isEqual:@"1"]&&![_isSelf isEqual:@1]&&([cardNbr isEqualToString:@""]||[cardYxq isEqualToString:@""]||[cardCvv isEqualToString:@""]||[cardPhone isEqualToString:@""]))
    {
        [self alertMsg:@"请填写完整信息"];
        btn.enabled = YES;
        //[SVProgressHUD dismiss];
        [GiFHUD dismiss];
        _table.userInteractionEnabled = YES;
        return;
    }else if([_cardType isEqual:@0]&&![_isSelf isEqual:@1]&&([cardNbr isEqualToString:@""]||[cardPhone isEqualToString:@""])){
        {
            [self alertMsg:@"请填写完整信息"];
            btn.enabled = YES;
            //[SVProgressHUD dismiss];
            [GiFHUD dismiss];
            _table.userInteractionEnabled = YES;
            return;
        }
    }else {
        [self addTimer];
        NSString *MD5;
        if (self.tag == 100) {
            //激活的时候提示输入银行卡
            if ([BankFld.text isEqualToString:@""]) {
                [self alertMsg:@"请输入银行卡"];
                //[SVProgressHUD dismiss];
                [GiFHUD dismiss];
                _table.userInteractionEnabled = YES;
                return;
            }
            MD5 = [NSString stringWithFormat:@"%@%@%@%@",[BankFld.text stringByReplacingOccurrencesOfString:@" " withString:@""],cardCvv,cardYxq,key];
        }else {
            MD5 = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",cardName,cardNbr,cardCvv,cardPhone,cardYxq,info.OrderNo,key];
        }
        NSLog(@"%@",MD5);
        NSLog(@"%@",info.OrderName);
        NSString *sign = [self md5HexDigest:MD5];
        NSLog(@"%@",sign);
        NSDictionary *dic1 = @{
                               @"orderNo": [BusiIntf curPayOrder].OrderNo,
                               @"cardAccount":cardName ,
                               @"cardCert":cardNbr,
                               @"cardPhone":cardPhone,
                               @"cardCvv":cardCvv,
                               @"cardYxq":cardYxq,
                               @"token":token,
                               @"sign":sign
                               };
        NSDictionary *dic2 = @{
                               @"orderNo":[BankFld.text stringByReplacingOccurrencesOfString:@" " withString:@""],
                               @"cardCvv":cardCvv,
                               @"cardYxq":cardYxq,
                               @"token":token,
                               @"sign":sign
                               };
        NSDictionary *dicc;
        if (self.tag == 100) { //激活交易
            dicc = @{
                     @"action":@"ShopActivationSubmit",
                     @"data":dic2
                     };
        }else {     //正常交易
            dicc = @{
                     @"action":@"nocardOrderSmsState",
                     @"data":dic1
                     };
        }
        NSString *params = [dicc JSONFragment];
        NSLog(@"参数:%@",params);
        [IBHttpTool postWithURL:url params:params success:^(id result) {
            //[SVProgressHUD dismiss];
            [GiFHUD dismiss];
            _table.userInteractionEnabled = YES;
            NSDictionary *dicc = [result JSONValue];
            NSString *code = dicc[@"code"];
            NSLog(@"获取短信:%@",dicc);
            NSString *content = dicc[@"msg"];
//            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//            [user setObject:dicc[@"orderNo"] forKey:@"orderNo"];
//            
//            NSLog(@"%@",dicc[@"orderNo"]);
//            NSLog(@"%@",dicc);
            if (![code isEqualToString:@"000000"]) {
                [self alertMsg:content];
                btn.enabled = YES;
            }else {
                btn.hidden = YES;
                _sendCell.reSendBtn.hidden = NO;
                //获取到短信后让支付按钮可点击
                payBtn.enabled = YES;
                payBtn.backgroundColor = NavBack;
            }
            
            
        } failure:^(NSError *error) {
            NSLog(@"请求失败:%@",error);
            [self alertMsg:@"网络请求失败！"];
            btn.enabled = YES;
            //[SVProgressHUD dismiss];
            [GiFHUD dismiss];
            _table.userInteractionEnabled = YES;
        }];
    }
}
//重新发送接口
- (void)reSendAction:(UIButton *)btn {
    
//    btn.enabled = NO;
//    [SVProgressHUD show];
//    NSString *url = BaseUrl;
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *token = [user objectForKey:@"token"];
//    NSString *key = [user objectForKey:@"key"];
//    NSString *orderno = [user objectForKey:@"orderNo"];
//    NSString *md5 = [NSString stringWithFormat:@"%@%@",orderno,key];
//    NSString *sign = [self md5HexDigest:md5];
//    NSDictionary *dic1 = @{
//                           @"orderNo":orderno,
//                           @"token":token,
//                           @"sign":sign
//                           };
//    NSDictionary *dicc = @{
//                           @"action":@"OrderSmsSend",
//                           @"data":dic1
//                           };
//    NSString *params = [dicc JSONFragment];
//    [IBHttpTool postWithURL:url params:params success:^(id result) {
//        [SVProgressHUD dismiss];
//        NSDictionary *dicc = [result JSONValue];
//        NSString *code = dicc[@"code"];
//        NSString *content = dicc[@"msg"];
//        if ([code isEqualToString:@"000000"]) {
//            _sendCell.reSendBtn.hidden = NO;
//            btn.hidden = YES;
//            [self addTimer];
//        }else {
//            [self alertMsg:content];
//            btn.enabled = YES;
//        }
//    } failure:^(NSError *error) {
//        NSLog(@"请求失败:%@",error);
//        [self alertMsg:@"请求网络失败！"];
//        btn.enabled = YES;
//        [SVProgressHUD dismiss];
//    }];

    
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
//添加一个计时器
- (void)addTimer {
    _time = _time + 120;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(startTime) userInfo:nil repeats:YES];
}
//计时器开始方法
- (void)startTime {
    _time--;
    [_sendCell.reSendBtn setTitle:[NSString stringWithFormat:@"重新发送(%lds)",(long)_time] forState:UIControlStateNormal];
    _sendCell.reSendBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    if (_time == 0) {
        [_timer invalidate];
        _sendCell.reSendBtn.hidden = YES;
        _sendCell.button.hidden = NO;
        _sendCell.button.enabled = YES;
    }
}

#define mark - TextFiledDeleage
//短信发送textfiled点击上移和收缩
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    UITextField *text = [self.view viewWithTag:107];
    UITextField *sendtext = [self.view viewWithTag:102];
    if (textField == text) {
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:0.3];
        _table.contentOffset = CGPointMake(0, 135);
        [UIView commitAnimations];
    }if (textField == sendtext) {
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:0.3];
        _table.contentOffset = CGPointMake(0, 58);
        [UIView commitAnimations];
    }
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    UITextField *text = [self.view viewWithTag:107];
    UITextField *sendtext = [self.view viewWithTag:102];
    if (textField == text||textField == sendtext) {
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:0.3];
        _table.contentOffset = CGPointMake(0, 0);
        [UIView commitAnimations];
    }
    if(textField.tag == 200) {
        NameStr = textField.text;
    }
    if (textField.tag == 103) {
        CardID = textField.text;
    }
    if (textField.tag == 104) {
        YXQ = textField.text;
    }
    if (textField.tag == 105) {
        CVV = textField.text;
    }
    if (textField.tag == 106) {
        PhoneNum = textField.text;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    text105 = (UITextField *)[self.view viewWithTag:105];
    UITextField *text10010 = (UITextField *)[self.view viewWithTag:10010];
    if (textField == text105&&range.location >= 3) {
        return NO;
    }
    else if(textField == text10010) {
        __block NSString *text = [textField text];
        
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        }
        text = [text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *newString = @"";
        while (text.length > 0) {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4) {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }
        
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        [textField setText:newString];
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
    
}

-(void)alertMsg: (NSString *)msg
{
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message: msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alter.delegate = self;
    [alter show];
}

//隐私信息打*处理
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

//视图消失的时候将本人卡设为“1”
- (void)viewDidDisappear:(BOOL)animated {
    
    [BusiIntf curPayOrder].BankIsSelf = @"1";
    _isSelf = [NSNumber numberWithInt:[[BusiIntf curPayOrder].BankIsSelf integerValue]];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    [self.view endEditing:YES];
//    
//}

//收键盘
- (void)HiddenKeyBoard {
    
    [NameCell.textFiled resignFirstResponder];
    [CertCell.textFiled resignFirstResponder];
    [ValidDateCell.textFiled resignFirstResponder];
    [CVVCell.textFiled resignFirstResponder];
    [PhoneCell.textFiled resignFirstResponder];
    [_sendCell.text resignFirstResponder];
    
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
