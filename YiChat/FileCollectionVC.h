//
//  FileCollectionVC.h
//  YiChat
//
//  Created by 孙 化育 on 15-2-3.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileCollectionVC : UICollectionViewController{
        //下载器管理器，所有文件的下载器都存在这个字典中
    NSMutableDictionary     *_downloaderManager;
}


- (id)initWithDataSource:(NSMutableArray *)array;

@end
