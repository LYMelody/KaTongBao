//
//  LocationCell.m
//  wujieNew
//
//  Created by rongfeng on 16/1/11.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "LocationCell.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
@implementation LocationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.leftLab = [[UILabel alloc] init];
        self.leftLab.font = [UIFont systemFontOfSize:15];
        self.leftLab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.leftLab];
        self.leftLab.sd_layout.leftSpaceToView(self.contentView,14.5).topSpaceToView(self.contentView,11).widthIs(80).heightIs(19.5);
        
        self.rightLab = [[UILabel alloc] init];
        self.rightLab.font = [UIFont systemFontOfSize:13];
        self.rightLab.textColor = Color(144, 144, 144);
        self.rightLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.rightLab];
        self.rightLab.sd_layout.rightSpaceToView(self.contentView,15.5).topSpaceToView(self.contentView,9.5).widthIs(100).heightIs(20);
    }
    return self;
}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
}
@end
