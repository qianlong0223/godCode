//
//  MidVC.m
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/20.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "MidVC.h"
#import "HW3DBannerView.h"
#import "HotWorkCell.h"
#import "BSHeaderFooterView.h"
#import "ActivityCell.h"
#import "LXFloaintButton.h"
#import "JLPublishVC.h"
#import "JLActivityDetailVC.h"
#import "JLProductDetailVC.h"
#import "JLSquareDeatailVC.h"
@interface MidVC ()<JLDataHandlerProtocol>
@property (nonatomic,strong) HW3DBannerView *scrollView1;
@property(nonatomic,strong)LXFloaintButton *button;
@property(nonatomic,strong)NSMutableArray *bannerArr;
@property(nonatomic,strong)NSMutableArray *bannerData;
@property(nonatomic,strong)NSMutableArray *bannerIdArr;
@property(nonatomic,strong)NSMutableArray *hotProArr;
@property(nonatomic,strong)NSMutableArray *activityArr;
@end

@implementation MidVC

- (void)viewDidLoad {
    [super viewDidLoad];
    LXFloaintButton *button = [LXFloaintButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"发布2"] forState:UIControlStateNormal];
    ViewRadius(button, button.width/2);
    [button addTarget:self action:@selector(publishBtnClick) forControlEvents:UIControlEventTouchUpInside];
    button.safeInsets = UIEdgeInsetsMake(0, 0, ELSareArea, 0);
    [kWindow addSubview:button];
    button.parentView = kWindow;
     button.frame = CGRectMake(ScreenWidth-60, ScreenHeight-TabbarHeight-60, 80, 80);
//    button.sd_layout.rightSpaceToView(self, 0).bottomSpaceToView(self, TabbarHeight).widthIs(60).heightIs(60);
    self.button  = button;
    
    //初始化数据
    [self setData];
    [self getBageInfo];
    [self requestBannerData];
    
    
}
-(void)requestActivityRecommend{
    [[[JLMidActivityAPI getMidActivityRecommend] netWorkClient] getRequestInView:self.view networkCodeTypeSuccessDataHandler:self isCache:NO];
}
-(void)requestHotProcduct{
    [[[JLMidHotProcutAPI getMidHotProduct] netWorkClient] getRequestInView:self.view networkCodeTypeSuccessDataHandler:self isCache:NO];
}
-(void)requestBannerData{
    NSString * schoolId = [[NSUserDefaults standardUserDefaults]objectForKey:@"schoolId"];
    [[[JLMidAPI getMidHomeBannerWithSchoolId:schoolId] netWorkClient] getRequestInView:self.view networkCodeTypeSuccessDataHandler:self isCache:NO];
    
}

-(void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject{
    if ([responseObject isKindOfClass:[JLMidAPI class]]) {
        JLMidAPI *api = responseObject;
        _bannerData = [NSMutableArray arrayWithArray:api.data];
        for (NSDictionary * imageDic in api.data) {
            NSString * iamgeUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,imageDic[@"image"]];
            [_bannerArr addObject:iamgeUrl];
        }
        //初始化UI
        [self setUIWithBannerArr:api.data];
        [self requestHotProcduct];
    }
    if ([responseObject isKindOfClass:[JLMidHotProcutAPI class]]) {
        JLMidHotProcutAPI *api = responseObject;
        _hotProArr = [NSMutableArray arrayWithArray:api.data];
        
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
        [_tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        [self requestActivityRecommend];
    }
    if ([responseObject isKindOfClass:[JLMidActivityAPI class]]) {
        JLMidActivityAPI *api = responseObject;
        _activityArr = [NSMutableArray arrayWithArray:api.data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableview reloadData];
        });
    }
    [JLProgressHUD hide];
}

