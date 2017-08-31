//
//  Top10ViewController.m
//  openeyes
//
//  Created by YSmac1 on 16/10/18.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import "Top10ViewController.h"
#import "PlayVideoInfoViewController.h"
#import "NetWorkingTool.h"
#import "MBPrograssTool.h"
#import "UIImageView+WebCache.h"

#import "UIView+Buttons.h"
#import "TopTenCell.h"

#import "TopModel.h"

@interface Top10ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)UITableView *topTenInfoTableView;

@property (strong, nonatomic)NSMutableArray *dataArr;

@property (strong, nonatomic)NSMutableArray *allDataArr;

@end

@implementation Top10ViewController
{
    NSString *_getDataUrl;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _getDataUrl = PopularUrl;
    _allDataArr = [NSMutableArray array];
    
    [self _setupUI];
    [self _requestData:0];
}

- (void)_setupUI
{
    //设置titleView
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    titleView.text = @"排行榜";
    titleView.font = [UIFont boldSystemFontOfSize:15];
    titleView.textColor = [UIColor blackColor];
    titleView.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleView;
    
    UIView *indexView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 30)];
    indexView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
    [indexView addButtonWithTitle:@[@"周排行",@"月排行",@"总排行"] font:[UIFont systemFontOfSize:14] btnClick:^(UIButton *sender, NSInteger tag) {
        NSArray *urlArr = @[PopularUrl,PopularMonth,PopularAll];
        if([_getDataUrl isEqualToString:urlArr[tag]]) return ;
        _getDataUrl = urlArr[tag];
        
        if(tag == 2 && _allDataArr.count == 3){
            _dataArr = _allDataArr[tag];
        }else if(tag >= _allDataArr.count-1)
        {
            [self _requestData:tag];
        }
        else
            _dataArr = _allDataArr[tag];
        [_topTenInfoTableView reloadData];
        
    }];
    [self.view addSubview:indexView];
    
    //信息表视图
    _topTenInfoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 94, SCREEN_WIDTH, SCREEN_HEIGHT - 30) style:UITableViewStylePlain];
    _topTenInfoTableView.delegate = self;
    _topTenInfoTableView.dataSource = self;
    _topTenInfoTableView.estimatedRowHeight = 200;
    _topTenInfoTableView.rowHeight = 200;
    [self.view addSubview:_topTenInfoTableView];
}

- (void)_requestData:(NSInteger)index
{
    [MBPrograssTool showAlertWithStatus:@"加载中。。。"];
    
    _dataArr = [NSMutableArray array];
    
    //请求数据
    [NetWorkingTool requestDataWithUrl:_getDataUrl parameters:nil sucess:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *itemListArr = [responseObject objectForKey:@"itemList"];
        
        for (NSDictionary *dict in itemListArr) {
            TopModel *model = [[TopModel alloc] initWithDictionary:dict[@"data"] error:nil];
            [_dataArr addObject:model];
        }
        if(index == 1 && _allDataArr.count == 2){
            [_allDataArr insertObject:_dataArr atIndex:1];
        }else{
            [_allDataArr addObject:_dataArr];
        }
        [_topTenInfoTableView reloadData];
        [MBPrograssTool hideAllHub];
    } fail:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error - %@",error.localizedDescription);
        [MBPrograssTool hideAllHub];
    }];
}

#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopTenCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topCell"];
    
    if(!cell){
        cell = [[TopTenCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"topCell"];
    }
    
    TopModel *model = _dataArr[indexPath.row];
    [cell.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.cover[@"feed"]]];
    cell.titleLabel.text = model.title;
    cell.messageLabel.text = [NSString stringWithFormat:@"#%@ / %@",model.category,[self timeStrForDuration:model.duration]];
    cell.rankLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CGRect origalFrame = [tableView rectForRowAtIndexPath:indexPath];
    CGRect newFrame = [self.view convertRect:origalFrame fromView:tableView];
    PlayVideoInfoViewController *VC = [[PlayVideoInfoViewController alloc] initWithimgOrginalFrame:newFrame image:[[(SelectedVCCell *)[tableView cellForRowAtIndexPath:indexPath] bgImageView] image] model:self.dataArr[indexPath.row]];
    [self presentViewController:VC animated:NO completion:nil];
}

- (NSString *)timeStrForDuration:(NSString *)duration
{
    CGFloat time = [duration floatValue];
    return [NSString stringWithFormat:@"%02d'%02d\"",(int)time/60,(int)time%60];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
