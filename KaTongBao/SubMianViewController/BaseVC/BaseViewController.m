//
//  BaseViewController.m
//  ChunYa
//
//  Created by JIAN WEI ZHANG on 16/3/23.
//  Copyright © 2016年 JIAN WEI ZHANG. All rights reserved.
//

#import "BaseViewController.h"
#import "macro.h"
@interface BaseViewController ()

{
    UIView *_bgView;
    UILabel *_titleLable;
    UIImageView *_titleImage;
    UIButton *_leftItem;
    UIButton *_rightItem;
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initBaseView];
}

-(void)initBaseView
{
    //把系统的导航条隐藏掉
    self.navigationController.navigationBarHidden = YES;
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, 64)];
    //bgView.backgroundColor = kCustomColor(240, 240, 240);
    [self.view addSubview:bgView];
    [bgView bringSubviewToFront:self.view];
    
    //中间
    UILabel *lableText = [[UILabel alloc]initWithFrame:CGRectZero];
    lableText.text = @"";
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [bgView addSubview:lableText];
    [bgView addSubview:imageView];
    
    //左右button
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton addTarget:self action:@selector(leftEvent:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.frame = CGRectZero;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame = CGRectZero;
    
    [bgView addSubview:leftButton];
    [bgView addSubview:rightButton];
    _bgView = bgView;
    _titleLable = lableText;
    _titleImage = imageView;
    _leftItem = leftButton;
    _rightItem = rightButton;
    
}

#pragma mark -------设置试图控制器的UI Attributes 属性
-(void)setBaseVCAttributes:(NSString *)title
              withLeftName:(NSString *)leftName
             withRightName:(NSString *)rightName
                 withColor:(UIColor *)color
{
    if (!title && !leftName && !rightName) {
        return;
    }
    if (title) {
        if ([title hasSuffix:@".png"] ||
            [title hasSuffix:@".jpg"] ||
            [title hasSuffix:@".jpeg"]) {
            _titleImage.bounds = CGRectMake(0, 0, 60, 35);
            _titleImage.center = CGPointMake(_bgView.center.x, _bgView.center.y + 10);
            _titleImage.image = [UIImage imageNamed:title];
            
            _titleLable.hidden = YES;
        }else{
            _titleLable.text = title;
            _titleLable.textColor = [UIColor whiteColor];
            _titleLable.textAlignment = NSTextAlignmentCenter;
            _titleLable.bounds = CGRectMake(0, 0, 200, 34);
            _titleLable.center = CGPointMake(_bgView.center.x, _bgView.center.y + 10);
            _titleImage.hidden = YES;
        }
    }
    if (leftName) {
        if ([leftName hasSuffix:@".png"] ||
            [leftName hasSuffix:@".jpg"] ||
            [leftName hasSuffix:@".jpeg"]) {
            [_leftItem setImage:[UIImage imageNamed:leftName] forState:UIControlStateNormal];
            _leftItem.frame = CGRectMake(18, _bgView.center.y-3 , 12, 21);
        }else{
            [_leftItem setTitle:leftName forState:UIControlStateNormal];
            _leftItem.frame = CGRectMake(10, _bgView.center.y , 40, 30);
        }
    }
    if (rightName) {
        if ([rightName hasSuffix:@".png"] ||
            [rightName hasSuffix:@".jpg"] ||
            [rightName hasSuffix:@".jpeg"]) {
            [_rightItem setImage:[UIImage imageNamed:rightName] forState:UIControlStateNormal];
            _rightItem.frame = CGRectMake(KscreenWidth - 5 - 50, _bgView.center.y - 10, 55, 50);
        }else{
            [_rightItem setTitle:rightName forState:UIControlStateNormal];
            _rightItem.frame = CGRectMake(KscreenWidth - 5 - 50, _bgView.center.y - 10, 55, 50);
        }
    }
    
    _bgView.backgroundColor = color;
}

- (void)leftEvent:(UIButton *)sender{
    
}
- (void)rightButton:(UIButton *)sender
{
    
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
