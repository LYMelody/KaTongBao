//
//  GatheringView.m
//  JingXuan
//
//  Created by wj on 16/5/12.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "GatheringView.h"
#import "UIView+SDAutoLayout.h"
#import "macro.h"
@implementation GatheringView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self init_UI];
    }
    return self;
}

- (void)init_UI {
    
    UIView *backView = [[UIView alloc] init];
    backView.layer.borderWidth = 0.5;
    backView.clipsToBounds = YES;
    backView.layer.cornerRadius = 3;
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.borderColor = [UIColor colorWithRed:189.0/255.0 green:189.0/255.0 blue:189.0/255.0 alpha:1].CGColor;
    [self addSubview:backView];
    backView.sd_layout.topSpaceToView(self,15).leftSpaceToView(self,10).widthIs(KscreenWidth - 20).heightIs(85);
    
    _imageView = [[UIImageView alloc] init];
    _imageView.clipsToBounds = YES;
    _imageView.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [backView addSubview:_imageView];
    _imageView.sd_layout.leftSpaceToView(backView,10).centerYEqualToView(backView).widthRatioToView(backView,0.2).heightRatioToView(backView,0.7);
    
    _label = [[UILabel alloc] init];
    _label.font = [UIFont systemFontOfSize:19];
    [self addSubview:_label];
    _label.sd_layout.leftSpaceToView(_imageView,30).centerYEqualToView(backView).widthRatioToView(backView,0.55).heightRatioToView(backView,0.6);
    
    _arrowsImage= [[UIImageView alloc] init];
    _arrowsImage.image = [UIImage imageNamed:@"arrow1"];
    _arrowsImage.alpha = 0.5;
    [backView addSubview:_arrowsImage];
    _arrowsImage.sd_layout.rightSpaceToView(backView,15).centerYEqualToView(backView).widthRatioToView(backView,0.06).heightRatioToView(backView,0.3);
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