-(void)netWorkCodeFailureDealWithResponseObject:(id)responseObject{
    CLog(@"%@",responseObject);
    
}
-(void)publishBtnClick{
    JLPublishVC *plusVC = [[JLPublishVC alloc] init];
    JTNavigationController *navVc = [[JTNavigationController alloc] initWithRootViewController:plusVC];
    
    [self presentViewController:navVc animated:YES completion:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

/**
 初始化UI
 */
- (void)setUIWithBannerArr:(NSArray *)bannerArr{
    self.navigationItem.title = @"首页";
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 220*MYWIDTH)];
    UIView * radioView = [[UIView alloc]initWithFrame:CGRectMake(10, 5, headView.width-20, headView.height-40)];
    ViewRadius(radioView, 12.f);
    [headView addSubview:radioView];
    UILabel * marginLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, radioView.bottom + 20, radioView.width, 8)];
    marginLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    ViewRadius(marginLabel, 2.f);
    [headView addSubview:marginLabel];
    _scrollView1 = [HW3DBannerView initWithFrame:CGRectMake(0, 0, radioView.width, radioView.height) imageSpacing:0 imageWidth:ScreenWidth];
    
    JLWeakSelf(self)
    _scrollView1.clickImageBlock = ^(NSInteger currentIndex) {
        JLStrongSelf(self)
        NSDictionary * dic = self.bannerData[currentIndex];
        if ([dic[@"type"] isEqualToString:@"1"]) {//活动
            JLActivityDetailVC * vc = [[JLActivityDetailVC alloc]init];
            vc.activityId = [NSString stringWithFormat:@"%@",dic[@"data"]];
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([dic[@"type"] isEqualToString:@"2"]){//作品
            JLProductDetailVC * vc = [[JLProductDetailVC alloc]init];
            vc.paintId = [NSString stringWithFormat:@"%@",dic[@"data"]];
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([dic[@"type"] isEqualToString:@"3"]){//拓展
            JLSquareDeatailVC * vc = [[JLSquareDeatailVC alloc]init];
            vc.titlename = @"拓展详情";
            vc.mid = [NSString stringWithFormat:@"%@",dic[@"data"]];
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([dic[@"type"] isEqualToString:@"4"]){//作业
            JLSquareDeatailVC * vc = [[JLSquareDeatailVC alloc]init];
            vc.titlename = @"作业详情";
            vc.mid = [NSString stringWithFormat:@"%@",dic[@"data"]];
            [self.navigationController pushViewController:vc animated:YES];
        }else{//外链
            
        }
    };
    _scrollView1.placeHolderImage = [UIImage imageNamed:@"123"]; // 设置占位图片
    self.scrollView1.data = _bannerArr;
    [radioView addSubview:self.scrollView1];
    self.tableview.tableHeaderView = headView;
    
}

/**
 初始化数据
 */
- (void)setData{
    _bannerArr = [[NSMutableArray alloc]init];
    _bannerData = [[NSMutableArray alloc]init];
    _bannerIdArr = [[NSMutableArray alloc]init];
    _hotProArr  = [[NSMutableArray alloc]init];
    _activityArr  = [[NSMutableArray alloc]init];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        
        return _activityArr.count;
    }
}
// 返回组头部view的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 30*MYWIDTH;
    }else{
       return 0.01;
    }
}
//返回组头部view方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        BSHeaderFooterView *headerFooter = [BSHeaderFooterView headerFooterViewWithTabelView:tableView];
        
        return headerFooter;
    }else{
        return nil;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    CGFloat imW = ScreenWidth-260*MYWIDTH;
    if (indexPath.section == 0) {
        return 220;
    }else{
         return 230;
    }
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HotWorkCell *cell = [HotWorkCell cellWithTableView:tableView WithData:_hotProArr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString * JGFirstOneCellId = @"ActivityCell";
        ActivityCell * cell = [tableView dequeueReusableCellWithIdentifier:JGFirstOneCellId];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:JGFirstOneCellId owner:nil options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ViewRadius(cell.marginLabel, 2.f);
        ViewRadius(cell.userImage, 15.f);
        JLViewBorderRadius(cell.acImage, 10.f, 3, [UIColor groupTableViewBackgroundColor]);
        cell.acImage.layer.shadowColor = [UIColor blueColor].CGColor;//阴影颜色
        cell.acImage.layer.shadowOffset = CGSizeMake(0,0);//偏移距离
        cell.acImage.layer.shadowOpacity = 0.5;//不透明度
        cell.acImage.layer.shadowRadius = 12.f;
        cell.activityName.text = _activityArr[indexPath.row][@"title"];
        [cell.acImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,_activityArr[indexPath.row][@"image"]]] placeholderImage:[UIImage imageNamed:@"123"]];
        [cell.userImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,_activityArr[indexPath.row][@"sender"][@"headImage"]]] placeholderImage:[UIImage imageNamed:@"123"]];
        cell.schoolName.text = _activityArr[indexPath.row][@"sender"][@"name"];
        return cell;
    }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
    }else{
        JLActivityDetailVC * vc = [[JLActivityDetailVC alloc]init];
        vc.activityId = _activityArr[indexPath.row][@"activityId"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - ################################ 访问器方法 ################################

@end
