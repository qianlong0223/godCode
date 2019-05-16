//
//  JLMineVC.m
//  Jia-li Liu
//
//  Created by KLIANS on 2017/4/19.
//  Copyright © 2017年 KLIANS. All rights reserved.
//

#import "JLMineVC.h"
#import "UIImage+Image.h"
#import "MyProductionCell.h"
#import "JLMineMessageVC.h"
#import "JLSettingVC.h"
@interface JLMineVC ()<UITableViewDelegate,UITableViewDataSource,JLDataHandlerProtocol>

@property(nonatomic,strong)UITableView *mainTable;
@property (nonatomic,strong)UIImageView * beijingImage;
@property (nonatomic,strong)UIButton *icon;
@property (nonatomic,strong)UILabel *name;
@property (nonatomic,strong)UILabel *sclass;
@property (nonatomic,strong)UILabel *lineMargin;
@property(nonatomic,strong)UIBarButtonItem *setBtn;//第一个
@property(nonatomic,strong)UIBarButtonItem *messageBtn;//第二个

@property (nonatomic,strong)NSMutableArray * dataArr;

@end

@implementation JLMineVC
{
    NSString * _page;
    ImagePicker *imagePicker;
}
#pragma mark - ################################# 生命周期 #################################

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    //间隙
    UIBarButtonItem *fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceBarButtonItem.width = 5;
    self.navigationItem.rightBarButtonItems = @[self.messageBtn,fixedSpaceBarButtonItem,self.setBtn];

    
    //初始化数据
    [self setData];
    
}

/**
 初始化数据
 */
- (void)setData{
    //初始化
    imagePicker = [ImagePicker sharedManager];
    _page = @"1";
    _dataArr = [NSMutableArray array];
    //添加列表
    [self.view addSubview:self.mainTable];
    //添加头部背景
    [self.mainTable addSubview:self.beijingImage];
    _beijingImage.sd_layout.xIs(0).yIs(-ScreenWidth/ 2.2).widthIs(ScreenWidth).heightIs(ScreenWidth/2);
}
-(void)uploadImageInfoWithBaseImage:(NSString *)iamgeString{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    [parameter setObject:iamgeString forKey:@"headImage"];
    [manager POST:[NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/person/saveimg"] parameters:parameter progress:nil success:
     ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
         NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功---%@---%@--%@",responseObject,[responseObject class],dic);
         if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
             [StateView showSuccessInfo:[dic objectForKey:@"info"]];
             [[NSUserDefaults standardUserDefaults]setObject:[dic objectForKey:@"data"] forKey:@"headImage"];
             [self setUI];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

         NSLog(@"请求失败--%@",error);
     }];
 
}
-(void)getBageMessageInfo{
    NSString * banji_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"classId"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    [parameter setObject:banji_id forKey:@"banji_id"];
    
    [manager POST:[NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/news/noread"] parameters:parameter progress:nil success:
     ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
         NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
             NSDictionary * data = dic[@"data"];
//             NSString * expansionUnreadNum = [NSString stringWithFormat:@"%@",data[@"expansionUnreadNum"]];
//             NSString * homeworkUnreadNum = [NSString stringWithFormat:@"%@",data[@"homeworkUnreadNum"]];
             NSString * noticeUnreadNum = [NSString stringWithFormat:@"%@",data[@"noticeUnreadNum"]];
             NSLog(@"%@",noticeUnreadNum);
             if ([noticeUnreadNum integerValue]>0) {
                 _setBtn.badgeValue = noticeUnreadNum;
                 _setBtn.badgeBGColor = kRedColor;
             }else{
                 _setBtn.badgeValue = @"";
                 _setBtn.badgeBGColor = kRedColor;
             }
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         NSLog(@"请求失败--%@",error);
     }];
}
-(void)requestMineProListData{
    [_dataArr removeAllObjects];
    [[[JLMineProAPI getProListWithPage:_page] netWorkClient] getRequestInView:self.view networkCodeTypeSuccessDataHandler:self isCache:NO];
    
}
-(void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject{
    if ([responseObject isKindOfClass:[JLMineProAPI class]]) {
        JLMineProAPI *api = responseObject;
        [_dataArr addObjectsFromArray:api.list];
        [self.mainTable reloadData];
    }
}

-(void)netWorkCodeFailureDealWithResponseObject:(id)responseObject{
    [StateView showErrorInfo:@"解析失败"];
    CLog(@"%@",responseObject);
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //去掉导航栏底部的黑线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],
                                                                      NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:17]}];
    //初始化UI
    [self setUI];
    [self requestMineProListData];
    [self getBageMessageInfo];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 500;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyProductionCell *cell = [MyProductionCell cellWithTableView:tableView];
    cell.array = _dataArr;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    if (point.y < - ScreenWidth/ 2.2) {
        CGRect rect = [self.mainTable viewWithTag:101].frame;
        rect.origin.y = point.y;
        rect.size.height = -point.y;
        [self.mainTable viewWithTag:101].frame = rect;
    }
    
