//
//  ProductCell.m
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/24.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "ProductCell.h"

@implementation ProductCell
{
    UIView * bgview;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //(ScreenWidth-50)/2*4/3
        bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width,(ScreenWidth-50)/2*4/3.7)];
        [self.contentView addSubview:bgview];
        _imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, bgview.height-40)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;//关键在此
//        _imageView.backgroundColor = [UIColor redColor];
        [bgview addSubview:_imageView];
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(5, _imageView.bottom+5, 100*MYWIDTH, 30*MYWIDTH)];
        _name.textAlignment = NSTextAlignmentLeft;
        _name.textColor = [UIColor grayColor];
        _name.font = [UIFont systemFontOfSize:13*MYWIDTH];
        [bgview addSubview:_name];
        
        _count = [[UILabel alloc]init];
        _count.font = FONT(12*MYWIDTH);
        _count.textColor = kGrayColor;
        _count.textAlignment = NSTextAlignmentRight;
        [bgview addSubview:_count];
        _count.sd_layout.rightSpaceToView(bgview, 5).centerYEqualToView(self.name).widthIs(20).heightIs(10);
        _zanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_zanBtn addTarget:self action:@selector(zanBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [bgview addSubview:_zanBtn];
        _zanBtn.sd_layout.rightSpaceToView(_count, 2).centerYEqualToView(self.name).widthIs(15).heightIs(15);
        UIButton * coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [coverBtn addTarget:self action:@selector(zanBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [bgview addSubview:coverBtn];
        coverBtn.sd_layout.rightSpaceToView(bgview, 0).centerYEqualToView(self.name).widthIs(ScreenWidth).heightIs(30);
        JLViewBorderRadius(bgview, 8.f, 2, [UIColor groupTableViewBackgroundColor]);
        bgview.clipsToBounds = NO;
        bgview.layer.shadowColor = [UIColor whiteColor].CGColor;//阴影颜色
        bgview.layer.shadowOffset = CGSizeMake(0,0);//偏移距离
        bgview.layer.shadowOpacity = 0.6;//不透明度
        bgview.layer.shadowRadius = 12.f;


    }
    
    return self;
}
-(void)setDic:(NSDictionary *)dic{
    _dic = dic;
    NSString * image = [NSString stringWithFormat:@"%@%@",BaseUrl,dic[@"image"]];
    NSDictionary * senderDic = dic[@"sender"];
    
    NSString * title = [NSString stringWithFormat:@"%@",senderDic[@"name"]];
    NSString * praiseNum = [NSString stringWithFormat:@"%@",dic[@"praiseNum"]];
    NSString * paintingId = [NSString stringWithFormat:@"%@",dic[@"paintingId"]];
    //myPraise": "当前用户是否点赞  1：未点赞；2：已点赞
    NSString * praise = [NSString stringWithFormat:@"%@",dic[@"myPraise"]];
    self.name.text = title;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"123"]];
    if ([praiseNum isEqualToString:@"0"]) {
        self.count.text = @"赞";
    }else{
        self.count.text = praiseNum;
    }
    if ([praise isEqualToString:@"1"]) {
        [self.zanBtn setImage:[UIImage imageNamed:@"nonpraise"] forState:UIControlStateNormal];
    }else{
        [self.zanBtn setImage:[UIImage imageNamed:@"praise"] forState:UIControlStateNormal];
    }
    CGSize size = CGSizeMake(100, MAXFLOAT);//设置高度宽度的最大限度
    CGRect rect = [_count.text boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12*MYWIDTH]} context:nil];
    _count.sd_layout.rightSpaceToView(bgview, 5).centerYEqualToView(self.name).widthIs(rect.size.width).heightIs(10);
}
-(void)zanBtnClicked:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (_zanBtnBlcok) {
        self.zanBtnBlcok();
    }
}

@end
