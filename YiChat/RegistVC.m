//
//  RegistVC.m
//  YiChat
//
//  Created by 孙 化育 on 15-1-27.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import "RegistVC.h"

@interface RegistVC ()

@end

@implementation RegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)registButtonClick:(UIButton *)sender {
    if (_nameField.text.length<=0) {
        [APP_WINDOW showHUDWithText:@"用户名不能为空" Type:ShowPhotoNo Enabled:YES];
        return;
    }
    if (_passwordField.text.length<=0) {
        [APP_WINDOW showHUDWithText:@"密码不能为空" Type:ShowPhotoNo Enabled:YES];
        return;
    }
    if (![_confirmField.text isEqualToString:_passwordField.text]) {
        [APP_WINDOW showHUDWithText:@"两次密码输入不一致" Type:ShowPhotoNo Enabled:YES];
        return;
    }
    
    [NetworkTool registNewUserWithName:_nameField.text password:_passwordField.text nickName:_nickNameField.text email:_emailField.text completionBlock:^(NSDictionary *dic) {
        if ([[dic objectForKey:@"result"] intValue] == 1) {
                //注册成功
            [APP_WINDOW showHUDWithText:@"注册成功" Type:ShowPhotoYes Enabled:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
                //注册失败
            [APP_WINDOW showHUDWithText:[dic objectForKey:@"error"] Type:ShowPhotoNo Enabled:YES];
        }
    }];
    
    
    
    
    
    
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
    [_confirmField release];
    [_nickNameField release];
    [_emailField release];
    [super dealloc];
}
@end
