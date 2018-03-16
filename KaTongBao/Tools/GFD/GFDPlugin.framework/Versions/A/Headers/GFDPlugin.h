//
//  GFDPlugin.h
//  GFDPlugin V2.1
//
//  Created by David Lan on 15/11/9.
//  Copyright (c) 2015年 Hangzhou Tree Finance Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * 调用顺序1->2->3->4 eg.

    [[GFDPlugin sharedInstance]setupAPPID:<appID> appKey:<appKey>];//初始化
    [[GFDPlugin sharedInstance]showOnNavigateController:<navigationController> phone:<phone>];//显示功夫贷
 
 */
@interface GFDPlugin : NSObject

@property(nonatomic,readonly) NSString *appID;
@property(nonatomic,readonly) NSString *appKey;
@property(nonatomic,readonly) NSString *sdkVersion;


/*
 * 1. 初始化方法获取单例对象
 */
+(instancetype)sharedInstance;
/*
 * 2. 设置appID和appKey
 */
-(void)setupAPPID:(NSString*)appID appKey:(NSString*)appKey;

/*
 * 3. 显示功夫贷界面，注意：此方法必须在 setupAPPID:appKey 方法后被调用
 */
-(void)showOnNavigateController:(UINavigationController*)nav phone:(NSString *)phone;

/*
 * 4. 手动退出功夫贷登录
 *  - 建议有用户登录的App在用户退出登录后手动调用此方法
 */
-(void)logout;



@end