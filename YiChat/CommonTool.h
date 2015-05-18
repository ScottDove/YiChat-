//
//  CommonTool.h
//  YiChat
//
//  Created by 孙 化育 on 15-1-27.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonTool : NSObject


+ (NSString *)fileDownloadPath;
+ (NSString *)fileTempPath;

    //去主页面
+ (void)gotoMainVC;

    //去登录页
+ (void)gotoLoginVC;

    //是否已经登录
+ (BOOL)isLogin;

    //存储未读的聊天信息
+ (void)saveChatInfo:(NSMutableDictionary *)chatInfo;

    //文件是否下载完毕
+ (BOOL)isFileDownloadFinish:(NSString *)fileName;

    //文件是否下了一部分
+ (BOOL)isFileDownloadPart:(NSString *)fileName;


@end
