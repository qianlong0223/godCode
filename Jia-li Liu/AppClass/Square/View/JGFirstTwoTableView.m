//
//  JGFirstTwoTableView.m
//  JGNavSegmentScroll
//
//  Created by stkcctv on 17/1/14.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "JGFirstTwoTableView.h"
#import "JGFirstOneCell.h"
#import "JLSquareDeatailVC.h"
@interface JGFirstTwoTableView () <UITableViewDelegate, UITableViewDataSource>

@end

static NSString * const JGFirstTwoTableViewCellId = @"JGFirstTwoTableViewCellId";
@implementation JGFirstTwoTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count;
//    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * JGFirstOneCellId = @"JGFirstOneCell";
    JGFirstOneCell * cell = [tableView dequeueReusableCellWithIdentifier:JGFirstOneCellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:JGFirstOneCellId owner:nil options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.name.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.section][@"sender"][@"name"]];
    cell.tiLabel.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.section][@"title"]];
    NSString * datestring = [NSString formateDate:[NSString convertToDateTime:_dataArr[indexPath.section][@"sendTime"]] withFormate:@"yyyy-MM-dd HH:mm"];
    cell.date.text = [NSString stringWithFormat:@"%@",datestring];
    NSString * isread = [NSString stringWithFormat:@"%@",_dataArr[indexPath.section][@"read"]];
    if ([isread isEqualToString:@"2"]) {
        cell.pointLabel.hidden = YES;
    }else{
        cell.pointLabel.hidden = NO;
    }
    ViewRadius(cell.pointLabel, 4.f);
    JLViewBorderRadius(cell.bgView, 10, 1, [UIColor lightGrayColor]);
    ViewRadius(cell.scanLabel, 8.f);
    cell.scanLabel.backgroundColor = UIColorFromRGB(0x5251F5);
    cell.scanLabel.textColor = kWhiteColor;
//    cell.bgView.clipsToBounds = NO;
//    cell.bgView.layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
//    cell.bgView.layer.shadowOffset = CGSizeMake(0,0.0);//偏移距离
//    cell.bgView.layer.shadowOpacity = 0.5;//不透明度
//    cell.bgView.layer.shadowRadius = 10.f;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JLSquareDeatailVC * vc = [[JLSquareDeatailVC alloc]init];
    vc.titlename = @"作业详情";
    vc.mid = _dataArr[indexPath.section][@"homeworkId"];
    [self.zyviewController.navigationController pushViewController:vc animated:YES];
}
-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
    [self reloadData];
}
@end
