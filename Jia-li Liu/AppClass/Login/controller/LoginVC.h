//
//  LoginVC.h
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/20.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginVC : JLBaseViewController
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *phonetf;
@property (weak, nonatomic) IBOutlet UITextField *pswTf;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toptobg;

@end

NS_ASSUME_NONNULL_END
