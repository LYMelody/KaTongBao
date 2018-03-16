//
//  AddCardViewController.m
//  KaTongBao
//
//  Created by rongfeng on 16/8/1.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "AddCardViewController.h"
#import "Common.h"
#import "macro.h"
#import "BusiIntf.h"
#import "UIView+SDAutoLayout.h"
#import "TDMegCell.h"
#import "MesageCell.h"
#import "ViewsCell.h"
#import "TDAlertViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "SelectProVC.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonDigest.h>
#import "SVProgressHUD.h"
#import "KTBExampleViewController.h"
#import "AFFNumericKeyboard.h"
@interface AddCardViewController ()<MyAlertViewPopupDelegate>

@end

@implementation AddCardViewController {
    
    UIImageView *imageView;
    TDAlertViewController *AlertViewController;
    TDAlertViewController *AlertViewC;
    NSArray *BankArray;
    NSArray *BankTypeArray;
    MesageCell *Mesagecell;
    MesageCell *Mcell;
    UIImageView *ImageView;
    UITableView *AddCardTable;
    NSString *SubBank;
    UIButton *CardFontBtn;
    MesageCell *Bankcell;
    NSString *imageBase64;
    NSUserDefaults *user;
    NSString *CardImgUrl;
    UILabel *SubBankLab;
    BOOL isPhoto;
    UIButton *CommitBtn;
}

