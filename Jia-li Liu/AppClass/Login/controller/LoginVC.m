//
//  LoginVC.m
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/20.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "LoginVC.h"
#import "RegistVC.h"
@interface LoginVC ()<JLDataHandlerProtocol>

@end

@implementation LoginVC
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    ViewRadius(self.loginBtn, 22.f);
    self.pswTf.secureTextEntry = YES;
    self.loginBtn.backgroundColor = UIColorFromRGB(0x5251F5);
    [self.registBtn setTitleColor:UIColorFromRGB(0x5251F5) forState:UIControlStateNormal];
    if (kiPhone5) {
        self.toptobg.constant = 2;
    }
    
}
- (IBAction)loginBtnClicked:(id)sender {
    [self requestData];
    
}
-(void)requestData{
    
    if ([self.phonetf.text isEqualToString:@""]) {
        [StateView showWarningInfo:@"请填写手机号"];
        return;
    }
    if (![BoolJudge isPhoneNumber:self.phonetf.text]) {
        [StateView showWarningInfo:@"请填写正确的手机号"];
        return;
    }
    if ([self.pswTf.text isEqualToString:@""]) {
        [StateView showWarningInfo:@"请填写密码"];
        return;
    }
    NSString * password = [NSString MD5_32BitEncry:self.pswTf.text isUppercase:NO];
    [JLProgressHUD showOnlyText:@"登录中..." inView:kWindow];
    [[[JLLoginAPI getLoginInfoWithUserPhone:self.phonetf.text Password:password] netWorkClient] getRequestInView:self.view networkCodeTypeSuccessDataHandler:self isCache:NO];
}

-(void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject{
    if ([responseObject isKindOfClass:[JLLoginAPI class]]) {
        
        JLLoginAPI *api = responseObject;
        [[NSUserDefaults standardUserDefaults]setObject:api.userId forKey:@"userId"];
        [[NSUserDefaults standardUserDefaults]setObject:api.sessionId forKey:@"sessionId"];
        [[NSUserDefaults standardUserDefaults]setObject:api.name forKey:@"name"];
        [[NSUserDefaults standardUserDefaults]setObject:api.headImage forKey:@"headImage"];
        [[NSUserDefaults standardUserDefaults]setObject:api.gender forKey:@"gender"];
        [[NSUserDefaults standardUserDefaults]setObject:api.studentId forKey:@"studentId"];
        [[NSUserDefaults standardUserDefaults]setObject:api.schoolId forKey:@"schoolId"];
        [[NSUserDefaults standardUserDefaults]setObject:api.schoolName forKey:@"schoolName"];
        [[NSUserDefaults standardUserDefaults]setObject:api.classId forKey:@"classId"];
        [[NSUserDefaults standardUserDefaults]setObject:api.className forKey:@"className"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"isRememberLogin"];
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        //异步返回主线程，根据获取的数据，更新UI
        dispatch_async(mainQueue, ^{
            NSLog(@"根据更新UI界面");
            JLTabBarController *tabBarVc = [[JLTabBarController alloc] init];
            kWindow.rootViewController = tabBarVc;
        });

    }
}

-(void)netWorkCodeFailureDealWithResponseObject:(id)responseObject{
    CLog(@"%@",responseObject);
    [JLProgressHUD hide];
    [StateView showErrorInfo:@"网络问题解析失败"];
}
- (IBAction)registtBtnClicked:(id)sender {
    RegistVC * vc = [[RegistVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
