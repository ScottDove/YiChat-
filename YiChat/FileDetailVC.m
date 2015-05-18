//
//  FileDetailVC.m
//  YiChat
//
//  Created by 孙 化育 on 15-2-5.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import "FileDetailVC.h"

@interface FileDetailVC ()

@property (nonatomic,retain)ZYFile *file;

@end

@implementation FileDetailVC

- (id)initWithFile:(ZYFile *)file{
    self = [super init];
    if (self) {
        self.file = file;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.sectionHeaderHeight = 40;
    
        //加载一个本地路径的url
    NSURL *url = [[NSURL alloc] initFileURLWithPath:[[CommonTool fileDownloadPath] stringByAppendingPathComponent:_file.tname]];
    
    if (_file.type.integerValue == 1||_file.type.integerValue == 2) {
            //视频或音频文件
        _player = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
            //把播放器视图添加到表头上
        _tableView.tableHeaderView = _player.view;
    }else{
            //pdf,jpg,doc.....
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [[UIScreen mainScreen] bounds].size.height-64-40)];
        _tableView.tableHeaderView = _webView;
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
        
            //自动缩放到适合的尺寸
        _webView.scalesPageToFit = YES;
    }
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = [NSString stringWithFormat:@"   %@",_file.name];
    label.textColor = [UIColor blueColor];
    label.backgroundColor = [UIColor lightGrayColor];
    return [label autorelease];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 100;
    }else{
        CGRect rect = [_file.fileDescription boundingRectWithSize:CGSizeMake(288, 0) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
        return rect.size.height+35;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"] autorelease];
        cell.textLabel.textColor = [UIColor blueColor];
        cell.detailTextLabel.numberOfLines = 0;
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"·资源介绍";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"上传者:%@\n上传时间:%@\n下载次数:%@",_file.author,_file.time,_file.dTime];
    }else{
        cell.textLabel.text = @"·内容简介";
        cell.detailTextLabel.text = _file.fileDescription;
    }
    
    
    return cell;
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
    self.file = nil;
    [_tableView release];
    [_player release];
    [_webView release];
    [super dealloc];
}
@end
