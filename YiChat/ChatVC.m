//
//  ChatVC.m
//  YiChat
//
//  Created by 孙 化育 on 15-1-30.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import "ChatVC.h"
#import "SelfCell.h"
#import "OtherCell.h"

@interface ChatVC ()

@property (nonatomic,retain)ZYUser *user;
@property (nonatomic,retain)NSMutableDictionary *chatInfoDic;

@end

@implementation ChatVC

- (void)dealloc{
    self.user = nil;
    self.chatInfoDic = nil;
    [_tableView release];
    [_inputView release];
    [_inputField release];
    [_messageArray release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (id)initWithUser:(ZYUser *)user andChatInfo:(NSMutableDictionary *)chatInfo;{
    self = [super init];
    if (self) {
        self.user = user;
        self.chatInfoDic = chatInfo;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        //监听获得新消息的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNewMessage) name:@"gotNewMessage" object:nil];
    
    _messageArray = [[NSMutableArray alloc] init];
    
        //查看是否有属于这个好友的新消息
    [self checkNewMessage];
    
    [self loadSubviews];
    
}

- (void)checkNewMessage{
    NSMutableArray *arr = [_chatInfoDic objectForKey:_user.name];
    if ([arr count]>0) {
            //有这个好友的消息
        for (NSString *message in arr) {
            NSDictionary *dic = @{@"msg":message,@"owner":@"other"};
            [_messageArray addObject:dic];
        }
        
            //当消息已经被显示后，视为已读，所以把这些消息从未读的大字典中删除
        [arr removeAllObjects];
        [CommonTool saveChatInfo:_chatInfoDic];
    }
    
    [_tableView reloadData];
}

- (void)loadSubviews{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 568-40)];
        //_tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"SelfCell" bundle:nil]forCellReuseIdentifier:@"self"];
    [_tableView registerNib:[UINib nibWithNibName:@"OtherCell" bundle:nil]forCellReuseIdentifier:@"other"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 528, SCREEN_WIDTH, 40)];
    [self.view addSubview:_inputView];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    imgView.image = [UIImage imageNamed:@"chatinputbg.png"];
    [_inputView addSubview:imgView];
    [imgView release];
    
    _inputField = [[UITextField alloc] initWithFrame:CGRectMake(8, 5, SCREEN_WIDTH-16, 30)];
    
    _inputField.delegate = self;
        //设置边框样式
    _inputField.borderStyle = UITextBorderStyleRoundedRect;
        //设置返回键类型
    _inputField.returnKeyType = UIReturnKeySend;
        //自动可用返回键
    _inputField.enablesReturnKeyAutomatically = YES;
    [_inputView addSubview:_inputField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"在M-d H:m:s说:"];
    NSString *time = [formatter stringFromDate:date];
    NSString *message = [NSString stringWithFormat:@"%@\n%@",time,textField.text];
    [NetworkTool sendMessage:message toFriend:_user.name completionBlock:^(NSDictionary *dic) {
        if ([[dic objectForKey:@"result"] integerValue] == 1) {
            NSDictionary *dic = @{@"msg":message,@"owner":@"self"};
            [_messageArray addObject:dic];
            _inputField.text = @"";
            [_tableView reloadData];
            [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_messageArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
        }
    }];
    
    
    return YES;
}

- (void)keyboardWillChangeFrame:(NSNotification *)noti{
    NSLog(@"%@",noti.userInfo);
    
    CGRect rect = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:[[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]];
//    [UIView setAnimationCurve:[[noti.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue]];
//    _inputView.frame = CGRectMake(0, rect.origin.y-40, SCREEN_WIDTH, 40);
//    [UIView commitAnimations];
    
    [UIView animateWithDuration:[[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        _inputView.frame = CGRectMake(0, rect.origin.y-40, SCREEN_WIDTH, 40);
        _tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _inputView.frame.origin.y);
    }];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [_messageArray objectAtIndex:indexPath.row];
    NSString *message = [dic objectForKey:@"msg"];
    CGRect rect = [message boundingRectWithSize:CGSizeMake(180, 0) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    return rect.size.height+30<80?80:rect.size.height+30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _messageArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [_messageArray objectAtIndex:indexPath.row];
    if ([[dic objectForKey:@"owner"] isEqualToString:@"self"]) {
        SelfCell *cell = [tableView dequeueReusableCellWithIdentifier:@"self"];
        NSString *message = [dic objectForKey:@"msg"];
        CGRect rect = [message boundingRectWithSize:CGSizeMake(180, 0) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        cell.messageLabel.frame = CGRectMake(60, 20, 180, rect.size.height);
        cell.messageLabel.text = message;
        cell.bubbleImageView.frame = CGRectMake(50, 10, 200, rect.size.height+20);
        return cell;
    }else{
        OtherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"other"];
        NSString *message = [dic objectForKey:@"msg"];
        CGRect rect = [message boundingRectWithSize:CGSizeMake(180, 0) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        cell.messageLabel.frame = CGRectMake(75, 20, 180, rect.size.height);
        cell.messageLabel.text = message;
        cell.bubbleImageView.frame = CGRectMake(65, 10, 200, rect.size.height+20);
        [cell.headerImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PIC_URL_ADDRESS,_user.headerURL]] placeholderImage:[UIImage imageNamed:@"head.png"]];
        return cell;
    }
    
    return nil;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
