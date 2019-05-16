//
//  BSHeaderFooterView.h
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/24.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSHeaderFooterView : UITableViewHeaderFooterView
@property(nonatomic,copy)NSString * title;
@property(nonatomic,strong)UILabel * label;
@property(nonatomic,strong)UIButton * moreBtn;
+ (instancetype)headerFooterViewWithTabelView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
