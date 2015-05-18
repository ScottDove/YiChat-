//
//  NetworkTool.m
//  YiChat
//
//  Created by 孙 化育 on 15-1-27.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import "NetworkTool.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "Base64.h"


@implementation NetworkTool


+ (void)registNewUserWithName:(NSString *)name password:(NSString *)password nickName:(NSString *)nickName email:(NSString *)email completionBlock:(void(^)(NSDictionary *dic))block{
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:USER_API]];
    
    [request setPostValue:@"ST_R" forKey:@"command"];
    [request setPostValue:name forKey:@"name"];
    [request setPostValue:password forKey:@"psw"];
    [request setPostValue:nickName forKey:@"nickname"];
    [request setPostValue:email forKey:@"email"];
    [request setCompletionBlock:^{
        NSDictionary *dic = request.responseString.JSONValue;
        block(dic);
    }];
    
    [request startAsynchronous];
}

+ (void)loginWithName:(NSString *)name password:(NSString *)password completionBlock:(void(^)(NSDictionary *dic))block{
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:USER_API]];
    
    [request setPostValue:@"ST_L" forKey:@"command"];
    [request setPostValue:name forKey:@"name"];
    [request setPostValue:password forKey:@"psw"];
    [request setCompletionBlock:^{
        block(request.responseString.JSONValue);
    }];
    [request startAsynchronous];
}

+ (void)requestSelfInfoWithCompletionBlock:(void(^)(NSDictionary *dic))block{
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:USER_API]];
    [request setPostValue:@"ST_GPI" forKey:@"command"];
    [request setPostValue:[USER_D objectForKey:@"token"] forKey:@"access_token"];
    [request setCompletionBlock:^{
            //NSLog(@"%@",request.responseString);
        NSDictionary *dic = request.responseString.JSONValue;
        [USER_D setObject:[[dic objectForKey:@"data"] objectForKey:@"name"] forKey:@"userName"];
        [USER_D setObject:[[dic objectForKey:@"data"] objectForKey:@"nickname"] forKey:@"userNickname"];
        [USER_D setObject:[[dic objectForKey:@"data"] objectForKey:@"email"] forKey:@"userEmail"];
        [USER_D setObject:[[dic objectForKey:@"data"] objectForKey:@"headerurl"] forKey:@"userHeaderurl"];
        block(request.responseString.JSONValue);
    }];
    [request startAsynchronous];
}

+ (void)logoutRequestWithCompletionBlock:(void(^)(NSDictionary *dic))block{
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:USER_API]];
    [request setPostValue:@"ST_LO" forKey:@"command"];
    [request setPostValue:[USER_D objectForKey:@"token"] forKey:@"access_token"];
    [request setCompletionBlock:^{
        block(request.responseString.JSONValue);
    }];
    [request startAsynchronous];
}

+ (void)uploadHeaderImage:(UIImage *)image completionBlock:(void(^)(NSDictionary *dic))block{
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",USER_API,@"?command=ST_H&access_token=",[USER_D objectForKey:@"token"]]]];
    NSMutableData *data = [NSMutableData dataWithData:UIImagePNGRepresentation(image)];
    [request setPostBody:data];
    [request setCompletionBlock:^{
        block(request.responseString.JSONValue);
    }];
    [request startAsynchronous];
}

+ (void)updateNickName:(NSString *)nickName andEmail:(NSString *)email completionBlock:(void(^)(NSDictionary *dic))block{
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:USER_API]];
    [request setPostValue:@"ST_SPI" forKey:@"command"];
    [request setPostValue:[USER_D objectForKey:@"token"] forKey:@"access_token"];
    [request setPostValue:nickName forKey:@"nickname"];
    [request setPostValue:email forKey:@"email"];
    [request setCompletionBlock:^{
        block(request.responseString.JSONValue);
    }];
    [request startAsynchronous];
}

+ (void)requestNewsListWithCompletionBlock:(void(^)(NSDictionary *dic))block{
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:NEWS_API]];
    [request setCompletionBlock:^{
        NSString *string = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
            //NSLog(@"%@",string);
        block(string.JSONValue);
        [string release];
    }];
    
    [request startAsynchronous];
    
}

+ (void)requestNewsOfURL:(NSString *)urlString completionBlock:(void(^)(NSDictionary *dic))block{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_ADDRESS,urlString]];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        NSString *string = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
            //NSLog(@"%@",string);
        block(string.JSONValue);
        [string release];
    }];
    [request startAsynchronous];
    
}

+ (void)requestFriendListWithCompletionBlock:(void(^)(NSDictionary *dic))block{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?command=ST_FL&access_token=%@",USER_API,[USER_D objectForKey:@"token"]]];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
            //NSLog(@"%@",request.responseString);
        block(request.responseString.JSONValue);
    }];
    
    [request startAsynchronous];
}

+ (void)sendMessage:(NSString *)message toFriend:(NSString *)name completionBlock:(void(^)(NSDictionary *dic))block{
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:USER_API]];
    [request setPostValue:@"ST_CS" forKey:@"command"];
    [request setPostValue:[USER_D objectForKey:@"token"] forKey:@"access_token"];
    [request setPostValue:name forKey:@"friendname"];
    [request setPostValue:[message base64EncodedString] forKey:@"chatinfo"];
    [request setCompletionBlock:^{
        block(request.responseString.JSONValue);
    }];
    [request startAsynchronous];
}

+ (void)requestChatInfoWithCompletionBlock:(void(^)(NSDictionary *dic))block{
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:USER_API]];
    [request setPostValue:@"ST_CG" forKey:@"command"];
    [request setPostValue:[USER_D objectForKey:@"token"] forKey:@"access_token"];
    [request setCompletionBlock:^{
            //NSLog(@"%@",request.responseString);
        block(request.responseString.JSONValue);
    }];
    [request startAsynchronous];
}

+ (void)requestFileListWithCompletionBlock:(void(^)(NSDictionary *dic))block{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?command=ST_F_FL&access_token=%@",USER_API,[USER_D objectForKey:@"token"]]];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setCompletionBlock:^{
            //NSLog(@"%@",request.responseString);
        block(request.responseString.JSONValue);
    }];
    
    [request startAsynchronous];
}

@end
