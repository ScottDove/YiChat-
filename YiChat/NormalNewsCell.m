//
//  NormalNewsCell.m
//  YiChat
//
//  Created by 孙 化育 on 15-1-29.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import "NormalNewsCell.h"

@implementation NormalNewsCell

- (void)awakeFromNib {
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)dealloc {
    [_newsImageView release];
    [_titleLabel release];
    [_introLabel release];
    [_sourceLabel release];
    [super dealloc];
}
@end
