//
//  BasicCustomView.h
//  JingXuan
//
//  Created by wj on 16/5/18.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicCustomView : UIView

@property (nonatomic, strong) UILabel *checkLabel;
@property (nonatomic, strong) UILabel *informationLab;
@property (nonatomic, strong) UILabel *informationLabel;

@property (nonatomic, strong) UIView *informationBGView;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UITextField *numberTF;

@property (nonatomic, strong) UIButton *choosePhotoButton;
@property (nonatomic, strong) UIView *photoLabelView;
@property (nonatomic, strong) UILabel *photoLabel;

@property (nonatomic, strong) UIView *photoView;

@property (nonatomic, strong) UILabel *frontLabel;
@property (nonatomic, strong) UILabel *reverseSideLabel;
@property (nonatomic, assign) id delegate;
@property (nonatomic,strong)UIButton *Sendbutton;

@property (nonatomic,strong)UIImageView *img;

@end
@protocol basicCustomViewDelegate <NSObject>

-(void)btnClickWith:(NSInteger )index;
-(void)btnClick:(NSInteger) tag;

@end



