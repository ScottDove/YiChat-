//
//  PersonInfoVC.h
//  YiChat
//
//  Created by 孙 化育 on 15-1-28.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYUser.h"

@interface PersonInfoVC : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    
    IBOutlet UIImageView *_headImageView;
    IBOutlet UILabel *_nameLabel;
    
    IBOutlet UITextField *_nickNameField;
    
    IBOutlet UITextField *_emailField;
    
    IBOutlet UIButton *_confirmButton;
}

- (id)initWithUser:(ZYUser *)user isSelf:(BOOL)isSelf;


@end
