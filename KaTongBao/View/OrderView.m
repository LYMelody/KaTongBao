//
//  OrderView.m
//  JingXuan
//
//  Created by wj on 16/5/13.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "OrderView.h"
#import "UIView+SDAutoLayout.h"
#import "macro.h"
@implementation OrderView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.tag = ORDERVIEWTAGE;
    if (self) {
        [self init_UI];
    }
    return self;
}
- (void)init_UI {
    
    UIView *backView = [[UIView alloc] init];
    backView.layer.borderWidth = 0.5;
    backView.layer.borderColor = [UIColor colorWithRed:151.0/255.0 green:151.0/255.0 blue:151.0/255.0 alpha:1].CGColor;
    [self addSubview:backView];
    backView.sd_layout.xIs(0).yIs(0).widthIs(KscreenWidth).heightIs(60);
    
    UILabel *gatheringLabel = [[UILabel alloc] init];
    gatheringLabel.text = @"收款";
    [backView addSubview:gatheringLabel];
    gatheringLabel.sd_layout.topSpaceToView(backView,10).leftSpaceToView(backView,10).widthIs(60).heightIs(20);
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:14];
    [_timeLabel setTintColor:[UIColor lightGrayColor]];
    _timeLabel.text = @"2016-05-10 15:33:20";
    [backView addSubview:_timeLabel];
    _timeLabel.sd_layout.topSpaceToView(gatheringLabel,10).leftSpaceToView(backView,10).widthIs(140).heightIs(20);
    
    _moneyLabel = [[UILabel alloc] init];
    _moneyLabel.tintColor = [UIColor lightGrayColor];
    [backView addSubview:_moneyLabel];
    _moneyLabel.sd_layout.topSpaceToView(backView,10).rightSpaceToView(backView,30).widthIs(130).heightIs(20);
    
    
    _statutLabel = [[UILabel alloc] init];
    [backView addSubview:_statutLabel];
    _statutLabel.sd_layout.topSpaceToView(_moneyLabel,10).rightSpaceToView(backView,30).widthIs(130).heightIs(20);
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"arrow1"];
    [backView addSubview:imageView];
    imageView.sd_layout.centerYEqualToView(backView).rightSpaceToView(backView,10).widthIs(15).heightIs(25);
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
