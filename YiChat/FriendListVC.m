//
//  FriendListVC.m
//  YiChat
//
//  Created by 孙 化育 on 15-1-27.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import "FriendListVC.h"
#import "ZYUser.h"
#import "FriendCell.h"
#import "PersonInfoVC.h"
#import "ChatVC.h"
#import "Base64.h"

@interface FriendListVC ()

@end

@implementation FriendListVC

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_tableView reloadData];
    [self resetBadgeValue];
}

- (void)stopTimer{
    [_timer invalidate];
    _timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
        //注册推送类型
    [[UIApplication sharedApplication] registerUserNotificationSettings:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopTimer) name:@"logout" object:nil];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/chatInfo/%@.plist",[USER_D objectForKey:@"userName"]]];
        //启动后先读取本地未读的聊天记录
    _chatInfoDic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    if (!_chatInfoDic) {
        _chatInfoDic = [[NSMutableDictionary alloc] init];
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 100;
    [_tableView registerNib:[UINib nibWithNibName:@"FriendCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    _friendArray = [[NSMutableArray alloc] init];
    
    
        //开启timer，每5秒更新一次好友列表，并请求聊天信息
    _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerHandle) userInfo:nil repeats:YES];
    
    
    [self timerHandle];
}

- (void)timerHandle{
    [NetworkTool requestFriendListWithCompletionBlock:^(NSDictionary *dic) {
        [_friendArray removeAllObjects];
        for (NSDictionary *friendDic in [dic objectForKey:@"data"]) {
            ZYUser *user = [[ZYUser alloc] initWithDictionary:friendDic];
            [_friendArray addObject:user];
            [user release];
        }
        
            //好友列表请求完成后，立刻请求聊天信息
        [NetworkTool requestChatInfoWithCompletionBlock:^(NSDictionary *dic) {
            if ([dic objectForKey:@"error"]) {
                    //没有消息
            }else{
                    //有新消息
                NSArray *chatArray = [dic objectForKey:@"data"];
                    //遍历所有聊天信息
                for (NSDictionary *chatDic in chatArray) {
                        //先查看这条消息是谁发的
                    NSString *name = [[chatDic allKeys] lastObject];
                        //首先查看聊天信息字典中有没有这个好友，如果没有的话，给他创建一个数组
                    if (![_chatInfoDic objectForKey:name]) {
                        [_chatInfoDic setObject:[NSMutableArray array] forKey:name];
                    }
                        //取出聊天信息
                    NSString *message = [[chatDic objectForKey:name] base64DecodedString];
                        //把这条聊天信息放入大字典中这个好友的数组里
                    [[_chatInfoDic objectForKey:name] addObject:message];
                }
                    //把未读的聊天消息存到本地
                [CommonTool saveChatInfo:_chatInfoDic];
                
                    //获得新消息后，发送一个通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"gotNewMessage" object:self];
                
                    //设置角标
                [self resetBadgeValue];
                
                [_tableView reloadData];
            }
        }];
    }];
}

- (void)resetBadgeValue{
    NSInteger number = 0;
    for (NSArray *arr in [_chatInfoDic allValues]) {
        number += arr.count;
    }
    
    if (number>0) {
        self.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",number];
    }else{
        self.navigationController.tabBarItem.badgeValue = nil;
    }
    
        //设置应用图标的角标
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:number];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _friendArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    ZYUser *user = [_friendArray objectAtIndex:indexPath.row];
    [cell.headerButton setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PIC_URL_ADDRESS,user.headerURL]] placeholderImage:[UIImage imageNamed:@"head.png"]];
    cell.nameLabel.text = user.name;
    cell.nickNameLabel.text = user.nickName;
    
    NSArray *arr = [_chatInfoDic objectForKey:user.name];
    cell.messageCountLabel.text = [NSString stringWithFormat:@"%d",arr.count];
    
    if (indexPath.row == 0) {
        cell.messageCountLabel.hidden = YES;
    }else{
        cell.messageCountLabel.hidden = NO;
    }
    
    [cell.headerButton addTarget:self action:@selector(headerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.headerButton.tag = indexPath.row;
    
    return cell;
}


- (void)headerButtonClick:(UIButton *)sender{
    ZYUser *user = [_friendArray objectAtIndex:sender.tag];
    PersonInfoVC *vc = [[PersonInfoVC alloc] initWithUser:user isSelf:sender.tag == 0];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return;
    }
    
    ZYUser *user = [_friendArray objectAtIndex:indexPath.row];
    ChatVC *vc = [[ChatVC alloc] initWithUser:user andChatInfo:_chatInfoDic];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
    
}



- (void)dealloc {
    NSLog(@"聊天页面被释放了");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_chatInfoDic release];
    [_friendArray release];
    [_tableView release];
    [super dealloc];
}
@end
