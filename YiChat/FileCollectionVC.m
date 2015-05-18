//
//  FileCollectionVC.m
//  YiChat
//
//  Created by 孙 化育 on 15-2-3.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import "FileCollectionVC.h"
#import "FileCell.h"
#import "ZYFile.h"
#import "UIButton+WebCache.h"
#import "FileButton.h"
#import "FileDownloader.h"
#import "FileDetailVC.h"

@interface FileCollectionVC ()

@property (nonatomic,retain)NSMutableArray *dataSource;

@end

@implementation FileCollectionVC

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_downloaderManager release];
    [super dealloc];
}

- (id)initWithDataSource:(NSMutableArray *)array{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(60, 90);
    layout.minimumInteritemSpacing = 35;
    layout.sectionInset = UIEdgeInsetsMake(10, 35, 35, 35);
    
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.dataSource = array;
    }
    return self;
}

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    _downloaderManager = [[NSMutableDictionary alloc] init];
    [self.collectionView registerNib:[UINib nibWithNibName:@"FileCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadCollectionView) name:@"needReloadCollectionView" object:nil];
}

- (void)reloadCollectionView{
    [self.collectionView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FileCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    ZYFile *file = [_dataSource objectAtIndex:indexPath.row];
    
    FileDownloader *downloader = [_downloaderManager objectForKey:file.tname];
    
        //让button记录自己对应的downloader
    cell.button.downloader = downloader;
    
    if ([CommonTool isFileDownloadFinish:file.tname]) {
            //文件下载完毕
        cell.button.downloadState = buttonCompletion;
    }else if ([CommonTool isFileDownloadPart:file.tname]){
            //文件下载了一部分
        if ([downloader isDownloading]) {
                //正在下载
            cell.button.downloadState = buttonDownloading;
        }else{
                //暂停下载
            NSDictionary *dic = [FILE_M attributesOfItemAtPath:[NSString stringWithFormat:@"%@/%@",[CommonTool fileTempPath],file.tname] error:nil];
            cell.button.progress = (double)[dic fileSize]/[file.length floatValue];
            cell.button.downloadState = buttonPause;
        }
    }else{
            //文件没有下载
        cell.button.downloadState = buttonNormal;
    }
    
    
    [cell.button addTarget:self action:@selector(cellButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.button.tag = indexPath.row;
    cell.label.text = file.name;
    [cell.button setBackgroundImageWithURL:[NSURL URLWithString:file.imageURL]];
    
        //让文件记录自己对应的button
    file.button = cell.button;
    
    
    
    return cell;
}

- (void)cellButtonClick:(FileButton *)sender{
    ZYFile *file = [_dataSource objectAtIndex:sender.tag];
    
        //先去下载器管理器中寻找这个文件的下载器，如果有就直接使用，没有的话创建一个并加入下载器管理器
    FileDownloader *downloader = [_downloaderManager objectForKey:file.tname];
    
    if (!downloader) {
        downloader = [[FileDownloader alloc] initWithFile:file];
        [_downloaderManager setObject:downloader forKey:file.tname];
    }
    
        //让button记录自己的downloader
    sender.downloader = downloader;
    
    switch (sender.downloadState) {
        case buttonNormal:
        {
            //开始下载
        [downloader startDownload];
        sender.downloadState = buttonDownloading;
        }
            break;
        case buttonPause:
        {
            //继续下载
        [downloader startDownload];
        sender.downloadState = buttonDownloading;
        }
            break;
        case buttonDownloading:
        {
            //停止下载
        [downloader stopDownload];
        sender.downloadState = buttonPause;
        }
            break;
        case buttonCompletion:
        {
            //打开文件
        FileDetailVC *vc = [[FileDetailVC alloc] initWithFile:file];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
        
        }
            break;
        default:
            break;
    }
}


@end
