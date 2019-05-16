//
//  JLBaseViewController.m
//  Jia-li Liu
//
//  Created by KLIANS on 2017/4/20.
//  Copyright © 2017年 KLIANS. All rights reserved.
//

#import "JLBaseViewController.h"

@interface JLBaseViewController ()


@end

@implementation JLBaseViewController

#pragma mark - ################################# 生命周期 #################################

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
-(void)getBageInfo{
    NSString * banji_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"classId"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    [parameter setObject:banji_id forKey:@"banji_id"];
    
    [manager POST:[NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/news/noread"] parameters:parameter progress:nil success:
     ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
         NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
             NSDictionary * data = dic[@"data"];
             //             NSString * expansionUnreadNum = data[@"expansionUnreadNum"];
             //             NSString * homeworkUnreadNum = data[@"homeworkUnreadNum"];
             //             NSString * noticeUnreadNum = data[@"noticeUnreadNum"];
             //             NSLog(@"%@",noticeUnreadNum);
             NSString * expansionUnreadNum = [NSString stringWithFormat:@"%@",data[@"expansionUnreadNum"]];
             NSString * homeworkUnreadNum = [NSString stringWithFormat:@"%@",data[@"homeworkUnreadNum"]];
             NSString * noticeUnreadNum = [NSString stringWithFormat:@"%@",data[@"noticeUnreadNum"]];
             NSLog(@"%@",noticeUnreadNum);
             if ([expansionUnreadNum integerValue]>0&&[homeworkUnreadNum integerValue]>0) {
                 NSString * bage = [NSString stringWithFormat:@"%ld",[expansionUnreadNum integerValue]+[homeworkUnreadNum integerValue]];
                 //                 [self.tabBarController.tabBar showBadgeOnItemIndex:1];
                 [[self.tabBarController.tabBar.items objectAtIndex:1] setBadgeValue:bage];
             }else if ([expansionUnreadNum integerValue]>0&&[homeworkUnreadNum integerValue]==0){
                 
                 [[self.tabBarController.tabBar.items objectAtIndex:1] setBadgeValue:[NSString stringWithFormat:@"%ld",[expansionUnreadNum integerValue]]];
             }else if ([expansionUnreadNum integerValue]==0&&[homeworkUnreadNum integerValue]>0){
                 [[self.tabBarController.tabBar.items objectAtIndex:1] setBadgeValue:[NSString stringWithFormat:@"%ld",[homeworkUnreadNum integerValue]]];
             }else{
                 [self.tabBarController.tabBar hideBadgeOnItemIndex:1];
             }
             if ([noticeUnreadNum integerValue]>0) {
                 [self.tabBarController.tabBar showBadgeOnItemIndex:4];
             }
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         NSLog(@"请求失败--%@",error);
     }];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

@end
