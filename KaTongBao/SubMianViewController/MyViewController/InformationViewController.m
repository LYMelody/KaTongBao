//
//  InformationViewController.m
//  JingXuan
//
//  Created by wj on 16/5/16.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "InformationViewController.h"
#import "macro.h"
#import "InformationView.h"
#import "UIView+SDAutoLayout.h"
#import "RealNameViewController.h"


@interface InformationViewController () <UITableViewDataSource,UITableViewDelegate,UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) NSArray *infomationArr;
@property (nonatomic, strong) NSArray *detailArr;
@property (nonatomic, strong) UIButton *headerButton;

@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBaseVCAttributes:@"个人信息" withLeftName:@"返回" withRightName:nil withColor:NavBack];
    self.view.backgroundColor = LightGrayColor;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KscreenWidth, KscreenHeight)];
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.scrollEnabled = NO;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = LightGrayColor;
    [self.view addSubview:tableView];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    NSArray *headerArr = [NSArray arrayWithObjects:@"头像", nil];
    NSArray *userArr = [NSArray arrayWithObjects:@"账号",@"实名认证", nil];
    NSArray *adressArr = [NSArray arrayWithObjects:@"我的地址", nil];
    
    self.infomationArr = [NSArray arrayWithObjects:headerArr,userArr,adressArr, nil];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 2;
    }
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [[cell viewWithTag:VIEWTAGE] removeFromSuperview];
    
    
    InformationView *informationCell = [[InformationView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, 50)];
    informationCell.informationLabel.text = self.infomationArr[indexPath.section][indexPath.row];
    [cell addSubview:informationCell];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        informationCell.informationLabel.hidden = YES;
        informationCell.detailLabel.hidden = YES;
        informationCell.arrowView.hidden = YES;
        
        UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, KscreenWidth/4, 40)];
        headerLabel.text = @"头像";
        headerLabel.textColor = [UIColor darkGrayColor];
        [cell addSubview:headerLabel];
        
        _headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _headerButton.frame = CGRectMake(KscreenWidth-120, 10, 60, 60);
        _headerButton.clipsToBounds = YES;
        _headerButton.layer.cornerRadius = 30;
        [_headerButton setBackgroundImage:[UIImage imageNamed:@"个人信息头像.png"] forState:UIControlStateNormal];
        [_headerButton addTarget:self action:@selector(choosePictureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:_headerButton];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(KscreenWidth-40, 33, 11, 16)];
        imageView.image = [UIImage imageNamed:@"arrow1.png"];
        [cell addSubview:imageView];
        
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        informationCell.arrowView.hidden = YES;
    }
    if (indexPath.section == 1) {
        NSArray *detailArr = [NSArray arrayWithObjects:@"123456",@"未认证", nil];
        informationCell.detailLabel.text = detailArr[indexPath.row];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 80.0f;
    }
    
    return 50.0f;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 20)];
    view.backgroundColor = LightGrayColor;
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 1) {
        RealNameViewController *realNameVC = [[RealNameViewController alloc]init];
        [self.navigationController pushViewController:realNameVC animated:YES];
    }
}
- (void)choosePictureButtonClick:(UIButton *)sender {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选取照片", nil];
    [alertView show];
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        
//    }];
//    
//    UIAlertAction *chosePhotoAction = [UIAlertAction actionWithTitle:@"从相册选取照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        
//    }];
//    
//    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
//    
//    [alert addAction:takePhotoAction];
//    [alert addAction:chosePhotoAction];
//    [alert addAction:cancleAction];
//    
//    [self presentViewController:alert animated:YES completion:nil];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //1、验证方法是否被调用；2、验证参数buttonIndex的值为多少；
    NSLog(@"click-->%ld", buttonIndex);
    //alert buttonIndex规律：有取消按钮，取消为0，后面一次按照顺序递增；如果没有取消按钮，从0开始依次递增；
    if (buttonIndex == 1) {
        [self addCarema];
    }
    if (buttonIndex == 2) {
        [self openPicLibrary];
    }
}

-(void)addCarema
{
    //判断是否可以打开相机,模拟器无法使用此功能
    
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
    //得到图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSLog(@"%@",image);
    
//    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
//    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
//    NSString *imageBase64 = [NSString stringWithFormat:@"%@%@",@"data:image/png;base64,",encodedImageStr];
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *auth = [user objectForKey:@"auth"];
//    NSString *key = [user objectForKey:@"key"];
    
//    NSString *sign = [NSString stringWithFormat:@"%@%@",@"1",key];
//    NSString *str = [self md5:sign];
//    
//    NSDictionary *dic1 = @{@"picNbr":@"1",
//                           @"picBase64":imageBase64,
//                           @"token":auth,
//                           @"sign":str,
//                           };
//    NSDictionary *dicc = @{@"action":@"ShopPicInfo",
//                           @"data":dic1};
//    NSString *params = [dicc JSONFragment];
//    [IBHttpTool postWithURL:HOST params:params success:^(id result) {
//        NSLog(@"数据:%@",result);
//        NSDictionary *dic = [result JSONValue];
//        NSString *msg = dic[@"msg"];
//        [AlertView(msg, @"确定") show];
//    } failure:^(NSError *error) {
//        NSLog(@"网络请求失败:%@",error);
//    }];
    
//    UIButton * btn =[self.scrollView viewWithTag:_currentIndex];
    
    [_headerButton setBackgroundImage:image forState:UIControlStateNormal];
    
    //图片存入相
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)openPicLibrary
{
    //相册是可以用模拟器打开的
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        
        //打开相册选择照片
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:nil];
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"你没有摄像头" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"取消", nil];
        [alert show];
    }
}
- (void)leftEvent:(UIButton *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
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
