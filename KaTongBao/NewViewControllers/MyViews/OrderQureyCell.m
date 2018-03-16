//
//  OrderQureyCell.m
//  wujieNew
//
//  Created by rongfeng on 15/12/22.
//  Copyright © 2015年 rongfeng. All rights reserved.
//

#import "OrderQureyCell.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
@implementation OrderQureyCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.LeftLab = [[UILabel alloc] init];
        self.LeftLab.font = [UIFont systemFontOfSize:14];
        self.LeftLab.textColor = Color(100, 100, 100);
        [self.contentView addSubview:self.LeftLab];
        self.RightLab = [[UILabel alloc] init];
        self.RightLab.font = [UIFont systemFontOfSize:14];
        self.RightLab.textColor = Color(136, 136, 136);
        [self.contentView addSubview:self.RightLab];
        self.LeftLab.sd_layout.leftSpaceToView(self.contentView,16).topSpaceToView(self.contentView,10).widthIs(60).heightIs(15.5);
        self.RightLab.sd_layout.leftSpaceToView(self.contentView,105).topSpaceToView(self.contentView,10).widthIs(154).heightIs(15.5);
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    
}


@end
