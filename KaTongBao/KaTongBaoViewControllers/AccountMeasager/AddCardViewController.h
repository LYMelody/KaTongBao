//
//  AddCardViewController.h
//  KaTongBao
//
//  Created by rongfeng on 16/8/1.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFFNumericKeyboard.h"
@interface AddCardViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,AFFNumericKeyboardDelegate>

@property(nonatomic,assign)NSInteger tag;
@end
