//
//  ZYNews.m
//  YiChat
//
//  Created by 孙 化育 on 15-1-29.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import "ZYNews.h"

@implementation ZYNews

- (void)dealloc{
    [_channel release];
    [_newsTitle release];
    [_intro release];
    [_sourceURL release];
    [_time release];
    [_source release];
    [_readTimes release];
    [_auther release];
    [_images release];
    [super dealloc];
}

- (id)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.newsID = [[dic objectForKey:@"id"] integerValue];
        self.type = [[dic objectForKey:@"type"] integerValue];
        self.channel = [dic objectForKey:@"channel"];
        self.newsTitle = [dic objectForKey:@"news_title"];
        self.intro = [dic objectForKey:@"intro"];
        self.time = [dic objectForKey:@"time"];
        self.sourceURL = [dic objectForKey:@"source_url"];
        self.source = [dic objectForKey:@"source"];
        self.readTimes = [dic objectForKey:@"readtimes"];
        self.auther = [dic objectForKey:@"auther"];
        self.images = [dic objectForKey:@"images"];
    }
    
    return self;
}





@end
