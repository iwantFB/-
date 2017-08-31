//
//  FoundViewController.m
//  openeyes
//
//  Created by YSmac1 on 16/10/13.
//  Copyright © 2016年 YiSenZhongHe. All rights reserved.
//

#import "FoundBannerModel.h"

#import "FoundCollectionReusableHeaderView.h"
#import "FoundCollectionViewCell.h"

#import "FoundViewController.h"
#import "Top10ViewController.h"

#import "NetWorkingTool.h"
#import "MBPrograssTool.h"
#import "UIImageView+WebCache.h"

NSString *discoverUrl = @"http://baobab.wandoujia.com/api/v3/discovery?_s=81e478cfa17beb02b80f41420d3c7e5c&f=iphone&net=wifi&p_product=EYEPETIZER_IOS&u=995a366ec4369fa6cbcf4347cdf3b76bf753d0c6&v=2.7.0&vc=1305";

@interface FoundViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FoundCollectionReusableHeaderViewDelegate>

@property (strong, nonatomic)NSMutableArray *bannerArr;

@property (strong, nonatomic)NSMutableArray *dataArr;

@property (strong, nonatomic)UICollectionView *infoCollectionView;

@end

@implementation FoundViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"发现";
    
    [self _setupUI];
    [self _requestData];
}

- (void)_requestData
{
    
    _bannerArr = [NSMutableArray array];
    _dataArr = [NSMutableArray array];
    [MBPrograssTool showAlertWithStatus:@"加载中。。。"];
                    [NetWorkingTool requestDataWithUrl:discoverUrl parameters:nil sucess:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSArray *dataListArr = responseObject[@"itemList"];
    [dataListArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj[@"type"] isEqualToString:@"horizontalScrollCard"]){
            NSArray *data = obj[@"data"][@"itemList"];
            [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FoundBannerModel *model = [[FoundBannerModel alloc] initWithDictionary:obj[@"data"] error:nil];
                [_bannerArr addObject:model];
            }];
        }
        if([obj[@"type"] isEqualToString:@"rectangleCard"] || [obj[@"type"] isEqualToString:@"squareCard"]){
            NSLog(@"data is %@/n",obj[@"data"]);
            FoundBannerModel *model = [[FoundBannerModel alloc] initWithDictionary:obj[@"data"] error:nil];
            [self.dataArr addObject:model];
        }
    }];
    
                        [_infoCollectionView reloadData];
                        [MBPrograssTool hideAllHub];
} fail:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"error - %@",error.localizedDescription);
    [MBPrograssTool hideAllHub];
}];
}

- (void)_setupUI
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.text = @"eyepetizer";
    label.font = [UIFont fontWithName:MyEnFontTwo size:24];
    label.textColor = [UIColor blackColor];
    self.navigationItem.titleView = label;
    
    UIBarButtonItem *searchBtnItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"search_black"] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch] style:UIBarButtonItemStylePlain target:self action:@selector(searchBarItemAction:)];
    self.navigationItem.rightBarButtonItem = searchBtnItem;
    
    //单元格
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.minimumLineSpacing = 2;
    flow.minimumInteritemSpacing = 2;
    
    _infoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flow];
    _infoCollectionView.backgroundColor = [UIColor whiteColor];
    _infoCollectionView.delegate = self;
    _infoCollectionView.dataSource = self;
    [_infoCollectionView registerClass:[FoundCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
    [_infoCollectionView registerClass:[FoundCollectionReusableHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self.view addSubview:_infoCollectionView];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 19;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FoundCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    if(self.dataArr.count != 0){
        FoundBannerModel *model = self.dataArr[indexPath.item];
        if(model.shade){
            cell.maskView.hidden = NO;
            cell.longG.enabled = YES;
            cell.titleLabel.text = model.title;
        }else{
            cell.longG.enabled = NO;
            cell.maskView.hidden = YES;
        }
        [cell.cellImageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    FoundCollectionReusableHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    view.delegate = self;
    [view setDataArr:self.bannerArr];
    return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width =  (SCREEN_WIDTH-2)/2.0;
    if(indexPath.item == 2){
        return CGSizeMake(SCREEN_WIDTH, width);
    }
    return CGSizeMake(width, width);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 200);
}

//点击⌚️
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.item == 0){
        Top10ViewController *topVC = [[Top10ViewController alloc] init];
        topVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:topVC animated:YES];
    }
}

#pragma mark - Found
- (void)foundCollectionReusableHeaderView:(UIView *)headerView didCilckImageindex:(NSInteger)imageIndex
{
    NSLog(@"点击的是%ld",imageIndex);
}

- (void)searchBarItemAction:(UIButton *)sender
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 
 CGFloat detailInfoLabelX=CGRectGetMidX(questImageView.frame);
 CGFloat detailInfoLabelW=detailInfoView.width-detailInfoLabelX*2;
 UILabel * detailInfoLabel=[[UILabel alloc] init];
 detailInfoLabel.numberOfLines=0;
 detailInfoLabel.text=@"啦啦啦啦啦啦啦啦啦啦啦啦啦啦啊啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啊啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啊啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦";
 detailInfoLabel.textColor=RGB(102, 102, 102, 1);
 detailInfoLabel.font=[UIFont systemFontOfSize:myScalFont(20)];
 CGSize detailSize=[detailInfoLabel.text sizeWithFont:detailInfoLabel.font constrainedToSize:CGSizeMake(detailInfoLabelW, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
 detailInfoLabel.x=detailInfoLabelX;
 detailInfoLabel.y=0;
 detailInfoLabel.width=detailSize.width;
 detailInfoLabel.height=detailSize.height;
 
 #pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
