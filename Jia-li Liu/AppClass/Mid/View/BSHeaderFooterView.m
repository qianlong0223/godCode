//
//  BSHeaderFooterView.m
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/24.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "BSHeaderFooterView.h"

@implementation BSHeaderFooterView

+ (instancetype)headerFooterViewWithTabelView:(UITableView *)tableView{
    
    BSHeaderFooterView *headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BSHeaderFooterView"];
    
    if (headerFooterView == nil) {
        
        headerFooterView = [[BSHeaderFooterView alloc]initWithReuseIdentifier:@"BSHeaderFooterView"];
        
    }
    
    return headerFooterView;
    
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = kWhiteColor;
        UILabel * hotLabel = [[UILabel alloc]init];
        hotLabel.text = @"推荐活动";
        [hotLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        hotLabel.textColor = kBlackColor;
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
    }
    return self;
}
-(void)moreBtnClicekd{
    self.zyviewController.navigationController.tabBarController.selectedIndex = 3;
}
//接收外界传进来的字符串并赋值
- (void)setTitle:(NSString *)title{
    _title = [title copy];
    self.label.text = title;
}
@end
