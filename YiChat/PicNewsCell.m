//
//  PicNewsCell.m
//  YiChat
//
//  Created by 孙 化育 on 15-1-29.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import "PicNewsCell.h"

@implementation PicNewsCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    

    // Configure the view for the selected state
}

- (void)dealloc {
    [_titleLabel release];
    [_sourceLabel release];
    [_newsImageViews release];
    [super dealloc];
}
@end
