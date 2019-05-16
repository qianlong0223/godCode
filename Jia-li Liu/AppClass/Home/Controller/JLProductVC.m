//
//  JLProductVC.m
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/24.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLProductVC.h"
#import "ProductCell.h"
#import "JLProductDetailVC.h"
#import "JLProListModel.h"
@interface JLProductVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,JLDataHandlerProtocol>
{
    UICollectionView *mainCollectionView;
    NSMutableArray * _dataArray;
    NSString * _source;
    NSInteger _page;
    NSString * _praise;
    NSString * _totalPage;
    
}
@end

@implementation JLProductVC
-(void)requestProListData{
    if (_page == 1) {
        [_dataArray removeAllObjects];
    }
    NSString * schoolId = [[NSUserDefaults standardUserDefaults]objectForKey:@"schoolId"];
    [[[JLProListAPI getProListWithSource:_source SchoolId:schoolId Page:[NSString stringWithFormat:@"%ld",_page]] netWorkClient] getRequestInView:self.view networkCodeTypeSuccessDataHandler:self isCache:NO];
    
    
    
}
-(void)requstPraiseWithIndex:(NSInteger)index PaintingId:(NSString *)paintingId{
    NSString * schoolId = [[NSUserDefaults standardUserDefaults]objectForKey:@"schoolId"];
//    [[[JLPraiseAPl getProListWithPaintingId:paintingId SchoolId:schoolId] netWorkClient] getRequestInView:self.view networkCodeTypeSuccessDataHandler:self isCache:NO];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    [parameter setObject:schoolId forKey:@"schoolId"];
    [parameter setObject:paintingId forKey:@"paintingId"];
    [manager POST:[NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/zuopin/click"] parameters:parameter progress:nil success:
     ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
         NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功---%@---%@--%@",responseObject,[responseObject class],dic);
         if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
             NSInteger  state = [[dic objectForKey:@"state"] integerValue];
             NSMutableDictionary * dd = [NSMutableDictionary dictionaryWithDictionary:_dataArray[index]];
             NSInteger  num = [[dd objectForKey:@"praiseNum"] integerValue];
             [dd setObject:[NSString stringWithFormat:@"%ld",state] forKey:@"myPraise"];
             if (state == 1) {
                 [dd setObject:[NSString stringWithFormat:@"%ld",num-1] forKey:@"praiseNum"];
             }else{
                 [dd setObject:[NSString stringWithFormat:@"%ld",num+1] forKey:@"praiseNum"];
             }
             [_dataArray replaceObjectAtIndex:index withObject:dd];
             [mainCollectionView reloadData];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         NSLog(@"请求失败--%@",error);
     }];
    
}
-(void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject{
    [mainCollectionView.mj_header endRefreshing];
    [mainCollectionView.mj_footer endRefreshing];
    if ([responseObject isKindOfClass:[JLProListAPI class]]) {
        JLProListAPI *api = responseObject;
        _totalPage = api.totalPage;
        [_dataArray addObjectsFromArray:api.list];
        [mainCollectionView reloadData];
    }
   
}

-(void)netWorkCodeFailureDealWithResponseObject:(id)responseObject{
    CLog(@"%@",responseObject);
    [mainCollectionView.mj_header endRefreshing];
    [mainCollectionView.mj_footer endRefreshing];
}
/**
 上下拉刷新
 */
- (void)setupRefresh {
    
    //下拉刷新 在开始刷新后会调用此block
    mainCollectionView.mj_header = [JLRefreshGifHeader headerWithRefreshingBlock:^{
        _page = 1;
        //网络请求数据
        [self requestProListData];
        
    }];
    
    mainCollectionView.mj_footer = [JLRefreshGifFoot footerWithRefreshingBlock:^{
        _page = _page + 1;
        [self requestProListData];
        if ([[NSString stringWithFormat:@"%ld",_page] isEqualToString:_totalPage]) {
            [mainCollectionView.mj_footer endRefreshingWithNoMoreData];
        }
        
    }];
    
}
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self setupRefresh];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    _source = @"2";
    _page = 1;
    self.navigationItem.title = @"作品中心";
    _dataArray = [[NSMutableArray alloc]init];
    [self.twoBtn setImage:[UIImage imageNamed:@"未选中校外作品"] forState:UIControlStateNormal];
    [self.oneBtn setImage:[UIImage imageNamed:@"选中校内作品"] forState:UIControlStateNormal];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    //    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //设置headerView的尺寸大小