//    if (point.y > 10) {
//        self.navigationController.navigationBarHidden = NO;
//    }else{
//        self.navigationController.navigationBarHidden = YES;
//    }
}
/**
 初始化UI
 */
- (void)setUI{
    //隐藏导航栏
//    self.navigationController.navigationBarHidden = YES;
    NSString * sname = [[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
    NSString * schoolName = [[NSUserDefaults standardUserDefaults]objectForKey:@"schoolName"];
    NSString * className = [[NSUserDefaults standardUserDefaults]objectForKey:@"className"];
    NSString * headImage = [[NSUserDefaults standardUserDefaults]objectForKey:@"headImage"];

    //头像
    [_beijingImage addSubview:self.icon];
    [_icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,headImage]] forState:UIControlStateNormal];
    _icon.sd_layout.xIs(ScreenWidth/2-50).bottomSpaceToView(_beijingImage,60).widthIs(100).heightIs(100);
    JLViewBorderRadius(_icon, 50, 3, [UIColor groupTableViewBackgroundColor]);
    //昵称
    [_beijingImage addSubview:self.name];
     _name.text = sname;
    _name.sd_layout.topSpaceToView(_icon,0).leftSpaceToView(_beijingImage,ScreenWidth*.2).rightSpaceToView(_beijingImage,ScreenWidth*.2).heightIs(30);
    //学校、班级
    [_beijingImage addSubview:self.sclass];
    _sclass.text = [NSString stringWithFormat:@"%@  %@",schoolName,className];
    _sclass.sd_layout.topSpaceToView(_name,0).leftSpaceToView(_beijingImage,ScreenWidth*.2).rightSpaceToView(_beijingImage,ScreenWidth*.2).heightIs(20);
    
    [_beijingImage addSubview:self.lineMargin];
    _lineMargin.sd_layout.topSpaceToView(_sclass,5).leftSpaceToView(_beijingImage,10).rightSpaceToView(_beijingImage,10).heightIs(8);
}
-(void)editHeadImage:(UIButton *)sender{
    //设置主要参数
    [imagePicker dwSetPresentDelegateVC:self SheetShowInView:self.view InfoDictionaryKeys:(long)nil];

    //回调
    [imagePicker dwGetpickerTypeStr:^(NSString *pickerTypeStr) {

        NSLog(@"-----%@",pickerTypeStr);

    } pickerImagePic:^(UIImage *pickerImagePic) {
        [sender setImage:pickerImagePic forState:UIControlStateNormal];
        NSString *encodedImageStr = [self imageChangeBase64:pickerImagePic];
        CLog(@"这尼玛%@",encodedImageStr);
        //这里执行上传图片的网络请求
        [self uploadImageInfoWithBaseImage:encodedImageStr];
    }];
}
-(void)buttonClick
{
    JLMineMessageVC * vc = [[JLMineMessageVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)setButtonClick{
    JLSettingVC * vc = [[JLSettingVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - ################################ 访问器方法 ################################
-(UITableView *)mainTable{
    if (_mainTable == nil) {
        _mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:(UITableViewStylePlain)];
        _mainTable.delegate = self;
        _mainTable.dataSource = self;
        _mainTable.showsVerticalScrollIndicator = NO;
        if (kiPhone5) {
            _mainTable.contentInset = UIEdgeInsetsMake(ScreenWidth/2.1, 0, 0, 0);
        }else if (kiPhone6){
            _mainTable.contentInset = UIEdgeInsetsMake(ScreenWidth/2.4, 0, 0, 0);
        }else if (kiPhone6Plus){
            _mainTable.contentInset = UIEdgeInsetsMake(ScreenWidth/2.6, 0, 0, 0);
        }else if (IS_iPhoneX){
            _mainTable.contentInset = UIEdgeInsetsMake(ScreenWidth/2.6, 0, 0, 0);
        }else{
            _mainTable.contentInset = UIEdgeInsetsMake(ScreenWidth/2.6, 0, 0, 0);
        }
    }
    return _mainTable;
}
-(UIImageView *)beijingImage{
    if (!_beijingImage) {
        _beijingImage = [[UIImageView alloc] init];
        _beijingImage.clipsToBounds = YES;
        _beijingImage.userInteractionEnabled = YES;
        _beijingImage.image = JLGetImage(@"图层-858");
        _beijingImage.contentMode = UIViewContentModeScaleToFill;
        _beijingImage.tag = 101;
        
    }
    return _beijingImage;
}
-(UIButton *)icon{
    if (!_icon) {
        _icon = [[UIButton alloc]init];
        JLViewBorderRadius(_icon, 50, 1, kWhiteColor);
        [_icon addTarget:self action:@selector(editHeadImage:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _icon;
}
-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc]init];
        _name.textColor = kBlackColor;
        _name.font = FONT(17);
        _name.textAlignment = NSTextAlignmentCenter;
       
        
    }
    return _name;
}
-(UILabel *)sclass{
    if (!_sclass) {
        _sclass = [[UILabel alloc]init];
        _sclass.textColor = kGrayColor;
        _sclass.font = FONT(13);
        _sclass.textAlignment = NSTextAlignmentCenter;
    }
    return _sclass;
}
-(UILabel *)lineMargin{
    if (!_lineMargin) {
        _lineMargin = [[UILabel alloc]init];
        _lineMargin.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _lineMargin;
}
//第一个
-(UIBarButtonItem *)setBtn{
    
    if (!_setBtn) {
        
        UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
//        [btn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e637", 23, __kColorGray)] forState:UIControlStateNormal];
        [btn sizeToFit];
        _setBtn =  [[UIBarButtonItem alloc] initWithCustomView:btn];
        
    }
    return _setBtn;
}

//第二个
-(UIBarButtonItem *)messageBtn{
    
    if (!_messageBtn) {
        
        UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(setButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:@"set"] forState:UIControlStateNormal];
        [btn sizeToFit];
        
        _messageBtn =  [[UIBarButtonItem alloc] initWithCustomView:btn];
        
    }
    return _messageBtn;
}
#pragma mark -- image转化成Base64位
-(NSString *)imageChangeBase64: (UIImage *)image{
    
    NSData   *imageData = nil;
    //NSString *mimeType  = nil;
    if ([self imageHasAlpha:image]) {
        
        imageData = UIImagePNGRepresentation(image);
        //mimeType = @"image/png";
    }else{
        
        imageData = UIImageJPEGRepresentation(image, 0.3f);
        //mimeType = @"image/jpeg";
    }
    return [NSString stringWithFormat:@"%@",[imageData base64EncodedStringWithOptions: 0]];
}

-(BOOL)imageHasAlpha:(UIImage *)image{
    
    
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

@end
