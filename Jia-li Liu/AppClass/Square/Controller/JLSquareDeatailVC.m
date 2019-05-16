//
//  JLSquareDeatailVC.m
//  Jia-li Liu
//
//  Created by jdlx on 2019/1/10.
//  Copyright © 2019 KLIANS. All rights reserved.
//

#import "JLSquareDeatailVC.h"

@interface JLSquareDeatailVC ()

@end

@implementation JLSquareDeatailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.title = self.titlename;
    ViewRadius(self.bgview, 8.f);
    [self requestDataDetailInfo];
}
-(void)requestDataDetailInfo{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    if ([self.titlename isEqualToString:@"拓展详情"]) {
        [parameter setObject:self.mid forKey:@"expansionId"];
        [manager POST:[NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/tuozhan/info"] parameters:parameter progress:nil success:
         ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             NSLog(@"请求成功---%@",dic);
             if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
                 NSDictionary * data = dic[@"data"];
                 self.worktitle.text = [NSString stringWithFormat:@"%@",data[@"title"]];
                 self.date.text = [NSString stringWithFormat:@"%@",[NSString convertTomMouthDay:data[@"sendTime"]]];
                 self.name.text = [NSString stringWithFormat:@"%@",data[@"sender"][@"name"]];
                 NSString *htmlString = [NSString stringWithFormat:@"%@",data[@"content"]];
                 [self.webview loadHTMLString:htmlString baseURL:nil];
             }
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             NSLog(@"请求失败--%@",error);
         }];
    }else{
        [parameter setObject:self.mid forKey:@"homeworkId"];
        [manager POST:[NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/zuoye/info"] parameters:parameter progress:nil success:
         ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             NSLog(@"请求成功---%@",dic);
             if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
                 NSDictionary * data = dic[@"data"];
                 self.worktitle.text = [NSString stringWithFormat:@"%@",data[@"title"]];
                 self.date.text = [NSString stringWithFormat:@"%@",[NSString convertTomMouthDay:data[@"sendTime"]]];
                 self.name.text = [NSString stringWithFormat:@"%@",data[@"sender"][@"name"]];
                 NSString *htmlString = [NSString stringWithFormat:@"%@",data[@"content"]];
                 [self.webview loadHTMLString:htmlString baseURL:nil];
             }
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             NSLog(@"请求失败--%@",error);
         }];
    }
    
}

@end