//    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 100);
    //该方法也可以设置itemSize
    layout.itemSize =CGSizeMake((ScreenWidth-50)/2, (ScreenWidth-50)/2*4/3.7);
    
    //2.初始化collectionView
    mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, self.oneBtn.bottom+20, ScreenWidth-20, ScreenHeight-self.oneBtn.y-self.oneBtn.height-20-TabbarHeight) collectionViewLayout:layout];
    [self.view addSubview:mainCollectionView];
    mainCollectionView.backgroundColor = [UIColor whiteColor];
    mainCollectionView.enablePlaceHolderView = YES;
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [mainCollectionView registerClass:[ProductCell class] forCellWithReuseIdentifier:@"cellId"];
    
    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
//    [mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    
    //4.设置代理
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
    [self setupRefresh];
}
#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProductCell *cell = (ProductCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    if (_dataArray.count) {
         cell.dic = _dataArray[indexPath.item];
    }
    NSString * paintingId = _dataArray[indexPath.item][@"paintingId"];
    [cell setZanBtnBlcok:^{
        [self requstPraiseWithIndex:indexPath.row PaintingId:paintingId];
        
    }];
    ViewRadius(cell, 5.f);
    ViewRadius(cell.imageView, 5.f);
//    cell.backgroundColor = [UIColor clearColor];
    
   
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth-50)/2, (ScreenWidth-50)/2*4/3.7);
}

//footer的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return CGSizeMake(10, 10);
//}

//header的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(10, 10);
//}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}


////通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
//    headerView.backgroundColor =[UIColor grayColor];
//    UILabel *label = [[UILabel alloc] initWithFrame:headerView.bounds];
//    label.text = @"这是collectionView的头部";
//    label.font = [UIFont systemFontOfSize:20];
//    [headerView addSubview:label];
//    return headerView;
//}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCell *cell = (ProductCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSString *msg = cell.name.text;
    NSLog(@"%@",msg);
    NSString * paintingId = [NSString stringWithFormat:@"%@",_dataArray[indexPath.item][@"paintingId"]];
    JLProductDetailVC * vc = [[JLProductDetailVC alloc]init];
    vc.paintId = paintingId;
    [vc setZanBlock:^(NSString * pr) {
        NSInteger  state = [pr integerValue];
        NSMutableDictionary * dd = [NSMutableDictionary dictionaryWithDictionary:_dataArray[indexPath.row]];
        NSInteger  num = [[dd objectForKey:@"praiseNum"] integerValue];
        [dd setObject:[NSString stringWithFormat:@"%ld",state] forKey:@"myPraise"];
        if (state == 1) {
            [dd setObject:[NSString stringWithFormat:@"%ld",num-1] forKey:@"praiseNum"];
        }if (state == 2){
            [dd setObject:[NSString stringWithFormat:@"%ld",num+1] forKey:@"praiseNum"];
        }
        [_dataArray replaceObjectAtIndex:indexPath.row withObject:dd];
        [mainCollectionView reloadData];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)oneBtnClicked:(UIButton *)sender {
    _source = @"2";
    _page = 1;
//    self.title = @"校内作品";
    [self.twoBtn setImage:[UIImage imageNamed:@"未选中校外作品"] forState:UIControlStateNormal];
    [self.oneBtn setImage:[UIImage imageNamed:@"选中校内作品"] forState:UIControlStateNormal];
    [self requestProListData];
}
- (IBAction)twoBtnClicked:(UIButton *)sender {
    _source = @"1";
    _page = 1;
//    self.title = @"校外作品";
    [self.twoBtn setImage:[UIImage imageNamed:@"校外作品"] forState:UIControlStateNormal];
    [self.oneBtn setImage:[UIImage imageNamed:@"校内作品"] forState:UIControlStateNormal];
    [self requestProListData];
}



@end
