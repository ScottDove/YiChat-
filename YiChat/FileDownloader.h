//
//  FileDownloader.h
//  YiChat
//
//  Created by 孙 化育 on 15-2-4.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYFile.h"
#import "ASIHTTPRequest.h"
#import "FileButton.h"

    //文件下载器

@interface FileDownloader : NSObject<ASIProgressDelegate>{
    __block ASIHTTPRequest      *_request;
}

- (id)initWithFile:(ZYFile *)file;

@property (nonatomic,retain,readonly)ZYFile *file;

@property (nonatomic,assign)FileButton *button;

    //开始下载
- (void)startDownload;

    //停止下载
- (void)stopDownload;

    //是否正在下载
- (BOOL)isDownloading;



@end
