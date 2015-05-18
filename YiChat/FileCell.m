//
//  FileCell.m
//  YiChat
//
//  Created by 孙 化育 on 15-2-3.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import "FileCell.h"

@implementation FileCell

- (void)awakeFromNib {
    self.label.adjustsFontSizeToFitWidth = YES;
    self.label.numberOfLines = 0;
}

- (void)dealloc {
    [_button release];
    [_label release];
    [super dealloc];
}
@end
