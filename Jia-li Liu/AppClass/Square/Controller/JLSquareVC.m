//
//  JLSquareVC.m
//  Jia-li Liu
//
//  Created by KLIANS on 2017/4/19.
//  Copyright © 2017年 KLIANS. All rights reserved.
//

#import "JLSquareVC.h"
#import "JGFirstOneTableView.h"
#include "JGFirstTwoTableView.h"
@interface JLSquareVC ()<UIScrollViewDelegate,JLDataHandlerProtocol>

@property (nonatomic, strong) UISegmentedControl *segmentCtrl;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic,strong)JGFirstOneTableView *tableViewOne;
@property (nonatomic,strong)JGFirstTwoTableView *tableViewTwo;

@property (nonatomic,strong)NSMutableArray * expandArr;
@property (nonatomic,strong)NSMutableArray * homeworkArr;
@end

@implementation JLSquareVC
{
    NSInteger  _page;
    NSString * _totalPage;
}
#pragma mark - ################################# 生命周期 #################################

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _expandArr = [[NSMutableArray alloc]init];
    _homeworkArr = [[NSMutableArray alloc]init];
    _page = 1;
    
    [self settingScrollView];
    [self settingSegment];
    [self setupRefreshExpand];
    [self setupRefreshHomeword];

}

/**
 上下拉刷新
 */
