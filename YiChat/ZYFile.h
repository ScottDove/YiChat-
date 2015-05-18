//
//  ZYFile.h
//  YiChat
//
//  Created by 孙 化育 on 15-2-3.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FileButton.h"

@interface ZYFile : NSObject

@property (nonatomic,copy)NSString *fileID;
@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *imageURL;
@property (nonatomic,copy)NSString *fileURL;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *tname;
@property (nonatomic,copy)NSString *fileDescription;
@property (nonatomic,copy)NSString *author;
@property (nonatomic,copy)NSString *time;
@property (nonatomic,copy)NSString *dTime;
@property (nonatomic,copy)NSString *length;

@property (nonatomic,assign)FileButton *button;


- (id)initWithDictionary:(NSDictionary *)dic;


@end
