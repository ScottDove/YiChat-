//
//  SettingVC.m
//  YiChat
//
//  Created by 孙 化育 on 15-1-27.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import "SettingVC.h"
#import "UIImageView+WebCache.h"
#import "PersonInfoVC.h"
#import "ZYUser.h"
#import "SDImageCache.h"

@interface SettingVC ()

@end

@implementation SettingVC

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [_tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section == 0?80:44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 1?3:1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
            //第0区cell右侧有图片，单独使用一种重用标识
        cell = [tableView dequeueReusableCellWithIdentifier:@"section0"];
        if (!cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"section0"] autorelease];
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(240, 5, 70, 70)];
            imgView.tag = 99;
            imgView.layer.cornerRadius = 35;
            imgView.layer.masksToBounds = YES;
            [cell.contentView addSubview:imgView];
            [imgView release];
        }
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"section1"];
        if (!cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"section1"] autorelease];
        }
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"个人信息";
        UIImageView *imgView = (UIImageView *)[cell viewWithTag:99];
        [imgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PIC_URL_ADDRESS,[USER_D objectForKey:@"userHeaderurl"]]] placeholderImage:[UIImage imageNamed:@"head.png"]];
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"清理图片缓存";
            
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fM",(double)[[SDImageCache sharedImageCache] getSize]/1000/1000];
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"清理文件缓存";
            
                //文件夹枚举器，可以枚举这个文件夹内以及这个文件夹的子文件夹中的所有文件
            NSDirectoryEnumerator *enumerator = [FILE_M enumeratorAtPath:[CommonTool fileDownloadPath]];
            unsigned long long totalSize = 0;
            while ([enumerator nextObject]) {
                totalSize+=[[enumerator fileAttributes] fileSize];
            }
            
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fM",(double)totalSize/1000/1000];
        }else{
            cell.textLabel.text = @"退出登录";
        }
    }else{
        cell.textLabel.text = @"关于我们";
        cell.detailTextLabel.text = @"";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
                //进个人设置界面
        {
        ZYUser *user = [[ZYUser alloc] init];
        user.name = [USER_D objectForKey:@"userName"];
        user.nickName = [USER_D objectForKey:@"userNickname"];
        user.email = [USER_D objectForKey:@"userEmail"];
        user.headerURL = [USER_D objectForKey:@"userHeaderurl"];
        PersonInfoVC *vc = [[PersonInfoVC alloc] initWithUser:user isSelf:YES];
        [user release];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
        }
            break;
        case 1:
        {
        switch (indexPath.row) {
            case 0:
            {
            //清除图片缓存
            [[SDImageCache sharedImageCache] clearDisk];
            SHOW_ALERT(@"清除成功");
            [_tableView reloadData];
            }
                break;
            case 1:{
                    //清理文件缓存
                [FILE_M removeItemAtPath:[CommonTool fileDownloadPath] error:nil];
                SHOW_ALERT(@"清除成功");
                [_tableView reloadData];
            }
                
                break;
            case 2:
            {
                //退出登录
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"确定要退出吗？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出" otherButtonTitles:nil, nil];
            [sheet showInView:self.view];
            [sheet release];
            }
                break;
                
            default:
                break;
        }
        }
            break;
        case 2:
        {
        SHOW_ALERT(@"易聊是一款。。。。。。。。。。。。。。。。。。。的应用");
        }
            break;
            
        default:
            break;
    }
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [NetworkTool logoutRequestWithCompletionBlock:^(NSDictionary *dic) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"logout" object:self];
            [USER_D removeObjectForKey:@"token"];
            [USER_D removeObjectForKey:@"endDate"];
            [CommonTool gotoLoginVC];
        }];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end
