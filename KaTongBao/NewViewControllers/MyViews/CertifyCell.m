
//
//  CertifyCell.m
//  wujieNew
//
//  Created by rongfeng on 15/12/24.
//  Copyright © 2015年 rongfeng. All rights reserved.
//

#import "CertifyCell.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
@implementation CertifyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.Llabel = [[UILabel alloc] init];
        self.Llabel.font = [UIFont systemFontOfSize:14];
        self.Llabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.Llabel];
        self.Fld = [[UITextField alloc] init];
        self.Fld.font = [UIFont systemFontOfSize:14];
        self.Fld.textColor = Color(136, 136, 136);
        [self.contentView addSubview:self.Fld];
        self.Llabel.sd_layout.leftSpaceToView(self.contentView,16).topSpaceToView(self.contentView,10).widthIs(96).heightIs(22.5);
        self.Fld.sd_layout.leftSpaceToView(self.contentView,136).topSpaceToView(self.contentView,10).widthIs(154).heightIs(21);
        
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    
}

@end
