//
//  UpdatePswVC.h
//  Jia-li Liu
//
//  Created by jdlx on 2019/1/4.
//  Copyright © 2019 KLIANS. All rights reserved.
//

#import "JLBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UpdatePswVC : JLBaseViewController
@property (weak, nonatomic) IBOutlet UITextField *oldPsw;
@property (weak, nonatomic) IBOutlet UITextField *npsw;
@property (weak, nonatomic) IBOutlet UITextField *againPsw;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

NS_ASSUME_NONNULL_END
