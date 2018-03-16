//
//  InformationView.m
//  JingXuan
//
//  Created by wj on 16/5/16.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "InformationView.h"
#import "UIView+SDAutoLayout.h"
#import "macro.h"

@implementation InformationView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    self.tag = VIEWTAGE;
    if (self) {
        [self initView];
    }
    return self;
}
- (void)initView {
    
    self.informationLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, KscreenWidth/4, 30)];
    self.informationLabel.font = [UIFont systemFontOfSize:15.0f];
    self.informationLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:self.informationLabel];
    
    self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(KscreenWidth/3*2, 10, KscreenWidth/5, 30)];
    self.detailLabel.font = [UIFont systemFontOfSize:12.0f];
    self.detailLabel.textColor = [UIColor lightGrayColor];
    self.detailLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.detailLabel];
    
    
    self.arrowView = [[UIView alloc]initWithFrame:CGRectMake(KscreenWidth - 40, 17, 10, 15)];
    [self addSubview:self.arrowView];
    UIImageView *arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 15)];
    arrowImageView.image = [UIImage imageNamed:@"arrow1.png"];
    [self.arrowView addSubview:arrowImageView];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
