//
//  JLMineMessageCell.h
//  Jia-li Liu
//
//  Created by jdlx on 2019/1/2.
//  Copyright © 2019 KLIANS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JLMineMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *messageTitle;
@property (weak, nonatomic) IBOutlet UILabel *messageContent;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *isReadLabel;

@end

NS_ASSUME_NONNULL_END
