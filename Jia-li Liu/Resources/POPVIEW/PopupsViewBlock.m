//
//  PopupsView.m
//  Popups
//
//  Created by Arthur on 2018/5/30.
//  Copyright © 2018年 Arthur. All rights reserved.
//

#import "PopupsViewBlock.h"
#import "ServiceCell.h"
#define CELLID @"ServiceCell"
@interface PopupsViewBlock()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *alertView;

//@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation PopupsViewBlock
{
    NSMutableArray * _dataArray;
}

- (instancetype)initWithItemArr:(NSArray *)itemArr {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        _dataArray = [NSMutableArray arrayWithArray:itemArr];
        self.alertView.frame = CGRectMake(0, 0, 300, _dataArray.count*60);
        self.alertView.center = self.center;
        [self addSubview:self.alertView];

        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, self.alertView.width, self.alertView.height) style:UITableViewStylePlain];
        [self.tableView registerClass:[ServiceCell class] forCellReuseIdentifier:CELLID];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.rowHeight = 60;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.alertView addSubview:self.tableView];
        
    }
    
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return   _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
//    cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArtray[indexPath.row]]];
    NSDictionary * model = _dataArray[indexPath.row];
    cell.nameLabel.text = [model objectForKey:@"name"];
    cell.nameLabel.textColor = [UIColor blackColor];
    
    return cell;
}

#pragma mark--点击单元格页面跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary * model = _dataArray[indexPath.row];
    NSString * typeId = [model objectForKey:@"typeId"];
    NSString * name = [model objectForKey:@"name"];
    if (_block) {
        self.block(name,typeId);
    }
    [self hiddenAction];
}
- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.masksToBounds = YES;
        _alertView.layer.cornerRadius = 5;
        _alertView.userInteractionEnabled = YES;
        _alertView.userInteractionEnabled = YES;
    }
    return _alertView;
}

- (void)showView {
    self.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    
    self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.2,0.2);
    self.alertView.alpha = 0;
    [UIView animateWithDuration:0.3 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
        self.alertView.transform = transform;
        self.alertView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hiddenAction {

    [self dismissAlertView];
}


-(void)dismissAlertView {
    [UIView animateWithDuration:.2 animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(0.2, 0.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.08
                         animations:^{
                             self.alertView.transform = CGAffineTransformMakeScale(0.25, 0.25);
                         }completion:^(BOOL finish){
                             [self removeFromSuperview];
                         }];
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hiddenAction];
}

@end
