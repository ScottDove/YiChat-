//
//  FileCell.h
//  YiChat
//
//  Created by 孙 化育 on 15-2-3.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileButton.h"

@interface FileCell : UICollectionViewCell

@property (retain, nonatomic) IBOutlet FileButton *button;

@property (retain, nonatomic) IBOutlet UILabel *label;

@end
