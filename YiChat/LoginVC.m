//
//  LoginVC.m
//  YiChat
//
//  Created by 孙 化育 on 15-1-27.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import "LoginVC.h"
#import "RegistVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)loginButtonClick:(UIButton *)sender {
    if (_nameField.text.length<=0) {
        [APP_WINDOW showHUDWithText:@"用户名不能为空" Type:ShowPhotoNo Enabled:YES];
        return;
    }
    if (_passwordField.text.length<=0) {
        [APP_WINDOW showHUDWithText:@"密码不能为空" Type:ShowPhotoNo Enabled:YES];
        return;
    }
    
    [NetworkTool loginWithName:_nameField.text password:_passwordField.text completionBlock:^(NSDictionary *dic) {
            //登录成功后，存储token
        if ([[dic objectForKey:@"result"] integerValue] == 1) {
            [USER_D setObject:[dic objectForKey:@"access_token"] forKey:@"token"];
            NSDate *nowDate = [NSDate date];
            float time = [[dic objectForKey:@"time"] floatValue];
            NSDate *endDate = [nowDate dateByAddingTimeInterval:time];
            [USER_D setObject:endDate forKey:@"endDate"];
            [USER_D synchronize];
            
                //登录成功后线获取个人信息，再进入主界面
            [NetworkTool requestSelfInfoWithCompletionBlock:^(NSDictionary *dic) {
                [CommonTool gotoMainVC];
            }];
            
        }else{
            [APP_WINDOW showHUDWithText:[dic objectForKey:@"error"] Type:ShowPhotoNo Enabled:YES];
        }
        
        
        
        
    }];
    
}


- (IBAction)registButtonClick:(UIButton *)sender {
    RegistVC *vc = [[RegistVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
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
    [_nameField release];
    [_passwordField release];
    [super dealloc];
}
@end
