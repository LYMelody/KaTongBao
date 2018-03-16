//
//  SettingVC.m
//  wujieNew
//
//  Created by rongfeng on 16/1/19.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "SettingVC.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "ViewsCell.h"
#import "LoginViewController.h"
#import "ReNamePwdVC.h"
#import "RestPwdVC.h"
@implementation SettingVC {
    
    UIImageView *LineOne;
    UIImageView *LineTwo;
    UIImageView *LineThird;
    UIImageView *LineFour;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    //隐藏导航栏
    self.navigationController.navigationBarHidden = NO;
    //隐藏工具栏
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = DrackBlue;
    //自定义返回按钮
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    right.title = @"返回";
    self.navigationItem.backBarButtonItem = right;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"设置";
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight + 50) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    table.showsVerticalScrollIndicator = NO;
    [self.view addSubview:table];
    
    UIImageView *FootView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 300)];
    FootView.userInteractionEnabled = YES;
    FootView.backgroundColor = LightGrayColor;
    UILabel *backLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 54, KscreenWidth - 30, 40)];
    backLabel.text = @"退 出";
    backLabel.textColor = [UIColor whiteColor];
    backLabel.textAlignment = NSTextAlignmentCenter;
    backLabel.layer.cornerRadius = 4;
    backLabel.layer.masksToBounds = YES;
    backLabel.backgroundColor = RedColor;
    backLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickClearButton)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.delegate = self;
    
    [backLabel addGestureRecognizer:singleTap];
    [FootView addSubview:backLabel];

    table.tableFooterView = FootView;
    
    
    LineOne = [[UIImageView alloc] init];
    LineOne.backgroundColor = Color(213, 215, 220);
    LineTwo = [[UIImageView alloc] init];
    LineTwo.backgroundColor = Color(213, 215, 220);
    LineThird = [[UIImageView alloc] init];
    LineThird.backgroundColor = Color(213, 215, 220);
    LineFour = [[UIImageView alloc] init];
    LineFour.backgroundColor = Color(213, 215, 220);
}
//退出登录实现方法
-(void)clickClearButton{
    
    LoginViewController* controller = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:controller] ;
    navController.navigationBarHidden = YES;
    navController.toolbarHidden = YES;
    [UIApplication sharedApplication].keyWindow.rootViewController = navController;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 16;
    }else if (indexPath.row == 4){
        return 25;
    }else {
        return 45;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
        if (indexPath.row == 0) {
            ViewsCell *Cell = [[ViewsCell alloc] init];
            Cell.contentView.backgroundColor = LightGrayColor;
            cell = Cell;
        }else if (indexPath.row == 1) {
            cell.textLabel.text = @"检测更新";
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.textLabel.textColor = Gray100;
            [cell.contentView addSubview:LineOne];
            LineOne.sd_layout.leftSpaceToView(cell.contentView,0).rightSpaceToView(cell.contentView,0).topSpaceToView(cell.contentView,-0.5).heightIs(1);
        }else if (indexPath.row == 2) {
            cell.textLabel.text = @"关于我们";
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.textLabel.textColor = Gray100;
        }else if (indexPath.row == 3) {
            cell.textLabel.text = @"意见反馈";
            cell.textLabel.textColor = Gray100;
            [cell.contentView addSubview:LineTwo];
            LineTwo.sd_layout.leftSpaceToView(cell.contentView,0).rightSpaceToView(cell.contentView,0).bottomSpaceToView(cell.contentView,-0.5).heightIs(1);
        }else if (indexPath.row == 4) {
            ViewsCell *Cell = [[ViewsCell alloc] init];
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            Cell.contentView.backgroundColor = LightGrayColor;
            cell = Cell;
        } else if (indexPath.row == 5) {
            cell.textLabel.text = @"修改登录密码";
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.textLabel.textColor = Gray100;
            [cell.contentView addSubview:LineThird];
            [cell.contentView addSubview:LineFour];
            LineThird.sd_layout.leftSpaceToView(cell.contentView,0).rightSpaceToView(cell.contentView,0).topSpaceToView(cell.contentView,-0.5).heightIs(1);
            LineFour.sd_layout.leftSpaceToView(cell.contentView,0).rightSpaceToView(cell.contentView,0).bottomSpaceToView(cell.contentView,-0.5).heightIs(1);
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 5) {
        ReNamePwdVC *ReName = [[ReNamePwdVC alloc] init];
        [self.navigationController pushViewController:ReName animated:YES];
        
//        RestPwdVC *ResetVC = [[RestPwdVC alloc] init];
//        [self.navigationController pushViewController:ResetVC animated:YES];
    }
}
@end
