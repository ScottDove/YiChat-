//
//  FriendCell.m
//  YiChat
//
//  Created by 孙 化育 on 15-1-30.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import "FriendCell.h"

@implementation FriendCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
            //////////
    }
    
    return self;
}

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.headerButton.layer.cornerRadius = 35;
    self.headerButton.layer.masksToBounds = YES;
    self.messageCountLabel.layer.cornerRadius = 20;
    self.messageCountLabel.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
        //self.messageCountLabel.backgroundColor = [UIColor redColor];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_headerButton release];
    [_nameLabel release];
    [_nickNameLabel release];
    [_messageCountLabel release];
    [super dealloc];
}
@end
