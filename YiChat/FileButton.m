//
//  FileButton.m
//  YiChat
//
//  Created by 孙 化育 on 15-2-3.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import "FileButton.h"
#import "FileDownloader.h"

@implementation FileButton
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_coverView release];
    [super dealloc];
}

- (void)awakeFromNib{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadFinish:) name:@"downloadFinish" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setNewProgress:) name:@"setNewProgress" object:nil];
    
    _coverView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:_coverView];
    _coverView.userInteractionEnabled = NO;
    _coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    
    self.titleLabel.font = [UIFont systemFontOfSize:15];
}

- (void)setProgress:(float)progress{
    _progress = progress;
    [self setTitle:[NSString stringWithFormat:@"%.1f%%",progress*100] forState:UIControlStateNormal];
    
    _coverView.frame = CGRectMake(0,progress*60, 60, (1-progress)*60);
}

- (void)setNewProgress:(NSNotification *)noti{
    float progress = [[[noti userInfo] objectForKey:@"progress"] floatValue];
        //如果通知是自己对应的downloader发送的，那么就更新进度
    if (noti.object == self.downloader) {
        self.progress = progress;
    }
    
}

- (void)downloadFinish:(NSNotification *)noti{
    if (noti.object == self.downloader) {
        self.downloadState = buttonCompletion;
    }
}


- (void)setDownloadState:(ButtonState)downloadState{
    _downloadState = downloadState;
    switch (downloadState) {
        case buttonNormal:{
            self.progress = 0;
            [self setTitle:@"下载" forState:UIControlStateNormal];
        }
            break;
        case buttonPause:{
            [self setTitle:@"继续下载" forState:UIControlStateNormal];
        }
            break;
        case buttonDownloading:{
            [self setTitle:@"停止" forState:UIControlStateNormal];
        }
            break;
        case buttonCompletion:{
            self.progress = 1;
            [self setTitle:@"打开" forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
