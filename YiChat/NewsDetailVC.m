//
//  NewsDetailVC.m
//  YiChat
//
//  Created by 孙 化育 on 15-1-29.
//  Copyright (c) 2015年 孙 化育. All rights reserved.
//

#import "NewsDetailVC.h"
#import "NewsContentCell.h"

@interface NewsDetailVC ()

@property (nonatomic,retain)ZYNews *news;

@end

@implementation NewsDetailVC

- (id)initWithNews:(ZYNews *)news{
    self = [super init];
    if (self) {
        self.news = news;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    [_tableView registerNib:[UINib nibWithNibName:@"NewsContentCell" bundle:nil] forCellReuseIdentifier:@"newsContent"];
    
    self.title = _news.channel;
    
        //新闻标题，tableHeaderView
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 40)];
    titleLabel.text = _news.newsTitle;
    
    UILabel *sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, SCREEN_WIDTH-30, 40)];
    sourceLabel.font = [UIFont systemFontOfSize:14];
    sourceLabel.text = [NSString stringWithFormat:@"%@\t%@\t%@",_news.source,_news.auther,_news.time];
    [tableHeaderView addSubview:titleLabel];
    [tableHeaderView addSubview:sourceLabel];
    [titleLabel release];
    [sourceLabel release];
    
    _tableView.tableHeaderView = tableHeaderView;
    [tableHeaderView release];
    
        //请求新闻内容
    [NetworkTool requestNewsOfURL:_news.sourceURL completionBlock:^(NSDictionary *dic) {
        
        _newsContentArray = [[dic objectForKey:@"data"] retain];
        _commentArray = [[dic objectForKey:@"comments"] retain];
        
        [_tableView reloadData];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

    //设置区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        CGRect rect = [_news.intro boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-30, 0) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} context:nil];
        return rect.size.height+30;
    }else{
        return 50;
    }
}

    //设置区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
            //新闻内容区
        UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"section0"];
        if (!header) {
            header = [[[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"section0"] autorelease];
            header.contentView.backgroundColor = [UIColor lightGrayColor];
            CGRect rect = [_news.intro boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-30, 0) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} context:nil];
            UILabel *introLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH-30, rect.size.height)];
            introLabel.numberOfLines = 0;
            introLabel.font = [UIFont boldSystemFontOfSize:14];
            [header addSubview:introLabel];
            [introLabel release];
            introLabel.text = _news.intro;
        }
        return header;
    }else{
            //评论区
        UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"section1"];
        if (!header) {
            header = [[[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"section1"] autorelease];
            header.contentView.backgroundColor = [UIColor lightGrayColor];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH-30, 20)];
            label.text = @"热门评论";
            [header addSubview:label];
            [label release];
        }
        return header;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section == 0) {
//        return _newsContentArray.count;
//    }else{
//        return _commentArray.count;
//    }
    
    return section?_commentArray.count:_newsContentArray.count;
}

    //设置每行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
            //新闻内容区
        NSDictionary *dic = [_newsContentArray objectAtIndex:indexPath.row];
        if ([[dic objectForKey:@"data_type"] integerValue] == 1){
                //文本
            NSString *text = [NSString stringWithFormat:@"\t%@",[dic objectForKey:@"content"]];
            CGRect rect = [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, 0) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} context:nil];
            return rect.size.height+20;
        }else{
                //图片
            return [[[dic objectForKey:@"image"] objectForKey:@"height"] floatValue]+20;
        }
    }else{
            //评论区
        NSDictionary *dic = [_commentArray objectAtIndex:indexPath.row];
        NSString *info = [dic objectForKey:@"info"];
        CGRect rect = [info boundingRectWithSize:CGSizeMake(290, 0) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        return rect.size.height+24;
    }
    
    
}

    //设置每行的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
            //新闻内容区
        NewsContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsContent"];
        NSDictionary *dic = [_newsContentArray objectAtIndex:indexPath.row];
        if ([[dic objectForKey:@"data_type"] integerValue] == 1) {
                //文本内容
            cell.newsImageView.image = nil;
            cell.newsLabel.text = [NSString stringWithFormat:@"\t%@",[dic objectForKey:@"content"]];
            
            CGRect rect = [cell.newsLabel.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, 0) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} context:nil];
            cell.newsLabel.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, rect.size.height);
        }else{
                //图片内容
            cell.newsLabel.text = @"";
            cell.newsImageView.frame = CGRectMake(10, 10, 300, [[[dic objectForKey:@"image"] objectForKey:@"height"] floatValue]);
            [cell.newsImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_ADDRESS,[[dic objectForKey:@"image"] objectForKey:@"source"]]]];
        }
        
        return cell;
    }else{
            //评论区
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
        if (!cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"comment"] autorelease];
            cell.textLabel.textColor = [UIColor blueColor];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.numberOfLines = 0;
        }
        NSDictionary *dic = [_commentArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [dic objectForKey:@"name"];
        cell.detailTextLabel.text = [dic objectForKey:@"info"];
        
        return cell;
    }
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
    [_commentArray release];
    [_newsContentArray release];
    [_tableView release];
    [super dealloc];
}
@end
