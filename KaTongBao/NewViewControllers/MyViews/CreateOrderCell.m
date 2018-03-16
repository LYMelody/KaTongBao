//
//  CreateOrderCell.m
//  wujieNew
//
//  Created by rongfeng on 15/12/22.
//  Copyright © 2015年 rongfeng. All rights reserved.
//

#import "CreateOrderCell.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
@implementation CreateOrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        self.Llabel = [[UILabel alloc] init];
        self.Llabel.font = [UIFont systemFontOfSize:14];
        self.Llabel.textColor = Color(185, 185, 185);
        [self.contentView addSubview:self.Llabel];
        self.Fld = [[UITextField alloc] init];
        self.Fld.font = [UIFont systemFontOfSize:14];
        self.Fld.textColor = Color(136, 136, 136);
        [self.contentView addSubview:self.Fld];
        self.Llabel.sd_layout.leftSpaceToView(self.contentView,16).topSpaceToView(self.contentView,10).widthIs(60).heightIs(15.5);
        self.Fld.sd_layout.leftSpaceToView(self.contentView,105).topSpaceToView(self.contentView,10).widthIs(154).heightIs(15.5);
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    
}
@end
