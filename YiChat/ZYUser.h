//
//  ZYUser.h
//  YiChat
//
//  Created by 孙 化育 on 15-1-28.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYUser : NSObject

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *nickName;
@property (nonatomic,copy)NSString *email;
@property (nonatomic,copy)NSString *headerURL;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
