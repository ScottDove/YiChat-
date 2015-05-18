//
//  NetworkTool.h
//  YiChat
//
//  Created by 孙 化育 on 15-1-27.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkTool : NSObject



    //注册新用户
+ (void)registNewUserWithName:(NSString *)name password:(NSString *)password nickName:(NSString *)nickName email:(NSString *)email completionBlock:(void(^)(NSDictionary *dic))block;


    //登录
+ (void)loginWithName:(NSString *)name password:(NSString *)password completionBlock:(void(^)(NSDictionary *dic))block;

    //请求个人信息
+ (void)requestSelfInfoWithCompletionBlock:(void(^)(NSDictionary *dic))block;

    //退出登录
+ (void)logoutRequestWithCompletionBlock:(void(^)(NSDictionary *dic))block;

    //上传头像
+ (void)uploadHeaderImage:(UIImage *)image completionBlock:(void(^)(NSDictionary *dic))block;

    //修改昵称和邮箱
+ (void)updateNickName:(NSString *)nickName andEmail:(NSString *)email completionBlock:(void(^)(NSDictionary *dic))block;

    //请求新闻列表
+ (void)requestNewsListWithCompletionBlock:(void(^)(NSDictionary *dic))block;

    //请求某个新闻的详细内容
+ (void)requestNewsOfURL:(NSString *)urlString completionBlock:(void(^)(NSDictionary *dic))block;

    //请求好友列表
+ (void)requestFriendListWithCompletionBlock:(void(^)(NSDictionary *dic))block;

    //发送聊天信息
+ (void)sendMessage:(NSString *)message toFriend:(NSString *)name completionBlock:(void(^)(NSDictionary *dic))block;

    //请求聊天信息
+ (void)requestChatInfoWithCompletionBlock:(void(^)(NSDictionary *dic))block;


    //请求文件列表
+ (void)requestFileListWithCompletionBlock:(void(^)(NSDictionary *dic))block;

@end













