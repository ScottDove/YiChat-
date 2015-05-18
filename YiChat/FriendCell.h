//
//  FriendCell.h
//  YiChat
//
//  Created by 孙 化育 on 15-1-30.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIButton *headerButton;

@property (retain, nonatomic) IBOutlet UILabel *nameLabel;

@property (retain, nonatomic) IBOutlet UILabel *nickNameLabel;

@property (retain, nonatomic) IBOutlet UILabel *messageCountLabel;



@end
