//
//  FileListVC.m
//  YiChat
//
//  Created by 孙 化育 on 15-1-27.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import "FileListVC.h"
#import "ZYFile.h"
#import "FileCollectionVC.h"
#import "LocalFileVC.h"

@interface FileListVC ()

@end

@implementation FileListVC

- (void)loadSubviews{
    
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2, self.view.frame.size.height-49);
    _scrollView.pagingEnabled = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _sgCon = [[UISegmentedControl alloc] initWithItems:@[@"公共资源",@"个人资源"]];
    self.navigationItem.titleView = _sgCon;
    _sgCon.selectedSegmentIndex = 0;
    [_sgCon addTarget:self action:@selector(segmentIndexChange:) forControlEvents:UIControlEventValueChanged];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"download_button.png"] style:UIBarButtonItemStylePlain target:self action:@selector(downloadedFileClick)];
    self.navigationItem.rightBarButtonItem = item;
    [item release];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"needReloadCollectionView" object:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadSubviews];
    
    [NetworkTool requestFileListWithCompletionBlock:^(NSDictionary *dic) {
        
            //整理公共文件
        _pubArray = [[NSMutableArray alloc] init];
        for (NSDictionary *fileDic in [[dic objectForKey:@"filelist"] objectForKey:@"pub_file"]) {
            ZYFile *file = [[ZYFile alloc] initWithDictionary:fileDic];
            [_pubArray addObject:file];
            [file release];
        }
        
            //整理个人文件
        _perArray = [[NSMutableArray alloc] init];
        for (NSDictionary *fileDic in [[dic objectForKey:@"filelist"] objectForKey:@"per_file"]) {
            ZYFile *file = [[ZYFile alloc] initWithDictionary:fileDic];
            [_perArray addObject:file];
            [file release];
        }
        
        for (int i = 0; i<2; i++) {
            FileCollectionVC *vc = [[FileCollectionVC alloc] initWithDataSource:i?_perArray:_pubArray];
            vc.collectionView.frame = CGRectMake(i*_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
            [_scrollView addSubview:vc.collectionView];
            [self addChildViewController:vc];
            [vc release];
        }
        
    }];
    
}

- (void)segmentIndexChange:(UISegmentedControl *)sender{
    [_scrollView setContentOffset:CGPointMake(_sgCon.selectedSegmentIndex*_scrollView.frame.size.width, 0) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x/scrollView.frame.size.width;
    _sgCon.selectedSegmentIndex = page;
}

- (void)downloadedFileClick{
    NSMutableArray *downloadedFile = [NSMutableArray array];
    
    for (ZYFile *file in _pubArray) {
        if ([CommonTool isFileDownloadFinish:file.tname]) {
            [downloadedFile addObject:file];
        }
    }
    for (ZYFile *file in _perArray) {
        if ([CommonTool isFileDownloadFinish:file.tname]) {
            [downloadedFile addObject:file];
        }
    }
    
    LocalFileVC *vc = [[LocalFileVC alloc] initWithFiles:downloadedFile];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}




- (void)dealloc {
    [_pubArray release];
    [_perArray release];
    [_sgCon release];
    [_scrollView release];
    [super dealloc];
}
@end
