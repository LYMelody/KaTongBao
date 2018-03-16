//
//  JieSuanDetailCell.m
//  wujieNew
//
//  Created by rongfeng on 16/1/7.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "JieSuanDetailCell.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
@implementation JieSuanDetailCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.LeftLab = [[UILabel alloc] init];
        self.LeftLab.textAlignment = NSTextAlignmentLeft;
        self.LeftLab.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.LeftLab];
        self.LeftLab.sd_layout.leftSpaceToView(self.contentView,16).topSpaceToView(self.contentView,12.5).widthIs(100).heightIs(20);
        self.RightLab = [[UILabel alloc] init];
        self.RightLab.textAlignment = NSTextAlignmentRight;
        self.RightLab.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.RightLab];
        self.RightLab.sd_layout.rightSpaceToView(self.contentView,16).topSpaceToView(self.contentView,12.5).widthIs(240).heightIs(20);
        self.Line = [[UIImageView alloc] init];
        self.Line.backgroundColor = Color(151, 151, 151);
        [self.contentView addSubview:self.Line];
        self.Line.sd_layout.leftSpaceToView(self.contentView,16).bottomSpaceToView(self.contentView,0.5).widthIs(KscreenWidth - 16).heightIs(0.5);
        
    }
    
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
}
@end
