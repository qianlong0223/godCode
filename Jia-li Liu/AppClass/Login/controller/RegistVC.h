//
//  RegistVC.h
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/20.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RegistVC : JLBaseViewController
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet UITextField *pswTf;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toptobg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toptolabel;

@end

NS_ASSUME_NONNULL_END
