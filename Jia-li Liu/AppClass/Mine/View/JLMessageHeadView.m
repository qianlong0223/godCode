//
//  JLMessageHeadView.m
//  Jia-li Liu
//
//  Created by jdlx on 2019/1/2.
//  Copyright © 2019 KLIANS. All rights reserved.
//

#import "JLMessageHeadView.h"

@implementation JLMessageHeadView

+ (instancetype)headerFooterViewWithTabelView:(UITableView *)tableView{
    
    JLMessageHeadView *headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"JLMessageHeadView"];
    
    if (headerFooterView == nil) {
        
        headerFooterView = [[JLMessageHeadView alloc]initWithReuseIdentifier:@"JLMessageHeadView"];
        
    }
    
    return headerFooterView;
    
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = kWhiteColor;
        self.label = [[UILabel alloc]init];
//        hotLabel.text = @"2018-12-29 12:22";
        self.label.font = FONT(14);
        self.label.textColor = kBlackColor;
        self.label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.label];
        self.label.sd_layout.leftSpaceToView(self, 10).topSpaceToView(self,0).rightSpaceToView(self, 10).heightIs(40);
    }
    return self;
}
//接收外界传进来的字符串并赋值

- (void)setTitle:(NSString *)title{
    _title = [title copy];
    self.label.text = title;
}

@end
