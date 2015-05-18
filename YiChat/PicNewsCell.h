//
//  PicNewsCell.h
//  YiChat
//
//  Created by 孙 化育 on 15-1-29.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicNewsCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *titleLabel;

@property (retain, nonatomic) IBOutlet UILabel *sourceLabel;


@property (retain, nonatomic) IBOutletCollection(UIImageView) NSArray *newsImageViews;






@end
