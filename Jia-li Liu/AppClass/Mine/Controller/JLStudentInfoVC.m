//
//  JLStudentInfoVC.m
//  Jia-li Liu
//
//  Created by jdlx on 2019/1/4.
//  Copyright © 2019 KLIANS. All rights reserved.
//

#import "JLStudentInfoVC.h"

@interface JLStudentInfoVC ()

@end

@implementation JLStudentInfoVC
{
    ImagePicker *imagePicker;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"学生信息";
    ViewRadius(self.studentImage, 35.f);
    //初始化
    imagePicker = [ImagePicker sharedManager];
    NSString * image = [[NSUserDefaults standardUserDefaults]objectForKey:@"headImage"];
   NSString * name = [[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
    NSString * sex = [[NSUserDefaults standardUserDefaults]objectForKey:@"gender"];
    NSString * number = [[NSUserDefaults standardUserDefaults]objectForKey:@"studentId"];
    NSString * school = [[NSUserDefaults standardUserDefaults]objectForKey:@"schoolName"];
    NSString * sclass = [[NSUserDefaults standardUserDefaults]objectForKey:@"className"];
    [self.studentImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,image]] placeholderImage:[UIImage imageNamed:@"123"]];
    self.name.text = [NSString stringWithFormat:@"%@",name];
    if ([sex isEqualToString:@"1"]) {
        self.sex.text = @"男";
    }else{
        self.sex.text = @"女";
    }
    self.number.text = [NSString stringWithFormat:@"%@",number];
    self.school.text = [NSString stringWithFormat:@"%@",school];
    self.classlabel.text = [NSString stringWithFormat:@"%@",sclass];
}
-(void)uploadImageInfoWithBaseImage:(NSString *)image{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    [parameter setObject:image forKey:@"headImage"];
    [manager POST:[NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/person/saveimg"] parameters:parameter progress:nil success:
     ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
         NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功---%@---%@--%@",responseObject,[responseObject class],dic);
         if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
             [StateView showSuccessInfo:[dic objectForKey:@"info"]];
             [[NSUserDefaults standardUserDefaults]setObject:[dic objectForKey:@"data"] forKey:@"headImage"];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         NSLog(@"请求失败--%@",error);
     }];
}
- (IBAction)selectBtnClicked:(UIButton *)sender {
//    [StateView showWarningInfo:@"修改头像"];
    //设置主要参数
    [imagePicker dwSetPresentDelegateVC:self SheetShowInView:self.view InfoDictionaryKeys:(long)nil];
    
    //回调
    [imagePicker dwGetpickerTypeStr:^(NSString *pickerTypeStr) {
        
        NSLog(@"-----%@",pickerTypeStr);
        
    } pickerImagePic:^(UIImage *pickerImagePic) {
        self.studentImage.image = pickerImagePic;
        NSString *encodedImageStr = [self imageChangeBase64:pickerImagePic];
        //这里执行上传图片的网络请求
        [self uploadImageInfoWithBaseImage:encodedImageStr];
    }];
}
#pragma mark -- image转化成Base64位
-(NSString *)imageChangeBase64: (UIImage *)image{
    
    NSData   *imageData = nil;
    //NSString *mimeType  = nil;
    if ([self imageHasAlpha:image]) {
        
        imageData = UIImagePNGRepresentation(image);
        //mimeType = @"image/png";
    }else{
        
        imageData = UIImageJPEGRepresentation(image, 0.3f);
        //mimeType = @"image/jpeg";
    }
    return [NSString stringWithFormat:@"%@",[imageData base64EncodedStringWithOptions: 0]];
}

-(BOOL)imageHasAlpha:(UIImage *)image{
    NSLog(@"test");
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

@end
