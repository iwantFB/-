//
//  FHSelectedViewController.m
//  openeyes
//
//  Created by YSmac1 on 16/10/13.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import "NetWorkingTool.h"
#import "MBPrograssTool.h"
#import "FHSelectedModel.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

#import "SelectedHeaderView.h"
#import "SelectedVCCell.h"

#import "FHSelectedViewController.h"
#import "PlayVideoInfoViewController.h"

const CGFloat kimageHeight = 200;
@interface FHSelectedViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic)SelectedHeaderView *headerView;

@property (strong, nonatomic)UITableView *infoTableView;

@property (strong, nonatomic)NSMutableArray *listArr;

@property (copy, nonatomic)NSString *nextPageUrl;

@end

@implementation FHSelectedViewController
- (BOOL)shouldAutorotate//是否支持旋转屏幕
{
    return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations//支持哪些方向
{
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation//默认显示的方向
{
    return UIInterfaceOrientationPortrait;
}

#pragma mark - 数据懒加载
- (UITableView *)infoTableView
{
    if(!_infoTableView){
        _infoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                                      style:UITableViewStylePlain];
        _infoTableView.rowHeight = 200;
        _infoTableView.estimatedRowHeight = 200;
        [_infoTableView setContentInset:UIEdgeInsetsMake(kimageHeight, 0, 0, 0)];
        _infoTableView.backgroundColor = [UIColor clearColor];
        _infoTableView.showsVerticalScrollIndicator = NO;
        _infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _infoTableView.dataSource = self;
        _infoTableView.delegate = self;
        [self.view addSubview:_infoTableView];
        
        //设置刷新头
        UIRefreshControl *refreshHead = [[UIRefreshControl alloc] init];
        [refreshHead addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
        self.infoTableView.refreshControl = refreshHead;
        
        //设置上拉加载
        __weak typeof(self) weakSelf = self;
        _infoTableView.mj_footer  = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            [weakSelf loadMore];
        }];
    }
    return _infoTableView;
}

- (UIView *)stutesBarView
{
    if(!_stutesBarView){
        self.stutesBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        self.stutesBarView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    }
    return _stutesBarView;
}

#pragma mark - 生命周期
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.hidden = YES;
    
    //请求数据
    [self requestDataWithSender:nil];
    //配置子视图
    [self initSubViews];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.hidden = YES;
}

- (void)requestDataWithSender:(UIRefreshControl *)sender
{
    _listArr = [NSMutableArray array];
    
    //开始请求
    [MBPrograssTool showAlertWithStatus:@"加载中"];
    NSString *url = [self getUrlWithDate:[NSDate date]];
    
    clearWarning_force(
                       ([NetWorkingTool requestDataWithUrl:url parameters:nil sucess:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dailyListDict = [responseObject objectForKey:@"dailyList"];
        self.nextPageUrl = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"nextPageUrl"]];
        for (NSDictionary *videoList in dailyListDict) {
            NSArray *temp = [videoList objectForKey:@"videoList"];
            
            for (NSDictionary *dict in temp) {
                FHSelectedModel *model = [[FHSelectedModel alloc]initWithDictionary:dict error:nil];
                
                [_listArr addObject:model];
            }
        }
        
        [_infoTableView reloadData];
        [MBPrograssTool hideAllHub];
        [sender endRefreshing];
    } fail:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
        [MBPrograssTool hideAllHub];
        [sender endRefreshing];
    }])
                       );
}

- (NSString *)getUrlWithDate:(NSDate *)date//创建请求
{
    return [NSString stringWithFormat:dailyList,10,[self getDate:date]];
}

- (NSString *)getDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMdd";
    return [formatter stringFromDate:date];
}

