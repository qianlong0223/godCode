//
//  JLMessageDetailVC.m
//  Jia-li Liu
//
//  Created by jdlx on 2019/1/2.
//  Copyright © 2019 KLIANS. All rights reserved.
//

#import "JLMessageDetailVC.h"

@interface JLMessageDetailVC ()

@end

@implementation JLMessageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"消息详情";
    [self setUI];
}
-(void)setUI{
    UIView * contentView = [[UIView alloc]init];
    contentView.backgroundColor = kWhiteColor;
    [self.view addSubview:contentView];
    contentView.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(self.view, 10).heightIs(ScreenHeight);
    UILabel * acTitle = [[UILabel alloc]init];
    acTitle.text = [NSString stringWithFormat:@"%@",self.messageDic[@"title"]];
    acTitle.textColor = kBlackColor;
    acTitle.font = FONT(17);
    [contentView addSubview:acTitle];
    acTitle.sd_layout.leftSpaceToView(contentView, 10).rightSpaceToView(contentView, 10).topSpaceToView(contentView, 10).heightIs(30);
    UIImageView * userImage = [[UIImageView alloc]init];
    userImage.image = [UIImage imageNamed:@"123"];
    ViewRadius(userImage, 20);
    [contentView addSubview:userImage];
    userImage.sd_layout.leftSpaceToView(contentView, 10).topSpaceToView(acTitle, 10).widthIs(40).heightIs(40);
    UILabel * school = [[UILabel alloc]init];
    school.text = @"系统消息";
    school.textColor = kBlackColor;
    school.font = FONT(14);
    [contentView addSubview:school];
    school.sd_layout.leftSpaceToView(userImage, 4).rightSpaceToView(contentView, 20).topSpaceToView(acTitle, 10).heightIs(20);
    UILabel * time = [[UILabel alloc]init];
    NSString * date = [NSString stringWithFormat:@"%@",self.messageDic[@"sendTime"]];
    time.text = [NSString stringWithFormat:@"%@",[NSString convertToDateTimer:date]];
    time.textColor = kBlackColor;
    time.font = FONT(12);
    [contentView addSubview:time];
    time.sd_layout.leftSpaceToView(userImage, 4).rightSpaceToView(contentView, 20).topSpaceToView(school, 0).heightIs(20);
    UILabel * line = [[UILabel alloc]init];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    line.font = FONT(12);
    [contentView addSubview:line];
    line.sd_layout.leftSpaceToView(contentView, 10).rightSpaceToView(contentView, 10).topSpaceToView(time, 10).heightIs(1);
    UILabel * contentLabel = [[UILabel alloc]init];
    contentLabel.text = [NSString stringWithFormat:@"%@",self.messageDic[@"jianjie"]];
    contentLabel.textColor = kBlackColor;
    contentLabel.font = FONT(14);
    contentLabel.numberOfLines = 0;
    [contentView addSubview:contentLabel];
    CGSize labelSize = [self sizeWithSt:contentLabel.text font:contentLabel.font];
    contentLabel.sd_layout.leftSpaceToView(contentView, 10).rightSpaceToView(contentView, 10).topSpaceToView(line, 10).heightIs(labelSize.height);
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

@end
