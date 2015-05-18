//
//  FileListVC.h
//  YiChat
//
//  Created by 孙 化育 on 15-1-27.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileListVC : UIViewController<UIScrollViewDelegate>{
    
    IBOutlet UIScrollView *_scrollView;
    
    UISegmentedControl      *_sgCon;
    
    NSMutableArray          *_pubArray;
    NSMutableArray          *_perArray;
}

@end