-(void)viewWillAppear:(BOOL)animated
{
    //不隐藏导航栏
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.hidden = NO;
    //隐藏工具栏
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = NavBack;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    if ([[BusiIntf curPayOrder].SubBankName isEqualToString:@""] || [BusiIntf curPayOrder].SubBankName == nil) {
//        Mcell.textFiled.hidden = NO;
//        SubBankLab.hidden = YES;
    }else {
        //Mcell.textFiled.text = [BusiIntf curPayOrder].SubBankName;
        Mcell.textFiled.hidden = YES;
        SubBankLab.hidden = NO;
        SubBankLab.text = [BusiIntf curPayOrder].SubBankName;
        SubBankLab.textAlignment = NSTextAlignmentLeft;
        SubBankLab.numberOfLines = 0;
        SubBankLab.adjustsFontSizeToFitWidth = YES;
        [Mcell.contentView addSubview:SubBankLab];
        SubBankLab.sd_layout.leftSpaceToView(Mcell.contentView,90).topSpaceToView(Mcell.contentView,15).widthIs(200).heightIs(18.5);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加银行卡";
    UIBarButtonItem *left = [[UIBarButtonItem alloc] init];
    left.title = @"返回";
    self.navigationItem.backBarButtonItem = left;
    self.navigationController.navigationBar.barTintColor = NavBack;
    
    AddCardTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    AddCardTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    AddCardTable.delegate = self;
    AddCardTable.dataSource = self;
    AddCardTable.scrollEnabled = NO;
    AddCardTable.userInteractionEnabled = YES;
    [self.view addSubview:AddCardTable];
    
    
    UITapGestureRecognizer *TapToHiddenKeyBoard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HiddenKeyBoard)];
    TapToHiddenKeyBoard.numberOfTouchesRequired = 1;
    TapToHiddenKeyBoard.cancelsTouchesInView = NO;
    [AddCardTable addGestureRecognizer:TapToHiddenKeyBoard];
    
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 45)];
    headerView.backgroundColor = LightGrayColor;
    headerView.userInteractionEnabled = YES;
    
    UILabel *BankInfoLab = [[UILabel alloc] init];
    BankInfoLab.textAlignment = NSTextAlignmentLeft;
    BankInfoLab.font = [UIFont systemFontOfSize:14];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"银行卡信息[%@]",[BusiIntf curPayOrder].bankAccont]];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6, [BusiIntf curPayOrder].bankAccont.length)];
    BankInfoLab.attributedText = AttributedStr;
    [headerView addSubview:BankInfoLab];
    BankInfoLab.sd_layout.leftSpaceToView(headerView,16).centerYEqualToView(headerView).widthIs(200).heightIs(40);
    AddCardTable.tableHeaderView = headerView;
    
    imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"确认订单页面下拉"];
    
    ImageView = [[UIImageView alloc] init];
    ImageView.image = [UIImage imageNamed:@"确认订单页面下拉"];
    
    BankArray = [[NSArray alloc] initWithObjects:@"中国工商银行",@"中国农业银行",@"中国银行",@"中国建设银行",@"交通银行",@"中信银行",@"中国光大银行",@"华夏银行",@"中国民生银行" ,@"广发发展银行",@"平安银行",@"招商银行",@"兴业银行",@"上海浦东发展银行",@"恒丰银行",@"浙商银行",@"渤海银行",@"徽商银行",@"上海农村商业银行",@"中国邮政储蓄银行",nil];
    BankTypeArray = [[NSArray alloc] initWithObjects:@"102",@"103",@"104",@"105",@"301",@"302",@"303",@"304",@"305",@"306",@"307",@"308",@"309", @"310",@"315",@"316",@"318",@"319",@"322",@"403",nil];
    UIImageView *footView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 300)];
    footView.backgroundColor = LightGrayColor;
    footView.userInteractionEnabled = YES;
    //身份证正面照
    UIImageView *BackWhiteimg = [[UIImageView alloc] init];
    BackWhiteimg.backgroundColor = [UIColor whiteColor];
    BackWhiteimg.userInteractionEnabled = YES;
    [footView addSubview:BackWhiteimg];
    BackWhiteimg.sd_layout.leftSpaceToView(footView,0).topSpaceToView(footView,0).widthIs(KscreenWidth).heightIs(105);
    
    CardFontBtn = [[UIButton alloc] init];
    CardFontBtn.tag = 1000;
    CardFontBtn.layer.cornerRadius = 3;
    [CardFontBtn setBackgroundImage:[UIImage imageNamed:@"点击上传.png"] forState:UIControlStateNormal];
    
    [CardFontBtn addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:CardFontBtn];
    CardFontBtn.sd_layout.leftSpaceToView(footView,16).topSpaceToView(footView,10).widthIs(90).heightIs(90);
    
    UILabel *MidLab = [[UILabel alloc] init];
    MidLab.text = @"上传您的银行卡正面照";
    MidLab.font = [UIFont systemFontOfSize:14];
    MidLab.textAlignment = NSTextAlignmentLeft;
    [footView addSubview:MidLab];
    MidLab.sd_layout.leftSpaceToView(CardFontBtn,10).topSpaceToView(footView,15).widthIs(200).heightIs(20);
    
    UIButton *CaseBtn = [[UIButton alloc] init];
    [CaseBtn setTitle:@"查看实例" forState:UIControlStateNormal];
    [CaseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    CaseBtn.layer.cornerRadius = 3;
    CaseBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    CaseBtn.backgroundColor = LightGrayColor;
    [CaseBtn addTarget:self action:@selector(Example) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:CaseBtn];
    CaseBtn.sd_layout.rightSpaceToView(footView,10).topSpaceToView(MidLab,30).widthIs(80).heightIs(28);
    
    UIView *LineOne = [[UIView alloc] init];
    LineOne.backgroundColor = [UIColor lightGrayColor];
    LineOne.userInteractionEnabled = YES;
    [footView addSubview:LineOne];
    LineOne.sd_layout.leftSpaceToView(footView,0).topSpaceToView(CardFontBtn,5).widthIs(KscreenWidth).heightIs(0.5);
    
    AddCardTable.tableFooterView = footView;
    
    CommitBtn = [[UIButton alloc] init];
    if (self.tag == 2) {
        [CommitBtn setTitle:@"提交审核" forState:UIControlStateNormal];
    }else {
        [CommitBtn setTitle:@"结算银行卡绑定" forState:UIControlStateNormal];
    }
    
    [CommitBtn  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CommitBtn.layer.cornerRadius = 3;
    CommitBtn.backgroundColor = NavBack;
    CommitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [CommitBtn addTarget:self action:@selector(Commit) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:CommitBtn];
    CommitBtn.sd_layout.leftSpaceToView(footView,20).rightSpaceToView(footView,20).topSpaceToView(LineOne,20).heightIs(40);
    SubBankLab = [[UILabel alloc] init];
}

//拍照
- (void)takePhoto:(UIButton *)btn {
    
    if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.delegate = self;
        //picker.allowsEditing = YES; //是否可编辑
        //摄像头
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }else
        
    {
        //如果没有提示用户
        AlertView(@"没有相机...", @"确定");
    }
}

