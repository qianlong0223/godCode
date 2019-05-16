//
//  JLActivityVC.m
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/25.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLActivityVC.h"
#import "JLActivityCell.h"
#import "JLActivityDetailVC.h"
@interface JLActivityVC ()<UITableViewDelegate,UITableViewDataSource,JLDataHandlerProtocol>
@property (nonatomic,strong)UITableView *tableViewOne;
@property (nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation JLActivityVC
{
    NSString * _source;
    NSInteger  _page;
    NSString * _totalPage;
    
}
-(void)requestActivityListData{
    if (_page == 1) {
        [_dataArray removeAllObjects];
    }
    NSString * schoolId = [[NSUserDefaults standardUserDefaults]objectForKey:@"schoolId"];
    [[[JLActivityAPI getActivityListWithSource:_source SchoolId:schoolId Page:[NSString stringWithFormat:@"%ld",_page]] netWorkClient] getRequestInView:self.view networkCodeTypeSuccessDataHandler:self isCache:NO];
    
}
-(void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject{
    [self.tableViewOne.mj_header endRefreshing];
    [self.tableViewOne.mj_footer endRefreshing];
    if ([responseObject isKindOfClass:[JLActivityAPI class]]) {
        JLActivityAPI *api = responseObject;
        _totalPage = api.totalPage;
        [_dataArray addObjectsFromArray:api.list];
        [_tableViewOne reloadData];
    }
    
}

-(void)netWorkCodeFailureDealWithResponseObject:(id)responseObject{
    CLog(@"%@",responseObject);
    [self.tableViewOne.mj_header endRefreshing];
    [self.tableViewOne.mj_footer endRefreshing];
}
/**
 上下拉刷新
 */
- (void)setupRefresh {
    
    //下拉刷新 在开始刷新后会调用此block
    self.tableViewOne.mj_header = [JLRefreshGifHeader headerWithRefreshingBlock:^{
        _page = 1;
        //网络请求数据
        [self requestActivityListData];
        
    }];
    
    self.tableViewOne.mj_footer = [JLRefreshGifFoot footerWithRefreshingBlock:^{
        _page = _page +1;
        [self requestActivityListData];
        if ([[NSString stringWithFormat:@"%ld",_page] isEqualToString:_totalPage]) {
            [self.tableViewOne.mj_footer endRefreshingWithNoMoreData];
        }
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _dataArray = [NSMutableArray array];
    _source = @"2";
    _page = 1;
    self.navigationItem.title = @"活动中心";
    [self.twoBtn setImage:[UIImage imageNamed:@"未选中校外活动"] forState:UIControlStateNormal];
    [self.oneBtn setImage:[UIImage imageNamed:@"选中校内活动"] forState:UIControlStateNormal];
//    [self.oneBtn setBackgroundImage:[UIImage imageNamed:@"校内活动"] forState:UIControlStateNormal];
//    [self.twoBtn setBackgroundImage:[UIImage imageNamed:@"校外活动"] forState:UIControlStateNormal];
    if (kiPhone5) {
        _tableViewOne = [[UITableView alloc] initWithFrame:CGRectMake(0,self.oneBtn.bottom + 20, ScreenWidth, self.view.height-TabbarHeight-TopHeight-30) style:UITableViewStylePlain];
    }else{
        _tableViewOne = [[UITableView alloc] initWithFrame:CGRectMake(0,self.oneBtn.bottom + 20, ScreenWidth, self.view.height-TabbarHeight) style:UITableViewStylePlain];
    }
    _tableViewOne.enablePlaceHolderView = YES;
    _tableViewOne.delegate = self;
    _tableViewOne.dataSource = self;
    _tableViewOne.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableViewOne.backgroundColor = [UIColor whiteColor];
//    _tableViewOne.contentInset = UIEdgeInsetsMake(0, 0, self.oneBtn.bottom + 20, 0);
    [self.view addSubview:_tableViewOne];
    [self setupRefresh];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 240;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * JGFirstOneCellId = @"JLActivityCell";
    JLActivityCell * cell = [tableView dequeueReusableCellWithIdentifier:JGFirstOneCellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:JGFirstOneCellId owner:nil options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ViewRadius(cell.marginLabel, 2.f);
    ViewRadius(cell.state, 6.f);
    ViewRadius(cell.schoolImage, 15.f);
    JLViewBorderRadius(cell.activityImage, 10.f, 3, [UIColor groupTableViewBackgroundColor]);
    NSString * image = [NSString stringWithFormat:@"%@%@",BaseUrl,_dataArray[indexPath.row][@"image"]];
    NSDictionary * senderDic = _dataArray[indexPath.row][@"sender"];
    NSString * userimage = [NSString stringWithFormat:@"%@%@",BaseUrl,senderDic[@"headImage"]];
    NSString * sendtime = [NSString convertToDate:[NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"sendTime"]]];
    NSString * state = [NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"status"]];
    [cell.activityImage sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"123"]];
    [cell.schoolImage sd_setImageWithURL:[NSURL URLWithString:userimage] placeholderImage:[UIImage imageNamed:@"123"]];
    cell.activityTitle.text = _dataArray[indexPath.row][@"title"];
    cell.activityTime.text = sendtime;
    cell.schoolName.text = senderDic[@"name"];
    if ([state isEqualToString:@"1"]) {
        cell.state.text = @"未开始";
        cell.state.backgroundColor = [UIColor purpleColor];
        
    }
    if ([state isEqualToString:@"2"]) {
        cell.state.text = @"进行中";
        cell.state.backgroundColor = UIColorFromRGB(0Xd3aa50);

    }
    if ([state isEqualToString:@"3"]) {
        cell.state.text = @"已结束";
        cell.state.textColor = [UIColor grayColor];
        cell.state.backgroundColor = [UIColor groupTableViewBackgroundColor];

    }
    
    cell.activityImage.layer.shadowColor = [UIColor blueColor].CGColor;//阴影颜色
    cell.activityImage.layer.shadowOffset = CGSizeMake(0,0);//偏移距离
    cell.activityImage.layer.shadowOpacity = 0.5;//不透明度
    cell.activityImage.layer.shadowRadius = 12.f;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * activityId = [NSString stringWithFormat:@"%@",_dataArray[indexPath.item][@"activityId"]];
    JLActivityDetailVC * vc = [[JLActivityDetailVC alloc]init];
    vc.activityId = activityId;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)oneBtnClicked:(UIButton *)sender {
    _source = @"2";
    _page = 1;
//    self.title = @"校内活动";
    [self.twoBtn setImage:[UIImage imageNamed:@"未选中校外活动"] forState:UIControlStateNormal];
    [self.oneBtn setImage:[UIImage imageNamed:@"选中校内活动"] forState:UIControlStateNormal];
    [self requestActivityListData];
}

- (IBAction)twoBtnClicked:(UIButton *)sender {
    _source = @"1";
    _page = 1;
//    self.title = @"校外活动";
    [self.twoBtn setImage:[UIImage imageNamed:@"校外活动"] forState:UIControlStateNormal];
    [self.oneBtn setImage:[UIImage imageNamed:@"校内活动"] forState:UIControlStateNormal];
    [self requestActivityListData];
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
