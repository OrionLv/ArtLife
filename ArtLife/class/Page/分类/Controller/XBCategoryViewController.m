//
//  XBCategoryViewController.m
//  ArtLife
//
//  Created by lxb on 2017/2/17.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import "XBCategoryViewController.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "GobelDefine.h"
#import "SVProgressHUD.h"
#import "XBLoadingView.h"
#import "XBReadcarousel.h"
#import "XBRefreshHeader.h"
#import "XBReadListModel.h"
#import "XBReadPhotoView.h"
#import "SDCycleScrollView.h"
#import "XBWebViewController.h"
#import "XBNewReadPageController.h"
#import "AFOwnerHTTPSessionManager.h"


@interface XBCategoryViewController ()<SDCycleScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


/**等待页面*/
@property (nonatomic, strong) XBLoadingView *waitView;

/**顶部滚动视图*/
@property (nonatomic, strong) SDCycleScrollView *SDscrollView;

/**顶部滚动图片数据模型数组*/
@property (nonatomic, strong) NSArray *cacheImages;

/**书本的模型数组*/
@property (nonatomic, strong) NSArray *ReadListArray;

/**底部写作的按钮*/
@property (nonatomic, strong) UIButton *bottonButton;

/**collectionView*/
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation XBCategoryViewController

#pragma mark - 懒加载
- (NSArray *)cacheImages
{
    if (!_cacheImages) {
        _cacheImages = [NSArray array];
    }
    return _cacheImages;
}

- (NSArray *)ReadListArray
{
    if (!_ReadListArray) {
        _ReadListArray = [NSArray array];
    }
    return _ReadListArray;
}

- (UIButton *)bottomButton
{
    
    if (!_bottonButton) {
        _bottonButton = [[UIButton alloc] init];
        [_bottonButton setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
        _bottonButton.contentMode = UIViewContentModeScaleAspectFill;
        _bottonButton.adjustsImageWhenHighlighted = NO;
    }
    return _bottonButton;
}

-(UICollectionView *)collectionView
{
    if(!_collectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"item"];
        //设置下拉刷新控件
        _collectionView.mj_header = [XBRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    }
    return _collectionView;
}

#pragma mark - load Method
-(void)viewDidLoad{
    
    [self setupSubViews];
}
//页面即将出现的时候不重新加载数据

#pragma mark - private Method
-(void)setupSubViews{
    
    //设置背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加等待动画
    self.waitView = [[XBLoadingView alloc] initWithFrame:self.view.frame];
    [self.waitView showLoadingTo:self.view];
    
//    //发送网络请求
//    [self setupUrlRequest];
    [self getData];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //设置导航控制器
    self.navigationItem.title = @"分类";
}

-(UIView *)setupTopView{
    // 设置顶部的轮播器
    SDCycleScrollView *scrollView = [[SDCycleScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, SCREENWIDTH, 180);
    scrollView.delegate = self;
    self.SDscrollView = scrollView;
    
    //设置分页位置
    self.SDscrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    //设置时间间隔
    self.SDscrollView.autoScrollTimeInterval = 3.0;
    //设置当前分页圆点的颜色
    self.SDscrollView.currentPageDotColor = [UIColor whiteColor];
    //设置其他分页圆点颜色
    self.SDscrollView.pageDotColor = [UIColor lightGrayColor];
    //设置动画样式
    self.SDscrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    
    self.SDscrollView.backgroundColor = [UIColor lightGrayColor];
    
 
    
    return self.SDscrollView;
}

-(void)loadData{
    
    [self getData];
    [self.collectionView.mj_header endRefreshing];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return  self.ReadListArray.count + 1;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    if(indexPath.row == 0){
        
        cell.backgroundView = [self setupTopView];
        
        //给轮播器设置数据
        NSArray *imgs = @[@"http://lorempixel.com/400/200/sports/6/", @"http://lorempixel.com/400/200/sports/1/"];
        self.SDscrollView.imageURLStringsGroup = imgs;
        
    }else{
        XBReadPhotoView *photoView = [[XBReadPhotoView alloc] init];
        photoView.backgroundColor = [UIColor orangeColor];
        photoView.coverImageView.image = [UIImage imageNamed:self.ReadListArray[indexPath.row - 1]];
//        photoView.model = self.ReadListArray[indexPath.row - 1];
        cell.backgroundView = photoView;
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return CGSizeMake(SCREENWIDTH, 180);
    }else{
        return CGSizeMake(SCREENWIDTH / 3 - 5, SCREENWIDTH / 3 - 5);
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.row > 0){
        
        XBNewReadPageController *secondVC = [[XBNewReadPageController alloc] init];
//        XBReadListModel *model = self.ReadListArray[indexPath.row - 1];
//        secondVC.typeID = [NSString stringWithFormat:@"%ld", model.type];
        [self.navigationController pushViewController:secondVC animated:YES];
    }
}

#pragma mark - loadRequest method
//
//-(void)setupUrlRequest{
//    
//    [[AFOwnerHTTPSessionManager manager] getURL:@"http://api2.pianke.me/read/columns" Parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@", responseObject);
//        
//        NSDictionary *dataDic = responseObject[@"data"];
//        
//        [self.waitView dismiss];
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//        [SVProgressHUD showErrorWithStatus:@"网络不给力"];
//        [self.waitView dismiss];
//    }];
//}

-(void)getData{
    //顶部滚动视图数据模型
    self.cacheImages = @[@"img_00", @"img_01"];
    
    //书本的数据模型
    self.ReadListArray = @[@"img_02.jpg", @"img_03", @"img_04.jpg", @"img_05.jpg", @"img_06.jpg", @"img_07.jpeg", @"img_08.jpeg", @"img_09.jpeg", @"img_10"];
    
    //创建collectionView
    [self.view addSubview:self.collectionView];
    
    
    //刷新数据
    [self.collectionView reloadData];

}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    XBReadcarousel *model = self.cacheImages[index];
    XBWebViewController *webVC = [[XBWebViewController alloc] init];
    webVC.url = model.url;
    
    [self.navigationController pushViewController:webVC animated:YES];
}

@end
