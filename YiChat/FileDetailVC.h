//
//  FileDetailVC.h
//  YiChat
//
//  Created by 孙 化育 on 15-2-5.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYFile.h"
#import <MediaPlayer/MediaPlayer.h>

@interface FileDetailVC : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    IBOutlet UITableView *_tableView;
    
    MPMoviePlayerViewController     *_player;
    
    UIWebView                       *_webView;
}


- (id)initWithFile:(ZYFile *)file;




@end





