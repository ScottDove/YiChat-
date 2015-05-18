//
//  CommonTool.m
//  YiChat
//
//  Created by 孙 化育 on 15-1-27.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import "CommonTool.h"
#import "SettingVC.h"
#import "FileListVC.h"
#import "NewsListVC.h"
#import "FriendListVC.h"
#import "LoginVC.h"

@implementation CommonTool

+ (void)gotoMainVC{
    
    UITabBarController *tabBarCon = [[UITabBarController alloc] init];
    
    FriendListVC *fr = [[FriendListVC alloc] init];
    UINavigationController *frnav = [[UINavigationController alloc] initWithRootViewController:fr];
    frnav.tabBarItem.title = @"聊天";
    frnav.tabBarItem.image = [UIImage imageNamed:@"main.png"];
    
    NewsListVC *ne = [[NewsListVC alloc] init];
    UINavigationController *nenav = [[UINavigationController alloc] initWithRootViewController:ne];
    nenav.tabBarItem.title = @"新闻";
    nenav.tabBarItem.image = [UIImage imageNamed:@"news.png"];
    
    FileListVC *fi = [[FileListVC alloc] init];
    UINavigationController *finav = [[UINavigationController alloc] initWithRootViewController:fi];
    finav.tabBarItem.title = @"文件";
    finav.tabBarItem.image = [UIImage imageNamed:@"file.png"];
    
    SettingVC *se = [[SettingVC alloc] init];
    UINavigationController *senav = [[UINavigationController alloc] initWithRootViewController:se];
    senav.tabBarItem.title = @"个人";
    senav.tabBarItem.image = [UIImage imageNamed:@"person.png"];
    
    tabBarCon.viewControllers = @[frnav,nenav,finav,senav];
    
    [fr release];[frnav release];
    [ne release];[nenav release];
    [fi release];[finav release];
    [se release];[senav release];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:APP_WINDOW cache:YES];
        APP_WINDOW.rootViewController = tabBarCon;
    }];
    
    [tabBarCon release];
}


+ (BOOL)isLogin{
    if ([USER_D objectForKey:@"token"]) {
        NSDate *endDate = [USER_D objectForKey:@"endDate"];
        NSDate *nowDate = [NSDate date];
        if ([nowDate compare:endDate] == NSOrderedAscending) {
                //没有过去
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}

+ (void)gotoLoginVC{
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    LoginVC *vc = [[LoginVC alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:window cache:YES];
        window.rootViewController = nav;
    }];
    [nav release];
}

+ (void)saveChatInfo:(NSMutableDictionary *)chatInfo{
    if (![FILE_M fileExistsAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/chatInfo"]]) {
        [FILE_M createDirectoryAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/chatInfo"] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/chatInfo/%@.plist",[USER_D objectForKey:@"userName"]]];
    [chatInfo writeToFile:path atomically:YES];
}

+ (NSString *)fileDownloadPath{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/fileDownloadPath"];
}

+ (NSString *)fileTempPath{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/fileTempPath"];
}

+ (BOOL)isFileDownloadFinish:(NSString *)fileName{
    return [FILE_M fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",[self fileDownloadPath],fileName]];
}

+ (BOOL)isFileDownloadPart:(NSString *)fileName{
    return [FILE_M fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",[self fileTempPath],fileName]];
}


@end
