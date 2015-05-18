//
//  ZYUser.m
//  YiChat
//
//  Created by 孙 化育 on 15-1-28.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import "ZYUser.h"

@implementation ZYUser

- (void)dealloc{
    self.name = nil;
    self.nickName = nil;
    self.email = nil;
    self.headerURL = nil;
    [super dealloc];
}

- (id)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.name = [dic objectForKey:@"name"];
        self.nickName = [dic objectForKey:@"nickname"];
        self.email = [dic objectForKey:@"email"];
        self.headerURL = [dic objectForKey:@"headerurl"];
    }
    
    return self;
}

@end
