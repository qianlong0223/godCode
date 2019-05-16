//
//  JLStudentInfoVC.h
//  Jia-li Liu
//
//  Created by jdlx on 2019/1/4.
//  Copyright © 2019 KLIANS. All rights reserved.
//

#import "JLBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JLStudentInfoVC : JLBaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *studentImage;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *sex;
@property (weak, nonatomic) IBOutlet UILabel *school;
@property (weak, nonatomic) IBOutlet UILabel *classlabel;

@end

NS_ASSUME_NONNULL_END
