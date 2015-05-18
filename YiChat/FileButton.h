//
//  FileButton.h
//  YiChat
//
//  Created by 孙 化育 on 15-2-3.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

@class FileDownloader;

typedef enum : NSUInteger {
    sunday = 0,
    monday,
    tuesday,
} Weekdays;

typedef NS_ENUM(NSInteger, ButtonState){
    buttonNormal = 0,
    buttonDownloading,
    buttonPause,
    buttonCompletion
};


#import <UIKit/UIKit.h>

@interface FileButton : UIButton{
    Weekdays _day;
    
    UIView          *_coverView;
    
}

@property (nonatomic,assign)ButtonState downloadState;

@property (nonatomic,assign)FileDownloader *downloader;

@property (nonatomic,assign)float progress;

@end