- (void)setupRefreshExpand {
    
    //下拉刷新 在开始刷新后会调用此block
    self.tableViewOne.mj_header = [JLRefreshGifHeader headerWithRefreshingBlock:^{
        _page = 1;
        //网络请求数据
        [self requestExpandListData];
        
    }];
    
    self.tableViewOne.mj_footer = [JLRefreshGifFoot footerWithRefreshingBlock:^{
        _page = _page +1;
        [self requestExpandListData];
        if ([[NSString stringWithFormat:@"%ld",_page] isEqualToString:_totalPage]) {
            [self.tableViewOne.mj_footer endRefreshingWithNoMoreData];
        }
        
    }];
    
}
- (void)setupRefreshHomeword {
    
    //下拉刷新 在开始刷新后会调用此block
    self.tableViewTwo.mj_header = [JLRefreshGifHeader headerWithRefreshingBlock:^{
        _page = 1;
        //网络请求数据
        [self requestHomeWorkListData];
        
    }];
    
    self.tableViewTwo.mj_footer = [JLRefreshGifFoot footerWithRefreshingBlock:^{
        _page = _page +1;
        [self requestHomeWorkListData];
        if ([[NSString stringWithFormat:@"%ld",_page] isEqualToString:_totalPage]) {
            [self.tableViewTwo.mj_footer endRefreshingWithNoMoreData];
        }
        
    }];
    
}
-(void)requestExpandListData{
    if (_page == 1) {
        [_expandArr removeAllObjects];
    }
    [[[JLExpandAPI getExpandListWithBanji_id:[[NSUserDefaults standardUserDefaults]objectForKey:@"classId"] Page:[NSString stringWithFormat:@"%ld",_page]] netWorkClient] getRequestInView:self.view networkCodeTypeSuccessDataHandler:self isCache:NO];
    
}
-(void)requestHomeWorkListData{
    if (_page == 1) {
        [_homeworkArr removeAllObjects];
    }
    NSString * banji_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"classId"];
    [[[JLHomeWorkAPI getHomeWorkListWithBanji_id:banji_id Page:[NSString stringWithFormat:@"%ld",_page]] netWorkClient] getRequestInView:self.view networkCodeTypeSuccessDataHandler:self isCache:NO];
    
}
-(void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject{
    if ([responseObject isKindOfClass:[JLExpandAPI class]]) {
        [self.tableViewOne.mj_header endRefreshing];
        [self.tableViewOne.mj_footer endRefreshing];
        JLExpandAPI *api = responseObject;
        [_expandArr addObjectsFromArray:api.list];
        if (_expandArr.count) {
            _tableViewOne.dataArr = _expandArr;
        }else{
            _tableViewOne.enablePlaceHolderView = YES;
        }
    }
    if ([responseObject isKindOfClass:[JLHomeWorkAPI class]]) {
        [self.tableViewTwo.mj_header endRefreshing];
        [self.tableViewTwo.mj_footer endRefreshing];
        JLHomeWorkAPI* api = responseObject;
        [_homeworkArr addObjectsFromArray:api.list];
        if (_homeworkArr.count) {
            _tableViewTwo.dataArr = _homeworkArr;
        }else{
            _tableViewTwo.enablePlaceHolderView = YES;

        }
    }
    
}

-(void)netWorkCodeFailureDealWithResponseObject:(id)responseObject{
    CLog(@"%@",responseObject);
    if ([responseObject isKindOfClass:[JLExpandAPI class]]) {
        [self.tableViewOne.mj_header endRefreshing];
        [self.tableViewOne.mj_footer endRefreshing];
    }
    if ([responseObject isKindOfClass:[JLHomeWorkAPI class]]) {
        [self.tableViewTwo.mj_header endRefreshing];
        [self.tableViewTwo.mj_footer endRefreshing];
    }
    
    
}
- (void)settingScrollView{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.directionalLockEnabled = YES;
    scrollView.contentInset = UIEdgeInsetsMake(-64, 0, -49, 0);
    scrollView.contentSize = CGSizeMake(2 *self.view.width, self.view.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:scrollView];
    
    _tableViewOne = [[JGFirstOneTableView alloc] initWithFrame:CGRectMake(0,64, self.view.width, self.view.height-TabbarHeight) style:UITableViewStyleGrouped];
//    _tableViewOne.enablePlaceHolderView = YES;
    _tableViewTwo = [[JGFirstTwoTableView alloc] initWithFrame:CGRectMake(self.view.width,64, self.view.width, self.view.height-TabbarHeight)style:UITableViewStyleGrouped];
//    _tableViewTwo.enablePlaceHolderView = YES;
    [scrollView addSubview:_tableViewOne];
    [scrollView addSubview:_tableViewTwo];
    
    _scrollView = scrollView;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.x;
    self.segmentCtrl.selectedSegmentIndex = offset/self.view.width;
//    if (self.segmentCtrl.selectedSegmentIndex == 1) {
//        [self setupRefreshHomeword];
//    }else{
//        [self setupRefreshExpand];
//    }
}

- (void)settingSegment{
    
    UISegmentedControl *segmentCtrl = [[UISegmentedControl alloc] initWithItems:@[@"拓展",@"作业"]];
    
    self.navigationItem.titleView = segmentCtrl;
    segmentCtrl.tintColor = UIColorFromRGB(0x5251F5);
    segmentCtrl.width = 120;
    segmentCtrl.selectedSegmentIndex = 0;
    
    [segmentCtrl addTarget:self action:@selector(segmentBtnClick) forControlEvents:UIControlEventValueChanged];
    _segmentCtrl = segmentCtrl;
    
    
}

- (void)segmentBtnClick{
    NSLog(@"改变========改变");
    self.scrollView.contentOffset = CGPointMake(self.segmentCtrl.selectedSegmentIndex * self.view.width, 64);
//    if (self.segmentCtrl.selectedSegmentIndex == 1) {
//        [self setupRefreshHomeword];
//    }else{
//        [self setupRefreshExpand];
//    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getBageInfo];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

#pragma mark - ################################# 网络请求 ################################

#pragma mark - ################################# 代理方法 ################################

#pragma mark - ################################# 事件处理 ################################

#pragma mark - ################################# 声明的成员方法和类方法 #####################

#pragma mark - ################################# 私有方法 ################################

/**
 初始化UI
 */
- (void)setUI{
    
}

/**
 初始化数据
 */
- (void)setData{
    
}

#pragma mark - ################################ 访问器方法 ################################

@end
