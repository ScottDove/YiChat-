//
//  NewsDetailVC.h
//  YiChat
//
//  Created by 孙 化育 on 15-1-29.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYNews.h"

@interface NewsDetailVC : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    IBOutlet UITableView *_tableView;
    
    NSArray         *_commentArray;
    NSArray         *_newsContentArray;
}

- (id)initWithNews:(ZYNews *)news;


@end