//拍摄完成后要执行的方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [SVProgressHUD showWithStatus:@"照片正在上传..."];
    //得到图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [CardFontBtn setBackgroundImage:image forState:UIControlStateNormal];
    isPhoto = YES;
    [self dismissViewControllerAnimated:YES completion:^{

    }];
    
    NSString *url = ImgUrl;
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    NSString *encodedImageStr = [GTMBase64 stringByEncodingData:data];
    imageBase64 = [NSString stringWithFormat:@"%@%@",@"data:image/png;base64,",encodedImageStr];
    user = [NSUserDefaults standardUserDefaults];
    NSString *auth = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    
    NSString *sign = [NSString stringWithFormat:@"%@",key];
    NSString *str = [self md5HexDigest:sign];
    
    NSDictionary *dic1 = @{//@"picNbr":imageType,
                           @"fileBase64":imageBase64,
                           @"token":auth,
                           @"sign":str,
                           };
    NSDictionary *dicc = @{@"action":@"fileUploadState",
                           @"data":dic1};
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        
        NSLog(@"数据:%@",result);
        NSDictionary *dic = [result JSONValue];
        NSString *msg = dic[@"msg"];
        NSString *code = dic[@"code"];
        NSString *httpPath = dic[@"httpPath"];
        if ([code isEqualToString:@"000000"]) {
            msg = @"图片上传成功!";
            CardImgUrl = httpPath;
        }
        [AlertView(msg, @"确定") show];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
        [SVProgressHUD dismiss];
    }];
}

//举例
- (void)Example {
    KTBExampleViewController *ExampleVc = [[KTBExampleViewController alloc] init];
    ExampleVc.tag = 104;
    ExampleVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ExampleVc animated:YES];
    ExampleVc.hidesBottomBarWhenPushed = NO;
}

//提交信息
- (void)Commit {
    NSLog(@"*******************");
    
    CommitBtn.enabled = NO;
    if([Bankcell.textFiled.text isEqualToString:@""] || [Mesagecell.textFiled.text isEqualToString:@""] || [SubBankLab.text isEqualToString:@""]) {
        [self alert:@"请填写完整您的银行卡信息!"];
        CommitBtn.enabled = YES;
        return;
    }else if (!isPhoto) {
        [self alert:@"请上传您的银行卡正面照!"];
        CommitBtn.enabled = YES;
        return;
    }
    
    [SVProgressHUD show];
    NSString *url = JXUrl;
    
    user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    
    NSString *md5 = [NSString stringWithFormat:@"%@%@%@%@",[BusiIntf curPayOrder].BankCode,CardImgUrl,[Bankcell.textFiled.text stringByReplacingOccurrencesOfString:@" " withString:@""],key];
    NSString *sign = [self md5HexDigest:md5];
    NSLog(@"%@%@",[BusiIntf curPayOrder].BankCode,[Bankcell.textFiled.text stringByReplacingOccurrencesOfString:@" " withString:@""]);
    NSDictionary *dic1 = @{
                           @"bankCode":[BusiIntf curPayOrder].BankCode,
                           @"pic3":CardImgUrl,
                           @"shopBank":[Bankcell.textFiled.text stringByReplacingOccurrencesOfString:@" " withString:@""],
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = nil;
    if (self.tag == 2) {   //银行卡信息变更
        dicc = @{
                               @"action":@"shopBankStateModify",
                               @"data":dic1
                               };
    }else {
        dicc = @{
                               @"action":@"shopBankStateBind",
                               @"data":dic1
                               };
    }
    
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSLog(@"数据:%@",result);
        NSDictionary *dic = [result JSONValue];
        NSString *code = dic[@"code"];
        NSString *msg = dic[@"msg"];
        if ([code isEqualToString:@"000000"]) {
            [self alert:@"信息提交成功!"];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [self alert:msg];
        }
        [SVProgressHUD dismiss];
        CommitBtn.enabled =YES;
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
        [SVProgressHUD dismiss];
        CommitBtn.enabled = YES;
    }];
}

