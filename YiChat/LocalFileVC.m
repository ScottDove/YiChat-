//
//  LocalFileVC.m
//  YiChat
//
//  Created by 孙 化育 on 15-2-5.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import "LocalFileVC.h"
#import "NormalNewsCell.h"
#import "ZYFile.h"
#import "FileDetailVC.h"

@interface LocalFileVC ()
@property (nonatomic,retain)NSMutableArray *fileArray;
@end

@implementation LocalFileVC

- (id)initWithFiles:(NSMutableArray *)fileArray{
    self = [super init];
    if (self) {
        self.fileArray = fileArray;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.rowHeight = 100;
    
    [_tableView registerNib:[UINib nibWithNibName:@"NormalNewsCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.fileArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NormalNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    ZYFile *file = [self.fileArray objectAtIndex:indexPath.row];
    [cell.newsImageView setImageWithURL:[NSURL URLWithString:file.imageURL]];
    cell.titleLabel.text = file.name;
    cell.introLabel.text = file.fileDescription;
    
    long long fileSize = [file.length longLongValue];
    if (fileSize<1000) {
        cell.sourceLabel.text = [NSString stringWithFormat:@"%lldB",fileSize];
    }else if (fileSize<1000000){
        cell.sourceLabel.text = [NSString stringWithFormat:@"%.1fKB",(double)fileSize/1000];
    }else{
        cell.sourceLabel.text = [NSString stringWithFormat:@"%.1fMB",(double)fileSize/1000/1000];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZYFile *file = [_fileArray objectAtIndex:indexPath.row];
    FileDetailVC *vc  =[[FileDetailVC alloc] initWithFile:file];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    ZYFile *file = [_fileArray objectAtIndex:indexPath.row];
    [FILE_M removeItemAtPath:[[CommonTool fileDownloadPath] stringByAppendingPathComponent:file.tname] error:nil];
    [_fileArray removeObjectAtIndex:indexPath.row];
    [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
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

- (void)dealloc {
    self.fileArray = nil;
    [_tableView release];
    [super dealloc];
}
@end
