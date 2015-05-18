//
//  ZYNews.h
//  YiChat
//
//  Created by 孙 化育 on 15-1-29.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYNews : NSObject

@property (nonatomic,assign)NSInteger newsID;
@property (nonatomic,assign)NSInteger type;
@property (nonatomic,copy)NSString *channel;
@property (nonatomic,copy)NSString *newsTitle;
@property (nonatomic,copy)NSString *intro;
@property (nonatomic,copy)NSString *sourceURL;
@property (nonatomic,copy)NSString *time;
@property (nonatomic,copy)NSString *source;
@property (nonatomic,copy)NSString *readTimes;
@property (nonatomic,copy)NSString *auther;
@property (nonatomic,retain)NSArray *images;


- (id)initWithDictionary:(NSDictionary *)dic;


@end