//银行卡输入显示
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 45;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identy = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        if(indexPath.row == 0) {
            Bankcell = [[MesageCell alloc] init];
            Bankcell.label.text = @"银行卡号";
            Bankcell.textFiled.placeholder = @"请输入银行卡信息";
            Bankcell.textFiled.keyboardType = UIKeyboardTypeNumberPad;
            Bankcell.textFiled.delegate = self;
//            AFFNumericKeyboard *AFFKeyboard = [[AFFNumericKeyboard alloc] init];
//            AFFKeyboard.Tag = 2;
//            AFFKeyboard.delegate = self;
//            Bankcell.textFiled.inputView = AFFKeyboard;
            
            //Bankcell.textFiled.inputView
            cell = Bankcell;
        }else if (indexPath.row == 1) {
            Mesagecell = [[MesageCell alloc] init];
            Mesagecell.label.text = @"所属银行";
            Mesagecell.textFiled.placeholder = @"请选择所属银行";
            Mesagecell.textFiled.enabled = NO;
            [Mesagecell addSubview:imageView];
            imageView.sd_layout.centerYEqualToView(Mesagecell).rightSpaceToView(Mesagecell,15).widthIs(20).heightIs(20);
            cell = Mesagecell;
        }else if (indexPath.row == 2) {
            Mcell = [[MesageCell alloc] init];
            Mcell.label.text = @"所属支行";
            Mcell.textFiled.placeholder = @"请选择所属支行";
            Mcell.textFiled.enabled = NO;
            if ([[BusiIntf curPayOrder].SubBankName isEqualToString:@""] || [BusiIntf curPayOrder].SubBankName == nil) {
                SubBankLab.hidden = YES;
            }else {
                Mcell.textFiled.text = [BusiIntf curPayOrder].SubBankName;
                Mcell.textFiled.hidden = YES;
                SubBankLab.hidden = NO;
                SubBankLab.text = [BusiIntf curPayOrder].SubBankName;
                SubBankLab.textAlignment = NSTextAlignmentLeft;
                SubBankLab.numberOfLines = 0;
                SubBankLab.adjustsFontSizeToFitWidth = YES;
                [Mcell.contentView addSubview:SubBankLab];
                SubBankLab.sd_layout.leftSpaceToView(Mcell.contentView,90).topSpaceToView(Mcell.contentView,15).widthIs(200).heightIs(18.5);
            }
           // Mcell.textFiled.adjustsFontSizeToFitWidth = YES;
            [Mcell addSubview:ImageView];
            ImageView.sd_layout.centerYEqualToView(Mcell).rightSpaceToView(Mcell,15).widthIs(20).heightIs(20);
            cell = Mcell;
        }else if (indexPath.row == 3) {
            ViewsCell *Viewcell = [[ViewsCell alloc] init];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, Viewcell.height)];
            label.text = @"  上传以下资料可申请认证";
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:14];
            label.backgroundColor = LightGrayColor;
            [Viewcell addSubview:label];
            cell = Viewcell;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        AlertViewController = nil;
        AlertViewController = [[TDAlertViewController alloc] initWithNibName:@"TDAlertViewController" bundle:nil contentArray:BankArray titleStr:@"请选择所属银行" tag:2];
        [AlertViewController.view setBackgroundColor:[UIColor whiteColor]];
        AlertViewController.delegate = self;
        [self presentPopupViewController:AlertViewController animationType:MJPopupViewAnimationFade];
    }else if (indexPath.row == 2) {
        if ([Mesagecell.textFiled.text isEqualToString:@""]) {
            [self alert:@"请先选择所属银行"];
            return;
        }
        SelectProVC *SPV = [[SelectProVC alloc] init];
        SPV.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:SPV animated:YES];
        SPV.hidesBottomBarWhenPushed = NO;
    }
    
}

//点击选择支付理由
-(void)tableViewSelect:(TDAlertViewController *)alertViewController tag:(int)myTag selectNum:(int)num{
    if (myTag != 3) {  //商品名称
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
        if (alertViewController == AlertViewController) {
            Mesagecell.textFiled.text = BankArray[num];
            [BusiIntf curPayOrder].AddBankName = BankArray[num];
            [BusiIntf curPayOrder].BankCardType = BankTypeArray[num];
        }
        
    }else {   //银行卡
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
        
    }
}

#define mark - AFFKeyBoardDeleage
//-(void)numberKeyboardBackspace
//{
//    if (Bankcell.textFiled.text.length != 0)
//    {
//        Bankcell.textFiled.text = [Bankcell.textFiled.text substringToIndex:Bankcell.textFiled.text.length -1];
//        //[self EnquirySubBank:SearchFld.text];
//    }
//}
//
//-(void)numberKeyboardInput:(NSInteger)number
//{
//    
//    Bankcell.textFiled.text = [Bankcell.textFiled.text stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)number]];
//    
//}
//
//- (void)ResignFirstResponse {
//    [Bankcell.textFiled resignFirstResponder];
//}

- (void)alert:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

- (void)viewDidDisappear:(BOOL)animated {
    if (![[BusiIntf curPayOrder].SubBankName isEqualToString:@""]) {
        [BusiIntf curPayOrder].SubBankName = nil;
    }
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    [self.view endEditing:YES];
//}

- (void)HiddenKeyBoard {
    [Bankcell.textFiled resignFirstResponder];
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
