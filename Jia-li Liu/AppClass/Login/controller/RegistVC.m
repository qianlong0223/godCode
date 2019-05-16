//
//  RegistVC.m
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/20.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "RegistVC.h"

@interface RegistVC ()<JLDataHandlerProtocol>

@end

@implementation RegistVC
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
    ViewRadius(self.registBtn, 22.f);
    self.pswTf.secureTextEntry = YES;
    self.registBtn.backgroundColor = UIColorFromRGB(0x5251F5);
    [self.loginBtn setTitleColor:UIColorFromRGB(0x5251F5) forState:UIControlStateNormal];
    if (kiPhone5) {
        self.toptobg.constant = 27;
        self.toptolabel.constant = 40;
    }
}
- (IBAction)registBtnClicked:(id)sender {
    if ([self.phoneTf.text isEqualToString:@""]) {
        [StateView showWarningInfo:@"请填写手机号"];
        return;
    }
    if (![BoolJudge isPhoneNumber:self.phoneTf.text]) {
        [StateView showWarningInfo:@"请填写正确的手机号"];
        return;
    }
    if ([self.pswTf.text isEqualToString:@""]) {
        [StateView showWarningInfo:@"请填写密码"];
        return;
    }
    if (self.pswTf.text.length < 6||self.pswTf.text.length > 16) {
        [StateView showWarningInfo:@"请填写6-16密码"];
        return;
    }
    if ([self.name.text isEqualToString:@""]) {
        [StateView showWarningInfo:@"请填写家长姓名"];
        return;
    }
    if ([self.code.text isEqualToString:@""]) {
        [StateView showWarningInfo:@"请填写激活码"];
        return;
    }
    [self requestData];
}
-(void)requestData{
    NSString * password = [NSString MD5_32BitEncry:self.pswTf.text isUppercase:NO];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    [parameter setObject:self.phoneTf.text forKey:@"phone"];
    [parameter setObject:password forKey:@"password"];
    [parameter setObject:self.name.text forKey:@"parentsName"];
    [parameter setObject:self.code.text forKey:@"activationCode"];
    [manager POST:[NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/login/reg"] parameters:parameter progress:nil success:
     ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
         NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功---%@---%@--%@",responseObject,[responseObject class],dic);
         if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
             [StateView showSuccessInfo:[dic objectForKey:@"info"]];
             [self.navigationController popViewControllerAnimated:YES];
         }else{
             [StateView showErrorInfo:[dic objectForKey:@"info"]];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         NSLog(@"请求失败--%@",error);
     }];
    
//    [[[JLRegistAPI getRegistInfoWithUserPhone:self.phoneTf.text Password:password ParentsName:self.name.text ActivationCode:self.code.text] netWorkClient] getRequestInView:self.view networkCodeTypeSuccessDataHandler:self isCache:NO];
}

//-(void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject{
//    if ([responseObject isKindOfClass:[JLRegistAPI class]]) {
//        JLRegistAPI *api = responseObject;
//        if ([api.code isEqualToString:@"0"]) {
//            CLog(@"%@",api);
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//
//    }
//}
//
//-(void)netWorkCodeFailureDealWithResponseObject:(id)responseObject{
//    CLog(@"%@",responseObject);
//
//}
- (IBAction)goLoginBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