- (void)initSubViews
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.stutesBarView];
    
    [self.view addSubview:[self infoTableView]];
    _headerView = [[SelectedHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kimageHeight)];
    [self.view insertSubview:_headerView atIndex:0];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectedVCCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[SelectedVCCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if(_listArr.count > indexPath.row){
        FHSelectedModel *model = _listArr[indexPath.row];
        [cell.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.coverForFeed]];
        cell.titleLabel.text = model.title;
        cell.messageLabel.text = [NSString stringWithFormat:@"#%@ / %@",model.category,[self timeStrForDuration:model.duration]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CGRect origalFrame = [tableView rectForRowAtIndexPath:indexPath];
    CGRect newFrame = [self.view convertRect:origalFrame fromView:tableView];
    PlayVideoInfoViewController *VC = [[PlayVideoInfoViewController alloc] initWithimgOrginalFrame:newFrame image:[[(SelectedVCCell *)[tableView cellForRowAtIndexPath:indexPath] bgImageView] image] model:self.listArr[indexPath.row]];
    //    [self addChildViewController:VC];
    //    [VC didMoveToParentViewController:self];
    //    self.stutesBarView.hidden = YES;
    //    [self.view addSubview:VC.view];
    
    [self presentViewController:VC animated:NO completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取scrollView的y轴偏移量
    CGFloat offsetY = scrollView.contentOffset.y;
    
    //    NSLog(@"%f", offsetY);
    
    //  计算滑动比例
    CGFloat p = (offsetY + kimageHeight) / (kimageHeight - 64);
    if(p <= 1){
        self.headerView.shadeLayer.opacity = p;
    }
    //    NSLog(@"%f", p);
    
    // 判断是向下滑动
    if (offsetY < -kimageHeight)
    {
        // 计算缩放值
        CGFloat scale = (-offsetY - kimageHeight) * 0.01;
        
        // 缩放图片
        self.headerView.bgImageView.transform = CGAffineTransformMakeScale(scale + 1, scale + 1);
        self.headerView.centerImageView.center = CGPointMake(self.headerView.centerImageView.center.x, self.headerView.centerImageView.center.y);
        [self setNeedsStatusBarAppearanceUpdate];//改变状态栏
    }
}

#pragma mark -上拉加载，下拉刷新
- (void)refreshData:(UIRefreshControl *)sender
{
    [sender beginRefreshing];
    [self requestDataWithSender:sender];
}

- (void)loadMore
{
    if([self.nextPageUrl isEqualToString:@"http://baobab.wandoujia.com/api/v1/feed.bak?date=20160924&num=10"]){
        [self.infoTableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        clearWarning_force(
                           ([NetWorkingTool requestDataWithUrl:self.nextPageUrl parameters:nil sucess:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dailyListDict = [responseObject objectForKey:@"dailyList"];
            self.nextPageUrl = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"nextPageUrl"]];
            NSLog(@"nextPageUrl - %@",self.nextPageUrl);
            for (NSDictionary *videoList in dailyListDict) {
                NSArray *temp = [videoList objectForKey:@"videoList"];
                
                for (NSDictionary *dict in temp) {
                    FHSelectedModel *model = [[FHSelectedModel alloc]initWithDictionary:dict error:nil];
                    
                    [_listArr addObject:model];
                }
            }
            
            [self.infoTableView reloadData];
            [self.infoTableView.mj_footer endRefreshing];
        } fail:nil]);
                           );
        
    }
}

#pragma mark - 设置状态栏
- (UIStatusBarStyle )preferredStatusBarStyle
{
    if (self.childViewControllers.count == 1) {
        return UIStatusBarStyleLightContent;
    }
    
    if(self.infoTableView.contentOffset.y>-20){
        self.stutesBarView.hidden = NO;
        return UIStatusBarStyleDefault;
    }
    
    self.stutesBarView.hidden = YES;
    
    return UIStatusBarStyleLightContent;
}

- (NSString *)timeStrForDuration:(NSString *)duration
{
    CGFloat time = [duration floatValue];
    return [NSString stringWithFormat:@"%02d'%02d\"",(int)time/60,(int)time%60];
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

@end
