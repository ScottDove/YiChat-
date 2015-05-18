//
//  PersonInfoVC.m
//  YiChat
//
//  Created by 孙 化育 on 15-1-28.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import "PersonInfoVC.h"

@interface PersonInfoVC ()

@property (nonatomic,retain)ZYUser *user;
@property (nonatomic,assign)BOOL isSelf;

@end

@implementation PersonInfoVC

- (id)initWithUser:(ZYUser *)user isSelf:(BOOL)isSelf{
    self = [super init];
    if (self) {
        self.user = user;
        self.isSelf = isSelf;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
    [self.view addGestureRecognizer:gesture];
    [gesture release];
    
    if (_isSelf) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"上传头像" style:UIBarButtonItemStylePlain target:self action:@selector(chooseImageClick)];
        self.navigationItem.rightBarButtonItem = item;
        [item release];
    }
    
    
    _nameLabel.text = self.user.name;
    _nickNameField.text = self.user.nickName;
    _emailField.text = self.user.email;
    
    if (!_isSelf) {
        _nickNameField.enabled = NO;
        _emailField.enabled = NO;
        _confirmButton.hidden = YES;
    }
    
    [_headImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PIC_URL_ADDRESS,self.user.headerURL]] placeholderImage:[UIImage imageNamed:@"head.png"]];
    
}

- (void)backgroundTapped:(UITapGestureRecognizer *)gesture{
    [self.view endEditing:YES];
}

- (void)chooseImageClick{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:picker animated:YES completion:nil];
        });
    });
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    [APP_WINDOW showHUDWithText:@"正在上传" Type:ShowLoading Enabled:YES];
    
    [NetworkTool uploadHeaderImage:image completionBlock:^(NSDictionary *dic) {
        [APP_WINDOW showHUDWithText:@"上传完毕" Type:ShowPhotoYes Enabled:YES];
        _headImageView.image = image;
        [NetworkTool requestSelfInfoWithCompletionBlock:^(NSDictionary *dic) {
            
        }];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    
}


- (IBAction)updateButtonClick:(UIButton *)sender {
    if (_nickNameField.text.length<=0) {
        return;
    }
    if (_emailField.text.length<=0) {
        return;
    }
    
    [NetworkTool updateNickName:_nickNameField.text andEmail:_emailField.text completionBlock:^(NSDictionary *dic) {
        [APP_WINDOW showHUDWithText:@"修改完成" Type:ShowPhotoYes Enabled:YES];
        [NetworkTool requestSelfInfoWithCompletionBlock:^(NSDictionary *dic) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
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
    [_headImageView release];
    [_nameLabel release];
    [_nickNameField release];
    [_emailField release];
    [_confirmButton release];
    [super dealloc];
}
@end
