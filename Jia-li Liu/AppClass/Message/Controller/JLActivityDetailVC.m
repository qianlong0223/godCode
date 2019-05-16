//
//  JLActivityDetailVC.m
//  Jia-li Liu
//
//  Created by jdlx on 2019/1/2.
//  Copyright © 2019 KLIANS. All rights reserved.
//

#import "JLActivityDetailVC.h"

@interface JLActivityDetailVC ()<JLDataHandlerProtocol>

@end

@implementation JLActivityDetailVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //去掉导航栏底部的黑线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],
                                                                      NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:17]}];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"活动详情";
    [self requestActivityDetailData];
    
}
-(void)requestActivityDetailData{
    [[[JLActivityDetailAPI getActivityDetailWithActivityId:self.activityId] netWorkClient] getRequestInView:self.view networkCodeTypeSuccessDataHandler:self isCache:NO];
    
}

-(void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject{
    if ([responseObject isKindOfClass:[JLActivityDetailAPI class]]) {
        JLActivityDetailAPI *api = responseObject;
        CLog(@"%@",api);
        [self setUIWithAPI:api];
    }
   
}

-(void)netWorkCodeFailureDealWithResponseObject:(id)responseObject{
    CLog(@"%@",responseObject);
    
}
-(void)setUIWithAPI:(JLActivityDetailAPI*)api{
    UIImageView * headBannerView = [[UIImageView alloc]init];
    NSString * image = [NSString stringWithFormat:@"%@%@",BaseUrl,api.image];
    [headBannerView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"123"]];
    [self.view addSubview:headBannerView];
    headBannerView.sd_layout.leftSpaceToView(self.view, 0).topSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).heightIs(ScreenHeight/4);
    UIView * cover = [[UIView alloc]init];
    cover.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
    [headBannerView addSubview:cover];
    cover.sd_layout.leftSpaceToView(headBannerView, 0).topSpaceToView(headBannerView, 0).rightSpaceToView(headBannerView, 0).heightIs(ScreenHeight/4);
    UIView * contentView = [[UIView alloc]init];
    contentView.backgroundColor = kWhiteColor;
    ViewRadius(contentView, 20.f);
    [self.view addSubview:contentView];
    contentView.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(headBannerView, -20).heightIs(3*ScreenHeight/4);
    
    UILabel * acTitle = [[UILabel alloc]init];
    acTitle.text = [NSString stringWithFormat:@"%@",api.title];
    acTitle.textColor = kBlackColor;
    acTitle.font = FONT(17);
    [contentView addSubview:acTitle];
    acTitle.sd_layout.leftSpaceToView(contentView, 10).rightSpaceToView(contentView, 10).topSpaceToView(contentView, 10).heightIs(30);
    UIImageView * userImage = [[UIImageView alloc]init];
    NSDictionary * sendDic = [NSDictionary dictionaryWithDictionary:api.sender];
    [userImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,sendDic[@"headImage"]]] placeholderImage:[UIImage imageNamed:@"123"]];
    ViewRadius(userImage, 20);
    [contentView addSubview:userImage];
    userImage.sd_layout.leftSpaceToView(contentView, 10).topSpaceToView(acTitle, 10).widthIs(40).heightIs(40);
    UILabel * school = [[UILabel alloc]init];
    school.text = [NSString stringWithFormat:@"%@",sendDic[@"name"]];
    school.textColor = kBlackColor;
    school.font = FONT(14);
    [contentView addSubview:school];
    school.sd_layout.leftSpaceToView(userImage, 4).rightSpaceToView(contentView, 20).topSpaceToView(acTitle, 10).heightIs(20);
    UILabel * time = [[UILabel alloc]init];
    NSString * start = [NSString convertToDate:api.startTime];
    NSString * end = [NSString convertToDate:api.endTime];
    time.text = [NSString stringWithFormat:@"活动时间:%@-%@",start,end];
    time.textColor = kBlackColor;
    time.font = FONT(12);
    [contentView addSubview:time];
    time.sd_layout.leftSpaceToView(userImage, 4).rightSpaceToView(contentView, 20).topSpaceToView(school, 0).heightIs(20);
    UIImageView * fankuiimage = [[UIImageView alloc]init];
    fankuiimage.image = [UIImage imageNamed:@"icon_action_finish"];
    fankuiimage.layer.contentsGravity = kCAGravityResizeAspectFill;
    [contentView addSubview:fankuiimage];
    fankuiimage.sd_layout.topSpaceToView(contentView, 5).rightSpaceToView(contentView, 15).widthIs(128).heightIs(77);
    if ([api.status isEqualToString:@"3"]) {
        fankuiimage.hidden = NO;
    }else{
        fankuiimage.hidden = YES;
    }
    UILabel * line = [[UILabel alloc]init];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    line.font = FONT(12);
    [contentView addSubview:line];
    line.sd_layout.leftSpaceToView(contentView, 10).rightSpaceToView(contentView, 10).topSpaceToView(time, 10).heightIs(1);
//    UILabel * contentLabel = [[UILabel alloc]init];
//    NSString * content = [self filterHTML:api.content];
//    contentLabel.text = [NSString stringWithFormat:@"%@",[NSString htmlEntityDecode:content]];
//    contentLabel.textColor = kBlackColor;
//    contentLabel.font = FONT(14);
//    contentLabel.numberOfLines = 0;
//    [contentView addSubview:contentLabel];
//    CGSize labelSize = [self sizeWithSt:contentLabel.text font:contentLabel.font];
//    contentLabel.sd_layout.leftSpaceToView(contentView, 10).rightSpaceToView(contentView, 10).topSpaceToView(line, 10).heightIs(labelSize.height);
    UIWebView * webView = [[UIWebView alloc]init];
    webView.backgroundColor = kWhiteColor;
    NSString *htmlString;
    if ([api.status isEqualToString:@"3"]) {
        htmlString = api.result;
    }else{
        htmlString = api.content;
    }
    [webView loadHTMLString:htmlString baseURL:nil];
    [contentView addSubview:webView];
    webView.sd_layout.leftSpaceToView(contentView, 10).rightSpaceToView(contentView, 10).topSpaceToView(line, 10).heightIs(ScreenHeight*3/4);
}
// 定义成方法方便多个label调用 增加代码的复用性
- (CGSize)sizeWithSt:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(320, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}
-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}
@end
