//
//  BaseMsgCell.m
//  wujieNew
//
//  Created by rongfeng on 16/1/11.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "BaseMsgCell.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
@implementation BaseMsgCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.leftLab = [[UILabel alloc] init];
        self.leftLab.font = [UIFont systemFontOfSize:15];
        self.leftLab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.leftLab];
        self.leftLab.sd_layout.leftSpaceToView(self.contentView,14.5).topSpaceToView(self.contentView,12).widthIs(60).heightIs(20);
        
//        UIImageView *TopLine = [[UIImageView alloc] init];
//        TopLine.backgroundColor = Gray151;
//        [self.contentView addSubview:TopLine];
//        TopLine.sd_layout.leftSpaceToView(self.contentView,0).topSpaceToView(self.contentView,0.5).rightSpaceToView(self.contentView,0).heightIs(1);
//        
        UIImageView *LineImg = [[UIImageView alloc] init];
        LineImg.backgroundColor = Color(178, 179, 182);
        [self.contentView addSubview:LineImg];
        LineImg.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0).heightIs(0.5);
        
        self.rightFld =[[UITextField alloc] init];
        self.rightFld.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.rightFld];
        self.rightFld.sd_layout.leftSpaceToView(self.contentView,85).topSpaceToView(self.contentView,12).widthIs(200).heightIs(18);
        
    }
    return self;
}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
}
@end
