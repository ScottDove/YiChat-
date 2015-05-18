//
//  LocalFileVC.h
//  YiChat
//
//  Created by 孙 化育 on 15-2-5.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocalFileVC : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    IBOutlet UITableView *_tableView;
}

- (id)initWithFiles:(NSMutableArray *)fileArray;



@end
