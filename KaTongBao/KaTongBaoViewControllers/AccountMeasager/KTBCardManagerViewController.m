//
//  KTBCardManagerViewController.m
//  KaTongBao
//
//  Created by rongfeng on 16/7/29.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "KTBCardManagerViewController.h"
#import "Common.h"
#import "macro.h"
#import "UIView+SDAutoLayout.h"
#import "AddCardViewController.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import <CommonCrypto/CommonDigest.h>
#import "KTBCardChangeInfoTableViewCell.h"
@interface KTBCardManagerViewController ()

@end

@implementation KTBCardManagerViewController {
    UILabel *InfoLab;
    UILabel *InfoLabTwo;
    UILabel *InfoLabThree;
    NSArray *taskInfoList;
    UITableView *Table;
    UIImageView *wheitImg;
    UIImageView *CertifyImg;
    UIButton *ChangeInfoBtn;
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
    [self RequestForCardInfo];
    [self RequestForChangeInfoRecorde];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"结算银行卡管理";
    UIBarButtonItem *left = [[UIBarButtonItem alloc] init];
    left.title = @"返回";
    self.navigationItem.backBarButtonItem = left;
    self.navigationController.navigationBar.barTintColor = NavBack;
    
    //布局
    UIImageView *BackImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    BackImg.backgroundColor = LightGrayColor;
    BackImg.userInteractionEnabled = YES;
    [self.view addSubview:BackImg];
    
    //手势
    UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(AddCard)];
    Tap.numberOfTapsRequired = 1;

    
    //添加结算银行卡
    wheitImg = [[UIImageView alloc] init];
    wheitImg.backgroundColor = [UIColor whiteColor];
    wheitImg.userInteractionEnabled = YES;
    [wheitImg addGestureRecognizer:Tap];
    wheitImg.hidden = YES;
    
    UIImageView *ImageView = [[UIImageView alloc] init];
    ImageView.image = [UIImage imageNamed:@"AddCard.png"];
    [wheitImg addSubview:ImageView];
    ImageView.sd_layout.leftSpaceToView(wheitImg,20).centerYEqualToView(wheitImg).widthIs(80).heightIs(80);
    
    UILabel *TipsLab = [[UILabel alloc] init];
    NSString *strOne = @"您尚未添加结算银行卡信息";
    NSString *StrTwo = @"点击添加结算银行卡";
    TipsLab.text = [NSString stringWithFormat:@"%@\n%@",strOne,StrTwo];
    TipsLab.font = [UIFont systemFontOfSize:14];
    TipsLab.numberOfLines = 0;
    [wheitImg addSubview:TipsLab];
    TipsLab.sd_layout.leftSpaceToView(ImageView,5).centerYEqualToView(ImageView).widthIs(200).heightIs(60);
    
    [self.view addSubview:wheitImg];
    wheitImg.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(self.view,40).rightSpaceToView(self.view,0).heightIs(200);
    
    //已有认证银行卡
    CertifyImg = [[UIImageView alloc] init];
    CertifyImg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:CertifyImg];
    CertifyImg.sd_layout.leftSpaceToView(self.view,10).topSpaceToView(self.view,20).rightSpaceToView(self.view,10).heightIs(100);
    
    UIImageView *LetfImg = [[UIImageView alloc] init];
    LetfImg.image = [UIImage imageNamed:@"AddCard.png"];
    [CertifyImg addSubview:LetfImg];
    LetfImg.sd_layout.leftSpaceToView(CertifyImg,10).centerYEqualToView(CertifyImg).widthIs(60).heightIs(60);
    
    InfoLab = [[UILabel alloc] init];
    InfoLab.font = [UIFont systemFontOfSize:14];
    InfoLab.textAlignment = NSTextAlignmentLeft;
    InfoLab.numberOfLines = 0;
    NSString *InfoOne = @"";
    NSString *InfoTwo = @"";
    NSString *InfoThree = @"";
    InfoLab.text = InfoOne;
    [CertifyImg addSubview:InfoLab];
    InfoLab.sd_layout.leftSpaceToView(LetfImg,8).topSpaceToView(CertifyImg,10).widthIs(200).heightIs(30);
    
    InfoLabTwo = [[UILabel alloc] init];
    InfoLabTwo.font = [UIFont systemFontOfSize:14];
    InfoLabTwo.textAlignment = NSTextAlignmentLeft;
    InfoLabTwo.numberOfLines = 0;
    InfoLabTwo.text = InfoTwo;
    [CertifyImg addSubview:InfoLabTwo];
    InfoLabTwo.sd_layout.leftSpaceToView(LetfImg,8).topSpaceToView(InfoLab,-8).widthIs(200).heightIs(30);
    
    InfoLabThree = [[UILabel alloc] init];
    InfoLabThree.font = [UIFont systemFontOfSize:14];
    InfoLabThree.textAlignment = NSTextAlignmentLeft;
    InfoLabThree.numberOfLines = 0;
    InfoLabThree.text = InfoThree;
    InfoLabThree.adjustsFontSizeToFitWidth = YES;
    [CertifyImg addSubview:InfoLabThree];
    InfoLabThree.sd_layout.leftSpaceToView(LetfImg,8).topSpaceToView(InfoLabTwo,-8).widthIs(200).heightIs(30);
    
    UILabel *CertifyLab = [[UILabel alloc] init];
    CertifyLab.text = @"已认证";
    CertifyLab.textColor = Green58;
    CertifyLab.font = [UIFont systemFontOfSize:15];
    CertifyLab.textAlignment = NSTextAlignmentRight;
    [CertifyImg addSubview:CertifyLab];
    CertifyLab.sd_layout.rightSpaceToView(CertifyImg,10).centerYEqualToView(CertifyImg).widthIs(80).heightIs(30);
    
    //变更银行卡信息
    ChangeInfoBtn = [[UIButton alloc] init];
    [ChangeInfoBtn setTitle:@"变更银行卡信息" forState:UIControlStateNormal];
    ChangeInfoBtn.layer.cornerRadius = 3;
    ChangeInfoBtn.backgroundColor = NavBack;
    [ChangeInfoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ChangeInfoBtn addTarget:self action:@selector(ChangeInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ChangeInfoBtn];
    ChangeInfoBtn.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,16).topSpaceToView(CertifyImg,40).heightIs(40);
    

    //历史变更记录
    UILabel *HistoryLab = [[UILabel alloc] init];
    HistoryLab.text = @"历史变更记录";
    HistoryLab.font = [UIFont systemFontOfSize:15];
    HistoryLab.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:HistoryLab];
    HistoryLab.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(wheitImg,0).widthIs(KscreenWidth - 16).heightIs(45);
    
    Table = [[UITableView alloc] init];
    Table.delegate = self;
    Table.dataSource = self;
    Table.separatorStyle = UITableViewCellSeparatorStyleNone;
    Table.backgroundColor = LightGrayColor;
    [self.view addSubview:Table];
    Table.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(HistoryLab,0).heightIs(218);
}
//变更银行卡信息
- (void)ChangeInfo {
    
    NSLog(@"改变信息");
    
    AddCardViewController *ADDCardView = [[AddCardViewController alloc] init];
    ADDCardView.tag = 2;
    ADDCardView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ADDCardView animated:YES];
    ADDCardView.hidesBottomBarWhenPushed = NO;
    
    
}
//添加银行卡
- (void)AddCard{
    
    AddCardViewController *AddCard = [[AddCardViewController alloc] init];
    AddCard.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:AddCard animated:YES];
    AddCard.hidesBottomBarWhenPushed = NO;
}
//结算银行卡信息
- (void)RequestForCardInfo {
    
    NSString *url = JXUrl;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    
    NSString *md5 = [NSString stringWithFormat:@"%@",key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"shopBankStateInfo",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSLog(@"数据:%@",result);
        NSDictionary *dic = [result JSONValue];
        NSString *code = dic[@"code"];
        if ([code isEqualToString:@"000000"]) {
            InfoLab.text = dic[@"bankNo"];
            InfoLabTwo.text = dic[@"bankName"];
            InfoLabThree.text = dic[@"bankInfoCnaps"];
            wheitImg.hidden = YES;
            CertifyImg.hidden = NO;
            ChangeInfoBtn.hidden = NO;
        }else { //没有信息
            wheitImg.hidden = NO;
            CertifyImg.hidden = YES;
            ChangeInfoBtn.hidden = YES;
        }
        
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
        
    }];
}
//银行卡变更记录
- (void)RequestForChangeInfoRecorde{
    
    NSString *url = JXUrl;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    
    NSString *md5 = [NSString stringWithFormat:@"%@",key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"shopBankStateList",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSLog(@"数据:%@",result);
        NSDictionary *dic = [result JSONValue];
        NSString *code = dic[@"code"];
        taskInfoList = nil;
        if ([code isEqualToString:@"000000"]) {
            taskInfoList = dic[@"taskInfoList"];
        }
        [Table reloadData];
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
        
    }];
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
    
    return taskInfoList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identy = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell == nil) {
        
        KTBCardChangeInfoTableViewCell *CardCell = [[KTBCardChangeInfoTableViewCell alloc] init];
        CardCell.TimeLab.text = [taskInfoList[indexPath.row] objectForKey:@"createTime"];
        CardCell.BankLab.text = [taskInfoList[indexPath.row] objectForKey:@"bankNick"];
        CardCell.BankNumberLab.text = [self rePlaceString:[taskInfoList[indexPath.row] objectForKey:@"bankNo"]];
        NSString *status = [taskInfoList[indexPath.row] objectForKey:@"taskStatus"];
        if ([status isEqualToString:@"0"]) {
            status = @"初始化";
            CardCell.StatusLab.textColor = [UIColor orangeColor];
        }else if ([status isEqualToString:@"1"]) {
            
            status = @"等待处理";
            CardCell.StatusLab.textColor = [UIColor orangeColor];
        }else if ([status isEqualToString:@"2"]) {
            status = @"处理成功";
        }else if ([status isEqualToString:@"3"]) {
            status = @"处理失败";
            CardCell.StatusLab.textColor = RedColor;
        }else if([status isEqualToString:@"9"]) {
            status = @"保留";
            CardCell.StatusLab.textColor = [UIColor orangeColor];
        }else {
            
        }
        CardCell.StatusLab.text = status;
        cell = CardCell;
    }
        //cell = [[UITableViewCell alloc] init];
    
    return cell;
}

-(NSString*)rePlaceString:(NSString*)string{
    if (![string isKindOfClass:[NSString class]]) {
        return @"";
    }else{
        NSMutableString *mutString = [NSMutableString stringWithString:string];
        NSInteger length = [mutString length];
        if (length>=6) {
            [mutString replaceCharactersInRange:NSMakeRange(3, length-6) withString:@"********"];
        }else{
            
        }
        
        return (NSString*)mutString;
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
