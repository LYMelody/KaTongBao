//
//  ShortcutView.m
//  JingXuan
//
//  Created by wj on 16/5/23.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "ShortcutView.h"
#import "macro.h"
#import "UIView+SDAutoLayout.h"
@implementation ShortcutView
- (instancetype)initWithFrame:(CGRect)frame {
    self.backgroundColor = LightGrayColor;
    self = [super initWithFrame:frame];
    if (self) {
        [self init_UI];
    }
    return self;
}
- (void)init_UI {
    
    _label= [[UILabel alloc] init];
    [self addSubview:_label];
    _label.sd_layout.topSpaceToView(self,0).leftSpaceToView(self,20).widthIs(80).heightIs(40);
    
    _label1= [[UILabel alloc] init];
    [self addSubview:_label1];
    _label1.sd_layout.topSpaceToView(self,0).leftSpaceToView(_label,10).widthIs(200).heightIs(40);
    UIImageView *LineImg = [[UIImageView alloc] init];
    LineImg.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:LineImg];
    LineImg.sd_layout.leftSpaceToView(self,0).rightSpaceToView(self,0).topSpaceToView(self,0).heightIs(0.5);
    
}
/* // Only override drawRect: if you perform  custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
