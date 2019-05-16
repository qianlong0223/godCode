//
//  HotWorkCell.m
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/24.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "HotWorkCell.h"
#import "JLProductDetailVC.h"
@interface HotWorkCell ()<HorScorllViewImageClickDelegate>

@end
@implementation HotWorkCell
{
    NSMutableArray * paintArr;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)cellWithTableView:(UITableView *)tableView WithData:(NSMutableArray *)array{
    static NSString * ID = @"HotWorkCell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID WithData:array];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithData:(NSMutableArray *)dataArr{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatSubViewsWithDataArr:dataArr];
    }
    return self;
}
- (void)creatSubViewsWithDataArr:(NSMutableArray *)arr{
    NSMutableArray * imageArr = [[NSMutableArray alloc]init];
    paintArr = [[NSMutableArray alloc]init];
    for (NSDictionary * imageDic in arr) {
        [imageArr addObject:[NSString stringWithFormat:@"%@%@",BaseUrl,imageDic[@"image"]]];
        [paintArr addObject:[NSString stringWithFormat:@"%@",imageDic[@"paintingId"]]];
    }
    UILabel * hotLabel = [[UILabel alloc]init];
    hotLabel.text = @"热门作品";
    [hotLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    hotLabel.textColor = kBlackColor;
//    hotLabel.backgroundColor = [UIColor blueColor];
    hotLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:hotLabel];
    hotLabel.sd_layout.leftSpaceToView(self, 10).topSpaceToView(self,0).widthIs(100).heightIs(30);
    UIButton * moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setTitle:@"更多>" forState:UIControlStateNormal];
    [moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    moreBtn.titleLabel.font = FONT(14);
    [moreBtn addTarget:self action:@selector(moreBtnClicekd) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:moreBtn];
    moreBtn.sd_layout.rightSpaceToView(self, 10).centerYEqualToView(hotLabel).widthIs(40).heightIs(30);
   
#pragma mark - 卡片滚动图
    
//    CGFloat imW = ScreenWidth-260*MYWIDTH;
    _scrollView = [[HorScorllView alloc] initWithFrame:CGRectMake(0, hotLabel.bottom +5, ScreenWidth, 190*MYWIDTH)];
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    if (imageArr.count) {
         _scrollView.images = imageArr;
    }

    UILabel * marginLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _scrollView.bottom, ScreenWidth-20, 8)];
    [self addSubview:marginLabel];
    marginLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    ViewRadius(marginLabel, 2.f);
//    marginLabel.sd_layout.topSpaceToView(_scrollView,30).leftSpaceToView(self,10).rightSpaceToView(self,10).heightIs(8);

}
- (void)horImageClickAction:(NSInteger)tag {
    NSLog(@"你点击的按钮tag值为：%ld",(long)tag);
    if (tag-100>=paintArr.count) {
        return;
    }
    JLProductDetailVC * vc = [[JLProductDetailVC alloc]init];
    vc.paintId = [NSString stringWithFormat:@"%@",paintArr[tag-100]];
    [self.zyviewController.navigationController pushViewController:vc animated:YES];
}
-(void)moreBtnClicekd{
    self.zyviewController.navigationController.tabBarController.selectedIndex = 0;
}

@end
