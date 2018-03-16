//
//  MyView.m
//  JingXuan
//
//  Created by wj on 16/5/16.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "MyView.h"
#import "UIView+SDAutoLayout.h"

@implementation MyView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self init_UI];
    }
    return self;
}
- (void)init_UI {
    
    UIImageView *backImage = [[UIImageView alloc] init];
    backImage.image = [UIImage imageNamed:@"标题"];
    [self addSubview:backImage];
    backImage.sd_layout.topSpaceToView(self,0).leftSpaceToView(self,0).rightSpaceToView(self,0).heightIs(150);
    
    UIButton *headButton = [[UIButton alloc] init];
    headButton.clipsToBounds = YES;
    headButton.layer.cornerRadius = 31;
    [headButton setImage:[UIImage imageNamed:@"人物头像"] forState:UIControlStateNormal];
    [headButton addTarget:self action:@selector(headClick:) forControlEvents:UIControlEventTouchUpInside];
    [backImage addSubview:headButton];
    headButton.sd_layout.topSpaceToView(backImage,50).leftSpaceToView(backImage,15).widthIs(63).heightIs(63);
    
    UILabel *phoneLabel = [[UILabel alloc] init];
    phoneLabel.textColor = [UIColor whiteColor];
    phoneLabel.text = @"15838286548";
    [backImage addSubview:phoneLabel];
    phoneLabel.sd_layout.topEqualToView(headButton).leftSpaceToView(headButton,10).heightIs(30).widthIs(120);
    
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.text = @"上次登录时间：2015-12-21 15:21:20";
    timeLabel.font = [UIFont systemFontOfSize:13];
    [backImage addSubview:timeLabel];
    timeLabel.sd_layout.topSpaceToView(phoneLabel,0).leftSpaceToView(headButton,10).heightIs(30).widthIs(220);
    
    
}
- (void)headClick:(UIButton *)sender {
    
    NSLog(@"---headClick---");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
