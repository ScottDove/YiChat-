//
//  ZYFile.m
//  YiChat
//
//  Created by 孙 化育 on 15-2-3.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import "ZYFile.h"

@implementation ZYFile

- (void)dealloc{
    self.fileID = nil;
    self.type = nil;
    self.imageURL = nil;
    self.fileURL = nil;
    self.name = nil;
    self.fileDescription = nil;
    self.author = nil;
    self.time = nil;
    self.dTime = nil;
    self.length = nil;
    self.tname = nil;
    [super dealloc];
}

- (id)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.fileID = [dic objectForKey:@"id"];
        self.type = [dic objectForKey:@"type"];
        self.imageURL = [dic objectForKey:@"image_url"];
        self.fileURL = [dic objectForKey:@"url"];
        self.name = [dic objectForKey:@"name"];
        self.fileDescription = [dic objectForKey:@"description"];
        self.author = [dic objectForKey:@"author"];
        self.time = [dic objectForKey:@"time"];
        self.dTime = [dic objectForKey:@"dtime"];
        self.length = [dic objectForKey:@"length"];
        self.tname = [dic objectForKey:@"tname"];
    }
    return self;
}

@end
