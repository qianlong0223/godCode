//
//  ActivityCell.h
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/24.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ActivityCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgvIEW;
@property (weak, nonatomic) IBOutlet UILabel *activityName;
@property (weak, nonatomic) IBOutlet UIImageView *acImage;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *schoolName;
@property (weak, nonatomic) IBOutlet UILabel *marginLabel;

@end

NS_ASSUME_NONNULL_END
