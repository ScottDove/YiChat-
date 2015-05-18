//
//  FileDownloader.m
//  YiChat
//
//  Created by 孙 化育 on 15-2-4.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import "FileDownloader.h"



@implementation FileDownloader

- (void)dealloc{
    [_file release];
    [super dealloc];
}

- (id)initWithFile:(ZYFile *)file{
    self = [super init];
    if (self) {
        _file = [file retain];
    }
    return self;
}

- (NSString *)fileDownloadPath{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/fileDownloadPath"];
}

- (NSString *)fileTempPath{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/fileTempPath"];
}

- (void)createDownloadPathIfNotExists{
    if (![FILE_M fileExistsAtPath:[self fileTempPath]]) {
        [FILE_M createDirectoryAtPath:[self fileTempPath] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if (![FILE_M fileExistsAtPath:[self fileDownloadPath]]) {
        [FILE_M createDirectoryAtPath:[self fileDownloadPath] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
}

- (void)startDownload{
        //保证下载路径存在
    [self createDownloadPathIfNotExists];
    
    _request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:_file.fileURL]];
    
    _request.downloadDestinationPath = [NSString stringWithFormat:@"%@/%@",[self fileDownloadPath],_file.tname];
    
    _request.temporaryFileDownloadPath = [NSString stringWithFormat:@"%@/%@",[self fileTempPath],_file.tname];
    
    _request.allowResumeForFileDownloads = YES;
    
    [_request setCompletionBlock:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"downloadFinish" object:self];
        _request = nil;
    }];
    
    _request.downloadProgressDelegate = self;
    
    
    [_request startAsynchronous];
}

- (BOOL)isDownloading{
    if (_request) {
        return YES;
    }else{
        return NO;
    }
}

- (void)stopDownload{
    [_request clearDelegatesAndCancel];
    _request = nil;
}

- (void)setProgress:(float)newProgress{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setNewProgress" object:self userInfo:@{@"progress":[NSNumber numberWithFloat:newProgress]}];
}




@end
