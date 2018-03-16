//
//  MesageCell.m
//  wujie
//
//  Created by rongfeng on 15/11/20.
//  Copyright © 2015年 ND. All rights reserved.
//

#import "MesageCell.h"
#import "UIView+SDAutoLayout.h"
#import "Common.h"
@implementation MesageCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.label = [[UILabel alloc] init];
        self.label.font = [UIFont systemFontOfSize:14];
        self.label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.label];
        self.label.sd_layout.leftSpaceToView(self.contentView,16).topSpaceToView(self.contentView,14).widthIs(80).heightIs(14.4);
        self.textFiled = [[UITextField alloc] init];
        self.textFiled.textAlignment = NSTextAlignmentLeft;
        self.textFiled.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.textFiled];
        self.textFiled.sd_layout.leftSpaceToView(self.contentView,90).topSpaceToView(self.contentView,15).widthIs(200).heightIs(18.5);
        UIImageView *LineImg = [[UIImageView alloc] init];
        LineImg.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:LineImg];
        LineImg.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0).heightIs(0.5);
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    

    // Configure the view for the selected state
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
}
@end
