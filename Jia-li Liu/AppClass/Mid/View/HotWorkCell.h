//
//  HotWorkCell.h
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/24.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HorScorllView.h"
NS_ASSUME_NONNULL_BEGIN

@interface HotWorkCell : UITableViewCell
@property (nonatomic,strong)void(^clickIndexImageBlock)(NSInteger);
@property (nonatomic,strong) HorScorllView *scrollView;
+ (instancetype)cellWithTableView:(UITableView *)tableView WithData:(NSMutableArray *)array;
@end

NS_ASSUME_NONNULL_END
