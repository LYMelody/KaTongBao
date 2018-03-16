//
//  macro.h
//  TFB
//
//  Created by 李 玉清 on 15/5/6.
//  Copyright (c) 2015年 TD. All rights reserved.
//

#ifndef TFB_macro_h
#define TFB_macro_h

#define RGBColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBAColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define BGColor [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0]
#define NavBack [UIColor colorWithRed:89/255.0 green:151.0/255.0 blue:255.0/255.0 alpha:1]
#define LightGrayColor [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:242.0/255.0 alpha:1]

#define FONT(number) [UIFont systemFontOfSize:number]

#define HOST @"http://192.168.100.84:3251/api/action"
//#define HOST @"http://192.168.100.36:3251/api/action"
//图片加载
#define IMAGELocalPngOnce(imageName) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:@"png"]]
#define IMAGELocalJpgOnce(imageName) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"]]

//视图尺寸
#define KscreenWidth [UIScreen mainScreen].bounds.size.width
#define KscreenHeight [UIScreen mainScreen].bounds.size.height

#define ScreenWidth self.view.frame.size.width
#define ScreenHeight self.view.frame.size.height
#define EffectiveHeight (self.view.frame.size.height-70)

#define ViewX(view) (CGRectGetMinX(view.frame))
#define ViewY(view) (CGRectGetMinY(view.frame))

#define ViewWidth(view) (CGRectGetWidth(view.frame))
#define ViewHeight(view) (CGRectGetHeight(view.frame))

#define ViewMaxX(view)  (CGRectGetMaxX(view.frame))
#define ViewMaxY(view)  (CGRectGetMaxY(view.frame))

#define Item ([UIScreen mainScreen].bounds.size.width - 50)/4
#define Cell ([UIScreen mainScreen].bounds.size.height - 120)/5


#define AlertView(msg,title) [[UIAlertView alloc]initWithTitle:nil message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:title, nil]

#define token(key) [[NSUserDefaults standardUserDefaults]objectForKey:key]
#endif
