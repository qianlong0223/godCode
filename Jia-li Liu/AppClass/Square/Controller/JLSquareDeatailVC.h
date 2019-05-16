//
//  JLSquareDeatailVC.h
//  Jia-li Liu
//
//  Created by jdlx on 2019/1/10.
//  Copyright © 2019 KLIANS. All rights reserved.
//

#import "JLBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JLSquareDeatailVC : JLBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *worktitle;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIView *bgview;
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@property(nonatomic,copy)NSString * titlename;
@property(nonatomic,copy)NSString * mid;
@end

NS_ASSUME_NONNULL_END
