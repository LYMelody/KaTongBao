//
//  MyTableViewCell.m
//  JingXuan
//
//  Created by wj on 16/5/16.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "MyTableViewCell.h"
#import "UIView+SDAutoLayout.h"
@implementation MyTableViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self init_UI];
    }
    
    return self;
}
- (void)init_UI {
    _imageView = [[UIImageView alloc] init];
    [self addSubview:_imageView];
    _imageView.sd_layout.topSpaceToView(self,10).leftSpaceToView(self,10).widthIs(25).heightIs(25);
    
    _label = [[UILabel alloc] init];
    [self addSubview:_label];
    _label.sd_layout.topEqualToView(_imageView).leftSpaceToView(_imageView,10).widthIs(80).heightIs(25);

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
