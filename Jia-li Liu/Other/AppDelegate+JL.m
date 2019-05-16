//
//  AppDelegate+JL.m
//  Jia-li Liu
//
//  Created by KLIANS on 2017/5/8.
//  Copyright © 2017年 KLIANS. All rights reserved.
//

#import "AppDelegate+JL.h"
#import "LoginVC.h"
@implementation AppDelegate (JL)


#pragma mark - 判断App是否首次打开 -
-(void)isAppFirstClose{
    BOOL isFirstLogin = [[[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstLogin"] boolValue];
    BOOL isRememberLogin = [[[NSUserDefaults standardUserDefaults] objectForKey:@"isRememberLogin"] boolValue];
    
    if (!isFirstLogin) {
        //是第一次
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"isFirstLogin"];
        //视频引导页
        //        self.window.rootViewController = [[JLMovieController alloc]init];
        
        //静态图引导页
//        JLTabBarController *tabBarVc = [[JLTabBarController alloc] init];
        NSArray *mArray = @[@"first_1.png",@"first_2.png",@"first_3.png",@"first_4.png"];
        LoginVC * login = [[LoginVC alloc]init];
        JTNavigationController *navVc = [[JTNavigationController alloc] initWithRootViewController:login];
        
        JLNewFetureController *vc = [[JLNewFetureController alloc]initWithNSArray:[mArray copy] withButtonSize:CGSizeMake(ScreenWidth-160, 300*MYWIDTH) withButtonTitle:@"" withButtonImage:nil withButtonTitleColor:kClearColor withButtonHeight:0.85 withViewController:navVc];
        self.window.rootViewController = vc;

    }else{
        //不是首次启动
        if (!isRememberLogin) {
            LoginVC * login = [[LoginVC alloc]init];
            JTNavigationController *navVc = [[JTNavigationController alloc] initWithRootViewController:login];
            self.window.rootViewController = navVc;
        }else{
            JLTabBarController *tabBarVc = [[JLTabBarController alloc] init];
            self.window.rootViewController = tabBarVc;
        }
    }
    
}


@end
