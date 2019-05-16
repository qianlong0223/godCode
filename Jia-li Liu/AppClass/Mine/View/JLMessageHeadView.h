//
//  JLMessageHeadView.h
//  Jia-li Liu
//
//  Created by jdlx on 2019/1/2.
//  Copyright © 2019 KLIANS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JLMessageHeadView : UITableViewHeaderFooterView
@property(nonatomic,copy)NSString * title;
@property(nonatomic,strong)UILabel * label;
+ (instancetype)headerFooterViewWithTabelView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
