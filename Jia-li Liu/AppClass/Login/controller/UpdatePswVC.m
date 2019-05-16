//
//  UpdatePswVC.m
//  Jia-li Liu
//
//  Created by jdlx on 2019/1/4.
//  Copyright © 2019 KLIANS. All rights reserved.
//

#import "UpdatePswVC.h"
#import "LoginVC.h"
@interface UpdatePswVC ()<JLDataHandlerProtocol>

@end

@implementation UpdatePswVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改密码";
    self.oldPsw.secureTextEntry = YES;
    self.npsw.secureTextEntry = YES;
    self.againPsw.secureTextEntry = YES;
    ViewRadius(self.saveBtn, 22.f);
    [self.saveBtn setBackgroundColor:UIColorFromRGB(0x5251F5)];
}
- (IBAction)saveBtnClicked:(UIButton *)sender {
    if ([self.oldPsw.text isEqualToString:@""]) {
        [StateView showWarningInfo:@"请输入旧密码"];
        return;
    }
    if ([self.npsw.text isEqualToString:@""]) {
        [StateView showWarningInfo:@"请输入新密码"];
        return;
    }
    if ([self.againPsw.text isEqualToString:@""]) {
        [StateView showWarningInfo:@"请再次输入新密码"];
        return;
    }
    if (![self.npsw.text isEqualToString:self.againPsw.text]) {
        [StateView showWarningInfo:@"两次输入新密码不一致"];
        return;
    }
    [self requestData];
}
-(void)requestData{
    NSString * oldpassword = [NSString MD5_32BitEncry:self.oldPsw.text isUppercase:NO];
    NSString * npassword = [NSString MD5_32BitEncry:self.npsw.text isUppercase:NO];
    [[[JLUpdatePswAPI updatePasswordWithOldPassword:oldpassword newPassword:npassword] netWorkClient] getRequestInView:self.view networkCodeTypeSuccessDataHandler:self isCache:NO];
}

-(void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject{
    if ([responseObject isKindOfClass:[JLUpdatePswAPI class]]) {
        /** 单按键 */
        [JHSysAlertUtil presentAlertViewWithTitle:@"提示" message:@"密码修改成功请重新登录" confirmTitle:@"确定" handler:^{
            LoginVC * login = [[LoginVC alloc]init];
            JTNavigationController *navVc = [[JTNavigationController alloc] initWithRootViewController:login];
            kWindow.rootViewController = navVc;
        }];
    }
}

-(void)netWorkCodeFailureDealWithResponseObject:(id)responseObject{
    CLog(@"%@",responseObject);
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
