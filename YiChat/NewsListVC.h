//
//  NewsListVC.h
//  YiChat
//
//  Created by 孙 化育 on 15-1-27.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsListVC : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    IBOutlet UITableView *_tableView;
    
    NSMutableArray          *_newsListArray;
    
    
}

@end
