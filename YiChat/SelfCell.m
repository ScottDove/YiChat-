//
//  SelfCell.m
//  YiChat
//
//  Created by 孙 化育 on 15-1-30.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import "SelfCell.h"

@implementation SelfCell

- (void)awakeFromNib {
    self.headerImageView.layer.cornerRadius = 30;
    self.headerImageView.layer.masksToBounds = YES;
    [self.headerImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PIC_URL_ADDRESS,[USER_D objectForKey:@"userHeaderurl"]]] placeholderImage:[UIImage imageNamed:@"head.png"]];
    self.bubbleImageView.image = [[UIImage imageNamed:@"bubbleSelf.png"] stretchableImageWithLeftCapWidth:25 topCapHeight:20];
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
