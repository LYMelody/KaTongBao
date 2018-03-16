//
//  UISaveCardPay.m
//  wujie
//
//  Created by rongfeng on 15/11/20.
//  Copyright © 2015年 ND. All rights reserved.
//

#import "UISaveCardPay.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "BankCell.h"
#import "ViewsCell.h"
#import "SendMegCell.h"
#import "MesageCell.h"
#import "BusiIntf.h"
#import <CommonCrypto/CommonDigest.h>
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "UIFinashPay.h"
#import "UIPayDefault.h"
#import "CodeModel.h"
#import "SVProgressHUD.h"
#import "UIPayCheck.h"
#import "WalletViewController.h"
@interface UISaveCardPay ()

@end

@implementation UISaveCardPay {
    
    NSString  *_cardType;
    NSString  *_isSelf;
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
    MesageCell *NameCell;
    MesageCell *CertCell;
    MesageCell *ValidDateCell;
    MesageCell *CVVcell;
    MesageCell *PhoneCell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _cardType = [BusiIntf curPayOrder].BankCardType;
    NSLog(@"%@%@",_cardType,[BusiIntf curPayOrder].BankCardType);
    _isSelf = [BusiIntf curPayOrder].BankIsSelf;
    NSLog(@"%@",[BusiIntf curPayOrder].BankIsSelf);
    //_cardType = @0;
    //_isSelf = @"1";
    //[self addBackBtn];
    self.title = @"确认支付";
    //添加一个table
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight + 52 ) style:UITableViewStylePlain];
    _table.dataSource = self;
    _table.delegate = self;
    _table.backgroundColor = LightGrayColor;
    _table.showsVerticalScrollIndicator = NO;
    
    UITapGestureRecognizer *TapHiddenKeyBoard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HiddenKeyBoard)];
    TapHiddenKeyBoard.numberOfTouchesRequired = 1;
    TapHiddenKeyBoard.cancelsTouchesInView = NO;
    [_table addGestureRecognizer:TapHiddenKeyBoard];
    
    
    
    UIImageView *ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 55)];
     ImageView.backgroundColor = PayBackColor;
    UILabel *label = [[UILabel alloc] init];
    label.text = @"付款";
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor]; 
    [ImageView addSubview:label];
   
    UILabel *CarshLabel = [[UILabel alloc] init];
    CarshLabel.text = [NSString stringWithFormat:@"￥%@.00",[BusiIntf curPayOrder].OrderAmount];
    CarshLabel.textColor = [UIColor redColor];
    CarshLabel.font = [UIFont systemFontOfSize:24];
    CarshLabel.textAlignment = NSTextAlignmentCenter;
    CarshLabel.backgroundColor = [UIColor clearColor];
    [ImageView addSubview:CarshLabel];
    
    //设置table的头视图
    _table.tableHeaderView = ImageView;
    [self.view insertSubview:_table belowSubview:self.view];
    //布局头视图
     label.sd_layout.centerXEqualToView(_table).widthIs(100).heightIs(20).topSpaceToView(ImageView,5);
    CarshLabel.sd_layout.centerXEqualToView(_table).widthIs(200).heightIs(30).topSpaceToView(label,0);
    //设置table的尾视图(非本人交易)
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 200)];
    footView.backgroundColor = GrayColor;
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btn];
    _Img = [[UIImageView alloc] init];
    _Img.image = [UIImage imageNamed:@"iconfont-htmal5icon22.png"];
    [footView addSubview:_Img];
    UILabel *Deleagelabel = [[UILabel alloc] init];
    Deleagelabel.text = @"《一键支付服务协议》";
    Deleagelabel.font = [UIFont systemFontOfSize:13];
    Deleagelabel.textAlignment = NSTextAlignmentCenter;
    Deleagelabel.textColor = [UIColor blueColor];
    Deleagelabel.backgroundColor = [UIColor clearColor];
    [footView addSubview:Deleagelabel];
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
    UIButton *payBtn = [[UIButton alloc] init];
    payBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [payBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [payBtn addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    payBtn.backgroundColor = LightYellow;
    payBtn.layer.cornerRadius = 7;
    [footView addSubview:payBtn];
    //布局尾视图
    btn.sd_layout.leftSpaceToView(footView,19).topSpaceToView(footView,7).widthIs(18).heightIs(18);
    agreeLabel.sd_layout.leftSpaceToView(footView,46.5).topSpaceToView(footView,6).widthIs(30).heightIs(20);
    Deleagelabel.sd_layout.leftSpaceToView(footView,76.5).topSpaceToView(footView,6).widthIs(140).heightIs(20);
    tipsLabel.sd_layout.leftSpaceToView(footView,18).topSpaceToView(footView,40).widthIs(270).heightIs(67);
    payBtn.sd_layout.leftSpaceToView(footView,18).topSpaceToView(footView,126).widthIs(280).heightIs(38);
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
    
    if (![_isSelf isEqual:@"1"]) {
        _table.tableFooterView = footView;
    }else if ([_isSelf  isEqual:@"1"]) {
        _table.tableFooterView = SelfFootView;
        _table.scrollEnabled = NO;
    }
    
    //激活银行卡布局
    UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    leftLab.text = @"卡  号:";
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
//支付接口发起支付
- (void)pay:(UIButton *)btn {
    
    [SVProgressHUD show];
    _table.userInteractionEnabled = NO;
    btn.enabled = NO;
    NSString *url = BaseUrl;
    sms = @"123456";
    if ([_cardType isEqual:@"0"]&&![_isSelf isEqualToString:@"1"]) {
        UITextField *text102 = [self.view viewWithTag:102];
        sms = text102.text;
    }else {
        sms = _sendCell.text.text;
    }
    if ([sms isEqualToString:@""] || sms == nil) {
        [self alertMsg:@"请输入验证码"];
        btn.enabled = YES;
        [SVProgressHUD dismiss];
        _table.userInteractionEnabled = YES;
    }else {
        btn.enabled = YES;
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *token = [user objectForKey:@"token"];
        NSString *key = [user objectForKey:@"key"];
        NSString *orderNo = [user objectForKey:@"orderNo"];
        //如果没有创建订单给个提示，并返回.
        if (orderNo == nil) {
            //[Dialog showMsg:@"您还没有获取验证码!"];
            [self alertMsg:@"您还没有获取验证码!"];
            [SVProgressHUD dismiss];
            _table.userInteractionEnabled = YES;
            btn.enabled = YES;
            return;
        }
        NSString *md5 = [NSString stringWithFormat:@"%@%@%@",orderNo,sms,key];
        NSString *sign = [self md5HexDigest:md5];
        NSDictionary *dic1 = @{
                              @"orderNo":orderNo,
                              @"sms":sms,
                              @"token":token,
                              @"sign":sign
                              };
       NSDictionary *dicc = @{
                               @"action":@"OrderPaySubmit",
                               @"data":dic1
                               };

        NSString *params = [dicc
                            JSONFragment];
        [IBHttpTool postWithURL:url params:params success:^(id result) {
            
            NSDictionary *dicc = [result JSONValue];
            NSString *code = dicc[@"code"];
            NSString *errorMsg = dicc[@"content"];
            NSLog(@"%@",dicc);
            if ([code isEqualToString:@"000000"]){
                //做一个银行校验
                //[self requestForList:sms];
                _index = _index + 9;
                _Timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(StartTimer) userInfo:nil repeats:YES];
                btn.enabled = YES;
            }else {
               
                //push到失败页面
                UIPayDefault *defaultVC = [[UIPayDefault alloc] init];
                self.model = [[CodeModel alloc] init];
                self.model.code = code;
                self.model.errorMsg = errorMsg;
                defaultVC.model = self.model;
                [self.navigationController pushViewController:defaultVC animated:YES];
                btn.enabled = YES;
//                UIPayCheck *check = [[UIPayCheck alloc] init];
//                [self.navigationController pushViewController:check animated:YES];
                [SVProgressHUD dismiss];
                _table.userInteractionEnabled = YES;
            }
            
        }failure:^(NSError *error) {
            [SVProgressHUD dismiss];
            _table.userInteractionEnabled = YES;
            btn.enabled = YES;
            NSLog(@"请求失败:%@",error);
           // [UIManager doNavWnd:WndPayDefault];
        }];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([_isSelf isEqualToString:@"1"]) {
        return 4;
    } else if ([_cardType  isEqual: @0]){
        return 7;
    }else {
        return 9;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        if ([_isSelf isEqualToString:@"1"]) {
            return 10;
        }else {
             return 36;
        }
    } else if(indexPath.row == 1){
        return 65;
    }else if(indexPath.row == 2) {
        if ([_isSelf isEqualToString:@"1"]) {
            return 24;
        }else {
            return 7;
        }
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
            if ([_isSelf isEqualToString:@"1"]) {
                cell = [[ViewsCell alloc] init];
            }else {
                ViewsCell *Viewcell = [[ViewsCell alloc] init];
                Viewcell.lael.text = @"   填写银行卡信息";
                Viewcell.lael.textAlignment = NSTextAlignmentLeft;
                Viewcell.backgroundColor = [UIColor whiteColor];
                UIImageView *Img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 0.5)];
                Img.backgroundColor = Gray136;
                [Viewcell addSubview:Img];
                cell = Viewcell;
            }
        }
        if (indexPath.row == 1) {
            if (self.tag == 100) {
                [cell.contentView addSubview:BankFld];
                BankFld.sd_layout.leftSpaceToView(cell.contentView,16).rightSpaceToView(cell.contentView,16).topSpaceToView(cell.contentView,10).heightIs(20);
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }else {
                cell = [[BankCell alloc] init];
            }
            UIImageView *Img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, KscreenWidth, 0.5)];
            Img.backgroundColor = Gray136;
            [cell addSubview:Img];
        }
        if (indexPath.row == 2) {
            cell = [[ViewsCell alloc] init];
            cell.backgroundColor = LightGrayColor;
        }
        if ([_isSelf isEqualToString:@"1"]) {
            if (indexPath.row == 3) {
                _sendCell = [[SendMegCell alloc] init];
                _sendCell.text.tag = 110;
                [_sendCell.button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
                _sendCell.text.keyboardType = UIKeyboardTypeNumberPad;
                [_sendCell.sendButton addTarget:self action:@selector(reSendAction:) forControlEvents:UIControlEventTouchUpInside];
                _sendCell.button.hidden = NO;
                cell = _sendCell;
            }
        }else if([_cardType  isEqual: @"0"]) {
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
        }else {     //信用卡
            if (indexPath.row == 3) {
                NameCell = [[MesageCell alloc] init];
                NameCell.label.text = @"姓   名";
                NameCell.textFiled.placeholder = @"请输入真实姓名";
                //测试
                NameCell.textFiled.text = NameStr;
                NameCell.textFiled.tag = 200;
                NameCell.textFiled.delegate = self;
                if (self.tag == 100) {
                    NameCell.textFiled.text = [BusiIntf curPayOrder].bankAccont;
                    NameCell.textFiled.enabled = NO;
                }
                cell = NameCell;
                [cell.contentView addSubview:LineOne];
                LineOne.sd_layout.leftSpaceToView(cell.contentView,0).rightSpaceToView(cell.contentView,0).topSpaceToView(cell.contentView,0).heightIs(0.5);
            }
            if (indexPath.row == 4) {
                CertCell = [[MesageCell alloc] init];
                CertCell.label.text = @"身份证";
                CertCell.textFiled.tag = 103;
                CertCell.textFiled.delegate = self;
                CertCell.textFiled.placeholder = @"请输入持卡人身份证";
                CertCell.textFiled.text = CardID;
                //测试
                //megcell.textFiled.text = @"";
                CertCell.textFiled.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                if (self.tag == 100) {
                    
                    CertCell.textFiled.text = [BusiIntf curPayOrder].shopCard;
                    CertCell.textFiled.enabled = NO;
                }
                cell = CertCell;
            }
            if (indexPath.row == 5) {
                ValidDateCell = [[MesageCell alloc] init];
                ValidDateCell.label.text = @"有效期";
                ValidDateCell.textFiled.tag = 104;
                ValidDateCell.textFiled.delegate = self;
                ValidDateCell.textFiled.text = YXQ;
                ValidDateCell.textFiled.keyboardType = UIKeyboardTypeNumberPad;
                ValidDateCell.textFiled.placeholder = @"有效期,月/年(如06/15输入0615)";
                //测试
                //megcell.textFiled.text = @"";
                cell = ValidDateCell;
            }
            if (indexPath.row == 6) {
                CVVcell = [[MesageCell alloc] init];
                CVVcell.label.text = @"CVV2";
                CVVcell.textFiled.delegate = self;
                CVVcell.textFiled.text = CVV;
                CVVcell.textFiled.tag = 105;
                CVVcell.textFiled.keyboardType = UIKeyboardTypeNumberPad;
                CVVcell.textFiled.placeholder = @"CVV2,卡背后三位";
                //测试
               // megcell.textFiled.text = @"";
                CVVcell.textFiled.secureTextEntry = YES;
                cell = CVVcell;
            }
            if (indexPath.row == 7) {
                PhoneCell = [[MesageCell alloc] init];
                PhoneCell.label.text = @"手机号";
                PhoneCell.textFiled.tag = 106;
                PhoneCell.textFiled.text = PhoneNum;
                PhoneCell.textFiled.keyboardType = UIKeyboardTypeNumberPad;
                PhoneCell.textFiled.placeholder = @"银行预留手机号";
                //测试
                //megcell.textFiled.text = @"";
                if (self.tag == 100) {
//                    megcell.textFiled.text = [BusiIntf getUserInfo].UserName;
//                    megcell.textFiled.enabled = NO;
                }
                cell = PhoneCell;
            }
            if (indexPath.row == 8) {
                _sendCell = [[SendMegCell alloc] init];
                _sendCell.text.tag = 107;
                _sendCell.text.delegate = self;
                _sendCell.text.keyboardType = UIKeyboardTypeNumberPad;
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
//创建订单，获取短信验证码
- (void)clickAction:(UIButton *)btn {
    btn.enabled = NO;
    [SVProgressHUD show];
    //tableview不能点击
    _table.userInteractionEnabled = NO;
    
    OrderInfo *info = [BusiIntf curPayOrder];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *url = BaseUrl;
    NSString *cardNbr = @"";
    //NSString *orderType = [BusiIntf curPayOrder].TypeOrder;
    NSString *cardPhone = @"";
    NSString *cardCvv = @"";
    NSString *cardYxq = @"";
    NSString *imsi = @"";
    NSString *cardName = @"";
    //获取UUID并进行md5编码
    NSString *UUID = [[UIDevice currentDevice].identifierForVendor UUIDString];
    NSLog(@"uuid:%@",UUID);
    NSString *imsimd5 = [self md5:UUID];
    NSString *UUID16 = [[imsimd5 substringFromIndex:8] substringToIndex:16];
    NSString *mac = @"";
    if ([_cardType  isEqual: @"0"] && ![_isSelf isEqualToString:@"1"]) {
        UITextField *text100 = (UITextField *)[self.view viewWithTag:100];
        UITextField *text101 = (UITextField *)[self.view viewWithTag:101];
        UITextField *text201 = (UITextField *)[self.view viewWithTag:201];
        cardNbr = text100.text;
        cardPhone = text101.text;
        cardName = text201.text;
    } else if ([_cardType isEqual:@"1"]&&![_isSelf isEqualToString:@"1"]) {
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
    if ([_cardType isEqual:@"1"]&&![_isSelf isEqualToString:@"1"]&&([cardNbr isEqualToString:@""]||[cardYxq isEqualToString:@""]||[cardCvv isEqualToString:@""]||[cardPhone isEqualToString:@""]))
             {
                [self alertMsg:@"请填写完整信息"];
                 btn.enabled = YES;
                 [SVProgressHUD dismiss];
                 _table.userInteractionEnabled = YES;
                 return;
            }else if([_cardType isEqual:@0]&&![_isSelf isEqualToString:@"1"]&&([cardNbr isEqualToString:@""]||[cardPhone isEqualToString:@""])){
             {
                [self alertMsg:@"请填写完整信息"];
                 btn.enabled = YES;
                 [SVProgressHUD dismiss];
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
                    [SVProgressHUD dismiss];
                    _table.userInteractionEnabled = YES;
                    return;
                }
                MD5 = [NSString stringWithFormat:@"%@%@%@%@",[BankFld.text stringByReplacingOccurrencesOfString:@" " withString:@""],cardCvv,cardYxq,key];
            }else {
                MD5 = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",info.OrderNo,[cardName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],cardNbr,cardPhone,cardCvv,cardYxq,imsi,mac,UUID16,key];
            }
            NSLog(@"%@",MD5);
            NSLog(@"%@",info.OrderName);
            NSString *sign = [self md5HexDigest:MD5];
            NSLog(@"%@",sign);
            NSDictionary *dic1 = @{
                                  @"orderNo": [BusiIntf curPayOrder].OrderNo,
                                  @"cardName":[cardName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                                  @"cardNbr":cardNbr,
                                  @"cardPhone":cardPhone,
                                  @"cardCvv":cardCvv,
                                  @"cardYxq":cardYxq,
                                  @"imei":UUID16,
                                  @"imsi":imsi,
                                  @"mac":mac,
                                  @"token":token,
                                  @"sign":sign
                                  };
            NSDictionary *dic2 = @{
                                   @"cardNo":[BankFld.text stringByReplacingOccurrencesOfString:@" " withString:@""],
                                   @"cardCvv":cardCvv,
                                   @"cardYxq":cardYxq,
                                   @"imei":UUID16,
                                   @"cardPhone":cardPhone,
                                   @"imsi":imsi,
                                   @"mac":mac,
                                   @"token":token,
                                   @"sign":sign
                                   };
        NSDictionary *dicc;
            if (self.tag == 100) {
               dicc = @{
                       @"action":@"ShopActivationSubmit",
                       @"data":dic2
                       };
            }else {
                dicc = @{
                       @"action":@"OrderCreate",
                       @"data":dic1
                       };
            }
            NSString *params = [dicc JSONFragment];
            NSLog(@"参数:%@",params);
            [IBHttpTool postWithURL:url params:params success:^(id result) {
                [SVProgressHUD dismiss];
                _table.userInteractionEnabled = YES;
                NSDictionary *dicc = [result JSONValue];
                NSString *code = dicc[@"code"];
                
                NSString *content = dicc[@"content"];
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                [user setObject:dicc [@"orderNo"] forKey:@"orderNo"];
                [user synchronize];
                NSLog(@"%@",dicc[@"orderNo"]);
                NSLog(@"%@",dicc);
                if (![code isEqualToString:@"000000"]) {
                    [self alertMsg:content];
                    btn.enabled = YES;
                }else {
                     btn.hidden = YES;
                     _sendCell.reSendBtn.hidden = NO;
                }
            } failure:^(NSError *error) {
                NSLog(@"请求失败:%@",error);
                [self alertMsg:@"网络请求失败！"];
                btn.enabled = YES;
                [SVProgressHUD dismiss];
                _table.userInteractionEnabled = YES;
            }];
    }
}
//重新发送接口
- (void)reSendAction:(UIButton *)btn {
    btn.enabled = NO;
    [SVProgressHUD show];
    _table.userInteractionEnabled = NO;
    NSString *url = BaseUrl;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *orderno = [user objectForKey:@"orderNo"];
    NSString *md5 = [NSString stringWithFormat:@"%@%@",orderno,key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                          @"orderNo":orderno,
                          @"token":token,
                          @"sign":sign
                          };
    NSDictionary *dicc = @{
                           @"action":@"OrderSmsSend",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        [SVProgressHUD dismiss];
        _table.userInteractionEnabled = YES;
        NSDictionary *dicc = [result JSONValue];
        NSString *code = dicc[@"code"];
        NSString *content = dicc[@"content"];
        if ([code isEqualToString:@"000000"]) {
            _sendCell.reSendBtn.hidden = NO;
            btn.hidden = YES;
            [self addTimer];
        }else {
            [self alertMsg:content];
            btn.enabled = YES;
        }
    } failure:^(NSError *error) {
        NSLog(@"请求失败:%@",error);
        [self alertMsg:@"请求网络失败！"];
        btn.enabled = YES;
        [SVProgressHUD dismiss];
        _table.userInteractionEnabled = YES;
    }];
}
//添加一个计时器
- (void)addTimer {
    _time = _time + 120;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(startTime) userInfo:nil repeats:YES];
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

//计时器开始方法
- (void)startTime {
    _time--;
    [_sendCell.reSendBtn setTitle:[NSString stringWithFormat:@"重新发送(%lds)",(long)_time] forState:UIControlStateNormal];
    if (_time == 0) {
        [_timer invalidate];
        _sendCell.reSendBtn.hidden = YES;
        _sendCell.sendButton.hidden = NO;
        _sendCell.sendButton.enabled = YES;
    }
}

- (void)StartTimer {
    
    _index = _index - 3;
    [self requestForList:sms];
}
    
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
//    } else if (textField == text104) {
//        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//        [UIView setAnimationDuration:0.3];
//        _table.contentOffset = CGPointMake(0, 8);
//        [UIView commitAnimations];
//    } else if (textField == text105) {
//        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//        [UIView setAnimationDuration:0.3];
//        _table.contentOffset = CGPointMake(0, 48);
//        [UIView commitAnimations];
//    } else if (textField == text106) {
//        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//        [UIView setAnimationDuration:0.3];
//        _table.contentOffset = CGPointMake(0, 88);
//        [UIView commitAnimations];
//    }
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
////银行卡输入显示
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    //    if (!textField.isBankNoField)
//    //        return YES;
//    
//    __block NSString *text = [textField text];
//    
//    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
//    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
//    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
//        return NO;
//    }
//    
//    text = [text stringByReplacingCharactersInRange:range withString:string];
//    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
//    
//    NSString *newString = @"";
//    while (text.length > 0) {
//        NSString *subString = [text substringToIndex:MIN(text.length, 4)];
//        newString = [newString stringByAppendingString:subString];
//        if (subString.length == 4) {
//            newString = [newString stringByAppendingString:@" "];
//        }
//        text = [text substringFromIndex:MIN(text.length, 4)];
//    }
//    
//    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
//    
//    
//    [textField setText:newString];
//    
//    return NO;
//}

//订单查询
- (void)requestForList:(NSString *)sms {
    [SVProgressHUD show];
    NSString *url = BaseUrl;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    NSString *orderNo = [user objectForKey:@"orderNo"];
    NSString *md5 = [NSString stringWithFormat:@"%@%@",orderNo,key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                          @"orderNo":orderNo,
                          @"token":token,
                          @"sign":sign
                          };
    NSDictionary *dicc = @{
                           @"action":@"OrderStatusQuery",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    NSLog(@"参数：%@",params);
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSDictionary *dicc = [result JSONValue];
        NSLog(@"订单列表：%@",dicc);
        NSString *content = dicc[@"content"];
        NSString *failCode = dicc[@"failCode"];
        NSString *failMsg = dicc[@"failMsg"];
        if ([content isEqualToString:@"SUCC"] || [content isEqualToString:@"FROZEN"]) {
            //支付成功
            //[UIManager doNavWnd:WndFinashPay];
            UIFinashPay *PaySucc = [[UIFinashPay alloc] init];
            if (self.tag == 100) {
                PaySucc.tag = 100;
            }
            [self.navigationController pushViewController:PaySucc animated:YES];
            [_Timer invalidate];
            _index = 0;
            [SVProgressHUD dismiss];
        }
        else if(_index == 0 && [content isEqualToString:@"WAIT"]) {
            //[self alertMsg:content];
            UIPayCheck *check = [[UIPayCheck alloc] init];
            [self.navigationController pushViewController:check animated:YES];
            [_Timer invalidate];
            [SVProgressHUD dismiss];
        }else if ([content isEqualToString:@"FAIL"]) {
            UIPayDefault *defaultVC = [[UIPayDefault alloc] init];
            self.model = [[CodeModel alloc] init];
            self.model.code = failCode;
            self.model.errorMsg = failMsg;
            defaultVC.model = self.model;
            [self.navigationController pushViewController:defaultVC animated:YES];

            [_Timer invalidate];
            _index =0;
            [SVProgressHUD dismiss];
        }else {
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"网络申请失败:%@",error);
        [SVProgressHUD dismiss];
    }];
}

-(void)alertMsg: (NSString *)msg
{
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message: msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alter.delegate = self;
    [alter show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//收键盘
- (void)HiddenKeyBoard {
    
    [NameCell.textFiled resignFirstResponder];
    [CertCell.textFiled resignFirstResponder];
    [ValidDateCell.textFiled resignFirstResponder];
    [CVVcell.textFiled resignFirstResponder];
    [PhoneCell.textFiled resignFirstResponder];
    [_sendCell.text resignFirstResponder];
    
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    [self.view endEditing:YES];
//    
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
