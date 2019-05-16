//
//  JGFirstOneCell.h
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/20.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JGFirstOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *pointLabel;
@property (weak, nonatomic) IBOutlet UILabel *tiLabel;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *scanLabel;

@end

NS_ASSUME_NONNULL_END
