//
//  ViewController.m
//  YiChat
//
//  Created by 孙 化育 on 15-1-27.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        //[self performSelector:@selector(gotoLoginVC) withObject:nil afterDelay:0.5];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
        //先判断token是否过期
    if ([CommonTool isLogin]) {
        
            //如果已经登录，那么先请求个人信息
        [NetworkTool requestSelfInfoWithCompletionBlock:^(NSDictionary *dic) {
            [CommonTool gotoMainVC];
        }];
        
        
    }else{
        [CommonTool gotoLoginVC];
    }
    
    
}






- (void)dealloc {
    [_backgroundImageView release];
    [super dealloc];
}
@end
