//
//  JLMineMessageVC.m
//  Jia-li Liu
//
//  Created by jdlx on 2019/1/2.
//  Copyright © 2019 KLIANS. All rights reserved.
//

#import "JLMineMessageVC.h"
#import "JLMineMessageCell.h"
#import "JLMessageHeadView.h"
#import "JLMessageDetailVC.h"
@interface JLMineMessageVC ()<JLDataHandlerProtocol>
@property (nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation JLMineMessageVC
{
    NSInteger  _page;
    NSString * _totalPage;
    
}
-(void)requestMessageListData{
    if (_page == 1) {
        [_dataArray removeAllObjects];
    }
    NSString * schoolId = [[NSUserDefaults standardUserDefaults]objectForKey:@"schoolId"];
    [[[JLMessageListAPI getMessageListWithSchoolId:schoolId Page:[NSString stringWithFormat:@"%ld",_page]] netWorkClient] getRequestInView:self.view networkCodeTypeSuccessDataHandler:self isCache:NO];
    
    
}
-(void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject{
    [self.tableview.mj_header endRefreshing];
    [self.tableview.mj_footer endRefreshing];
    if ([responseObject isKindOfClass:[JLMessageListAPI class]]) {
        JLMessageListAPI *api = responseObject;
        _totalPage = api.totalPage;
        [_dataArray addObjectsFromArray:api.list];
        [_tableview reloadData];
    }
    
}

-(void)netWorkCodeFailureDealWithResponseObject:(id)responseObject{
    CLog(@"%@",responseObject);
    [self.tableview.mj_header endRefreshing];
    [self.tableview.mj_footer endRefreshing];
}
/**
 上下拉刷新
 */
- (void)setupRefresh {
    
    //下拉刷新 在开始刷新后会调用此block
    self.tableview.mj_header = [JLRefreshGifHeader headerWithRefreshingBlock:^{
        //网络请求数据
        [self requestMessageListData];
        
    }];
    
    self.tableview.mj_footer = [JLRefreshGifFoot footerWithRefreshingBlock:^{
        _page = _page +1;
        [self requestMessageListData];
        if ([[NSString stringWithFormat:@"%ld",_page] isEqualToString:_totalPage]) {
            [self.tableview.mj_footer endRefreshingWithNoMoreData];
        }
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"消息";
    _dataArray = [NSMutableArray array];
    _page = 1;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setupRefresh];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}
// 返回组头部view的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]init];
    return view;
}
//返回组头部view方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString * date = [NSString convertToDateTimer:_dataArray[section][@"sendTime"]];
    JLMessageHeadView *headerFooter = [JLMessageHeadView headerFooterViewWithTabelView:tableView];
    headerFooter.title = date;
    return headerFooter;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"JLMineMessageCell";
    JLMineMessageCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:cellid owner:nil options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    JLViewBorderRadius(cell.bgView, 10.f, 3, [UIColor groupTableViewBackgroundColor]);
    ViewRadius(cell.isReadLabel, 4);
    cell.bgView.layer.shadowColor = [UIColor grayColor].CGColor;//阴影颜色
    cell.bgView.layer.shadowOffset = CGSizeMake(5,0);//偏移距离
    cell.bgView.layer.shadowOpacity = 0.5;//不透明度
    cell.bgView.layer.shadowRadius = 12.f;
    cell.messageTitle.text = [NSString stringWithFormat:@"%@",_dataArray[indexPath.section][@"title"]];
    cell.messageContent.text = [NSString stringWithFormat:@"%@",_dataArray[indexPath.section][@"jianjie"]];
    NSString * isread = [NSString stringWithFormat:@"%@",_dataArray[indexPath.section][@"read"]];
    if ([isread isEqualToString:@"1"]) {
        cell.isReadLabel.hidden = NO;
    }else{
        cell.isReadLabel.hidden = YES;;
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
        JLMessageDetailVC * vc = [[JLMessageDetailVC alloc]init];
        vc.messageDic = _dataArray[indexPath.section];
        [self.navigationController pushViewController:vc animated:YES];
}
@end
