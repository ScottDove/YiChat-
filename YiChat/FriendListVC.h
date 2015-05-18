//
//  FriendListVC.h
//  YiChat
//
//  Created by 孙 化育 on 15-1-27.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendListVC : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    IBOutlet UITableView *_tableView;
    
    NSTimer             *_timer;
    
        //聊天信息字典，其中存储了所有好友的聊天信息，每个好友的名字是键，值是一个数组，数组中存储了这个好友发送的消息。
    NSMutableDictionary *_chatInfoDic;
}

@property (nonatomic,retain)NSMutableArray *friendArray;

@end




