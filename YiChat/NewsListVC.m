//
//  NewsListVC.m
//  YiChat
//
//  Created by 孙 化育 on 15-1-27.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import "NewsListVC.h"
#import "ZYNews.h"
#import "NormalNewsCell.h"
#import "PicNewsCell.h"
#import "NewsDetailVC.h"

@interface NewsListVC ()

@end

@implementation NewsListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:@"NormalNewsCell" bundle:nil] forCellReuseIdentifier:@"normal"];
    [_tableView registerNib:[UINib nibWithNibName:@"PicNewsCell" bundle:nil] forCellReuseIdentifier:@"pic"];
    
    _newsListArray = [[NSMutableArray alloc] init];
    
    [NetworkTool requestNewsListWithCompletionBlock:^(NSDictionary *dic) {
        for (NSDictionary *newsDic in [dic objectForKey:@"news_list"]) {
            ZYNews *news = [[ZYNews alloc] initWithDictionary:newsDic];
            [_newsListArray addObject:news];
            [news release];
        }
        
        [_tableView reloadData];
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZYNews *news = [_newsListArray objectAtIndex:indexPath.row];
    return news.type == 6?120:100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _newsListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZYNews *news = [_newsListArray objectAtIndex:indexPath.row];
    if (news.type == 6) {
            //图片新闻
        PicNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pic"];
        cell.titleLabel.text = news.newsTitle;
        cell.sourceLabel.text = news.source;
        for (int i = 0; i<3; i++) {
            UIImageView *imgView = [cell.newsImageViews objectAtIndex:i];
            NSString *picURL = [[news.images objectAtIndex:i] objectForKey:@"url"];
            [imgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_ADDRESS,picURL]]];
        }
        return cell;
    }else{
            //普通新闻
        NormalNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normal"];
        cell.titleLabel.text = news.newsTitle;
        cell.sourceLabel.text = news.source;
        cell.introLabel.text = news.intro;
        NSString *picURL = [[news.images objectAtIndex:0] objectForKey:@"url"];
        [cell.newsImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_ADDRESS,picURL]]];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZYNews *news = [_newsListArray objectAtIndex:indexPath.row];
    NewsDetailVC *vc = [[NewsDetailVC alloc] initWithNews:news];
        //push时自动隐藏tabBar
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
    
}

- (void)dealloc {
    NSLog(@"新闻列表页被释放了");
    [_newsListArray release];
    [_tableView release];
    [super dealloc];
}
@end
