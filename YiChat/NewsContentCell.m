//
//  NewsContentCell.m
//  YiChat
//
//  Created by 孙 化育 on 15-1-29.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import "NewsContentCell.h"

@implementation NewsContentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_newsLabel release];
    [_newsImageView release];
    [super dealloc];
}
@end
