//
//  OtherCell.m
//  YiChat
//
//  Created by 孙 化育 on 15-2-2.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import "OtherCell.h"

@implementation OtherCell

- (void)awakeFromNib {
    self.headerImageView.layer.cornerRadius = 30;
    self.headerImageView.layer.masksToBounds = YES;
    self.bubbleImageView.image = [[UIImage imageNamed:@"bubble.png"] stretchableImageWithLeftCapWidth:25 topCapHeight:20];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_headerImageView release];
    [_bubbleImageView release];
    [_messageLabel release];
    [super dealloc];
}
@end
