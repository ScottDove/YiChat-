//
//  ChatVC.h
//  YiChat
//
//  Created by 孙 化育 on 15-1-30.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYUser.h"

@interface ChatVC : UIViewController<UITableViewDelegate,UITextFieldDelegate,UITableViewDataSource>{
    UITableView         *_tableView;
    
    UIView              *_inputView;
    UITextField         *_inputField;
    
    NSMutableArray      *_messageArray;
}

- (id)initWithUser:(ZYUser *)user andChatInfo:(NSMutableDictionary *)chatInfo;

@end
